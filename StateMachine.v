//------------------------------------------------------------------------
// Finite State Machine
//------------------------------------------------------------------------

module StateMachine
(
//	input[x:0] PC,  	// needs to be fixed 
	input clk
);

reg[x:0] command; 
localparam LoadWord = 2'b00000000 // this should be some number that gives us enough options to have all of our commands
localparam ......

// define counter = 0 here? or do it in the beginning of each 

// ALU1 controller always set to add
// ALU2 controller always set to add
// ALU3 controller NOT always add

always @(posedge clk) begin

ALU1 <= add // these should always be add, whatever control number add is 
ALU2 <= add // this one too 

if (PC == LoadWord)
	command <= LoadWord
	
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
			Mux3 <= 	00 ;
			Mux4 <= 	0 ;
			RegFWrEn <= 0 ;	
			Mux5 <= 	1 ;
			ALU3 <= 	add ;		// should be whatever control number add is 
			Mux6 <= 	00 ;	
		end 		// ends the first stage, counter 0 
		
		if (counter == 1) begin	
			PC <= 		0 ;	
			Mux2 <= 	1 ;	
			Dec1 <= 	0 ; 	
			Mux3 <= 	01 ;
			Mux4 <= 	1 ;			
			ALU3 <= 	add ;		// should be whatever control number add is 
		end // end coumter is 1 
				
	end // end of load word 
	
	SaveWord: begin	
	
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	00 ;
			Mux4 <= 	0 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	1 ;
			ALU3 <= 	add ;		// should be whatever control number add is 
			Mux6 <= 	00 ;
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
			Mux3 <= 	00 ;
			Mux4 <= 	0 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	nothing? ;	
			Mux6 <= 	01 ;
		end 		 // end of the 0th and only stage 
	end // end of jump
	
	JumpReg: begin
	
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	00 ;
			Mux4 <= 	0 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	nothing? ;	
			Mux6 <= 	10 ;		
		end 		 // end of the 0th and only stage 
	end // end of jump register
	
	JumpAndLink: begin
		PC <= 		1 ;
		Mux1 <= 	0 ;
		Mux2 <= 	0 ;
		MemWrEn <= 	0 ; 
		Dec1 <= 	0 ; 
		Mux3 <= 	10 ;
		Mux4 <= 	10 ;
		RegFWrEn <= 1 ;
		Mux5 <= 	0 ;
		ALU3 <= 	nothing? ;	
		Mux6 <= 	01 ;
		
		counter = counter +1 ; 		// maybe we don't need to do this since there isn't a second thing
	end // end of jump and link
	
	BranchNotEqual: begin
	
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	00 ;
			Mux4 <= 	00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	0 ;
			ALU3 <= 	subtract ;	
			Mux6 <= 	00 ;
		end 		// end of the 0th stage when counter is zero 
		if (counter == 1) begin
			PC <= 		0 ;
			Mux1 <= 	[this is the inverse of the outputt of the zero flag] ;
		end 			// end of the stage when counter is 1 
	end // end of branch if not equal
	
	XORI: begin
		if (counter == 0) begin
			PC <= 		1 ;
			Mux1 <= 	0 ;
			Mux2 <= 	0 ;
			MemWrEn <= 	0 ; 
			Dec1 <= 	0 ; 
			Mux3 <= 	00 ;
			Mux4 <= 	00 ;
			RegFWrEn <= 0 ;
			Mux5 <= 	1 ;
			ALU3 <= 	xor_inddicator for_the pants ;	
			Mux6 <= 	00 ;
		end 		// end of the thing when counter is 0 
		if (counter == 0) begin
			PC <= 		0 ;  	// check that this is right: we don't have it on the sheet we drew
			Mux3 <= 	01 ;
			RegFWrEn <= 1 ; 
		end 		// end of the stage when counter is 1 
	end // end of xor immediate  
	
	
	
/////////////////////////////////////////////////////////////////
/////////   ones below here need to be finished /////////////////
/////////////////////////////////////////////////////////////////	
	
	Add: begin
		if (counter == 0) begin
		end 		// end of the thing when counter is 0 
		if (counter == 0) begin
		end 		// end of the stage when counter is 1 
	end // end of add
	
	Addi: begin
		if (counter == 0) begin
		end 		// end of the thing when counter is 0 
		if (counter == 0) begin
		end 		// end of the stage when counter is 1 
	end // end of addi
	
	Sub: begin
		if (counter == 0) begin
		end 		// end of the thing when counter is 0 
		if (counter == 0) begin
		end 		// end of the stage when counter is 1 
	end // end of sub
	
	ALT: begin
		if (counter == 0) begin
		end 		// end of the thing when counter is 0 
		if (counter == 0) begin
		end 		// end of the stage when counter is 1 
	end // end of set less than 
	

end 





end // ends the always @ pos clock thing 

endmodule 


