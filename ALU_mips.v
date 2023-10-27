module ALU_mips(alu_op,in1,in2,result,z,cout,ov);

input [31:0]in1,in2;
input [3:0]alu_op;
output reg [31:0]result;
output z,cout,ov;
parameter add=4'd0,sub=4'd1,and32=4'd2,or32=4'd3,xor32=4'd4,nor32=4'd5,srl=4'd6,sll=4'd7,addu=4'd8,
			 subu=4'd9;

wire s,cin;
wire [31:0]result0,result1,result2,result4,result5;

assign s=(alu_op == add) | (alu_op == sub) | ~(alu_op == addu) | ~(alu_op ==subu);
assign cin=(alu_op == add) | ~(alu_op == sub) | (alu_op == addu) | ~(alu_op ==subu);

 adder_cla(cin,s,in1,in2,result0,cout,ov);


 and_gate(in1 , in2 , result4);
 or_gate (in1 , in2 , result3);
 
 slr(
  in1,
  in2,
  result1
);

 sll(
  in1,
  in2,
   result2
);

always @(*) begin
	
	if ((alu_op == add) | (alu_op == sub) | (alu_op == addu) | (alu_op == subu) )
		result=result0;
	if ((alu_op == srl))
		result=result1;
	if ((alu_op == sll))
		result=result2;
	if ((alu_op == or32))
		result=result3;
	if ((alu_op == and32))
		result=result4;
end


endmodule 

module alu_mips_dut();

reg [31:0]in1,in2;
reg [3:0]alu_op;
wire [31:0]result;
wire z,cout,ov;
parameter add=4'd0,sub=4'd1,and32=4'd2,or32=4'd3,xor32=4'd4,nor32=4'd5,srl=4'd6,sll=4'd7,addu=4'd8,
			 subu=4'd9;

/////////////////////////////////////////

ALU_mips dut(alu_op,in1,in2,result,z,cout,ov);


/////////////////////////////////////////

initial begin
	in1=32'd5;
	in2=32'd1;
	
	alu_op=add;
	#30
	alu_op=sub;
	#30
	alu_op=and32;
	#30
	alu_op=or32;
	#30
	alu_op=xor32;
	#30
	alu_op=srl;
	#30
	alu_op=sll;
	#30
	alu_op=addu;
	#30
	alu_op=subu;

end

endmodule
