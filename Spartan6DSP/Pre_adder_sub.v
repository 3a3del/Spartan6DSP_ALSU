module preAdderSub(in1,in2,opmodeSel,out);
  input [17:0] in1,in2;
  input opmodeSel;
  output reg [17:0] out;
  always @* begin
    if(!opmodeSel)
      out=in1+in2;
    else if(opmodeSel)
      out=in1-in2;
    end
  endmodule
  


