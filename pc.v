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


  // Wires 
  
    reg [2:0]  Cycle_Count;     // Counter to keep track of the cycle count


//####################### circuit     ###############################################//


//procedural implentation as the sequential nature of the circuit require sensitivity list

  // Initializing Cycle_Count
    initial begin
	 
      Cycle_Count = 0; // Setting the initial value of Cycle_Count to zero
		q = 32'b0 ; 
    end

always @(posedge clk) begin 

      if (Cycle_Count < 4) begin
			 
        // Increment the cycle count
				
          Cycle_Count <= Cycle_Count + 1;
				  
      end else begin
        
		  // When 4 cycles have passed, 
          
	       q <=d;
			 
          Cycle_Count <= 0; // Reset cycle count
			 
      end

end

endmodule



