//-----------------------------------------------------
// File Name : regstest.sv
// Function : testbench for pMIPS 32 x n registers, %0 == 0
// Version 1 : code template for Cyclone  MLAB 
//             and true dual port sync RAM
// Author: tjk
// Last rev. 25 Oct 2012
//-----------------------------------------------------

`timescale 1ns/10ps
module regstest;

parameter n = 8;

logic clk, w;
logic [n-1:0] Wdata;
logic [4:0] Raddr1, Raddr2;
logic [n-1:0] Rdata1, Rdata2;
//logic [n-1:0] result;

regs  #(.n(n)) r(.*);

initial
begin
  clk =  0;
  #5  forever #5ns clk = ~clk;
end

initial
begin
    w = 1;
    Raddr1 = 1; Raddr2 = 2;
    Wdata = 11; ;

  #12 w = 0;
  #10 Wdata= 8'hFF;
  #10 w = 1;
  #10 Raddr2 = 0; Raddr1 = 0; // test reg %0
  #10 Wdata= 8'hFF;Raddr2 = 1;Raddr1 = 1;
  #10 Wdata = 8'hAF; Raddr2 = 2; Raddr1 = 1;
  #10 Raddr2 = 1;  Raddr1 = 2;
end

	

endmodule // module regstest