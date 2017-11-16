`include "mux.v"


module testmux();

wire  [31:0]  muxout;
wire  address;
wire [31:0] ALU2out;
wire [31:0] PCp4;

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
    $display("Mux 2:1x32 DUT passed?: %b", dutpassed);
  end
endmodule

module mux2to1by32tester(
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result

input [31:0]  muxout,
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
	address = 0;

  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

  // Verify expectations and report test result
  if(muxout != 32'b1010) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 2 Failed");
  end
  
    #5
  endtest = 1;
end
endmodule

/*
module testmux351();

wire [4:0]  regfileaddress;
wire [1:0]  mux3ctrl;
wire[4:0] thirtyone;
wire[4:0] rt;
wire[4:0] rd;

  reg		begintest;	// Set High to begin testing register file
  wire		dutpassed;	// Indicates whether register file passed tests
  wire		Clk;		// Clock (Positive Edge Triggered)

mux3to1by5 DUT(regfileaddress, mux3ctrl, thirtyone, rt, rd);
mux3to1by5tester TEST(begintest, endtest, dutpassed, regfileaddress, mux3ctrl, thirtyone, rt, rd,Clk);

  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end
  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("Mux 3:1x5 DUT passed?: %b", dutpassed);
  end
endmodule

module mux3to1by5tester(
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result

input  [4:0]  regfileaddress,
output reg [1:0]  mux3ctrl,
output reg[4:0] thirtyone,
output reg[4:0] rt,
output reg[4:0] rd,
output reg Clk
);

  initial begin
  	mux3ctrl = 00;
	thirtyone = 5'b11111;
    rt=00100;
    rd=11001;
    Clk=0;
  end
   always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10
  // Test Case 1: 
  //   Do we get rd at muxout? we should
	mux3ctrl = 00;
	thirtyone = 5'b11111;
    rt=00100;
    rd=11001;
  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

  // Verify expectations and report test result
  if(regfileaddress != 11001) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 1 Failed");
  end
  
    // Test Case 2: 
  //   Do we get rt at muxout? we should
	mux3ctrl = 01;

  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

  // Verify expectations and report test result
  if(regfileaddress != 00100) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 2 Failed");
  end
  
      // Test Case 3: 
  //   Do we get 31 at muxout? we should
	mux3ctrl = 10;
  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse
  // Verify expectations and report test result
  if(regfileaddress != 11111) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 3 Failed");
  end
    #5
  endtest = 1;
end
endmodule
*/

