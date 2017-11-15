`include "mux.v"


module testmux();

output  [31:0]  muxout;
input  address;
input[31:0] ALU2out;
input[31:0] PCp4;

  reg		begintest;	// Set High to begin testing register file
  wire		dutpassed;	// Indicates whether register file passed tests
  wire		Clk;		// Clock (Positive Edge Triggered)


mux2to1by32 DUT(muxout, address, ALU2out, PCp4);
mux2to1by32tester TEST(begintest, endtest, dutpassed, muxout, address, ALU2out, PCp4, Clk);

  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end
  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("DUT passed?: %b", dutpassed);
  end
endmodule

module mux2to1by32tester(
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result
output reg [31:0]  muxout,
output reg address,
output reg [31:0] ALU2out,
output reg [31:0] PCp4,
output reg		Clk

);

  initial begin
    ALU2out=32'b0;
    PCp4=32'b0;
    address=0;
    Clk=0;
  end
   always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10
  // Test Case 1: 
  //   Do we get ALU2out at muxout? we should
	ALU2out = 32'b1111;
	PCp4 = 32'b0010;
	address = 1;

  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

  // Verify expectations and report test result
  if(muxout != 32'b1111) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 1 Failed");
  end
  
    // Test Case 2: 
  //   Do we get PCp4 at muxout? we should
	ALU2out = 32'b0101;
	PCp4 = 32'b1010;
	address = 1;

  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

  // Verify expectations and report test result
  if(muxout != 32'b1110) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 2 Failed");
  end
  
    #5
  endtest = 1;
end
endmodule


