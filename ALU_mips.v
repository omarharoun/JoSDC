module ALU_mips(alu_op,in1,in2,result,z,cout,ov);

input [31:0]in1,in2;
input [3:0]alu_op;

parameter add=4'd0,sub=4'd1,and32=4'd2,or32=4'd3,xor32=4'd4,nor32=4'd5,srl=4'd6,sll=4'd7,addu=4'd8,
			 subu=4'd9;


assign s=(alu_op == add) | (alu_op == sub) | ~(alu_op == addu) | ~(alu_op ==subu);
assign cin=(alu_op == add) | ~(alu_op == sub) | (alu_op == addu) | ~(alu_op ==subu);

adder_cla(cin,s,in1,in2,sum,cout,ov);


endmodule 