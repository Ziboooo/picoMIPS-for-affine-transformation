//-------------------------------------------------------
//file name: decoder.sv
//funtinon: decoder module for affine tranformation 
//author: zy1u21
//version: 1 // 'ADD, 'ADDI, 'MULI, 'B(branch function) 
//last version: 10/04/2022
//-------------------------------------------------------

`define ADD  2'b00    //ADDITION
`define ADDI 2'b01   //ADDITION WITH IMMEDIATE
`define MULI 2'b10   //MULTIPLICATION with IMMEDIATE
`define B    2'b11   //BRANCH

//------------------------------------------
module decoder #(
    parameter datalength = 8  // n bit datalength
) (
    input logic [1:0] opcode, // top 2 bits of instructions
    input logic Wready, dataval,      // ready accept data I[7], data valid SW8
    output logic PCincr,//PCabsbranch,      // PC control
    output logic INen,        // flag for datain 
    output logic ALUfunc,     // ALU control
    output logic imm,         // imm mux control
    output logic w            // register file control
);


//-----------code starts here ------------------
// creat a decoder for instruction 

always_comb begin 
    // default output logic prevent latches 
    PCincr = 1'b1;                     // default PC increment is 1
    ALUfunc = '1;                    // default ALU function is 1 add
    imm = '0;
    w = '0;
    INen = '0;

    unique casez (opcode)


        `ADD: //register-register add
            begin 
                w = 1'b1;               // write result to register when Wready 
                ALUfunc = 1'b1;         // alu does addtion 
                INen = Wready;          // mux chooses register when Wready = 0, 
                                        // mux chooses SW0~SW7 when Wresdy =1 
            end

        `ADDI: //register-immediate add
            begin 
                w = 1'b1;              // write result to register
                ALUfunc = 1'b1;        // alu does addtion
                imm = 1'b1;            // immediate input 
            end
        
        `MULI: //register-immediate multiplication 
            begin 
                w = 1'b1;             // write result to register
                ALUfunc = 1'b0;       // alu does multiplication 
                imm  = 1'b1;          // immediate input
            end

        `B: // branch
            begin 
                if (Wready !== dataval)  // dataval is not equal to Wready , wait
                    begin 
                        PCincr = 1'b0;       // stop increment, stay at branches
                        //PCabsbranch = 1'b1;  // absolute branch
                    end
                else // dataval == Wready,  next 
                    begin 
                        PCincr = 1'b1;
                        //PCabsbranch = 1'b0;
                    end
            end // branch     
            
    default: 
        $error("unimplemented opcode %h",opcode);

    endcase  // opcode
end  // always_comb
   
endmodule