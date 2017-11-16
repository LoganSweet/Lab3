// register for lab 3 


module register
(
output reg	q,
input		d,
input		wrenable,
input		clk
);
always @(posedge clk) begin
	if(wrenable) 
		q = d;
end

endmodule


module register32
(
output reg [31:0]	q,
input      [31:0]	d,
input				wrenable,
input				clk
);

initial q = 32'b0;

always @(posedge clk) begin
	if(wrenable) 
		q = d;
end

endmodule



module register32zero
(
output reg [31:0]	q,
input      [31:0]	d,
input				wrenable,
input				clk
);
initial q = 32'b0;
always @(posedge clk) begin
	if(wrenable) 
		q = 32'b0;
end 

endmodule


