module alu_con(clk,insfunc,insop,alu_op , Jump_Register);
/////////////////scalers
input clk;

/////////////////vectors 

//inputs 

input [5:0]insfunc,insop;

//outputs

output reg [7:0] alu_op        ;
output reg       Jump_Register ;

//parameters for ins opcode[31:26]
parameter rfmt = 6'b000000  , beq  = 6'b000011   , bne = 6'b000100  , addi = 6'b001000  , andi = 6'b001100 ,
			 ori  = 6'b001101  , xori = 6'b001110   , lw  = 6'b100011  , sw   = 6'b101011  , blt  = 6'b011000 ,
			 bgt  = 6'b011001  , bge  = 6'b011010   , ble = 6'b011011 ;

			 
//parameters for rfmt opcode [5:0] 
parameter sll  = 6'b000000  , srl   = 6'b000010  , add  = 6'b100000 , addu  = 6'b100001 , sub   = 6'b100010 , 
          subu = 6'b100011  , and32 = 6'b100100 , or32 = 6'b100101 , xor32 = 6'b100110 , nor32 = 6'b100111 ,
			 jump_r   = 6'b001000 ;

always @(posedge clk) begin
	
	case(insop)
		
		rfmt:
				case(insfunc)
					
					sll  : begin  alu_op<=8'h7;Jump_Register<= 1'b0; end
					srl  : begin  alu_op<=8'h6;Jump_Register<= 1'b0; end 
					add  : begin  alu_op<=8'h0;Jump_Register<= 1'b0; end
					addu : begin  alu_op<=8'h8;Jump_Register<= 1'b0; end 
					sub  : begin  alu_op<=8'h1;Jump_Register<= 1'b0; end 
					subu : begin  alu_op<=8'h9;Jump_Register<= 1'b0; end
					and32: begin  alu_op<=8'h2;Jump_Register<= 1'b0; end
					or32 : begin  alu_op<=8'h3;Jump_Register<= 1'b0; end 
					xor32: begin  alu_op<=8'h4;Jump_Register<= 1'b0; end
					nor32: begin  alu_op<=8'h5;Jump_Register<= 1'b0; end
					
					jump_r: begin Jump_Register<= 1'b1; end
					
				   default: begin
						Jump_Register<= 1'b0;
						alu_op<=8'h0;
					end
					
				endcase
					
					addi: begin  alu_op=8'h0;Jump_Register<= 1'b0; end
					andi: begin  alu_op=8'h2;Jump_Register<= 1'b0; end
					ori : begin  alu_op=8'h3;Jump_Register<= 1'b0; end
					xori: begin  alu_op=8'h4;Jump_Register<= 1'b0; end
					lw  : begin  alu_op=8'h0;Jump_Register<= 1'b0; end
					sw  : begin  alu_op=8'h0;Jump_Register<= 1'b0; end

					beq : begin alu_op=8'h10;Jump_Register<= 1'b0; end
					bne : begin alu_op=8'h11;Jump_Register<= 1'b0; end
					blt : begin alu_op=8'h12;Jump_Register<= 1'b0; end
					bgt : begin alu_op=8'h13;Jump_Register<= 1'b0; end
					bge :	begin alu_op=8'h14;Jump_Register<= 1'b0; end
					ble : begin alu_op=8'h15;Jump_Register<= 1'b0; end
		
		endcase
end



endmodule

module alu_cont_dut;

reg clk;

reg  [5:0] insfunc , insop;

wire [7:0] alu_op         ;
wire       Jump_Register  ;

//parameters for ins opcode[31:26]
parameter rfmt = 6'b000000  , beq  = 6'b000011   , bne = 6'b000100  , addi = 6'b001000  , andi = 6'b001100 ,
			 ori  = 6'b001101  , xori = 6'b001110   , lw  = 6'b100011  , sw   = 6'b101011  , blt  = 6'b011000 ,
			 bgt  = 6'b011001  , bge  = 6'b011010   , ble = 6'b011011 ;

			 
//parameters for rfmt opcode [5:0] 
parameter sll  = 6'b000000  , srl   = 6'b000010  , add  = 6'b100000 , addu  = 6'b100001 , sub   = 6'b100010 , 
          subu = 6'b100011  , and32 = 6'b100100 , or32 = 6'b100101 , xor32 = 6'b100110 , nor32 = 6'b100111 ,
			 jump_r   = 6'b001000 ;




//ciruit under test
alu_con dut(clk,insfunc,insop,alu_op,Jump_Register);
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
				#60 insfunc=jump_r;

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