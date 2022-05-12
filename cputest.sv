`timescale 1ns/10ps

module cputest;

localparam datalength = 8;
localparam Psize = 6;
localparam Isize = 20;

logic clk;
logic [9:0] SW;
logic [7:0] led;

cpu #(.datalength(datalength),.Psize(Psize),.Isize(Isize)) mydesign 
    (.clk(clk),.rst(SW[9]),.SW(SW[8:0]),.dataout(led));

initial 
    begin 
        clk = 0;
    forever #5 clk=~clk;
    end

initial begin
    SW[9] = 1;
    SW[8:0] = 0;
    #10 SW[9] = 0;
    #10 SW[9] = 1;  // RESET
    #20 SW[8] = 1; //sw8=1, read sw0~7: 24
        SW[7:0] = 8'b00000000;
    #10 SW[7:0] = 8'b00011000;
    #20 SW[8] = 0; //SW8 = 0;
    #20 SW[8] = 1;  //SW8 =1, read SW0~7: -18
    #10 SW[7:0] = 8'b11011000;
    #10 SW[7:0] = 8'b11101110;
    #20 SW[8] = 0;
    #250 SW[8] = 1; // wait for affine transformation and display x2
    #100 SW[8] = 0; // display y2 and back for begining 
    #20 SW[8] = 1;
       SW[7:0] = 8'b00001111;  // x1=15
    #20 SW[8] = 0; //SW8 = 0;
    #20 SW[8] = 1;  //SW8 =1, read SW0~7: -31
        SW[7:0] = 8'b11100001;
    #20 SW[8] = 0;
    #250 SW[8] = 1; // wait for affine transformation and display x2
    #100 SW[8] = 0; // display y2 and back for begining 
    #20 SW[8] = 1;
   
       

end
endmodule
