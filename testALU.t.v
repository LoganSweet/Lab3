`include "alu_structural.v"

module testALU();

wire[31:0]  result; // OneBitFinalOut
wire        carryout;
wire        zero; //AllZeros
wire        overflow;
reg[31:0]   operandA; // A
reg[31:0]   operandB; // B
reg[2:0]    command; //Command

ALU testALU(result, carryout, zero, overflow, operandA, operandB, command);

initial begin

$display("Result | COut | Zero | OF | A | B | Cmd");
operandA = 32'b100; operandB = 32'b001; command = 000; #300
$display("%b | %b | %b | %b | %b | %b | %b", result[2:0], carryout, zero, overflow, operandA[2:0], operandB[2:0], command);

end

endmodule
