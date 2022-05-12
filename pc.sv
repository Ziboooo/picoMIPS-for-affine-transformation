//-------------------------------------------------------------------------
//file name: pc.sv
//funtinon: program counter module for affine tranformation 
//author: zy1u21
//version: 1 //  increment relative branch
//last version: 10/04/2022
//--------------------------------------------------------------------------

module pc #(
    parameter Psize = 4

)
(
    input logic clk, rst, PCincr, //PCabsbranch,
    //input logic [Psize-1:0] Branchaddr,          // relative branch addr
    output logic [Psize-1 : 0] PCout

);

//----------- codes start here --------------
// programme counter 
//logic [Psize-1 : 0] Branch; // temp variable for addtional oprand 
//always_comb begin // 
 //   if (PCincr) 
 //       Branch = { {(Psize-1){1'b0}}, 1'b1};
//    else Branch = Branchaddr;
//end


always_ff @(posedge clk, negedge rst) begin
    if (~rst) 
            PCout <= '0;
    
    else //if (PCout < 15)   //increment or PCincr
            PCout <= PCout + PCincr;

   // else                   // return to 0
         //   PCout <= '0; 
    
    //else if (PCabsbranch)         // absolute branch
    //        PCout <= Branchaddr;

end // always_ff

endmodule // pc

