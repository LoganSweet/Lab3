// test for Lab 3 modules

//`include "datamemory.v"

/*
`include "decoder.v"
module testdecoder();

parameter size = 4;
wire[size-1:0]	InstructIn;
wire[size-1:0] 	DataReg;  	//input
reg 		address;
reg [size-1:0]	DataIn;	//input 

decoder1to32 x(InstructIn, DataReg, address, DataIn);    
initial begin
$dumpfile("decodertest.vcd");
$dumpvars();
   
$display("DataIn |Address| InstructIn | DataReg");
DataIn = 4'b0101; address = 1; #200 // expect DataIn to go to DataReg
$display("%b|  %b |%b|%b ", DataIn, address, InstructIn, DataReg);

DataIn = 4'b1011; address = 0; #200 // expect DataIn to go to InstructIn
$display("%b|  %b |%b|%b ", DataIn, address, InstructIn, DataReg);

DataIn = 4'b0110; address = 0; #200 // expect DataIn to go to InstructIn
$display("%b|  %b |%b|%b ", DataIn, address, InstructIn, DataReg);

end
endmodule
*/ 

`include "StateMachine.v"
module testFSM();

// start by testing ADD
// Op Code = 6'b000111
// zeroflag3 = 0 (only used for SLT)
// For Add, expect 

wire PC; // this controls whether the PC flip flop is enabled
wire M1; // Mux1 controller
wire M2; // Mux2 controller
wire MemWrEn; // is memory write enable on or off
wire D1; // Dec1 controller
wire [1:0] M3;
wire [1:0] M4;
wire RegFWrEn;
wire M5;
wire [2:0] ALU3;
wire [1:0] M6;
reg clk;
reg [5:0] OpCode;
reg ZFlag;

initial clk=0;
always #10 clk=!clk; 

StateMachine FSM(OpCode, ZFlag, clk, PC, M1, M2, MemWrEn, D1, M3, M4, RegFWrEn, M5, ALU3, M6);


   

initial begin

$dumpfile("FSM.vcd");
$dumpvars();

$display("OpCode|PC| M1 | M2 ");
/* ADD
OpCode = 6'b000111; ZFlag = 0; #200
$display("%b 	| %b | %b | %b", OpCode, PC, M1, M2);
*/

/*LoadWord
OpCode = 6'b000000; ZFlag = 0; #200
$display("%b 	| %b | %b | %b", OpCode, PC, M1, M2);
*/

/*StoreWord
OpCode = 6'b000001; ZFlag = 0; #200
$display("%b 	| %b | %b | %b", OpCode, PC, M1, M2);
*/

OpCode = 6'b000011; ZFlag = 0; #200
$display("%b 	| %b | %b | %b", OpCode, PC, M1, M2);


$finish;
end

endmodule


