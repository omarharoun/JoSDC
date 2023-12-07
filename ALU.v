module ALU(ALU_Op,In1,In2,Result,Z,Cout,OF);// add the flag . 

  //Scalers
  
    output Cout , OF;
	 output reg Z ;

  //Vectors

    input [7:0]  ALU_Op    ;// ALU Operation
    input [31:0] In1 , In2 ;// ALU Inputs

    output  reg [31:0] Result;// ALU Output

  //Wires
  
    wire       S       , Cin                                                       ;
    wire [31:0]Result0 , Result1 , Result2 , Result3 , Result4 , Result5 , Result6 ;
	 

  //Operations 
  
    parameter ADD   = 8'h0  , SUB = 8'h1  , AND32 = 8'h2  , OR32 = 8'h3  , XOR32 = 8'h4  , 
              NOR32 = 8'h5  , SRL = 8'h6  , SLL   = 8'h7  , ADDU = 8'h8  , SUBU  = 8'h9  ,
				  BEQ   = 8'h10 , BNE = 8'h11 , BLT   = 8'h12 , BGT  = 8'h13 , BGE   = 8'h14 ,
				  BLE   = 8'h15 ;

  // Unsigned --> S = 0 , Signed --> S = 1 
  
    assign S   = (ALU_Op == ADD) |  (ALU_Op == SUB) ;
	 
  // Carry In Bit
  
    assign Cin = (ALU_Op == SUB) |   (ALU_Op ==SUBU);
	 
  // 32 - bit Carry lookahead Adder model 
  
    adder_cla adder_2 (Cin , S , In1 , In2 , Result0 , Cout , OF); 

  // 32 - bits And Gate
  
    And32_Gate b (Result1 , In1 , In2);
	 
  // 32 - bits Or Gate
	 
    Or32_Gate c(Result2 , In1 , In2);
	 
  // 32 - bits Xor Gate

	 Xor32_Gate d (Result3 , In1 , In2);
	 
  // 32 - bits Nor Gate
  
    Nor32_Gate e (Result4 , In1 , In2);
	 
  // 32 - bits Shift Left Logical model
 
    SLL32_Bit f (Result5 , In1 , In2);

  // 32 - bits Shift Right Logical model
    
	 SRL32_Bit g (Result6 , In1 , In2);
  
  /**********************************/

    always@(*) begin
	 
      case(ALU_Op)
		
		  ADD : begin Result = Result0;Z = 1'b0; end 
		  SUB : begin Result = Result0;Z = 1'b0; end 
		  SUBU: begin Result = Result0;Z = 1'b0; end 
		  ADDU: begin Result = Result0;Z = 1'b0; end 

		  
		  AND32: begin Result = Result1;Z = 1'b0; end 
        OR32 : begin Result = Result2;Z = 1'b0; end 
		  XOR32: begin Result = Result3;Z = 1'b0; end 
		  NOR32: begin Result = Result4;Z = 1'b0; end 
		
		  SLL: begin Result = Result5;Z = 1'b0; end
		  SRL: begin Result = Result6;Z = 1'b0; end
		  
		  BEQ: Z = (In1 == In2) ? 1'b1 : 1'b0 ;
		  BNE: Z = (In1 != In2) ? 1'b1 : 1'b0 ;
		  BLT: Z = (In1 < In2)  ? 1'b1 : 1'b0 ;
		  BGT: Z = (In1 > In2)  ? 1'b1 : 1'b0 ;
		  BGE: Z = (In1 >= In2) ? 1'b1 : 1'b0 ;
		  BLE: Z = (In1 <= In2) ? 1'b1 : 1'b0 ;

		endcase
	 end
endmodule 


module ALU_TestBench();

  // Reg for Test Values.

    reg [31:0] In1   , In2;
    reg [7:0]  ALU_Op     ;
	 
  //  Define the output Wires.

    wire [31:0] Result;
    wire Z,Cout,OF;

    parameter ADD   = 8'h0  , SUB = 8'h1  , AND32 = 8'h2  , OR32 = 8'h3  , XOR32 = 8'h4  , 
              NOR32 = 8'h5  , SRL = 8'h6  , SLL   = 8'h7  , ADDU = 8'h8  , SUBU  = 8'h9  ,
				  BEQ   = 8'h10 , BNE = 8'h11 , BLT   = 8'h12 , BGT  = 8'h13 , BGE   = 8'h14 ,
				  BLE   = 8'h15 ;



  // Device Under Test .

   ALU DUT (ALU_Op,In1,In2,Result,Z,Cout,OF);

  /************************/

  `timescale 1ns / 1ps

  initial begin
  
	
    In1=32'h5;
	 In2=32'h1;
	
	 #20 // General Tests For check all Models Work proprely
	
	 ALU_Op=ADD;
	
	 #20
	
	 ALU_Op=SUB;
	
	 #20
	
	 ALU_Op=AND32;
	
	 #20
	
	 ALU_Op=OR32;
	
	 #20
	
	 ALU_Op=XOR32;
	 
	 #20
	
	 ALU_Op=NOR32;
	
	 #20
	
	 ALU_Op=SRL;
	
	 #20
	
	 ALU_Op=SLL;
	
	 #20
	
	 ALU_Op=ADDU;
	
	 #20
	
	 ALU_Op=SUBU;
	 
	 #20
	
	 ALU_Op=BEQ;
	 
	 #20
	
	 ALU_Op=BNE;
	 
	 #20
	
	 ALU_Op=BLT;
	 
	 #20
	
	 ALU_Op=BGT;
	 
	 #20
	
	 ALU_Op=BGE;
	 
	 #20
	
	 ALU_Op=BLE;
	 
	 
	 #20  // Check specific cases (OverFlow
	
    In1=32'h7FFFFFFF; // Max positive Value for signed numbers 
	 In2=32'h1;

    ALU_Op=ADD; // Should appear overflow
	 
	 #20

	 ALU_Op=ADDU; // Shouldn't appear overflow
	 
	 #20
	 
	 In1=32'hFFFFFFFF; // Max positive Value for Unsigned numbers 
	 In2=32'h1;
	
    ALU_Op=ADD; // Shouldn't appear overflow
	 
	 #20

	 ALU_Op=ADDU; // Shouldn't appear overflow

end

endmodule