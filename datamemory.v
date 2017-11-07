module datamemory
#(
    parameter addresswidth  = 32,
    parameter depth         = 2**addresswidth,
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

endmodule
