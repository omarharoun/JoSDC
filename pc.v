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




