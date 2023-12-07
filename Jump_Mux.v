module Jump_Mux (Jump_Output, Jump , Jump_Addr , PCPlus4_BranchesAddr_Output) ;

  // Scalers 
  
    input Jump ; 
  
  // Vectors 
  
   input      [31:0] Jump_Addr , PCPlus4_BranchesAddr_Output ; 
	
	output  [31:0] Jump_Output ;
	
  /***********************************/
  
  // Select either 'Jump_Addr' from the register file or the PCPlus4_BranchesAddr_Output as the second input for the Next MUX.
    // if Jump = 0  --> Output = PCPlus4_BranchesAddr_Output
    // if Jump = 1  --> Output = Jump_Addr 
       
		 assign Jump_Output =   (!Jump) ? PCPlus4_BranchesAddr_Output : Jump_Addr ;  



endmodule