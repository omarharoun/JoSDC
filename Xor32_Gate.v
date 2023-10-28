
module Xor32_Gate(Out , In1 , In2);


  // Vectors

    input  [31:0] In1 , In2 ;
  
    output [31:0] Out ;
  
  // out = In1 xor In2
  
    assign Out = In1 ^ In2 ;


endmodule