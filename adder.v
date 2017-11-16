module adder(
output [31:0] sum,
output carryout,
input [31:0] A,
input [31:0] B,
input carryin
);
    assign {carryout, sum}=A+B+carryin;
    
endmodule

