module PCPlus4_BranchesAddr_Mux (PCPlus4_BranchesAddr_Output, Branch_Zero , BranchesAddr , PCPlus4) ;

  // Scalers 
  
    input Branch_Zero ; 
  
  // Vectors 
  
   input      [31:0] BranchesAddr , PCPlus4 ; 
	
	output  [31:0] PCPlus4_BranchesAddr_Output ;
	
  /***********************************/
  
  // Select either 'PCPlus4' from the register file or the BranchesAddr as the second input for the Next MUX.
    // if Branch_Zero = 0  --> Output = PCPlus4
    // if Branch_Zero = 1  --> Output = BranchesAddr 
       
		 assign PCPlus4_BranchesAddr_Output =   (!Branch_Zero) ? PCPlus4 : BranchesAddr ;  



endmodule