/*

Done By : Ahmad Haroun
Date    : 10/20/2023 

*/ 

module Imm_ReadData2_Mux (Clk , ReadData2_Imm_Output, ALUSrc , Read_Data2 , Imm_SignExtended_32Bits) ;

  // Scalers 
  
    input ALUSrc ,Clk ; 
  
  // Vectors 
  
   input      [31:0] Read_Data2 , Imm_SignExtended_32Bits ; 
	
	output reg [31:0] ReadData2_Imm_Output ;
	
  /***********************************/
  
  // Select either 'Readdata2' from the register file or the sign-extended immediate value as the second input for the ALU. 
 
  always@(posedge Clk) begin 
   
    if(!ALUSrc) ReadData2_Imm_Output <= Read_Data2       ; // if ALUSrc = 0  --> Output = Read_Data2
	 
	 else ReadData2_Imm_Output <= Imm_SignExtended_32Bits ; // if ALUSrc = 1  --> Output = Imm_SignExtended_32Bits 
  

  end  
	
	
endmodule

`timescale 1ns / 1ps

module Imm_ReadData2_Mux_testbench();

  // Reg for Test Values
  
    reg        Clk        , ALUSrc                  ;
	 reg [31:0] Read_Data2 , Imm_SignExtended_32Bits  ; 
	 
  // Define the output Wires.
  
    wire [31:0] ReadData2_Imm_Output ; 

  // Device Under Test .

    Imm_ReadData2_Mux DUT (Clk , ReadData2_Imm_Output, ALUSrc , Read_Data2 , Imm_SignExtended_32Bits) ;
	 
  /*************************/
  
    initial begin 
	   #20
		ALUSrc = 1'b0;
		
	   Read_Data2              = 32'b0 ;
		Imm_SignExtended_32Bits = 32'b0 ;
		
		#40 
		
	   Read_Data2              = 32'd1 ;
		Imm_SignExtended_32Bits = 32'd2 ;
		
		#40
		
		ALUSrc = 1'b1;
		
		#40 ;
	 
	 end

  // ClK Genetration 	 
    initial begin 
	
      Clk = 0 ;
			
		forever #20 Clk = ~Clk ; 
			
	 end 
  
endmodule 




