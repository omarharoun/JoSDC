/////////////////////////////////////////////////////////////////////////////////////////
/*
done by:  Omar Haroun
Date:     28/10/2023 - 8:48 PM
Function: demultiplexer for data memory 
*/
//////////////////////////////////////////////////////////////////////////////////////////


module Memory_demux(addrs_src,addrs_des) ; 
input[31:0] addrs_src ; 
output[31:0] addrs_des; 

assign addrs_des = (addrs_src>32'h0000FFFF) ? (addrs_src - 32'h0000FFFF) : addrs_src ;


 
endmodule
