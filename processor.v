module processor (
  input Clk,
  output  ALU_Src,
  output  Mem_Read,
  output  Mem_Write,
  output  [1:0]Mem_To_Reg,
  output  Reg_Write,
  output  Z,
  output  Cout,
  output  OF,
  output  Jump,
  output  Jump_Register,
  output  [1:0] Reg_Dest,
  output   Branch,
  output  [7:0] ALU_Op,
  output  [4:0] Dest_Addr1,
  output  [4:0] Dest_Addr2,
  output  [31:0] Inst,
  output  [31:0] Read_Data1,
  output  [31:0] Read_Data2,
  output  [31:0] Imm_Signed_Extended,
  output  [31:0] ALU_Src_Mux_Out,
  output  [31:0] ALU_Result,
  output  [31:0] Read_Data,
  output  [31:0] Write_Data1,
  output  [31:0] Present_Inst_Addr,
  output  [31:0] Next_Inst_Addr,
  output  [31:0] Imm_Signed_Extended_Branches_SLLBy2,
  output  [31:0] Branch_Addr,
  output  [31:0] PCPlus4_BranchesAddr_Output,
  output  [31:0] Jump_Output,
  output  [27:0] Jump_SLLBy2,
  output  [31:0] Jump_Register_Output,
  output  [31:0] Write_Data2
);


  /*//Scalers
  
    input Clk ;
  
  //Vectors
  
  //Wires
  
    wire         ALU_Src     , Mem_Read                    , Mem_Write  , Reg_Write         , Z                   , Cout                                , OF ,Jump ,Jump_Register ;
	 wire [1:0]   Reg_Dest    , Mem_To_Reg                                                                                                                                         ;
	 wire [3:0]   Branch      , ALU_Op                                                                                                                                             ;
	 wire [4:0]   Dest_Addr1  , Dest_Addr2                                                                                                                                         ; 
	 wire [31:0]  Inst        , Read_Data1                  , Read_Data2                     , Imm_Signed_Extended , ALU_Src_Mux_Out                     , ALU_Result              ;    
	 wire [31:0]  Read_Data   , Write_Data1, Present_Inst_Addr , Next_Inst_Addr      , Imm_Signed_Extended_Branches_SLLBy2                           ;
	 wire [31:0]  Branch_Addr , PCPlus4_BranchesAddr_Output , Jump_Output, Jump_SLLBy2       , Jump_Register_Output, Write_Data2                                                   ;
	 
  //Registers */
  
  
  
  /***********************************/
  
  //addition operation by 4 to jump to the next instruction using carry lookahead adder(Clock added in this module for counter needed)
    
	 adder_cla Address_Adder  (1'b0 , 1'b0 , 32'h4 , Present_Inst_Addr , Next_Inst_Addr ,,);
	 
  //module SLL32_Bit(Out , In , P);**
  
    SLL32_Bit Branches_SLL2  (Imm_Signed_Extended_Branches_SLLBy2 [31:0] , Imm_Signed_Extended[31:0] ,5'd2);    
	 
  //module adder_cla(cin,s,in1,in2,sum,cout,ov);**
   
	 adder_cla Branches_Addr (1'b0 , 1'b0 , Next_Inst_Addr , Imm_Signed_Extended_Branches_SLLBy2 ,Branch_Addr,,);  
	 
  //module PCPlus4_BranchesAddr_Mux (PCPlus4_BranchesAddr_Output, Branch_Zero , BranchesAddr , PCPlus4) ;**
 
    PCPlus4_BranchesAddr_Mux  a (PCPlus4_BranchesAddr_Output, Z & Branch , BranchesAddr , Next_Inst_Addr) ;
  
  //     **
	  SLL32_Bit Jump_SLL2 (Jump_SLLBy2[27:0] , Inst[25:0] ,5'd2);    

  //module Jump_Mux (Jump_Output, Jump , Jump_Addr , PCPlus4_BranchesAddr_Output) ;**

    Jump_Mux c (Jump_Output[31:0], Jump , {Next_Inst_Addr[31:28],Jump_SLLBy2[27:0]} , PCPlus4_BranchesAddr_Output[31:0]) ;
  
  //module Jump_Register_Mux (Jump_Register_Output, Jump_Register , Jump_Register_Addr , Jump_Output) ;

    Jump_Register_Mux d (Jump_Register_Output[31:0], Jump_Register , Read_Data1[31:0] , Jump_Output[31:0]) ;

  //Control unit "control_unit(clk,ir,regdest,alusrc,branch,memread,memwrite,regwrite,memtoreg)"
  
    control_unit f (Clk , Inst[31:26] , Reg_Dest[1:0] , ALU_Src , Branch , Mem_Read , Mem_Write , Reg_Write , Mem_To_Reg[1:0],Jump);
  
  //Program Counter "module pc(clk,d,q)"
  
    pc g (Clk , Jump_Register_Output[31:0] , Present_Inst_Addr[31:0]);

  //32 bits Read - Only Memory(ROM) "ROM_32_256 (address,clock,q)"
  
    ROM_32_256 h (Present_Inst_Addr[4:0] , Clk , Inst[31:0]);
  
  //Destination Address Multiplexer "destr_add_mux(in1,in2,s,dest_address)"

    destr_add_mux Dest_Addr_Mux1 (Inst[20:16] , Inst[15:11] , Reg_Dest[0] , Dest_Addr1[4:0]) ;
	 destr_add_mux Dest_Addr_Mux2 (Dest_Addr1 , 5'b11111 , Reg_Dest[1] , Dest_Addr2[4:0])     ;
  
  //Register File "Reg_File (Clk , Read_Reg1 , Read_Reg2 , Read_Data1 , Read_Data2 , Write_Reg , Write_Data  , Reg_Write )"
 
    Reg_File  j (Clk , Inst[25:21] , Inst[20:16] , Read_Data1[31:0] , Read_Data2[31:0] , Dest_Addr2[4:0] , Write_Data2[31:0]  , Reg_Write ); 
	 
  //32 bits signed extened block "imm_gen(imm,immse)" 
  
    imm_gen k (Inst[15:0] , Imm_Signed_Extended[31:0]);
	 
  //ALU Source Multiplexer "Imm_ReadData2_Mux (ReadData2_Imm_Output, ALUSrc , Read_Data2 , Imm_SignExtended_32Bits)"	 
	 
	 Imm_ReadData2_Mux l (ALU_Src_Mux_Out , ALU_Src , Read_Data2 , Imm_Signed_Extended) ;
	 
  //Arthmetic logic unit control block "alu_con(clk,insfunc,insop,alu_op)"

    alu_con z (Clk , Inst[5:0] , Inst[31:26] , ALU_Op , Jump_Register);  
	
  //Arthmetic logic unit "ALU(ALU_Op,In1,In2,Result,Z,Cout,OF)"
  
    ALU x (ALU_Op , Read_Data1 , ALU_Src_Mux_Out , ALU_Result , Z , Cout , OF);
	 
  //Random access memory (32 width - 65536 depth * 2) "Ram_32_65536 (address,clock,data,rden,wren,q)"
  
    Ram_32_65536  q (ALU_Result , Clk , Read_Data2 , Mem_Read , Mem_Write , Read_Data);
	  
  //"ALUResult_ReadData_Mux (Write_Data_Output,MemToReg , Read_Data(1) , ALU_Result(0))"
  
    ALUResult_ReadData_Mux ALU_Src_Mux1 (Write_Data1 , Mem_To_Reg[0] , Read_Data, ALU_Result)      ;
	 ALUResult_ReadData_Mux ALU_Src_Mux2 (Write_Data2 , Mem_To_Reg[1] , Next_Inst_Addr, Write_Data1) ;

	
endmodule