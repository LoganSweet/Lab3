// decoder for lab 3 
 
module decoder32to2
(

output reg [size-1:0]	InstructIn,
output reg [size-1:0]	DataReg,
input			address, // address - where does DataIn go?
input [size-1:0]	DataIn
);
parameter size = 32;
always @(*) begin
	if (address == 0)
		InstructIn <= DataIn; 
	if (address == 1)
		DataReg <= DataIn; 
end 
endmodule

module decoder1to32
(
output[31:0]	out,
input		enable,
input[4:0]	address
);
    assign out = enable<<address; 

endmodule

