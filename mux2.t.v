`include "mux.v"
`timescale 1 ns / 1 ps


module testmux2();

 wire [31:0]  muxout;
reg  address;
reg   [31:0] ALU2out;
reg [31:0] PCp4;
mux2to1by32 TEST(muxout, address, ALU2out, PCp4);


wire  [4:0]  regfileaddress;
reg [1:0]  mux3ctrl;
reg[4:0] thirtyone;
reg[4:0] rt;
reg[4:0] rd;
mux3to1by5 TEST2(regfileaddress, mux3ctrl, thirtyone, rt, rd);

wire  [31:0]  choosePC;
reg [1:0]  address2;
reg[31:0] A;
reg[31:0] jConcat;
reg[31:0] newPC;
mux3to1by32 TEST3(choosePC, address2, A, jConcat, newPC);

initial begin

$display("Out | ExOut | Address | ALU2out | PCp4 ");
ALU2out = 32'b0101; PCp4 = 32'b1111; address = 1; #400 // should be ALU2out
$display("%b, 0101,	 %b	, %b, %b", muxout[3:0], address, ALU2out[3:0], PCp4[3:0]);

ALU2out = 32'b0001; PCp4 = 32'b1000; address = 0; #400 // should be PCp4
$display("%b, 1000,	 %b	, %b, %b", muxout[3:0], address, ALU2out[3:0], PCp4[3:0]);

$display("Out | ExOut | Ctrl | 31 | RT | RD ");
thirtyone = 5'b11111; rt = 5'b10101; rd = 5'b01010; mux3ctrl = 00; #400
$display("%b 01010 	%b %b %b 	%b", regfileaddress, mux3ctrl, thirtyone, rt, rd);
thirtyone = 5'b11111; rt = 5'b10101; rd = 5'b01010; mux3ctrl = 01; #400
$display("%b 10101 	%b %b %b 	%b", regfileaddress, mux3ctrl, thirtyone, rt, rd);
thirtyone = 5'b11111; rt = 5'b10101; rd = 5'b01010; mux3ctrl = 10; #400
$display("%b 11111 	%b %b %b 	%b", regfileaddress, mux3ctrl, thirtyone, rt, rd);

$display("Out | ExOut | Add | A | Concat | newPC ");
A = 32'b1011; jConcat = 32'b0100; newPC = 32'b0110; address2 = 00; #400
$display("%b 0110 	%b %b %b 	%b", choosePC[3:0], address2, A[3:0], jConcat[3:0], newPC[3:0]);
A = 32'b1011; jConcat = 32'b0100; newPC = 32'b0110; address2 = 01; #400
$display("%b 0100 	%b %b %b 	%b", choosePC[3:0], address2, A[3:0], jConcat[3:0], newPC[3:0]);
A = 32'b1011; jConcat = 32'b0100; newPC = 32'b0110; address2 = 10; #400
$display("%b 1011 	%b %b %b 	%b", choosePC[3:0], address2, A[3:0], jConcat[3:0], newPC[3:0]);
end


endmodule
