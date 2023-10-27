// bit by bit or gate for ALU.

module or_gate(in1 , in2 , out);
  
  input [31:0] in1,in2;
  output [31:0] out;
  
  wire [31:0] in1_w, in2_w;
  
  assign in1_w = in1;
  assign in2_w = in2;
  
  
  assign out = in1 | in2;
  
endmodule


module and_gate(in1 , in2 , out);
  
  input [31:0] in1,in2;
  output [31:0] out;
  
  wire [31:0] in1_w, in2_w;
  
  assign in1_w = in1;
  assign in2_w = in2;
  
  
  assign out = in1 & in2;
  
endmodule
  