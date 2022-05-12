//-------------------------------------------------------------
//file name: aluteset.sv
//funtinon: testbench for alu.sv 
//author: zy1u21
//version: 1 test two function
//last version: 10/04/2022
//-------------------------------------------------------------

`timescale 1ns/10ps

module alutest #(
    parameter datalength = 8
);
logic signed [datalength-1 : 0] a, b;
logic ALUfunc;
logic signed [datalength-1 : 0] result;

alu #(.datalength(datalength)) atest (.a(a),.b(b),.func(ALUfunc),.result(result));

initial
    begin 
        a = '0;
        b = '0;
        ALUfunc = '0;      // ALUfunc default 0
    end

initial
    begin 
        // 50+0.5, 50*0.5
        a = 50;
        b = 8'b01000000;
        ALUfunc = 1;  //+
        #5;
        ALUfunc = 0;  // *
#5
        //-50+-0.5, -50*-0.5
        a = -50;
        b = 8'b11000000;
        ALUfunc = 1;  //+
        #5;
        ALUfunc = 0;  //*
#5
        // 127+-127, 127*-127
        a = 127;    
        b = -127;
        ALUfunc = 1;  //+
        #5;
        ALUfunc = 0;  //*
#5
        //24+0.75, 24*0.75
        a = 24;
        b = 8'b01100000;
        ALUfunc = 1;  //+
        #5;
        ALUfunc = 0;  //*
#5      
        ALUfunc = 1;

    end

endmodule