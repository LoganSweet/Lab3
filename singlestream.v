`include "alu_structural.v"
`include "mux.v"
`include "register.v"
`include "regfile.v"
`include "datamemory.v"

module singlestream(
// inputs should be controls - which command are we doing
input clk; // internal clock


);

wire [31:0] PC = 32'b0; // initial assignment - PC is 32 zeros 
wire [31:0] PCp4;
wire choosePC; // output of mux 6, goes into Program Counter register
wire PCcontrol; // to control the Program Counter - unclear when this should be true
Four = 32'b4 // how do you write the number 4 with thirty-two bits

wire carryout1; // trash from ALU1 that we don't need
wire zero1; // ^^
wire overflow1; // ^^

wire carryout2; // trash from ALU2 that we don't need
wire zero2;
wire overflow2;
wire [31:0] SEimm; // need to figure out how this actually happens
ADD = 3'b000;

wire [31:0] newPC; // output of mux 1
wire Mux1control; 

wire Mux6control; 
wire [31:0] jConcat;
wire [31:0] A;

wire [31:0] MemAddr;
wire Mux2control;
wire [31:0] ALU3res;

wire [31:0] MemOut;
wire Mem_WE;
wire [31:0] B;

register PCreg(PC, choosePC, PCcontrol , clk); // output, input, writeenable, clock

// command for both of these two ALUs will always be ADD

ALU ALU1(PCp4, carryout1, zero1, overflow1, PC, Four, ADD); // output[31:0]  result, output carryout, output zero, output overflow, input[31:0] operandA, input[31:0] operandB, input[2:0] command

ALU ALU2(ALU2out, carryout2, zero2, overflow2, PCp4, SEimm, ADD);

mux2to1by32 Mux1(newPC, Mux1control, ALU2out, PCp4); // output, address, ALU2out, PCp4

mux3to1by32 Mux6(choosePC, Mux6control, newPC, jConcat, A); // output, address, newPC, jConcat, A

mux2to1by32 Mux2(MemAddr, Mux2control, PC, ALU3res);

datamemory(clk, MemOut, MemAddr, Mem_WE, B);





endmodule
