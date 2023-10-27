// shift logical right
module slr(
  input [31:0] in1,
  input n,
  output [31:0] out
);
  wire [31:0] w;

  assign w = in1;

  assign out[31:0] = (n > 0) ? (w >>> n) : w;
endmodule
