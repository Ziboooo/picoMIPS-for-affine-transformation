//-------------------------------------------------------------------------
//file name: prog.sv
//funtinon: program memory Psize*Isize - reads from file prog.hex
//author: zy1u21
//version: 1 //  Psize width, Isize length
//last version: 10/04/2022
//--------------------------------------------------------------------------
module prog #(
    parameter Psize = 4, Isize = 20        // Psize - address width Isize - instruction width
) (
    input logic [Psize-1 : 0] address,     // address
    output logic [Isize-1 : 0] I            // I - instruction code
);
logic [Isize-1 : 0] progMem [(1<<Psize)-1:0]; // a Isize bit memory with a depth of 2^(Psize)

initial 
    $readmemh("prog.hex", progMem);     //get program memory from file: prog.hex

always_comb
    I = progMem[address];               // read instructions


endmodule // prog.sv