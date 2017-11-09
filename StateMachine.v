//------------------------------------------------------------------------
// Finite State Machine
//------------------------------------------------------------------------

`include "alu_structural.v"

module StateMachine
(
	input[5:0] opcode,  
	input zeroflag3,	
	input clk
);

reg PC; // this controls whether the PC flip flop is enabled
reg Mux1; // Mux1 controller
reg Mux2; // Mux2 controller
reg MemWrEn; // is memory write enable on or off
reg Dec1; // Dec1 controller
reg [1:0] Mux3;
reg [1:0] Mux4;
reg RegFWrEn;
reg Mux5;
reg [2:0] ALU3;
reg [1:0] Mux6;

localparam LoadWord = 6'b000000; // this should be some number that gives us enough options to have all of our commands
localparam StoreWord = 6'b000001;
localparam Jump = 6'b000010;
localparam JumpReg = 6'b000011;
localparam JumpAndLink = 6'b000100;
localparam BranchNotEqual = 6'b000101;
localparam XORI = 6'b000110;
localparam Add = 6'b000111;
localparam Addi = 6'b001000;
localparam Sub = 6'b001001;
localparam SLT = 6'b001010;
reg [5:0] command;

reg[5:0] counter = 0;


always @(posedge clk) begin

if (opcode == LoadWord)
	command <= LoadWord;
	
// ^^ need to to the above for ALL of the possible commands 

counter = counter + 1 ; 

if (counter == 3)
	counter <= 0 ; 

case (command)

	LoadWord: begin	
		// maybe needs to establish that counter is zero here? 	
		// if it does, then it needs to be at the beginning (or end?) of each one 
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ; // I'm concerned about the feasibility of this - can you actually do it just like 00?
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;	
			Mux5 <= 	1 ;
			ALU3 <= 	3'b000 ;		// should be whatever control number add is 
			Mux6 <= 	2'b00 ;	
		end 		// ends the first stage, counter 0 
		
		if (counter == 1) begin	
			PC <= 		0 ;	
			Mux2 <= 	1 ;	
			Dec1 <= 	0 ; 	
			Mux3 <= 	2'b01 ;
			Mux4 <= 	2'b01 ;			
			ALU3 <= 	3'b000 ;		// should be whatever control number add is 
		end // end coumter is 1 
				
	end // end of load word 
	
	StoreWord: begin	
	
		if (counter == 0) begin
			PC <= 		1 ;
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

		if (counter == 1) begin		
			PC <= 		0 ;
			Mux2 <= 	1 ;	
			MemWrEn <= 	1 ; 
		end 		// end the second stage when counter is 1 		
	end // end of save word 
	
	Jump: begin
	
		if (counter == 0) begin
			PC <= 		1 ;
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
	
		if (counter == 0) begin
			PC <= 		1 ;
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
		if (counter == 0) begin
		PC <= 		1 ;
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
	
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
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
		if (counter == 1) begin
			PC <= 		0 ;
			Mux1 <= 	~zeroflag3 ;
		end 			// end of the stage when counter is 1 
	end // end of branch if not equal
	
	XORI: begin
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	1 ;
			ALU3 <= 	3'b010 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 1) begin
			PC <= 		0 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 1 ; 
		end 		// end of the stage when counter is 1 
	end // end of xor immediate  
	
	
	Add: begin
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	3'b000 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 	1) begin
			PC <= 		0 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 1 ; 
		end 		// end of the stage when counter is 1 
	end // end of add
	
	Addi: begin
		if (counter == 0) begin
			PC <= 		1 ;
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
		end 		// end of the thing when counter is 0 
		if (counter == 1) begin
			PC <= 		0 ;  	
			Mux3 <= 	2'b00 ;
			RegFWrEn <= 1 ; 
		end 		// end of the stage when counter is 1 
	end // end of addi
	
	Sub: begin
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	3'b001 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 0) begin
			PC <= 		0 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 1 ; 
		end 		// end of the stage when counter is 1 
	end // end of sub
	
	
	SLT: begin
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	2'b00 ;
			Mux4 <= 	2'b00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	3'b011 ;	
			Mux6 <= 	2'b00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 1) begin	
			PC <= 		0 ;  	
			Mux3 <= 	2'b01 ;
			RegFWrEn <= 1 ; 
		end // end of the stage when counter is 1 
	end // end of set less than 

endcase

end // ends the always @ pos clock thing 

endmodule 

