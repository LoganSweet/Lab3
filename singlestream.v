//`include "alu_structural.v"
`include "regfile.v"
`include "datamemory.v"
`include "StateMachine.v"

module singlestream(
input clk // internal clock
);

wire [5:0] OpCode; // initializing this to something, just in case 
StateMachine FSM(OpCode, zero3, clk, PCcontrol, Mux1control, Mux2control, Mem_WE, Dec1control, Mux3control, Mux4control, RegWE, Mux5control, ALU3control, Mux6control);

wire [31:0] PC; // initial assignment - PC is 32 zeros 
wire [31:0] PCp4;
wire [31:0] choosePC; // output of mux 6, goes into Program Counter register
wire PCcontrol; // to control the Program Counter - unclear when this should be true
reg [31:0] Four = 32'b100;

wire carryout1; // trash from ALU1 that we don't need
wire zero1; // ^^
wire overflow1; // ^^

wire carryout2; // trash from ALU2 that we don't need
wire zero2;
wire overflow2;
wire [31:0] SEimm; // need to figure out how this actually happens
reg [2:0] ADD = 3'b000;

wire [31:0] newPC; // output of mux 1
wire Mux1control; 

wire [31:0] ALU2out;

wire [1:0] Mux6control; 
wire [31:0] jConcat;
wire [31:0] A;

wire [31:0] MemAddr;
wire Mux2control;
wire [31:0] ALU3res =32'b0;

wire [31:0] MemOut;
wire Mem_WE;
wire [31:0] B;

wire [31:0] InstructIn;
wire [31:0] DataReg;
wire Dec1control;

wire [4:0] RS;
wire [4:0] RT;
wire [4:0] RD;
wire [15:0] imm;
wire [25:0] jaddr;

wire [1:0] Mux3control;
wire [4:0] RegAw;
wire [31:0] RegDw;
wire [1:0] Mux4control;
wire RegWE;

wire Mux5control;
wire [31:0] Mux5out;

wire carryout3; // trash from ALU3 that we don't need
wire zero3 = 0; // initialize it because maybe this is why it doesn't work
wire overflow3;
wire [2:0] ALU3control;

register32 PCreg(PC, choosePC, PCcontrol , clk); // output, input, writeenable, clock

ALU ALU1(PCp4, carryout1, zero1, overflow1, PC, Four, ADD); // output[31:0]  result, output carryout, output zero, output overflow, input[31:0] operandA, input[31:0] operandB, input[2:0] command

ALU ALU2(ALU2out, carryout2, zero2, overflow2, PCp4, SEimm, ADD);

mux2to1by32 Mux1(newPC, Mux1control, ALU2out, PCp4); // output, address, ALU2out, PCp4


mux2to1by32 Mux2(MemAddr, Mux2control, ALU3res, PC);

//datamemory Memory(clk, MemOut, MemAddr, Mem_WE, B);
datamemory Memory(clk, Mem_WE, MemAddr, B, MemOut);

decoder32to2 Dec1(InstructIn, DataReg, Dec1control, MemOut);

assign OpCode = InstructIn[31:26];
assign RS = InstructIn[25:21];
assign RT = InstructIn[20:16];
assign RD = InstructIn[15:11];
assign imm = InstructIn[15:0];
assign jaddr = InstructIn[25:0];


mux3to1by5 Mux3(RegAw, Mux3control, 5'b11111, RT, RD); //output, address, 31, rd, rt
mux3to1by32 Mux4(RegDw, Mux4control, PC, DataReg, ALU3res); 
regfile DataRegister(A, B, RegDw, RS, RT, RegAw, RegWE, clk);

// sign extend
signextend extend(imm, SEimm);
//mux5
mux2to1by32 Mux5(Mux5out, Mux5control, SEimm, B);

//alu3
ALU ALU3(ALU3res, carryout3, zero3, overflow3, A, Mux5out, ALU3control);

// mux 6
wire [29:0] jConcat_intermediate;
assign jConcat_intermediate = {newPC[31:28], jaddr}; // DOUBLE CHECK - WHICH PC VALUES GO HERE
assign jConcat = {jConcat_intermediate, 2'b00};

mux3to1by32 Mux6(choosePC, Mux6control, A, jConcat, newPC); // output, address, newPC, jConcat, A


endmodule



module signextend(
input [15:0] immediate,
output reg [31:0] SEimm
);

always @(immediate) begin
	if (immediate[15] == 0)
		SEimm <= {16'b0000000000000000, immediate};
	else if (immediate[15] == 1)
		SEimm <= {16'b1111111111111111, immediate};
end

endmodule



