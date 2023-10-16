
/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: To hold temprory data from main memory for alu execution and addressing.
*/
//////////////////////////////////////////////////////////////////////////////////////////

module register_file(clk,sr1_add,sr2_add,sr1_data,sr2_data,dr_add,write_data,reg_write);

//####################### Scalers Ports ###############################################//
input reg_write,clk;

//####################### Vector Ports ###############################################//
output reg [31:0]sr1_data,sr2_data;
input [31:0]write_data;
input [4:0]sr1_add,sr2_add,dr_add; 

//####################### register blocks ###############################################//
reg [31:0] regfile[31:0];

//####################### circuit     ###############################################//

//implemntation will be procedural as we can use fpga internal registers for effecient use.
//implemntation is double pumped meaning the registrer file read at posedge of clk and write at regative edge
//NOTE !address zero is hardwired to ground!

//positive pump
always @(posedge clk) begin
	
      //register source 1 data acquisition at posedge of the clk
		if (!sr1_add)
		sr1_data<=32'b0; //address zero is hard wired to zero
		else
		sr1_data<=regfile[sr1_add];

		//register source 2 data acquisision at posedge od the clk
		if (!sr2_add)
		sr2_data<=32'b0; //address zero is hard wired to zero
		else
		sr2_data<=regfile[sr2_add];

end

//negative pump
always @(negedge clk)begin
	
	if (reg_write)begin
		if (!dr_add)
		regfile[dr_add]<=32'b0;
		else
		regfile[dr_add]<=write_data;

	end
	
end

endmodule

module register_file_dut;

	//registers to put test values to
	reg [4:0]sr1_add,sr2_add,dr_add;
	reg [31:0]write_data;
	reg reg_write;
	reg clk;
	//wires to prob outputs from
	wire [31:0]sr1_data,sr2_data;
	
	//ciruit under test
	register_file DUT(clk,sr1_add,sr2_add,sr1_data,sr2_data,dr_add,write_data,reg_write);
	///////////////////
	
	initial begin : test_vectors
			
			sr1_add=32'd0;sr2_add=32'd0;
			#40
			dr_add=3;
			write_data=32'd4;
			#40
			sr1_add=3;
			#40
			reg_write=1'b1;
			#40;
			
	end
	
	initial begin : clk_generation
		clk=0;
		forever
		#30 clk=~clk;
	
	end
	


endmodule


