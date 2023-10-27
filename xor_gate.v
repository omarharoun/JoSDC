// Xor gate
module xor32(in1 ,in2 ,out);
  input [31:0] in1,in2;
  
  wire [31:0] w1,w2;
  
  output [31:0]out;
  
  assign w1 = in1;
  assign w2 = in2;
  
  assign out = w1^w2;
  
endmodule
