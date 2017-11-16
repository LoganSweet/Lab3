`include "decoder.v"
`include "mux.v"
`include "register.v"

module regfile
(
output [31:0]	ReadData1,	// Contents of first register read
output [31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

wire[31:0] DecodeOut; 
wire[31:0] ROut_0;
wire[31:0] ROut_1; 
wire[31:0] ROut_2; 
wire[31:0] ROut_3; 
wire[31:0] ROut_4; 
wire[31:0] ROut_5; 
wire[31:0] ROut_6; 
wire[31:0] ROut_7; 
wire[31:0] ROut_8; 
wire[31:0] ROut_9; 
wire[31:0] ROut_10; 
wire[31:0] ROut_11; 
wire[31:0] ROut_12; 
wire[31:0] ROut_13; 
wire[31:0] ROut_14; 
wire[31:0] ROut_15; 
wire[31:0] ROut_16; 
wire[31:0] ROut_17; 
wire[31:0] ROut_18; 
wire[31:0] ROut_19; 
wire[31:0] ROut_20; 
wire[31:0] ROut_21; 
wire[31:0] ROut_22; 
wire[31:0] ROut_23; 
wire[31:0] ROut_24; 
wire[31:0] ROut_25; 
wire[31:0] ROut_26; 
wire[31:0] ROut_27; 
wire[31:0] ROut_28; 
wire[31:0] ROut_29; 
wire[31:0] ROut_30; 
wire[31:0] ROut_31; 

decoder1to32 decodetim(DecodeOut, RegWrite, WriteRegister);

register32zero r0(ROut_0, WriteData, DecodeOut[0], Clk);
//register32 r0(ROut_0,  WriteData, DecodeOut[0], Clk); 
register32 r1(ROut_1,  WriteData, DecodeOut[1], Clk); 
register32 r2(ROut_2,  WriteData, DecodeOut[2], Clk); 
register32 r3(ROut_3,  WriteData, DecodeOut[3], Clk); 
register32 r4(ROut_4,  WriteData, DecodeOut[4], Clk); 
register32 r5(ROut_5,  WriteData, DecodeOut[5], Clk); 
register32 r6(ROut_6,  WriteData, DecodeOut[6], Clk); 
register32 r7(ROut_7,  WriteData, DecodeOut[7], Clk); 
register32 r8(ROut_8,  WriteData, DecodeOut[8], Clk); 
register32 r9(ROut_9,  WriteData, DecodeOut[9], Clk); 
register32 r10(ROut_10, WriteData, DecodeOut[10], Clk); 
register32 r11(ROut_11, WriteData, DecodeOut[11], Clk); 
register32 r12(ROut_12, WriteData, DecodeOut[12], Clk); 
register32 r13(ROut_13, WriteData, DecodeOut[13], Clk); 
register32 r14(ROut_14, WriteData, DecodeOut[14], Clk); 
register32 r15(ROut_15, WriteData, DecodeOut[15], Clk); 
register32 r16(ROut_16, WriteData, DecodeOut[16], Clk); 
register32 r17(ROut_17, WriteData, DecodeOut[17], Clk); 
register32 r18(ROut_18, WriteData, DecodeOut[18], Clk); 
register32 r19(ROut_19, WriteData, DecodeOut[19], Clk); 
register32 r20(ROut_20, WriteData, DecodeOut[20], Clk); 
register32 r21(ROut_21, WriteData, DecodeOut[21], Clk); 
register32 r22(ROut_22, WriteData, DecodeOut[22], Clk); 
register32 r23(ROut_23, WriteData, DecodeOut[23], Clk); 
register32 r24(ROut_24, WriteData, DecodeOut[24], Clk); 
register32 r25(ROut_25, WriteData, DecodeOut[25], Clk); 
register32 r26(ROut_26, WriteData, DecodeOut[26], Clk); 
register32 r27(ROut_27, WriteData, DecodeOut[27], Clk); 
register32 r28(ROut_28, WriteData, DecodeOut[28], Clk); 
register32 r29(ROut_29, WriteData, DecodeOut[29], Clk); 
register32 r30(ROut_30, WriteData, DecodeOut[30], Clk); 
register32 r31(ROut_31, WriteData, DecodeOut[31], Clk); 

mux32to1by32 M1(ReadData1, ReadRegister1, ROut_0, ROut_1, ROut_2, ROut_3, ROut_4, ROut_5, ROut_6, ROut_7, ROut_8, ROut_9, ROut_10, ROut_11, ROut_12, ROut_13, ROut_14, ROut_15, ROut_16, ROut_17, ROut_18, ROut_19, ROut_20, ROut_21, ROut_22, ROut_23, ROut_24, ROut_25, ROut_26, ROut_27, ROut_28, ROut_29, ROut_30, ROut_31); 

mux32to1by32 M2(ReadData2, ReadRegister2, ROut_0, ROut_1, ROut_2, ROut_3, ROut_4, ROut_5, ROut_6, ROut_7, ROut_8, ROut_9, ROut_10, ROut_11, ROut_12, ROut_13, ROut_14, ROut_15, ROut_16, ROut_17, ROut_18, ROut_19, ROut_20, ROut_21, ROut_22, ROut_23, ROut_24, ROut_25, ROut_26, ROut_27, ROut_28, ROut_29, ROut_30, ROut_31); 

endmodule

