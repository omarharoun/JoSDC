/*

Done By : Ahmad Haroun
Date    : 10/20/2023 

*/ 

module ALUResult_ReadData_Mux (Clk , Write_Data_Output,MemToReg , Read_Data , ALU_Result) ;

  // Scalers 
  
    input MemToReg , Clk ; 
  
  // Vectors 
  
   input      [31:0] Read_Data , ALU_Result ; 
	
	output reg [31:0] Write_Data_Output      ;
	
  /***********************************/
  
  // Select either 'Readdata' from the memory or the ALU result value as write data for register file. 
 
  always@(posedge Clk) begin 
   
    if(!MemToReg) Write_Data_Output <= ALU_Result  ; // if MemToReg = 0  --> Output = Read_Data
	 
	 else Write_Data_Output <=   Read_Data     ; // if MemToReg = 1  --> Output = ALU_Result 
  
  end  
	
	
endmodule

`timescale 1ns / 1ps

module ALUResult_ReadData_Mux_TestBench();

  // Reg for Test Values
  
    reg        Clk        , MemToReg    ;
	 reg [31:0] Read_Data  , ALU_Result  ; 
	 
  // Define the output Wires.
  
    wire [31:0] Write_Data_Output ; 

  // Device Under Test .

    ALUResult_ReadData_Mux  DUT (Clk , Write_Data_Output,MemToReg , Read_Data , ALU_Result) ;
	 
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
	 
  // ClK Genetration 	 
    initial begin 
	
      Clk = 0 ;
			
		forever #20 Clk = ~Clk ; 
			
	 end 


endmodule 





