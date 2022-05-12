//-------------------------------------------------------------
//file name: alu.sv
//funtinon: alu module for affine tranformation 
//author: zy1u21
//version: 1 using two functions : multiplier and addition 
//last version: 10/04/2022
//-------------------------------------------------------------
 module alu #(
     parameter datalength = 8  // n bits 
 ) (
     input logic signed[datalength-1 : 0] a, b, // ALU inputs
     input logic func,  //ALU function code
     output logic signed [datalength-1 : 0]result // ALU results
 );

 // ---------code starts here ----------------------

 // creat an n-bit adder and multiplier (2n bits)
 // and ouput n-bit result. 
logic signed [2*datalength-1 :0] ar;
always_comb begin
    // default output avoid latches
    ar = a;
    if (func)                   // if func is 1, alu does addition,                      
        begin 

            ar = a + b;         // arithmetic addition,  n+1 bit result  
            result = ar[datalength-1 : 0];

        end

    else              // if func is 0, alu does multiplication, the result would be 2n bit
        begin 

            ar = a * b;         // arithmetic mutiplication, 2n bit result
            result = ar [(2*datalength-2) : datalength - 1];
        end

 /*   else
       begin 

            ar = a;             // default
            result = ar;

        end*/
end

// creat the output, truncate [n-1:0] bi
//assign result = ar[datalength-1 : 0];
     
endmodule