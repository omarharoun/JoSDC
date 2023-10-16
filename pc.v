/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: Hold current instruction address for processing the instruction.
*/
//////////////////////////////////////////////////////////////////////////////////////////

module pc(clk,d,q);

//####################### Scalers Ports ###############################################//
input clk;

//####################### Vector Ports ###############################################//
input [31:0]d;
output reg [31:0]q;

//####################### circuit     ###############################################//


//procedural implentation as the sequential nature of the circuit require sensitivity list

always @(posedge clk) begin 
	
	q <=d;

end

endmodule

module pc_dut;
	//registers to put test values to
	reg [31:0]d;
	reg clk;
	//wires to prob outputs from
	wire [31:0]q;
	
	//ciruit under test
	pc pc_ut(.clk(clk),.d(d),.q(q));
	///////////////////
	
	initial begin : test_vectors
		d=32'b0;
		#20 d=32'd20;
		#40 d=32'd10;
	end
	
	initial begin : clk_generation
		clk=0;
		forever
		#10 clk=~clk;
	
	end
	
endmodule 


