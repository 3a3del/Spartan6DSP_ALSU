module dsp #(parameter A0REG = 0 ,parameter A1REG = 0 , parameter B0REG = 1 , parameter B1REG = 1,
 parameter CREG = 1, parameter DREG = 1 ,parameter MREG = 1, parameter PREG = 1, parameter CARRYINREG = 1
 ,parameter CARRYOUTREG = 1, parameter OPMODEREG = 1, parameter CARRYINSEL = 1, parameter B_INPUT = 0,
  parameter RSTTYPE = 1,parameter MultiDSPblocksUsed = 0) //if multi dsp used blocks switch MultiDSPblocksUsed to 1
 (
   A,B,C,D,CLK,CARRYIN,OPMODE,BCIN,RSTA,RSTB,RSTC,RSTP,RSTM,RSTD,RSTCARRYIN,
  RSTOPMODE,CEA,CEB,CEP,CEM,CEC,CED,CECARRYIN,CEOPMODE,PCIN, BCOUT,PCOUT,P,M,
  CARRYOUT,CARRYOUTF);
 input CLK,CARRYIN,RSTA,RSTB,RSTC,RSTP,RSTM,RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEP,CEM,CEC,CED,CECARRYIN,CEOPMODE;
 input [17:0] A;
 input [17:0] B;
 input [17:0] D;
 input [17:0] BCIN;
 input [7:0] OPMODE;
 input [47:0] C;
 input [47:0] PCIN;
 output [17:0] BCOUT;
 output [47:0] P;
 inout  [47:0]PCOUT;
 output [35:0] M;
 output CARRYOUTF;
 inout CARRYOUT;
 wire [47:0] P_MUX_OUT;
 wire [17:0] out_from_eachReg [8:0];
 wire [7:0] OPMODE_selected;
 wire [47:0] c_port;
 wire [47:0] muxZout;
 wire [47:0]muxXout;
 wire [47:0]outFromPostAdder;
 wire [35:0] MultiResult;
 wire [35:0] MregOutput;
wire [47:0] Extended_M;
 wire CoutFromPostAdder;
 wire usse;
wire[17:0] A1_MUX_OUT;
wire[17:0] B1_MUX_OUT;
//****************************************

//****************************************
 REG_MUX #(A0REG,RSTTYPE,18) DUT1 (A,CEA,RSTA,CLK,out_from_eachReg[0]); //A0
 REG_MUX #(DREG,RSTTYPE,18) DUT3 (D,CED,RSTD,CLK,out_from_eachReg[2]); //D
 REG_MUX #(CREG,RSTTYPE,48) DUT4 (C,CEC,RSTC,CLK,c_port); //C

 assign out_from_eachReg[3] =(B_INPUT)? B:(~B_INPUT)? BCIN:0;

 REG_MUX #(B0REG,RSTTYPE,18) DUT5 (out_from_eachReg[3],CEB,RSTB,CLK,out_from_eachReg[4]); //B0
 
 REG_MUX #(OPMODEREG,RSTTYPE,8) DUT6 (OPMODE,CEOPMODE,RSTOPMODE,CLK,OPMODE_selected); //op mode
 
 preAdderSub DUT7(out_from_eachReg[2],out_from_eachReg[4],OPMODE_selected[6],out_from_eachReg[5]);

 
 assign out_from_eachReg[8]=(OPMODE_selected[4])? out_from_eachReg[5]:out_from_eachReg[4];
 REG_MUX #(B1REG,RSTTYPE,18) DUT15(out_from_eachReg[8],CEB,RSTB,CLK,A1_MUX_OUT); //B1
 REG_MUX #(A1REG,RSTTYPE,18) DUT2 (out_from_eachReg[0],CEA,RSTA,CLK,B1_MUX_OUT); //A1];
//****************************************
 assign BCOUT=B1_MUX_OUT;
 assign MultiResult=A1_MUX_OUT*B1_MUX_OUT;



 REG_MUX #(MREG,RSTTYPE,36) DTU(MultiResult,CEM,RSTM,CLK,MregOutput);
 assign M=MregOutput;
 
 assign Extended_M={{12{M[35]}},MregOutput};
 
//****************************************
 assign muxZout = OPMODE_selected[3] ? (OPMODE_selected[2] ? c_port : P_MUX_OUT) : (OPMODE_selected[2] ? PCIN : 48'h000000000000);
 
 assign muxXout = OPMODE_selected[1] ? (OPMODE_selected[0] ? {out_from_eachReg[2][11:0],A1_MUX_OUT,B1_MUX_OUT} : PCOUT) : (OPMODE_selected[0] ? Extended_M : 48'h000000000000);
 
 /*generate
   if(!CARRYINSEL)
     REG_MUX #(CARRYINREG,RSTTYPE,1) DUT8 (CARRYIN,CECARRYIN,RSTCARRYIN,CLK,usse); 
   else if (CARRYINSEL)
     REG_MUX #(CARRYINREG,RSTTYPE,1) DUT9 (OPMODE_selected[5],CECARRYIN,RSTCARRYIN,CLK,usse); 
 endgenerate*/
 assign CARRY_INPUT =(CARRYINSEL==1)? OPMODE_selected[5]:(CARRYINSEL==0)? CARRYIN:0;
 REG_MUX #(CARRYINREG,RSTTYPE,1) DUTTT (CARRY_INPUT,CECARRYIN,RSTCARRYIN,CLK,usse);
 
 postAdderSub DUT8(muxXout,muxZout,usse,OPMODE_selected[7],outFromPostAdder,CoutFromPostAdder);
     
 REG_MUX #(PREG,RSTTYPE,48) DUT10 (outFromPostAdder,CEP,RSTP,CLK,P_MUX_OUT); //P
 assign P=P_MUX_OUT;
 assign PCOUT=P;
 
 REG_MUX #(CARRYOUTREG,RSTTYPE,1) DUT11 (CoutFromPostAdder,CECARRYIN,RSTCARRYIN,CLK,CARRYOUT);
 assign CARRYOUTF = CARRYOUT ;

endmodule
     
 
 
 

