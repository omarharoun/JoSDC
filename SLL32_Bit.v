
module SLL32_Bit(Out , In , P);

  // Vectors

    input  [4:0]  P ; // # of Positions

    input  [31:0] In ; //Input
  
    output [31:0] Out ;// output
  
  // Out = (2)^P * In 
  
    assign Out = (P > 0) ? (In <<< P) : In ;


endmodule