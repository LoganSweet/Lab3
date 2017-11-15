`include "mux.v"


`include "decoder.v"
module testdecoder();

wire output0;
wire [4:0] address0;
wire [31:0] inputs0;

mux32to1by1 mux3211(ouput0, address0, inputs0);



endmodule
