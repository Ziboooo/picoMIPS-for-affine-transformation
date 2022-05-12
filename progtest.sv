//-------------------------------------------------------------------------
//file name: progtest.sv
//funtinon: testbench for program memory Psize*Isize - reads from file prog.hex
//author: zy1u21
//version: 1 //  Psize width, Isize length
//last version: 12/04/2022
//--------------------------------------------------------------------------

module progtest;

localparam Psize = 4, Isize = 20;
logic [Psize-1 : 0] address;     // addres
logic [Isize-1 : 0] I;

prog #(.Psize(Psize),.Isize(Isize)) pr (.address(address),.I(I));

initial 
    begin 
        address = '0;
    end

initial 
    begin 
        for (int i = 0; i < (1<<Psize); i++) begin 
        #5    address = i;
        end // for loop
    end // initial 

endmodule

