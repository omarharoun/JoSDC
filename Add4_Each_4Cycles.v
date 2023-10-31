module Add4_Each_4Cycles (Clk , Present_Inst , Next_Inst);

  //Scalers 
  
    input Clk  ;
  
  //Vectors
  
    input [31:0] Present_Inst ;
  
    output [31:0] Next_Inst   ;
  
  //Wires
  
    wire Cout , OF ;
    wire [31:0]  Next_Inst_Temp;
  
  //Registers
  
    reg [2:0]  Cycle_Count;     // Counter to keep track of the cycle count
	 reg [31:0] Next_Inst  ;
 	 
	 
  /************************************************************************/	 
  
  // Carry lookahead adder "adder_cla(cin,s,in1,in2,sum,cout,ov)"

    adder_cla adder_1(1'b0 , 1'b0 , 32'h4 , Present_Inst , Next_Inst_Temp , Cout ,OF);
  	 
	 
  // Initializing Cycle_Count
    initial begin
	 
      Cycle_Count = 0; // Setting the initial value of Cycle_Count to zero
		
    end
  
    always @(posedge Clk) begin
	 
      if (Cycle_Count < 4) begin
			 
        // Increment the cycle count
				
          Cycle_Count <= Cycle_Count + 1;
				  
      end else begin
        
		  // When 4 cycles have passed, add 4 to the input
          
			 Next_Inst <= Next_Inst_Temp;
					 
          Cycle_Count <= 0; // Reset cycle count
			 
      end
		
    end
    
endmodule




// Testbench for Add4_Each_4Cycles module

module Add4_Each_4Cycles_Testbench();

  // Reg for Test Values
  
    reg        Clk         ;
    reg [31:0] Present_Inst;
	 
  // Define the output Wires.

    wire [31:0] Next_Inst;

  // Device Under Test .
    Add4_Each_4Cycles dut (Clk , Present_Inst , Next_Inst);


  // Stimulus
    
	 initial begin
      
		// Initialize input
		
        Present_Inst = 32'h0; 

      // Simulate for 5 clock cycles
      // Each addition will occur after 4 cycles
        
		  #200 

      // Change input values
        
		  Present_Inst = 32'h4; 

        #200; 
    end
	 
	 
    // Clock generation
      
		initial begin
		
        Clk = 0;
        
		  forever #10 Clk = ~Clk;
    end
	 
endmodule