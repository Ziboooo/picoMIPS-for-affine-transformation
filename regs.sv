//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 32 x n registers, %0 == 0
// Version 1 :
// Author: zy1u21
// Last rev. 11/01/2022
//-----------------------------------------------------
module regs #(
    parameter n = 8   // n - data bus width
) 
(input logic clk, w, // clk and write control
 input logic [n-1:0] Wdata,
 input logic [2:0] Raddr1, Raddr2,
 output logic [n-1:0] Rdata1, Rdata2
 //output logic [n-1:0] result
 );

 	// Declare 6 n-bit registers 
	logic [n-1:0] gpr [3:0];
//assign result = gpr[7];

	
	// write process, dest reg is Raddr2
	always_ff @ (posedge clk)
	begin
	    
		if (w)
            gpr[Raddr2-1] <= Wdata;
	
	
	end

	// read process, output 0 if %0 is selected
	always_comb
        begin
	 if (Raddr1==3'd0)
	         Rdata1 =  {n{1'b0}};
        else 
		   Rdata1 = gpr[Raddr1-1];
	 
 
	 Rdata2 = gpr[Raddr2-1];
	end
	

endmodule // module regs