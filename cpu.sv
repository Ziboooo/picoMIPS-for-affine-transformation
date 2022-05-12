//-------------------------------------------------------------------------
//file name: cpu.sv
//funtinon: picMIPS cpu module for affine tranformation 
//author: zy1u21
//version: 1 //  alu, program counter, decoder, regs, prog
//last version: 11/04/2022
//--------------------------------------------------------------------------

module cpu #(
    parameter datalength = 8,
    parameter Psize = 4,           // address width 
    parameter Isize = 2+3+3+8    // instruction length 
)
(
    input logic clk,
    input logic rst, //master reset
    input logic [8:0] SW,
    output logic [datalength-1 : 0] dataout
);

// declaration of local signal that connect CPU modules
// progCounter
logic PCincr; //PCabsbranch;
logic [Psize-1 : 0] ProgAddress;  // instruction address
//.prog (progMemory)
logic [Isize-1 : 0] I;  // instruction code
//.decoder (D)
logic ALUfunc;          // alufunction control
logic imm;              // immediate control
logic w;                // write register control
logic INen;             // mux selection, SW input
//.regs (gpr)
logic [datalength-1 : 0] Wdata;
logic [datalength-1 : 0 ] Rdata1, Rdata2;
//.alu(iu)
logic [datalength-1 : 0] ALUb;  // mux output 
logic slowclk;


//--------codes start here ---------------------------
//module instantiation

counter #(24) clkcounter (.fastclk(clk), .clk(slowclk));

pc #(.Psize(Psize)) progCounter (.clk(slowclk), .rst(rst),
        .PCincr(PCincr),
        //.PCabsbranch(PCabsbranch),
        //.Branchaddr(I[Psize-1 : 0]),
        //output
        .PCout(ProgAddress)                          
);

prog #(.Psize(Psize),.Isize(Isize)) progMemory (
        .address(ProgAddress),
        .I(I)
);

decoder D (
        .opcode(I[Isize-1:Isize-2]),
        //output PC control
        .PCincr(PCincr),
        //.PCabsbranch(PCabsbranch),
        // ALU control
        .ALUfunc(ALUfunc),
        .imm(imm), .w(w),
        // mux control
        .Wready(I[6]),
        .dataval(SW[8]),
        .INen(INen)

);

regs #(.n(datalength)) gpr (.clk(slowclk), .w(w),
        .Wdata(Wdata),
        .Raddr1(I[(Isize-3) : (Isize-5)]),    // reg %d 
        .Raddr2(I[(Isize-6) :(Isize-8)]),   // reg %s
        .Rdata1(Rdata1),
        .Rdata2(Rdata2)
       //.result(dataout)

);

alu #(.datalength(datalength)) iu (
        .func(ALUfunc),
        .a(Rdata1),        // input a from regidter [Raddar1]
        .b(ALUb),          // input b from mux: imm, external. register 
        .result(Wdata)    //alu result to register
);

// mutiplexer for ALU B 3to1
always_comb begin //mux
    if (imm) ALUb = I[datalength-1 : 0];   // immediate
    else if (INen) ALUb = SW[7:0];              // input
    else ALUb = Rdata2;                    // register 2
end // always_comb


assign dataout = ALUb; /// led comes from Rdata2



endmodule