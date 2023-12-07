`timescale 1ns / 1ns

module processor_TestBench;


  // Reg for Test Values.
  
    reg Clk;
    wire [31:0] Inst;
	 
  //  Define the output Wires.
  
    wire ALU_Src, Mem_Read, Mem_Write, Reg_Write, Z, Cout, OF, Jump, Jump_Register;
    wire [1:0] Reg_Dest , Mem_To_Reg;
    wire [3:0] Branch, ALU_Op;
    wire [4:0] Dest_Addr1, Dest_Addr2;
    wire [31:0] Read_Data1, Read_Data2, Imm_Signed_Extended, ALU_Src_Mux_Out, ALU_Result;
    wire [31:0] Read_Data, Read_Data_2, Write_Data1, Present_Inst_Addr, Next_Inst_Addr, Imm_Signed_Extended_Branches_SLLBy2;
    wire [31:0] Branch_Addr, PCPlus4_BranchesAddr_Output, Jump_Output, Jump_SLLBy2, Jump_Register_Output, Write_Data2;

processor uut (
  .Clk(Clk),
  .ALU_Src(ALU_Src),
  .Mem_Read(Mem_Read),
  .Mem_Write(Mem_Write),
  .Reg_Write(Reg_Write),
  .Mem_To_Reg(Mem_To_Reg),
  .Z(Z),
  .Cout(Cout),
  .OF(OF),
  .Jump(Jump),
  .Jump_Register(Jump_Register),
  .Reg_Dest(Reg_Dest),
  .Branch(Branch),
  .ALU_Op(ALU_Op),
  .Dest_Addr1(Dest_Addr1),
  .Dest_Addr2(Dest_Addr2),
  .Inst(Inst),
  .Read_Data1(Read_Data1),
  .Read_Data2(Read_Data2),
  .Imm_Signed_Extended(Imm_Signed_Extended),
  .ALU_Src_Mux_Out(ALU_Src_Mux_Out),
  .ALU_Result(ALU_Result),
  .Read_Data(Read_Data),
  .Read_Data_2(Read_Data_2),
  .Write_Data1(Write_Data1),
  .Present_Inst_Addr(Present_Inst_Addr),
  .Next_Inst_Addr(Next_Inst_Addr),
  .Imm_Signed_Extended_Branches_SLLBy2(Imm_Signed_Extended_Branches_SLLBy2),
  .Branch_Addr(Branch_Addr),
  .PCPlus4_BranchesAddr_Output(PCPlus4_BranchesAddr_Output),
  .Jump_Output(Jump_Output),
  .Jump_SLLBy2(Jump_SLLBy2),
  .Jump_Register_Output(Jump_Register_Output),
  .Write_Data2(Write_Data2)
);


  
	initial begin : clk_generation
		Clk=0;
	end
	always #60 Clk=~Clk;
	
	 
endmodule
