
module Nor32_Gate(Out , In1 , In2);


  // Vectors

    input  [31:0] In1 , In2 ;
  
    output [31:0] Out ;
  
  // out = invert(In1 or In2)
  
    assign Out = ~(In1 | In2) ;


endmodule