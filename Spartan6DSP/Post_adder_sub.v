module postAdderSub(in1,in2,cin,opmodeSel,out,cout);
  input [47:0] in1,in2;
  output reg cout;
  input cin;
  input opmodeSel;
  output reg [47:0] out;
  always @* begin
    if(!opmodeSel)
      {cout,out}=in1+in2+cin;
    else if(opmodeSel)
      {cout,out}=in2-in1-cin;
    end
  endmodule
  




