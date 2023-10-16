/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: generate a sign extended 32-bit from 16 bit directly coupled from IR[15:0].
*/
//////////////////////////////////////////////////////////////////////////////////////////

module imm_gen(imm,immse);

//####################### Scalers Ports ###############################################//

/*NONE*/

//####################### Vector Ports ###############################################//
input [15:0]imm;
output [31:0]immse;

//####################### generate block variable #####################################//

/*generation block used to duplicate continues assignments */
genvar i; //valid for next parallel blocks only not nested to avoid overlapping


//####################### circuit     ###############################################//	
	
/*continues assignment for cmbinational logic*/

assign immse[15:0]=imm[15:0];

generate
	for (i=16;i<32;i=i+1) begin:sign_extension
	assign immse[i]=imm[15];
	end
endgenerate


endmodule

module imm_gen_dut;

	//registers to put test values to
	reg [15:0]imm;
	//wires to prob outputs from
	wire [31:0]immse;
	
	//ciruit under test
	imm_gen DUT(imm,immse); 
	///////////////////
	
	initial begin : test_vectors
		imm=16'hfff5;
		#40
		imm=16'd4;
		#40;
	end
	

endmodule

