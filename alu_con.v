module alu_con(clk,insfunc,insop,alu_op);
/////////////////scalers
input clk;

/////////////////vectors 

//inputs 

input [5:0]insfunc,insop;

//outputs
output reg [3:0]alu_op;

//parameters for ins opcode[31:26]
parameter rfmt=6'd0,beq=6'd3,bne=6'd4,addi=6'd10,andi=6'd14,
			 ori=6'd15,xori=6'd16,lw=6'd43,sw=6'd53,blt=6'd30,bgt=6'd31,bge=6'd32,ble=6'd33;

			 
//parameters for rfmt opcode [5:0] 
parameter sll=6'd0,srl=6'd2,add=6'd40,addu=6'd41,sub=6'd42,subu=6'd43,and32=6'd44,or32=6'd45,xor32=6'd46,nor32=6'd47;

always @(posedge clk) begin
	
	case(insop)
		
		rfmt:
				case(insfunc)
					
					sll: alu_op<=4'd7;
					srl: alu_op<=4'd6;
					add: alu_op<=4'd0;
					addu:alu_op<=4'd8;
					sub: alu_op<=4'd1;
					subu:alu_op<=4'd9;
					and32:alu_op<=4'd2;
					or32: alu_op<=4'd3;
					xor32:alu_op<=4'd4;
					nor32:alu_op<=4'd5;
					default: alu_op<=5;
					
				endcase
		
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

module alu_cont_dut;

reg clk;
reg [5:0]insfunc,insop;
wire [3:0]alu_op;

parameter rfmt=6'd0,beq=6'd3,bne=6'd4,addi=6'd10,andi=6'd14,
			 ori=6'd15,xori=6'd16,lw=6'd43,sw=6'd53,blt=6'd30,bgt=6'd31,bge=6'd32,ble=6'd33;

parameter sll=6'd0,srl=6'd2,add=6'd40,addu=6'd41,sub=6'd42,subu=6'd43,and32=6'd44,or32=6'd45,xor32=6'd46,nor32=6'd47;

//ciruit under test
alu_con dut(clk,insfunc,insop,alu_op);
////
	initial begin : test_vector
		insop=rfmt;
		
				#30 insfunc=sll;
				#60 insfunc=srl;
				#60 insfunc=add;
				#60 insfunc=addu;
				#60 insfunc=sub;
				#60 insfunc=subu;
				#60 insfunc=and32;
				#60 insfunc=xor32;
				#60 insfunc=nor32;

	   #60 insop=beq;
		#60 insop=bne;
		#60 insop=addi;
		#60 insop=andi;
		#60 insop=ori;
		#60 insop=xori;
		#60 insop=lw;
		#60 insop=sw;
		#60 insop=blt;
		#60 insop=bgt;
		#60 insop=bge;
		#60 insop=ble;
		#60;
	
	end

	
	initial begin : clk_generation
	
		clk=0;
		
		forever #30 clk=~clk;
	
	end
endmodule
