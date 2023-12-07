/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: generate control units to specify data element functionality and data path propagation.
*/
//////////////////////////////////////////////////////////////////////////////////////////

module control_unit(clk,ir,regdest,alusrc,branch,memread,memwrite,regwrite,memtoreg,Jump);


//####################### Scalers Ports ###############################################//
output reg alusrc , memread , memwrite , regwrite , Jump  ,branch;

input clk;

//####################### Vector Ports ###############################################//
input  [5:0] ir;
output reg [1:0] regdest , memtoreg;

//####################### parameters  ###############################################//
parameter  rfmt =6'b000000 , bltz =6'b000001 , j     =6'b000010,
			  jal  =6'b000011 , beq  =6'b000100 , bne   =6'b000101,
			  blez =6'b000110 , bgtz =6'b000111 , addi  =6'b001000,
			  addiu=6'b001001 , slti =6'b001010 , sltiu =6'b001011,
			  andi =6'b001100 , ori  =6'b001101 , xori  =6'b001110,
			  lui  =6'b001111 , tlb  =6'b010000 , flpt  =6'b010001,
			  blt  =6'b010011 , bgt  =6'b010100 , bge   =6'b010101,
			  lb   =6'b100000 , lh   =6'b100001 , lwl   =6'b100010,
			  lbu  =6'b100100 , lhu  =6'b100101 , lwr   =6'b100110,
			  sh   =6'b101001 , swl  =6'b101010 , sw    =6'b101011,
			  lwc1 =6'b110001 , swc0 =6'b111000 , swc1  =6'b111001,
           ble  =6'b010110 , lw   =6'b100011 , sb    =6'b101000,
			  lwc0 =6'b110000 ;
			  
			  
/*parameter pc_plus4=4'b0000,branch_j=4'b0001,branch_jr=4'b0010,branch_beq=4'b0011,branch_bne=4'b0100,branch_blez=4'b0101,
			 branch_bgtz=4'b0110,branch_blt=4'b0111,branch_bgt=4'b1000,branch_bge=4'b1001,branch_ble=4'b1010,branch_jal=4'b1011;	*/		

//////////////////////////Notes on the control signals//////////////////////////////////
/*
alusrc : operand 2 is 16 bit sign extended immediate or a register from the file registers
			0>>Read register 2 1>>read Immediate

memtoreg: 1>> return value to a destination register from the data memory 
			 0>> return value to a destination register from the alu
branch:   branch select from pc_plus4 if not branch instruction
			 branch_dir if the branch target (displacemen instructions) -from immediate- j and jal
			 branch_ind if the target is indirect (pc=return_register $31) -jr and jalr
			 		 
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
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b00;
					branch       =1'b0;
					regdest      =2'b01;
					Jump         =1'b0;
				end
		
		j:		begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b1;
				end
				
		jal: begin
				   alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b10;
					branch       =1'b0;
					regdest      =3'b10;
					Jump         =1'b1;
			  end
		
		bge: begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b00;
					branch       =1'b1;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		blt:  begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b1;
					regdest      =2'b00;
					Jump         =1'b0;
				end
		
		beq: begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b1;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		bne:  begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b1;
					regdest      =2'b00;
					Jump         =1'b0;
				end
		
		bgt:  begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b1;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		ble:  begin
					alusrc       =1'b0;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b1;
					regdest      =2'b00;
					Jump         =1'b0;
				end

		andi: begin
					alusrc       =1'b1;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b00;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		xori: begin
					alusrc       =1'b1;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b00;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		ori:  begin
					alusrc       =1'b1;
					memread      =1'b0;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b00;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		addi: begin
					alusrc       =1'b1;
					memread      =1'b1;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b01;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b0;
				end
		
		lw:   begin
					alusrc       =1'b1;
					memread      =1'b1;
					memwrite     =1'b0;
					regwrite     =1'b1;
					memtoreg     =2'b01;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b0;
				end
				
		sw:   begin
					alusrc       =1'b1;
					memread      =1'b0;
					memwrite     =1'b1;
					regwrite     =1'b0;
					memtoreg     =2'b00;
					branch       =1'b0;
					regdest      =2'b00;
					Jump         =1'b0;
				end
					
	endcase
	

end


endmodule

module control_dut;

//####################### Scalers Ports ###############################################//

wire alusrc  , memread , memwrite , regwrite  , Jump , branch;
reg clk;

//####################### Vector Ports ###############################################//

wire [1:0] regdest , memtoreg;

reg  [5:0]ir;

////////////instructions

parameter  rfmt =6'b000000 , bltz =6'b000001 , j     =6'b000010,
			  jal  =6'b000011 , beq  =6'b000100 , bne   =6'b000101,
			  blez =6'b000110 , bgtz =6'b000111 , addi  =6'b001000,
			  addiu=6'b001001 , slti =6'b001010 , sltiu =6'b001011,
			  andi =6'b001100 , ori  =6'b001101 , xori  =6'b001110,
			  lui  =6'b001111 , tlb  =6'b010000 , flpt  =6'b010001,
			  blt  =6'b010011 , bgt  =6'b010100 , bge   =6'b010101,
			  lb   =6'b100000 , lh   =6'b100001 , lwl   =6'b100010,
			  lbu  =6'b100100 , lhu  =6'b100101 , lwr   =6'b100110,
			  sh   =6'b101001 , swl  =6'b101010 , sw    =6'b101011,
			  lwc1 =6'b110001 , swc0 =6'b111000 , swc1  =6'b111001,
           ble  =6'b010110 , lw   =6'b100011 , sb    =6'b101000,
			  lwc0 =6'b110000 ;

////////////branch control signals

/*parameter pc_plus4=4'b0000,branch_j=4'b0001,branch_jr=4'b0010,branch_beq=4'b0011,branch_bne=4'b0100,branch_blez=4'b0101,
			 branch_bgtz=4'b0110,branch_blt=4'b0111,branch_bgt=4'b1000,branch_bge=4'b1001,branch_ble=4'b1010,branch_jal=4'b1011;		*/	
	

/////////////////////////////////circuit under test/////////////////////////////////
control_unit dut(clk,ir,regdest,alusrc,branch,memread,memwrite,regwrite,memtoreg,Jump);

////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////input test vectors//////////////////////////////////////////////////////

	initial begin : test_vectors
			
			#30 ir=rfmt;
			#60
			ir=j;
			#60
			ir=jal;
			#60
			ir=beq;
			#60
			ir=bne;
			#60
			ir=bge;
			#60
			ir=blt;
			#60
			ir=bgt;
			#60
			ir=ble;
			#60
			ir=addi;
			#60
			ir=andi;
			#60
			ir=ori;
			#60
			ir=xori;
			#60
			ir=lw;
			#60
			ir=sw;
			#60;
			
	end
	
	
	initial begin : clk_generation
		clk=0;
		
		forever #30 clk=~clk;
	
	end
	
	
endmodule