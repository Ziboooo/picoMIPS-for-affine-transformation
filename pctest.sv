//-------------------------------------------------------------------------
//file name: pctest.sv
//funtinon: testbench for program counter 
//author: zy1u21
//version: 1 //  increment relative branch
//last version: 12/04/2022
//--------------------------------------------------------------------------

`timescale 1ns/10ps

module pctest;

localparam Psize = 6;
logic clk,rst,PCincr;
logic [Psize-1 : 0] PCout;

pc #(.Psize(Psize) ) p (.*);

// inital clock
initial 
    begin 
        clk = 0;
        forever #5 clk=~clk;
    end

initial 
    begin 
        rst = 1;
        PCincr = 1;
        #5 rst = 0;
        #5 rst = 1; PCincr = 1;
        #60 PCincr = 0;
        #30 PCincr = 1;
        #60 PCincr = 0;
        #30 PCincr = 1;
        #60 PCincr = 0;
        #30 PCincr = 1;
        #60 PCincr = 0;
    end

endmodule


