module Jump_Register_Mux (Jump_Register_Output, Jump_Register , Jump_Register_Addr , Jump_Output) ;

  // Scalers 
  
    input Jump_Register ; 
  
  // Vectors 
  
   input      [31:0] Jump_Register_Addr , Jump_Output ; 
	
	output  [31:0] Jump_Register_Output ;
	
  /***********************************/
  
  // Select either 'Jump_Output' from the register file or the Jump_Register_Addr as the input PC Register.
    // if Jump_Register = 0  --> Output = Jump_Output
    // if Jump_Register = 1  --> Output = Jump_Register_Addr 
       
		 assign Jump_Register_Output =   (!Jump_Register) ? Jump_Output : Jump_Register_Addr ;  



endmodule