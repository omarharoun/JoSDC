
module processor (Clk);

  //Scalers
  
    input Clk ;
  
  //Vectors
  
  //Wires
  
    wire         Reg_Dest  , ALU_Src , Mem_Read   , Mem_Write , Reg_Write , Mem_To_Reg , Z , Cout , OF                    ;
	 wire [3:0]   Branch    , ALU_Op                                                                                       ;
	 wire [31:0]  ROM_Addr  , Inst        ,  Read_Data1  , Read_Data2 , Imm_Signed_Extended , ALU_Src_Mux_Out , ALU_Result ;  
	 wire [31:0]  Read_Data , Read_Data_2   ,  Write_Data  , Present_Inst_Addr  , Next_Inst_Addr                             ;
  //Registers 
  
  /***********************************/
  
  //addition operation by 4 to jump to the next instruction using carry lookahead adder
    
	 Add4_Each_4Cycles (Clk , Present_Inst_Addr , Next_Inst_Addr);

  //Control unit "control_unit(clk,ir,regdest,alusrc,branch,memread,memwrite,regwrite,memtoreg)"
  
    control_unit(Clk , Inst[31:26] , Reg_Dest , ALU_Src , Branch , Mem_Read , Mem_Write , Reg_Write , Mem_To_Reg);
  
  //Program Counter "module pc(clk,d,q)"
  
    pc (Clk , Next_Inst_Addr , Present_Inst_Addr);

  //32 bits Read - Only Memory(ROM) "ROM_32_256 (address,clock,q)"
  
    ROM_32_256 (Present_Inst_Addr , Clk , Inst);
  
  //Destination Address Multiplexer "destr_add_mux(in1,in2,s,dest_address)"

    destr_add_mux(Inst[20:16] , Inst[15:11] , Reg_Dest , Dest_Addr) ;
  
  //Register File "Reg_File (Clk , Read_Reg1 , Read_Reg2 , Read_Data1 , Read_Data2 , Write_Reg , Write_Data  , Reg_Write )"
 
    Reg_File (Clk , Inst[25:21] , Inst[20:16] , Read_Data1 , Read_Data2 , Dest_Addr , Write_Data   , Reg_Write ); 
	 
  //32 bits signed extened block "imm_gen(imm,immse)" 
  
    imm_gen(Inst[15:0] , Imm_Signed_Extended);
	 
  //ALU Source Multiplexer "Imm_ReadData2_Mux (Clk , ReadData2_Imm_Output, ALUSrc , Read_Data2 , Imm_SignExtended_32Bits)"	 
	 
	 Imm_ReadData2_Mux (Clk , ALU_Src_Mux_Out , ALU_Src , Read_Data2 , Imm_Signed_Extended) ;
	 
  //Arthmetic logic unit control block "alu_con(clk,insfunc,insop,alu_op)"

    alu_con(Clk , Inst[5:0] , Inst[31:26] , ALU_Op);  
	
  //Arthmetic logic unit "ALU(ALU_Op,In1,In2,Result,Z,Cout,OF)"
  
    ALU(ALU_Op , Read_Data1 , ALU_Src_Mux_Out , ALU_Result , Z , Cout , OF);
	 
  //Random access memory (32 width - 65536 depth * 2) "Ram_32_65536 (address,clock,data,rden,wren,q)"
  //Mif files should ensure the address filled for each memory carefully
  
    Ram_32_65536   (ALU_Result , Clk , Read_Data2 , Mem_Read , Mem_Write , Read_Data);
	 
	 Ram_32_65536_2 (ALU_Result , Clk , Read_Data2 , Mem_Read , Mem_Write , Read_Data_2);
 
  //"ALUResult_ReadData_Mux (Clk , Write_Data_Output,MemToReg , Read_Data , ALU_Result)"
  
    ALUResult_ReadData_Mux (Clk , Write_Data , Mem_To_Reg , Read_Data | Read_Data_2 , ALU_Result) ;
	
endmodule