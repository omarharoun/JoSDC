/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Mohammed A. Mardeni
Date:     7/10/2023 - 8:10 AM
Function: Select the destination register field S=0 for IR[20:16] at in1 and s=1 for IR[15:11] at in2.
*/
//////////////////////////////////////////////////////////////////////////////////////////


module destr_add_mux(in1,in2,s,dest_address);


//####################### Scalers Ports ###############################################//

input s;

//####################### Vector Ports ###############################################//
input [4:0]in1,in2;
output  [4:0]dest_address;

//####################### generate block variable #####################################//

/*generation block used to duplicate continues assignments */
genvar i; //valid for next parallel blocks only not nested to avoid overlapping


//####################### circuit     ###############################################//

/* combinational circuit hence continues assignment is used*/


generate
	
	for (i=0;i<5;i=i+1) begin:mux_5_bit_width
	assign dest_address[i]=( (~s) & in1[i]) | ( s & in2[i]);
	end
	
endgenerate




endmodule 

module destr_add_mux_dut;

	//registers to put test values to
	reg [4:0]in1,in2;
	reg s;
	//wires to prob outputs from
	wire [4:0]dest_address;
	
	//ciruit under test
	destr_add_mux DUT(in1,in2,s,dest_address);
	///////////////////
	
	initial begin : test_vectors
			
			in1=5'd4;in2=5'd2;
			#40
			s=0;
			#40
			s=1;
			#40;		
	end
	



endmodule

