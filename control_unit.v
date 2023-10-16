/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: generate control units to specify data element functionality and data path propagation.
*/
//////////////////////////////////////////////////////////////////////////////////////////

module control_unit(clk,ir,regdest,alusrc,aluop,branch,memread,memwrite,regwrite,memtoreg);


//####################### Scalers Ports ###############################################//
output reg alusrc,regdest,memread,memwrite,regwrite,memtoreg;
input clk;

//####################### Vector Ports ###############################################//
output reg[3:0]aluop;
input  [5:0]ir;
output reg[3:0]branch;

//####################### parameters  ###############################################//
parameter  rfmt=6'b000000,bltz=6'b000001,j=6'b000010,
			  jal=6'b000011,beq=6'b000100,bne=6'b000101,
			  blez=6'b000110,bgtz=6'b000111,addi=6'b001000,
			  addiu=6'b001001,slti=6'b001010,sltiu=6'b001011,
			  andi=6'b001100,ori=6'b001101,xori=6'b001110,
			  lui=6'b001111,tlb=6'b010000,flpt=6'b010001,jr=6'b010010,
			  blt=6'b010011,bgt=6'b010100,bge=6'b010101,ble=6'b010110,
			  lb=6'b100000,lh=6'b100001,lwl=6'b100010,lw=6'b100011,
			  lbu=6'b100100,lhu=6'b100101,lwr=6'b100110,sb=6'b101000,
			  sh=6'b101001,swl=6'b101010,sw=6'b101011,lwc0=6'b110000,
			  lwc1=6'b110001,swc0=6'b111000,swc1=6'b111001;

parameter pc_plus4=4'b0000,branch_j=4'b0001,branch_jr=4'b0010,branch_beq=4'b0011,branch_bne=4'b0100,branch_blez=4'b0101,
			 branch_bgtz=4'b0110,branch_blt=4'b0111,branch_bgt=4'b1000,branch_bge=4'b1001,branch_ble=4'b1010,branch_jal=4'b1011;			

//////////////////////////Notes on the control signals//////////////////////////////////
/*
alusrc : operand 2 is 16 bit sign extended immediate or a register from the file registers
			0>>Read register 2 1>>read Immediate

memtoreg: 1>> return value to a destination register from the data memory 
			 0>> return value to a destination register from the alu
branch:   branch select from pc_plus4 if not branch instruction
			 branch_dir if the branch target (displacemen instructions) -from immediate- j and jal
			 branch_ind if the target is indirect (pc=return_register $31) -jr and jalr
aluop:    this control signals are used to diffrentiate between rfmt and other i and j formates usage
			 of the control unit in addition it will help in [5:0] funct field encoding.
			 0000 > rfmt
			 0001 > addi //add
			 0010 > bge, //sub
			 0011 > andi
			 0100 > ori
			 0101 > xori
			 0110 > slti
			 0111 > load/store
			 1000 > flpt
			 		 
*/
///////////////////////////////////////////////////////////////////////////////////////
//####################### circuit     ###############################################//

/*//////////////////////////////////////////////////////////////////////////////////////////////////
This control unit is a single cycle (operate at one stage) control unit hence it is combiational logic
and can be implemented by continues assignments
*///////////////////////////////////////////////////////////////////////////////////////////////////

//generate control signals at each clk posedge hence procedureal assignment is used
always @(posedge clk) begin:con_cr
	
	//:ins_type_decode
	case(ir)
		rfmt:	begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b1;
				memtoreg=1'b0;
				branch=pc_plus4;
				aluop=4'b0000;
				regdest=1'b1;
				end
		
		j:		begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_j;
				aluop=4'b0000;
				regdest=1'bx;
				
				end
				
		jr:   begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_jr;
				aluop=4'b0000;
				regdest=1'bx;
				
				end
		jal: begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_jal;
				aluop=4'b0000;
				regdest=1'bx;
				
				end
		
		bge: begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_bge;
				aluop=4'b0010;
				regdest=1'bx;
				
				end
		blt:  begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_blt;
				aluop=4'b0010;
				regdest=1'bx;
				
				end
		
		beq: begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_beq;
				aluop=4'b0010;
				regdest=1'bx;
				
				end
		bne:  begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_bne;
				aluop=4'b0010;
				regdest=1'bx;
				
				end
		
		bgt:  begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_bgt;
				aluop=4'b0010;
				regdest=1'bx;
				
				end
		ble:  begin
				alusrc=1'b0;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b0;
				memtoreg=1'b0;
				branch=branch_ble;
				aluop=4'b0010;
				regdest=1'bx;
				
				end
		andi: begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b1;
				memtoreg=1'b0;
				branch=pc_plus4;
				aluop=4'b0011;
				regdest=1'b0;
				
				end
		xori: begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b1;
				memtoreg=1'b0;
				branch=pc_plus4;
				aluop=4'b0100;
				regdest=1'b0;
				
				end
		ori:  begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b1;
				memtoreg=1'b0;
				branch=pc_plus4;
				aluop=4'b0101;
				regdest=1'b0;
				
				end
		addi: begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b0;
				regwrite=1'b1;
				memtoreg=1'b0;
				branch=pc_plus4;
				aluop=4'b0001;
				regdest=1'b0;
				
				end
		
		lw:   begin
				alusrc=1'b1;
				memread=1'b1;
				memwrite=1'b0;
				regwrite=1'b1;
				memtoreg=1'b1;
				branch=pc_plus4;
				aluop=4'b0001;
				regdest=1'b0;
				
				end
		sw:   begin
				alusrc=1'b1;
				memread=1'b0;
				memwrite=1'b1;
				regwrite=1'b1;
				memtoreg=1'b1;
				branch=pc_plus4;
				aluop=4'b0001;
				regdest=1'bx;
				
				end
				
/*		bltz:

		blez:
		bgtz:
		bgt:
		addiu:
		slti:
		sltiu:
		flpt:
		lb:
		lh:
		lwl:
		lbu:
		lhu:
		lwr:
		sb:
		sh:
		swl:
		swr:
		lwc0:
		lwc1:
		swc0:
		swc1:
*/
		
	
	endcase
	

end


endmodule

module control_dut;

//####################### Scalers Ports ###############################################//
wire alusrc,memread,memwrite,regwrite,memtoreg;
reg clk;

//####################### Vector Ports ###############################################//
wire [3:0]aluop;
reg  [5:0]ir;
wire [3:0]branch;

////////////instructions
parameter  rfmt=6'b000000,bltz=6'b000001,j=6'b000010,
			  jal=6'b000011,beq=6'b000100,bne=6'b000101,
			  blez=6'b000110,bgtz=6'b000111,addi=6'b001000,
			  addiu=6'b001001,slti=6'b001010,sltiu=6'b001011,
			  andi=6'b001100,ori=6'b001101,xori=6'b001110,
			  lui=6'b001111,tlb=6'b010000,flpt=6'b010001,jr=6'b010010,
			  blt=6'b010011,bgt=6'b010100,bge=6'b010101,ble=6'b010110,
			  lb=6'b100000,lh=6'b100001,lwl=6'b100010,lw=6'b100011,
			  lbu=6'b100100,lhu=6'b100101,lwr=6'b100110,sb=6'b101000,
			  sh=6'b101001,swl=6'b101010,sw=6'b101011,lwc0=6'b110000,
			  lwc1=6'b110001,swc0=6'b111000,swc1=6'b111001;

////////////branch control signals

parameter pc_plus4=4'b0000,branch_j=4'b0001,branch_jr=4'b0010,branch_beq=4'b0011,branch_bne=4'b0100,branch_blez=4'b0101,
			 branch_bgtz=4'b0110,branch_blt=4'b0111,branch_bgt=4'b1000,branch_bge=4'b1001,branch_ble=4'b1010,branch_jal=4'b1011;			
	

/////////////////////////////////circuit under test/////////////////////////////////
control_unit dut(clk,ir,alusrc,aluop,branch,memread,memwrite,regwrite,memtoreg);

////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////input test vectors//////////////////////////////////////////////////////

	initial begin : test_vectors
			
			ir=rfmt;
			#40
			ir=j;
			#40
			ir=jr;
			#40
			ir=jal;
			#40
			ir=beq;
			#40
			ir=bne;
			#40
			ir=bge;
			#40
			ir=blt;
			#40
			ir=bgt;
			#40
			ir=ble;
			#40
			ir=addi;
			#40
			ir=andi;
			#40
			ir=ori;
			#40
			ir=xori;
			#40
			ir=lw;
			#40
			ir=sw;
			#40;
			
	end
	
	
	initial begin : clk_generation
		clk=0;
		forever
		#30 clk=~clk;
	
	end
	
	
endmodule
