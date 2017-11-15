/*module datamemory
#(
    parameter addresswidth  = 32,
 //   parameter depth         = 2**addresswidth,
 // Ben hill says to make this 16kiB, or (0x4000 bytes)
  // I've tried every converted on the internet and those numbers do NOT match up. 
  // kiB could be kibi- or kilo-, but neither seem right. 
  // for now, I'll try just 16 as depth and see what happens? 
  	parameter depth 		= 16,
    parameter width         = 32
)
(
    input 		                clk,
    output wire [width-1:0]      dataOut, // changed from reg to wire
    input [addresswidth-1:0]    address,
    input                       writeEnable,
    input [width-1:0]           dataIn
);
    reg [width-1:0] memory [depth-1:0];
    assign dataOut = memory[address]; // moved out of the always @posedge clk
    
    always @(posedge clk) begin
        if(writeEnable)
            memory[address] <= dataIn;
    end
endmodule*/
module datamemory
(
  input clk, regWE,
  input[31:0] Addr,
  input[31:0] DataIn,
  output[31:0]  DataOut
);
  
  reg [31:0] mem[1023:0];  
  
  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end
  
  initial $readmemh("Test.dat", mem);
    
  assign DataOut = mem[Addr];
endmodule

