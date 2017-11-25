//------------------------------------------------------------------------
// Finite State Machine
//------------------------------------------------------------------------

`include "alu_structural.v"

module StateMachine3
(
	input[5:0] opcode,  
	input[5:0] func,
	input zeroflag3,	
	input clk,
	output reg PCcontrol,
	output reg Mux1,
	output reg Mux2,
	output reg MemWrEn,
	output reg Dec1,
	output reg [1:0] Mux3,
	output reg [1:0] Mux4,
	output reg RegFWrEn,
	output reg Mux5,
	output reg [2:0] ALU3,
	output reg [1:0] Mux6
);

localparam AddSubOP = 6'b000000;
localparam AddF = 6'b100000;
localparam SubF = 6'b100010;
localparam SLTF = 6'b101010;
localparam Add = 7'b1;
localparam Sub = 7'b10;

localparam AddiOP = 6'b001000; 
localparam AddiF = 6'b000110;
localparam Addi = 7'b11;

localparam XORIOP = 6'b001110;
localparam XORIF = 6'b000011;
localparam XORI = 7'b100;

localparam SWOP = 6'b101011;
localparam SWF = 6'b000000;
localparam StoreWord = 7'b101;

localparam LWOP = 6'b100011; 
localparam LWF = 6'b000000;
localparam LoadWord = 7'b110;

localparam JOP = 6'b000000;
localparam JF = 6'b001100;
localparam Jump = 7'b111;

localparam JALF = 6'b001100;
localparam JALOP = 6'b000011;
localparam JumpAndLink = 7'b1000;
localparam JRF = 6'b001000;
localparam JumpReg = 7'b1001;


localparam BNEOP = 6'b000101;
localparam BNEF = 6'b110110;
localparam BranchNotEqual = 7'b1010;
localparam SLT = 7'b1011;

reg [6:0] command;

reg [5:0] counter = 6'b000011;

initial Mux2 = 0;
initial Dec1 = 0;
initial PCcontrol = 0 ;
initial Mux1 = 0 ;
initial Mux2 = 0 ;
initial MemWrEn = 0 ; 
initial Dec1  =0 ; 
initial Mux3 =2'b00 ; 
initial Mux4 =	2'b00 ;
initial RegFWrEn = 0 ;	
initial Mux5 = 1 ;
initial ALU3 = 3'b000 ;		// should be whatever control number add is 
initial Mux6 = 2'b00 ;	

always @(posedge clk) begin
//if (counter == 3)
//	counter <= 0 ;
//else 
//	counter = counter + 1 ;  

if (opcode == LWOP && func == LWF)
	command <= LoadWord;

if (opcode == SWOP && func == SWF)
	command <= StoreWord;	

if (opcode == JOP && func == JF)
	command <= Jump;

if (opcode == JOP && func == JRF)
	command <= JumpReg;
	
if (opcode == JALOP && func == JALF)
	command <= JumpAndLink;	
	
if (opcode == BNEOP && func == BNEF)
	command <= BranchNotEqual;	
	
if (opcode == XORIOP && func == XORIF)
	command <= XORI;	
	
if (opcode == AddSubOP && func == AddF)
	command <= Add;	
	
//if (opcode == AddiOP && func == AddiF)
if (opcode == AddiOP)
	command <= Addi;	
	
if (opcode == AddSubOP && func == SubF)
	command <= Sub;	
	
if (opcode == AddSubOP && func == SLTF)
	command <= SLT;	
	
case (command)

	LoadWord: begin	
		// maybe needs to establish that counter is zero here? 	
		// if it does, then it needs to be at the beginning (or end?) of each one 

		PCcontrol <=0 ;
		Mux1 <= 	0 ;
		Mux2 <= 	0 ;
		MemWrEn <= 	0 ; 
		Dec1 <= 	0 ; 
		Mux3 <= 	2'b01 ; //concerned about the feasibility of this - can you actually do it just like 00?
		Mux4 <= 	2'b01 ;
		RegFWrEn <= 1 ;	
		Mux5 <= 	1 ;
		ALU3 <= 	3'b000 ;		// should be whatever control number add is 
		Mux6 <= 	2'b00 ;	
	end 		
		

	Add: begin
		PCcontrol <= 0 ;
		Mux1 <= 	0 ;
		Mux2 <= 	0 ;
		MemWrEn <= 	0 ; 
		Dec1 <= 	0 ; 
		Mux3 <= 	2'b01 ;
		Mux4 <= 	2'b00 ;
		RegFWrEn <= 0 ;
		Mux5 <= 	0 ;
		ALU3 <= 	3'b000 ;	
		Mux6 <= 	2'b00 ;
	end 		// end of the thing when counter is 0 


	Addi: begin
		PCcontrol <= 0 ;
		Mux1 <= 	0 ;
		Mux2 <= 	0 ;
		MemWrEn <= 	0 ; 
		Dec1 <= 	0 ; 
		Mux3 <= 	2'b00 ;
		Mux4 <= 	2'b00 ;
		RegFWrEn <= 0 ; 
		Mux5 <= 	1 ;
		ALU3 <= 	3'b000 ;	
		Mux6 <= 	2'b00 ;		
	end 
	endcase 		
end 



always @(negedge clk) begin

if (opcode == LWOP && func == LWF)
	command <= LoadWord;

if (opcode == SWOP && func == SWF)
	command <= StoreWord;	

if (opcode == JOP && func == JF)
	command <= Jump;

if (opcode == JOP && func == JRF)
	command <= JumpReg;
	
if (opcode == JALOP && func == JALF)
	command <= JumpAndLink;	
	
if (opcode == BNEOP && func == BNEF)
	command <= BranchNotEqual;	
	
if (opcode == XORIOP && func == XORIF)
	command <= XORI;	
	
if (opcode == AddSubOP && func == AddF)
	command <= Add;	
	
//if (opcode == AddiOP && func == AddiF)
if (opcode == AddiOP)
	command <= Addi;	
	
if (opcode == AddSubOP && func == SubF)
	command <= Sub;	
	
if (opcode == AddSubOP && func == SLTF)
	command <= SLT;	

case (command)
	
	Add: begin
		PCcontrol <= 1 ;  	
		RegFWrEn <= 1 ; 
		Mux3<=2'b01;
	end // end of add


	Addi: begin
		PCcontrol <= 1 ;  	
		RegFWrEn <= 1 ; 
		Mux3<=2'b00;
	end 		// end of the stage when counter is 1 




	LoadWord: begin	
			PCcontrol <= 1 ;	
			Mux2 <= 	1 ;	
			Dec1 <= 	1 ; 	
			Mux3 <= 	2'b01 ;
			Mux4 <= 	2'b01 ;			
			ALU3 <= 	3'b000 ;		// should be whatever control number add is 
			RegFWrEn <= 0 ;						
	end // end of load word 
	
	
//////////////////////////////////////////////////
/////////////////////////////////////////////////	
	
	
	StoreWord: begin	
	
		if (counter == 1) begin
			PCcontrol <= 		0 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	1 ;
			ALU3 <= 	3'b000 ;		// should be whatever control number add is 
			Mux6 <= 	2'b00 ;
		end 			// end the first stage when counter is 0 

		if (counter == 2) begin		
			ALU3 <= 	3'b000 ;
			Mux3 <= 	2'b00 ;
			Mux5 <= 	1 ;
			Mux6 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			PCcontrol <= 		1 ;
			Mux2 <= 	1 ;	
			MemWrEn <= 	1 ; 
		end 		// end the second stage when counter is 1 
		else
			PCcontrol <= 0;		
	end // end of save word 
	
	Jump: begin
	
		if (counter == 1) begin
			PCcontrol <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
//			ALU3 <= 	nothing? ;	
			Mux6 <= 	2'b01 ;
		end 		 // end of the 0th and only stage 
	end // end of jump
	
	JumpReg: begin
	
		if (counter == 1) begin
			PCcontrol <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			//ALU3 <= 	nothing? ;	
			Mux6 <= 	2'b10 ;		
		end 		 // end of the 0th and only stage 
	end // end of jump register
	
	JumpAndLink: begin
		if (counter == 1) begin
		PCcontrol <= 		1 ;
		Mux1 <= 	0 ;
		Mux2 <= 	0 ;
		MemWrEn <= 	0 ; 
		Dec1 <= 	0 ; 
		Mux3 <= 	2'b10 ;
		Mux4 <= 	2'b10 ;
		RegFWrEn <= 1 ;
		Mux5 <= 	0 ;
		//ALU3 <= 	nothing? ;	
		Mux6 <= 	2'b01 ;
		end
	end // end of jump and link
	
	BranchNotEqual: begin
	
		if (counter == 1) begin
			PCcontrol <= 		0 ;
			Mux1 <= 	~zeroflag3 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	3'b001 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the 0th stage when counter is zero 
		if (counter == 2) begin
			PCcontrol <= 		1 ;
			Mux1 <= 	0 ;
		end 			// end of the stage when counter is 1 
		else
			PCcontrol <= 0;		
	end // end of branch if not equal
	
	XORI: begin
		if (counter == 1) begin
			PCcontrol <= 		0 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b01 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 1 ;
			Mux5 <= 	1 ;
			ALU3 <= 	3'b010 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		else if (counter == 2) begin
			ALU3 <= 	3'b010 ;	
			PCcontrol <= 		1 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 0 ; 
		end 		// end of the stage when counter is 1 
		else if (counter == 3) begin
			ALU3 <= 3'b010;
			PCcontrol <= 0;
		end
		else begin
			PCcontrol <= 0;
		end
	end // end of xor immediate  

	Sub: begin
		if (counter == 1) begin
			PCcontrol <= 		0 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b01 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 1 ;
			Mux5 <= 	0 ;
			ALU3 <= 	3'b001 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 2) begin
			ALU3 <= 	3'b001 ;	
			PCcontrol <= 		1 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 0 ; 
		end 		// end of the stage when counter is 1 
		else
			PCcontrol <= 0;
	end // end of sub
	
	
	SLT: begin
		if (counter == 1) begin
			PCcontrol <= 		0 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b01 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 1 ;
			Mux5 <= 	0 ;
			ALU3 <= 	3'b011 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 2) begin	
			ALU3 <= 	3'b011 ;	
			PCcontrol <= 		1 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 0 ; 
		end // end of the stage when counter is 1 
		else
			PCcontrol <= 0;
	end // end of set less than 

endcase

end // ends the always @ pos clock thing 

endmodule 

