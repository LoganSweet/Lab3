//------------------------------------------------------------------------
// Finite State Machine
//------------------------------------------------------------------------

module StateMachine
(
	input[5:0] opcode,  
	input zeroflag3,	
	input clk
);

wire PC; // this controls whether the PC flip flop is enabled
wire Mux1; // Mux1 controller
wire Mux2; // Mux2 controller
wire MemWrEn; // is memory write enable on or off
wire Dec1; // Dec1 controller
wire [1:0] Mux3;
wire [1:0] Mux4;
wire RegFWrEn;
wire Mux5;
wire [2:0] ALU3;
wire [1:0] Mux6;

localparam LoadWord = 6'b000000; // this should be some number that gives us enough options to have all of our commands
localparam StoreWord = 6'b000001;
// etc

reg[5:0] counter = 0;


always @(posedge clk) begin

if (opcode == LoadWord)
	command <= LoadWord;
	
// ^^ need to to the above for ALL of the possible commands 

counter = counter + 1 ; 

if (counter == [the max number we need])
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
		
		//counter = counter +1 ; 		// maybe we don't need to do this since there isn't a second thing
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
	
	
		
	
	
/////////////////////////////////////////////////////////////////
/////////   ones below here need to be finished /////////////////
/////////////////////////////////////////////////////////////////
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
		end 		// end of the stage when counter is 1 
	end // end of set less than 
	

end 





end // ends the always @ pos clock thing 

endmodule 


