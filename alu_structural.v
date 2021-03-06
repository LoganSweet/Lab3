// ALU for lab 3
// this is based on the lab 1 ALU, which was structural 

// This module is the same as the BitSlice32 module at the very end. We wrote BitSlice32 before ALU, and we only created ALU at the end as the cleanest version of our work.
module ALU
(
output[31:0]  result, // OneBitFinalOut
output        carryout,
output        zero, //AllZeros
output        overflow,
input[31:0]   operandA, // A
input[31:0]   operandB, // B
input[2:0]    command //Command
);

	parameter size = 32;
	wire [size-1:0] Cmd0Start;
    	wire [size-1:0] Cmd1Start; 
    	wire [size-1:0] CarryoutWire;
	wire yeszero;
	wire [size-1:0] NewVal; 
	wire [size-1:0] SLTSum;
	wire [size-1:0] ZeroFlag;
	wire [size-1:0] carryin;
	wire [size-1:0] subtract;
	wire SLTflag;
	wire [size-1:0] AndNandOut;
	wire [size-1:0] OrNorXorOut;
	wire [size-1:0] AddSubSLTSum;
 
	SLT32 SLTinALU3n(SLTSum, carryout, overflow, SLTflag, subtract, operandA, operandB, command, carryin);
	AddSubSLT32 trial(AddSubSLTSum, carryout, overflow, subtract, operandA, operandB, command, carryin);
	AndNand32 trial1(AndNandOut, operandA, operandB, command);
	OrNorXor32 trial2(OrNorXorOut, operandA, operandB, command);
     
	FourInMux ZeroMux0case(Cmd0Start[0], command[0], command[1], AddSubSLTSum[0], AddSubSLTSum[0], OrNorXorOut[0], SLTSum[0]);	 			
	FourInMux OneMux0case(Cmd1Start[0], command[0], command[1], AndNandOut[0], AndNandOut[0], OrNorXorOut[0], OrNorXorOut[0]);
	TwoInMux TwoMux0case(result[0], command[2], Cmd0Start[0], Cmd1Start[0]);
	and setZerothZero(ZeroFlag[0], result[0], result[0]);	
           
	genvar i; 
	generate 
    	for (i=1; i<size; i=i+1)
        	begin: muxbits
            	FourInMux ZeroMux(Cmd0Start[i], command[0], command[1], AddSubSLTSum[i], AddSubSLTSum[i], OrNorXorOut[i], SLTSum[i]);	 			
				FourInMux OneMux(Cmd1Start[i], command[0], command[1], AndNandOut[i], AndNandOut[i], OrNorXorOut[i], OrNorXorOut[i]);
                TwoInMux TwoMux(result[i], command[2], Cmd0Start[i], Cmd1Start[i]);

		or zeroflagtest(ZeroFlag[i], ZeroFlag[i-1], result[i]);     
		end        
    endgenerate 


	// the "zeros" flag depends on the final answer. It is only triggered when the final result is all zeros
	not invzeroflag(yeszero, ZeroFlag[size-1]);
	and setzeros(zero, yeszero, yeszero);

endmodule




module TwoInMux // this module is a two input mux that takes in two inputs (in0 and in1) and uses switch S to pick the value for outfinal
(
    output outfinal,
    input S,
    input in0, in1
);   
    wire nS; 
    wire out0; 
    wire out1; 

    not Sinv(nS, S);   
    and andgate1(out0, in0, nS);
    and andgate3(out1, in1, S);
    or orgate(outfinal, out0, out1);
endmodule

module FourInMux // this module is a four input mux that takes in four inputs (in0, in1, in2, and in3) and uses switches S0 and S1 to pick the value for out
(
    output out,
    input S0, S1,
    input in0, in1, in2, in3
);
    wire nS0; 
    wire nS1; 

    wire out0; 
    wire out1; 
    wire out2; 
    wire out3; 

    not S0inv(nS0, S0);
    not S1inv(nS1, S1);
    nand n0(out0, nS0, nS1, in0);
    nand n1(out1, S0,  nS1, in1);
    nand n2(out2, nS0, S1, in2);
    nand n3(out3, S0,  S1, in3);

    nand addthem(out, out0, out1, out2, out3);
endmodule

module AndNand // Uses Command[0] to determine whether and or nand is chosen
(
output AndNandOut, 
input A, B, 
input[2:0] Command
);

	wire AnandB;
	wire AandB;

	nand n0(AnandB, A, B);
	not Ainv(AandB, AnandB);
	TwoInMux potato(AndNandOut, Command[0], AandB, AnandB);    // order to follow out,S,in0, in1

endmodule

module OrNorXor
(
output OrNorXorOut, // uses both Command[0] and Command[2] to determine whether Or, Nor, or Xor is used
input A, B,
input[2:0] Command
);
	wire AnorB;
	wire AorB;
	wire AnandB;
	wire nXor;
	wire AxorB;
	wire XorNor;

	nor nor0(AnorB, A, B);
    not n0(AorB, AnorB);
	nand and0(AnandB, A, B);
    nand and1(nXor, AnandB, AorB);
    not n1(AxorB, nXor);

    TwoInMux mux0(XorNor, Command[2], AxorB, AnorB);
    TwoInMux mux1(OrNorXorOut, Command[0], XorNor, AorB);
endmodule

// this module calculates addition, subtraction, and SLT based on which command is selected. SLT happens when A<B, or when A-B < 0. SLT is only calculated with the most significant bit, so it is not used in this smaller module. We use the adder/subtractor like we discussed in class
module MiddleAddSubSLT 
(
output AddSubSLTSum, carryout, //overflow is only calculated for the most significant bit, while this is a generic adder/subtractor
output subtract, 
input A, B,
input[2:0] Command, 
input carryin  
);
	wire nB;
	wire BornB;
    wire AxorB;
    wire AandB;
    wire CINandAxorB;
    wire nCmd2;
                
	not Binv(nB, B);
    TwoInMux mux0(BornB, Command[0], B, nB); 
    not n0(nCmd2, Command[2]);
    and subtractchoose(subtract, Command[0], nCmd2); 
    xor XOR1(AxorB, A, BornB); 
    xor XOR2(AddSubSLTSum, AxorB, carryin); 
    and AND1(AandB, A, BornB); 
    and AND2(CINandAxorB, AxorB, carryin);
    or OR1(carryout, AandB, CINandAxorB); 
endmodule

// this module creates a 32-bit AND/NAND module
module AndNand32
(
output [size-1:0] AndNandOut, 
input [size-1:0] A,
input [size-1:0] B, 
input[2:0] Command
);
	parameter size = 32; // set the parameter size to whatever length you want
	wire AnandB;
	wire AandB;

	AndNand attempt2(AndNandOut[0], A[0], B[0], Command); // set the zeroth condition. This is only important for the ADD/SUB/SLT functions, but we do it for all for consistency

	genvar i; 
	generate 
    	for (i=1; i<size; i=i+1)
        	begin: andbits
            AndNand attempt(AndNandOut[i], A[i], B[i], Command); 
            end        
    endgenerate     
endmodule

// this module creates a 32-bit OR/NOR/XOR module
module OrNorXor32
(
output [size-1:0] OrNorXorOut,
input [size-1:0] A,
input [size-1:0] B,
input[2:0] Command
);
	parameter size = 32; // set the parameter size to whatever length you want
	wire AnorB;
	wire AorB;
	wire AnandB;
	wire nXor;
	wire AxorB;
	wire XorNor;

	OrNorXor attempt2(OrNorXorOut[0], A[0], B[0], Command); // set the zeroth condition. This is only important for the ADD/SUB/SLT module, but we do it for all for consistency

	genvar i; 
    generate 
    	for (i=1; i<size; i=i+1)
        	begin: orbits
            OrNorXor attempt(OrNorXorOut[i], A[i], B[i], Command); 
            end        
        endgenerate 
endmodule


// this module creates a 32-bit ADD/SUB module. We originally tried to combine ADD, SUB, and SLT since the three are connected, but SLT proved too tricky to include with ADD & SUB, so we moved it down to SLT32. 
module AddSubSLT32
(
output [size-1:0]AddSubSLTSum, 
output carryout,      
output overflow, 
output [size-1:0]subtract, 
input [size-1:0] A, B, 
input [2:0] Command,
input [size-1:0]carryin  // we think this doesnt do anything but dont want to break everything
);
    wire [size-1:0] CarryoutWire; // this is used to internally connect each of the 32 bitslices
	MiddleAddSubSLT attempt2(AddSubSLTSum[0], CarryoutWire[0], subtract[0], A[0], B[0], Command, subtract[0]);
      
	genvar i; 
	parameter size = 32; 
	generate 
    	for (i=1; i<size; i=i+1)
        	begin: addbits
            MiddleAddSubSLT attempt(AddSubSLTSum[i], CarryoutWire[i], subtract[i], A[i], B[i], Command, CarryoutWire[i-1]); 
            end        
    endgenerate 

	
	//set final carryout value - this will be used for calculating overflow and SLT
	or finalcarryout(carryout, CarryoutWire[size-1], 0);

	// check for overflow - does the final carryin = final carryout?
	xor overflowcheck(overflow, carryout, CarryoutWire[size-2]);
endmodule

// this module creates a 32-bit SLT module
module SLT32
(
output [size-1:0]SLTSum, 
output carryout,      
output overflow, 
output SLTflag,
output [size-1:0]subtract, 
input [size-1:0] A, B, 
input [2:0] Command,
input [size-1:0]carryin  // we think this doesn't do anything but don't want to break everything
);
    wire [size-1:0] CarryoutWire; // this is used to internally connect each of the 32 bitslices
    wire [size-1:0] NewVal; // this is used to internally connect each of the 32 bitslices
	wire [size-1:0]AddSubSLTSum; 
	wire SLTon;
	wire nOF;
	wire nAddSubSLTSum;
	wire Res1OF0;
	wire Res0OF1;
	wire SLTflag0;
	wire SLTflag1;
	wire nCmd2;
               
    not n0(nCmd2, Command[2]);

// we do weird things where we do subtraction to produce NewVal, then assign either NewVal or 0 to AddSubSLTSum (since if SLT is triggered, every bit except maybe the least significant will be 0), and then determine whether A<B at the very end, when we set the least significant bit to 0 or 1 depending 

	and sltcheck0(SLTon, Command[0], Command[1], nCmd2);
    MiddleAddSubSLT attempt2(NewVal[0], CarryoutWire[0], subtract[0], A[0], B[0], Command, subtract[0]);
     TwoInMux setSLTresult(AddSubSLTSum[0], SLTon, NewVal[0], 0);

	genvar i; 
	parameter size = 32; 
	generate 
    	for (i=1; i<size; i=i+1)
        	begin: sltbits
            MiddleAddSubSLT attempt(NewVal[i], CarryoutWire[i], subtract[i], A[i], B[i], Command, CarryoutWire[i-1]); 
			TwoInMux setSLTres2(AddSubSLTSum[i], SLTon, NewVal[i], 0);
			TwoInMux setSLTres3(SLTSum[i], SLTon, AddSubSLTSum[i], AddSubSLTSum[i]);	
            end        
    endgenerate 
	
	//set final carryout value - this will be used for calculating overflow and SLT
	or finalcarryout(carryout, CarryoutWire[size-1], 0);

	// check for overflow - does the final carryin = final carryout?
	xor overflowcheck(overflow, carryout, CarryoutWire[size-2]);

	// check whether A < B
	not invOF(nOF, overflow);
	not invAddSub(nAddSubSLTSum, AddSubSLTSum[size-1]); 
	and sltint0(Res1OF0, nOF, NewVal[size-1]);
	and sltint1(Res0OF1, overflow, nAddSubSLTSum);
	and sltint2(SLTflag0, Res1OF0, SLTon);
	and sltint3(SLTflag1, Res0OF1, SLTon);
	or sltcheck1(SLTflag, SLTflag0, SLTflag1);
	TwoInMux FinalSLT(SLTSum[0], SLTflag, AddSubSLTSum[0], SLTflag);

endmodule

// this module combines the 32 bit ADD/SUB, the 32 bit SLT, 32 bit OR/NOR/XOR, and the 32 bit AND/NAND
// We do this by using a series of final multiplexers to get the correct result based on what Command is calling for
module Bitslice32
(
output  [size-1:0] OneBitFinalOut, 
output  [size-1:0]AddSubSLTSum, 
output  [size-1:0]SLTSum, 
output carryout, 
output overflow, 
output SLTflag,
output  [size-1:0] OrNorXorOut,
output  [size-1:0] AndNandOut,
output  [size-1:0] subtract,
output [size-1:0] ZeroFlag,
output AllZeros,
input  [size-1:0] A, 
input  [size-1:0] B, 
input[2:0] Command,
input [size-1:0]carryin // dont think this does anything but dont want to break it!
);
	parameter size = 32;
	wire [size-1:0] Cmd0Start;
    wire [size-1:0] Cmd1Start; 
    wire [size-1:0] CarryoutWire;
	wire yeszero;
wire [size-1:0] NewVal; 
 
	SLT32 test(SLTSum, carryout, overflow, SLTflag, subtract, A, B, Command, carryin);
	AddSubSLT32 trial(AddSubSLTSum, carryout, overflow, subtract, A, B, Command, carryin);
	AndNand32 trial1(AndNandOut, A, B, Command);
	OrNorXor32 trial2(OrNorXorOut, A, B, Command);
     
	FourInMux ZeroMux0case(Cmd0Start[0], Command[0], Command[1], AddSubSLTSum[0], AddSubSLTSum[0], OrNorXorOut[0], SLTSum[0]);	 			
	FourInMux OneMux0case(Cmd1Start[0], Command[0], Command[1], AndNandOut[0], AndNandOut[0], OrNorXorOut[0], OrNorXorOut[0]);
	TwoInMux TwoMux0case(OneBitFinalOut[0], Command[2], Cmd0Start[0], Cmd1Start[0]);
	and setZerothZero(ZeroFlag[0], OneBitFinalOut[0], OneBitFinalOut[0]);	
           
	genvar i; 
	generate 
    	for (i=1; i<size; i=i+1)
        	begin: muxbits
            	FourInMux ZeroMux(Cmd0Start[i], Command[0], Command[1], AddSubSLTSum[i], AddSubSLTSum[i], OrNorXorOut[i], SLTSum[i]);	 			
				FourInMux OneMux(Cmd1Start[i], Command[0], Command[1], AndNandOut[i], AndNandOut[i], OrNorXorOut[i], OrNorXorOut[i]);
                TwoInMux TwoMux(OneBitFinalOut[i], Command[2], Cmd0Start[i], Cmd1Start[i]);

		or zeroflagtest(ZeroFlag[i], ZeroFlag[i-1], OneBitFinalOut[i]);     
		end        
    endgenerate 


	// the "zeros" flag depends on the final answer. It is only triggered when the final result is all zeros
	not invzeroflag(yeszero, ZeroFlag[size-1]);
	and setzeros(AllZeros, yeszero, yeszero);

endmodule 
