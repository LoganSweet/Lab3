`include "adder.v"

module testadder();
wire [31:0] sum;
wire carryout;
reg [31:0] A;
reg [31:0] B;
reg carryin;

adder add(sum, carryout, A, B, carryin);

initial begin
$display("Sum | A | B ");
A = 32'b01; B = 32'b10; carryin = 0; #100
$display("%b | %b | %b", sum, A, B);

end

endmodule
