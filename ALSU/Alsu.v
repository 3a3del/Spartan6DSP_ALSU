module alsu #(parameter FULL_ADDER="ON",parameter INPUT_PRIORITY="A")
(
A,B,opcode,cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst,
out,leds);
input cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst;
input [2:0] A,B,opcode;
output reg [5:0] out;
output reg [15:0] leds;
always@(posedge clk or posedge rst) begin
  if(rst) begin
    out=6'b000000;
    leds=16'b0000000000000000;
    end
  else
    if(bypass_A && bypass_B) begin
      if(INPUT_PRIORITY=="A")
        out=A;
      else if(INPUT_PRIORITY=="B")
        out=B;
      end
    else if(bypass_A && ~bypass_B)
      out=A;
    else if(~bypass_A && bypass_B)
      out=B;
    else if (~bypass_A && ~bypass_B) begin
      case(opcode)
        3'b111 : begin
          leds=~leds;
          out=6'b000000;
        end
        3'b110 : begin
          leds=~leds;
          out=6'b000000;
        end
        3'b000 : begin
          if(red_op_A && red_op_B) begin
            if(INPUT_PRIORITY=="A")
              out=&A;
            else if(INPUT_PRIORITY=="B")
              out=&B;
            end
          else if(red_op_A && ~red_op_B)
            out=&A;
          else if(~red_op_A && red_op_B)
            out=&B;
          else if(~red_op_A && ~red_op_B)
            out=A&B;
          end
        3'b001 : begin
          if(red_op_A && red_op_B) begin
            if(INPUT_PRIORITY=="A")
              out=^A;
            else if(INPUT_PRIORITY=="B")
              out=^B;
            end
          else if(red_op_A && ~red_op_B)
            out=^A;
          else if(~red_op_A && red_op_B)
            out=^B;
          else if(~red_op_A && ~red_op_B)
            out=A^B;
          end
//**************************
3'b010 : begin
  if(FULL_ADDER=="ON")
    out=A+B+cin;
  else if (FULL_ADDER=="OFF")
    out=A+B;
  end
//**************************
3'b011 : out=A*B;
//**************************
3'b100 : begin
  if(direction)
    if(INPUT_PRIORITY=="A")
      out={A[1],A[0],serial_in};
    else if (INPUT_PRIORITY=="B")
      out={B[1],B[0],serial_in};
  else
    if(INPUT_PRIORITY=="B")
      out={serial_in,A[2],A[1]};
    else if (INPUT_PRIORITY=="B")
      out={serial_in,A[2],A[1]};
    end
//**************************
3'b101 : begin
  if(direction)
    if(INPUT_PRIORITY=="A")
      out={A[1],A[0],A[2]};
    else if (INPUT_PRIORITY=="B")
      out={B[1],B[0],B[2]};
  else
    if(INPUT_PRIORITY=="B")
      out={A[0],A[2],A[1]};
    else if (INPUT_PRIORITY=="B")
      out={B[0],B[2],B[1]};
    end
//**************************
endcase
end
end
endmodule



