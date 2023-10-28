module ALU(ALU_Op,In1,In2,Result,Z,Cout,OF);

  //Scalers

    output Z , Cout , OF;

  //Vectors

    input [3:0]  ALU_Op    ;// ALU Operation
    input [31:0] In1 , In2 ;// ALU Inputs

    output reg [31:0] Result;// ALU Output

  //Wires
  
    wire       S       , Cin                                                       ;
    wire [31:0]Result0 , Result1 , Result2 , Result3 , Result4 , Result5 , Result6 ;

  //Operations 
  
    parameter ADD  = 4'd0  , SUB= 4'd1 , AND32= 4'd2 , OR32= 4'd3 , XOR32=4'd4 , 
              NOR32= 4'd5  , SRL= 4'd6 , SLL  = 4'd7 , ADDU= 4'd8 , SUBU =4'd9 ;


  // Unsigned --> S = 0 , Signed --> S = 1 
  
    assign S   = (ALU_Op == ADD) |  (ALU_Op == SUB) ;
	 
  // Carry In Bit
  
    assign Cin = (ALU_Op == SUB) |   (ALU_Op ==SUBU);// !!!!!
	 
  // 32 - bit Carry lookahead Adder model 
  
    adder_cla a (Cin , S , In1 , In2 , Result0 , Cout , OF); 

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

    always @(*) begin
	 
	   case(ALU_Op)
		  ADD : Result = Result0;
		  SUB : Result = Result0;
		  SUBU: Result = Result0;
		  ADDU: Result = Result0;
		  
		  AND32: Result = Result1;
        OR32 : Result = Result2;
		  XOR32: Result = Result3;
		  NOR32: Result = Result4;
		
		  SLL: Result = Result5;
		  SRL: Result = Result6;
		
		endcase

    end


endmodule 


module ALU_TestBench();

  // Reg for Test Values.

    reg [31:0] In1   , In2;
    reg [3:0]  ALU_Op     ;
	 
  //  Define the output Wires.

    wire [31:0] Result;
    wire Z,Cout,OF;


    parameter ADD  = 4'd0  , SUB= 4'd1 , AND32= 4'd2 , OR32= 4'd3 , XOR32=4'd4 , 
              NOR32= 4'd5  , SRL= 4'd6 , SLL  = 4'd7 , ADDU= 4'd8 , SUBU =4'd9 ;

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