module alu_con(clk,insfunc,insop,alu_op);
/////////////////scalers
input clk;

/////////////////vectors 

//inputs 

input [5:0]insfunc,insop;

//outputs
output reg [3:0]alu_op;

//parameters for ins opcode[31:26]
parameter rfmt=6'd0,j=6'd2,jal=6'd3,beq=6'd3,bne=6'd4,addi=6'd10,andi=6'd14,
			 ori=6'd15,xori=6'd16,lw=6'd43,sw=6'd53,blt=6'd30,bgt=6'd31,bge=6'd32,ble=6'd33;

			 
//parameters for rfmt opcode [5:0] 
parameter sll=6'd0,srl=6'd2,add=6'd40,addu=6'd41,sub=6'd42,subu=6'd43,and32=6'd44,or32=6'd45,xor32=6'd46,nor32=6'd47;
always @(posedge clk) begin
	
	case(insop)
		
		rfmt:
				case(insfunc)
					
					sll: alu_op=4'd7;
					srl: alu_op=4'd6;
					add: alu_op=4'd0;
					addu:alu_op=4'd8;
					sub: alu_op=4'd1;
					subu:alu_op=4'd9;
					and32:alu_op=4'd2;
					or32: alu_op=4'd3;
					xor32:alu_op=4'd4;
					nor32:alu_op=4'd5;
					
				endcase
				
		j: alu_op=4'd0;
		jal: alu_op=4'd0;
		beq: alu_op=4'd1;
		bne: alu_op=4'd1;
		addi: alu_op=4'd0;
		andi: alu_op=4'd2;
		ori:  alu_op=4'd3;
		xori: alu_op=4'd4;
		lw:   alu_op=4'd0;
		sw:   alu_op=4'd0;
		blt:  alu_op=4'd1;
		bgt:  alu_op=4'd1;
		bge:	alu_op=4'd1;
		ble:  alu_op=4'd1;
		
		endcase
end



endmodule
