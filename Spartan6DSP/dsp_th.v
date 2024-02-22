module proj_th;
 parameter A0REG = 0 ;parameter A1REG = 0 ; parameter B0REG = 1 ; parameter B1REG = 1;
 parameter CREG = 1;parameter DREG = 1 ;parameter MREG = 1; parameter PREG = 1; parameter CARRYINREG = 1
 ;parameter CARRYOUTREG = 1; parameter OPMODEREG = 1; parameter CARRYINSEL = 1; parameter B_INPUT = 0;
  parameter RSTTYPE = 1;parameter MultiDSPblocksUsed = 0;
  reg [17:0]A;
integer i=0;
reg [17:0]B;
reg [17:0]BCIN;
reg [47:0]C;
reg [17:0]D;
reg CARRYIN;
wire [35:0]M;
wire [47:0]P;
wire CARRYOUT;
wire CARRYOUTF;
//Control Input Ports
reg CLK;
reg [7:0]OPMODE;
//Clock Enable Input Ports
reg CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP;
//Reset Input Ports
reg RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
//Cascade Ports
reg [47:0]PCIN;
wire [17:0]BCOUT;
wire[47:0]PCOUT;
  dsp #(A0REG,A1REG,B0REG,B1REG,CREG,DREG,MREG,PREG,
  CARRYINREG,CARRYOUTREG,OPMODEREG,CARRYINSEL,B_INPUT,RSTTYPE,MultiDSPblocksUsed)
 DUT(
   A,B,C,D,CLK,CARRYIN,OPMODE,BCIN,RSTA,RSTB,RSTC,RSTP,RSTM,RSTD,RSTCARRYIN,
  RSTOPMODE,CEA,CEB,CEP,CEM,CEC,CED,CECARRYIN,CEOPMODE,PCIN, BCOUT,PCOUT,P,M,
  CARRYOUT,CARRYOUTF
 );
 initial begin
	CLK=0;
	forever
	#5 CLK=~CLK;
end

initial begin
RSTA=1'b1;
RSTB=1'b1;
RSTC=1'b1;
RSTCARRYIN=1'b1;
RSTD=1'b1;
RSTM=1'b1;
RSTOPMODE=1'b1;
RSTP=1'b1;
A=18'h0;
D=18'h0;
C=18'h0;
B=18'h0;
OPMODE=8'h0;
CARRYIN=1'b0;
BCIN=18'h0;
CEA=1'b0;
CEB=1'b0;
CEM=1'b0;
CEP=1'b0;
CEC=1'b0;
CED=1'b0;
CECARRYIN=1'b0;
CEOPMODE=1'b0;
PCIN=18'h0;
#50;
RSTA=1'b0;
RSTB=1'b0;
RSTC=1'b0;
RSTCARRYIN=1'b0;
RSTD=1'b0;
RSTM=1'b0;
RSTOPMODE=1'b0;
RSTP=1'b0;
#100;
A=18'h2;
D=18'h3;
C=18'h4;
B=18'h5;
OPMODE=8'b00110010;
CARRYIN=1'b1;
BCIN=18'h0;
CEA=1'b1;
CEB=1'b1;
CEM=1'b1;
CEP=1'b1;
CEC=1'b1;
CED=1'b1;
CECARRYIN=1'b1;
CEOPMODE=1'b1;
PCIN=18'h0;

#100
A=18'h5;
D=18'h4;
C=18'h8;
B=18'h9;
OPMODE=8'b00111001;
CARRYIN=1'b1;
BCIN=18'h7;
CEA=1'b1;
CEB=1'b1;
CEM=1'b1;
CEP=1'b1;
CEC=1'b1;
CED=1'b1;
CECARRYIN=1'b1;
CEOPMODE=1'b1;
PCIN=18'h3;
#100
$stop;
end
endmodule
