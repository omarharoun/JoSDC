/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: 32-bit adding using look ahead for carry algorithm for faster addition.
*/
/////////////////////////////////////////////////////////////////////////////////////

module adder_cla(cin,s,in1,in2,sum,cout,ov);


//**************vectors
input [31:0]in1,in2;
output [31:0]sum;

//***************scalers

//carry handlers
input cin;
output cout;

//sign or unsigned sum/sub option

input s; //s=0 unsigned and s=1 signed

//overflow detection
output ov;

//wires 
wire [32:0]c;
wire [31:0]y;
wire [1:0]over_flow; //signed or unsigned overflow decision

//variables used in the next (parallel) generation blocks

genvar i;

//************************************Circuit*****************************************

//circuit is structrual and continues (on input change) as the circuit has no sensitivity list (clocking nethodology).
//for_sub_decision 
generate			
	   for (i=0;i<32;i=i+1) begin:for_sub_decision
		assign y[i]=in2[i] ^ cin;
		end
endgenerate 

//carry look ahead circuit
generate		//note that (in1[i]|y[i]) can be replaced by xor
		for (i=0;i<32;i=i+1) begin:looking_ahead_for_the_carry
			assign c[i+1]=(in1[i]&y[i]) | (c[i]&(in1[i]|y[i])); //remmember that generate with loop will 
																					  //duplicate in parrallel the the statements 
																					  //in the generate block hence previous loop statements will be placed when called  
		end
endgenerate

//sum_duplication
generate
		for (i=0;i<32;i=i+1) begin:sum_duplication
			assign sum[i]=(in1[i]^y[i])^c[i]; // sum bit is one if the two bits are different and with carry if odd combination
		end
endgenerate

//initialize and setup wiring
assign c[0]=cin;
assign cout=c[32];

//overflow detection
//signed 
assign over_flow[0]=(in1[31] == in2[31]) && (in1[31] != sum[31]);
 

/*Two negative numbers are added and an answer comes positive or 
Two positive numbers are added and an answer comes as negative. */

//unsigned
assign over_flow[1]=cin ^ cout; //AT addition CI=0 if overflow if the result bigger CO=1 at sub CI=1 ov at result co=0

//ov decision
assign ov=(s&over_flow[0]) | (~s&over_flow[1]);

/*
        1111
		  1110
		  11101

*/



endmodule 

module adder_cla_dut;

	//registers to put test values to
	reg [31:0]in1,in2;
	reg cin,s;
	//wires to prob outputs from
	wire [31:0]sum;
	wire cout,ov;
	
	//ciruit under test
	adder_cla adder(cin,s,in1,in2,sum,cout,ov);
	///////////////////

		initial begin : test_vectors
		s=0;
		in1=32'd3;cin=0;in2=32'd10;
		#20 
		cin=1;
		#20
		cin=0;
		#20
		s=1;
		in1=32'hffffffff; in2=32'd5;
		#20
		cin=1;
		#20;
		end
		
endmodule 









