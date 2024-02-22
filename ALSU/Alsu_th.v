module alsuuu;
parameter FULL_ADDER="ON";
parameter INPUT_PRIORITY="A";
reg [2:0] A,B,opcode;
reg cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst;
integer i=0;
wire [5:0] out;
wire [15:0] leds;
alsu #(FULL_ADDER,INPUT_PRIORITY) DUT(A,B,opcode,cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst,out,leds);

initial begin
  clk=0;
  #200 $stop;
 end

always
#2 clk=~clk;

initial begin
rst=1;
#5
rst=0;
   for(i=0;i<50;i=i+1) begin
     #10 A=$random; B=$random; opcode=$random; cin=$random; serial_in=$random; direction=$random; 
        red_op_A=$random; red_op_B=$random; bypass_A=$random; bypass_B=$random; clk=$random;
end
end
endmodule