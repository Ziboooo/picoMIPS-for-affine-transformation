//-------------------------------------------------------
//file name: decodertest.sv
//funtinon: testbench for decoder module 
//author: zy1u21
//version: 2 // test for ‘prog.hex’, ADD, 'ADDI, 'MULI, 'B(branch function) 
//last version: 12/04/2022
//-------------------------------------------------------
//-------------------------------------------------------

`define ADD  2'b00    //ADDITION
`define ADDI 2'b01   //ADDITION WITH IMMEDIATE
`define MULI 2'b10   //MULTIPLICATION with IMMEDIATE
`define B    2'b11   //BRANCH

//------------------------------------------

`timescale 1ns/10ps

module decodertest;

localparam Isize = 20;
localparam Psize = 6;
localparam datalength = 8;

 logic [1:0] opcode; // top 2 bits of instructions
 logic Wready, dataval;      // ready accept data I[7], data valid SW8
 logic PCincr;//PCabsbranch;      // PC control
 logic INen;        // flag for datain 
 logic ALUfunc;     // ALU control
 logic imm;         // imm mux control
 logic w;            // register file control

decoder #(.datalength(datalength)) d (.*);

// creat register for prog.hex
logic [Isize - 1 : 0 ] progMem_test [(1<<Psize)-1 : 0];
logic [Isize - 1 : 0 ] ins; 

initial 

    $readmemh("prog.hex", progMem_test);


initial 
    begin 
        opcode = 2'b00;  // opcode default 0
        Wready = 0;
        dataval = 0;
        PCincr = 1;
        //PCabsbranch = 0;
        INen = 0;
        ALUfunc = 0;
        imm = 0;
        w = 0;
    end


// abstract opcode Wready from Instruction 
initial 
    begin 
        for (int i = 0;i<18 ;i++ ) begin
        #5    ins = progMem_test [i];
            opcode = ins [Isize-1: Isize-2];
            Wready = ins [6];
            dataval = 0;
            #5
            dataval = 1;
            
        end

    end
endmodule 