module REG_MUX #(parameter attrinute_mux=1,parameter rsttype=1,parameter N=18)(in,CE,RST,CLK,out);
/*parameter attrinute_mux=1;
parameter N=18;
parameter rsttype=1;*/
  input [N-1:0] in;
  output [N-1:0] out;
  reg [N-1:0] ref;
  input CE,RST,CLK;
  generate
    if(!rsttype)
      always @(posedge CLK or posedge RST) begin
        if(RST)
          ref<=0;
        else if(CE)
          ref<=in;
        else
          ref<=0;
        end
   else if (rsttype)
     always @(posedge CLK) begin
        if(RST)
          ref<=0;
        else if(CE)
          ref<=in;
        else
          ref<=0;
        end
   endgenerate
   
    assign out=(attrinute_mux)? ref:(~attrinute_mux)? in:0;
  endmodule  



