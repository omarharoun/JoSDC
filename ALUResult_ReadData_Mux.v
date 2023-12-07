/*

Done By : Ahmad Haroun
Date    : 10/20/2023 

*/ 

module ALUResult_ReadData_Mux (Write_Data_Output,MemToReg , Read_Data , ALU_Result) ;

  // Scalers 
  
    input MemToReg  ; 
  
  // Vectors 
  
   input      [31:0] Read_Data , ALU_Result ; 
	
	output  [31:0] Write_Data_Output      ;
	
  /***********************************/
  
  // Select either 'Readdata' from the memory or the ALU result value as write data for register file. 
    // if MemToReg = 0  --> Output = Read_Data
    // if MemToReg = 1  --> Output = ALU_Result 
       
		 assign Write_Data_Output =   (!MemToReg) ? ALU_Result : Read_Data ;  

endmodule

`timescale 1ns / 1ps

module ALUResult_ReadData_Mux_TestBench();

  // Reg for Test Values
  
    reg        MemToReg                 ;
	 reg [31:0] Read_Data  , ALU_Result  ; 
	 
  // Define the output Wires.
  
    wire [31:0] Write_Data_Output ; 

  // Device Under Test .

    ALUResult_ReadData_Mux  DUT (Write_Data_Output,MemToReg , Read_Data , ALU_Result) ;
	 
  /*************************/
  
    initial begin 
	 
	   #20
		MemToReg = 1'b0;
		
	   Read_Data  = 32'b0 ;
		ALU_Result = 32'b0 ;
		
		#40 
		
	   Read_Data   = 32'd2 ;
		ALU_Result  = 32'd1 ;
		
		#40
		
		MemToReg = 1'b1;
		
		#40 ;
	 
	 end
	 


endmodule 





