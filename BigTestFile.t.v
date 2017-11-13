// test for Lab 3 modules

//`include "datamemory.v"
`include "decoder.v"


module testdecoder();

wire[31:0]	DecOut;
reg			enable;  	//input
reg [4:0]	address;	//input 
    
decoder1to32 x(DecOut, enable, address);    

initial begin
$dumpfile("decodertest.vcd");
$dumpvars();
    
$display("addr |enbl|             DecOut	");
address = 0001; enable = 1; #200
$display("%b|  %b |%b ", address, enable, DecOut);

address = 0001; enable = 0; #200
$display("%b|  %b |%b ", address, enable, DecOut);

address = 0010; enable = 1; #200
$display("%b|  %b |%b ", address, enable, DecOut);

address = 0010; enable = 0; #200
$display("%b|  %b |%b ", address, enable, DecOut);

address = 0011; enable = 1; #200
$display("%b|  %b |%b ", address, enable, DecOut);

address = 0011; enable = 0; #200
$display("%b|  %b |%b ", address, enable, DecOut);



// this is example code that Ben provided for HW4
// it seems like something is wrong with it. 
// When I set address to 0010, the one that prints is 01010
// when it is set to 0011, the one that prints is 01011

// I'm probably doing something stupid. Unclear. 


$finish;
end


endmodule


