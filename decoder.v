// decoder for lab 3 

module decoder1to32
(
output[31:0]	DecOut,
input			enable,
input[4:0]		address
);
    assign DecOut = enable<<address; 
endmodule
