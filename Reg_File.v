/*

Done By : Ahmad Haroun
Date    : 10/20/2023 

*/ 

module Reg_File (Clk , Read_Reg1 , Read_Reg2 , Read_Data1 , Read_Data2 , Write_Reg , Write_Data  , Reg_Write );

  // Scalers
  
    input Reg_Write , Clk ;
  
  // Vectors
  
    input  [31:0] Write_Data                        ;
	 input  [4:0]  Read_Reg1 , Read_Reg2 , Write_Reg ; 
	 
	 output reg [31:0] Read_Data1 , Read_Data2 ;
	 
  // Registers
  
    reg [31:0] RegFile [0:31] ;
	 
  /******************************/ 
  
    always@(posedge Clk) begin
	
      //
		
		  if(!Read_Reg1) Read_Data1 <= 32'b0    ; // R0(Hard Wire) --> Read_Data1
		
	  	  else Read_Data1 <= RegFile[Read_Reg1] ; // R[Read_Reg1]  --> Read_Data1
     
	  //
	  
 		  if(!Read_Reg2) Read_Data2 <= 32'b0    ; // R0(Hard Wire) --> Read_Data2
		
	 	  else Read_Data2 <= RegFile[Read_Reg2] ; // R[Read_Reg2]  --> Read_Data2
   
	 //

	    if(Reg_Write) begin
		   
			if(!Write_Reg) RegFile[Write_Reg] <= 32'b0 ; // R0  <-- 32'b0 
			
			else RegFile[Write_Reg] <= Write_Data      ; // R[Write_Reg]  <-- Write Data
			
		 end
 
    end 

endmodule


`timescale 1ns / 1ps

module Reg_File_TestBench();
  
  // Reg for Test Values.
  
    reg        Clk      , Reg_Write             ;
	 reg [4:0]  Read_Reg1, Read_Reg2 , Write_Reg ;
	 reg [31:0] Write_Data                       ; 
	 
  //  Define the output Wires.
  
    wire [31:0] Read_Data1 , Read_Data2 ; 
	 
	 
  // Device Under Test .
  
    Reg_File DUT (Clk , Read_Reg1 , Read_Reg2 , Read_Data1 , Read_Data2 , Write_Reg , Write_Data  , Reg_Write);

  /*****************************/
	 initial begin 
	   #20
                Reg_Write = 1'b0 ;
		Read_Reg1 = 32'b0 ;
		Read_Reg2 = 32'b0 ;
		
		#40
		
		Write_Reg  = 5'd2 ;
		Write_Data = 32'd6;
	  
	   #40
	  
	   Read_Reg1 = 5'd2 ;
	  
	   #40 
		
	   Read_Reg1 = 32'b0 ;
	   Reg_Write = 1'b1 ;
	
      #40 
	
      Read_Reg1 = 5'd2 ;
		
	   #40	           ;
	 
	 end
	 
  // ClK Genetration 	 
	    initial begin 
	
		   Clk = 0 ;
			
		   forever #20 Clk = ~Clk ; 
			
		 end 

   //
	 
endmodule


