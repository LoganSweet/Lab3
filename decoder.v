// decoder for lab 3 

module decoder1to32
(
output[31:0]	InstructIn,
output[31:0]	DataReg,
input	enable,
input [31:0]	address
);
    assign {DataReg, InstructIn} = enable<<address; // SHIFT ENABLE LEFT BY ADDRESS 
endmodule
