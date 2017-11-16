`include "decoder.v"
/*
module testdec1to32();

wire  [31:0]  out;
wire  enable;
wire [4:0] address;

  reg		begintest;	// Set High to begin testing register file
  wire		dutpassed;	// Indicates whether register file passed tests
  wire		Clk;		// Clock (Positive Edge Triggered)

decoder1to32 DUT(out, enable, address);
decoder1to32tester TEST(begintest, endtest, dutpassed, out, enable, address, Clk);

  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end
  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("Dec 1:32 DUT passed?: %b", dutpassed);
  end
endmodule

module decoder1to32tester(
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result

input [31:0]  out,
output reg enable,
output reg [4:0] address,
output reg		Clk
);

initial begin
//out = 32'b0;
enable = 0;
address = 5'b0;
Clk = 0;
end

   always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10
    
    address = 00000;
    enable = 1;
    #5 Clk=1; #5 Clk=0;	// Generate single clock pulse
    
    if(out != 32'b001) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 1 Failed");
  end
       #5
  endtest = 1; 
    end
endmodule
*/

module testdec32to2();
wire [31:0]	InstructIn;
wire [31:0]	DataReg;
wire			address; // address - where does DataIn go?
wire [31:0]	DataIn;

  reg		begintest;	// Set High to begin testing register file
  wire		dutpassed;	// Indicates whether register file passed tests
  wire		Clk;		// Clock (Positive Edge Triggered)

decoder32to2 DUT(InstructIn, DataReg, address, DataIn);
decoder32to2tester TEST(begintest, endtest, dutpassed, InstructIn, DataReg, address, DataIn, Clk);

  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end
  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("Dec 32:2 DUT passed?: %b", dutpassed);
  end
endmodule

module decoder32to2tester(
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result

input [31:0]	InstructIn,
input [31:0]	DataReg,
output reg		address, // address - where does DataIn go?
output reg [31:0]	DataIn,
output reg Clk
);

initial begin
//out = 32'b0;
address = 0;
DataIn = 32'b0101;
Clk = 0;
end

   always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10
    
    address = 0;
    #5 Clk=1; #5 Clk=0;	// Generate single clock pulse
    
    if(InstructIn != 32'b0101) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 1 Failed");
  end
  
      address = 1;
    #5 Clk=1; #5 Clk=0;	// Generate single clock pulse
    
    if(DataReg != 32'b0101) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 2 Failed");
  end
       #5
  endtest = 1; 
    end
endmodule

