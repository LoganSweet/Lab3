// decoder for lab 3 
 
module decoder1to32
(
output[31:0]	InstructIn,
output[31:0]	DataReg,
input			enable,
input [31:0]	DataIn
);
always @(input) begin
	if (enable == 0)
		InstructIn <= DataIn; 
	if (enable == 1)
		DataReg <= DataIn; 
end 
endmodule


