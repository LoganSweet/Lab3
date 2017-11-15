`include "singlestream.v"
module testSE();

reg [15:0] immediate;
wire[31:0] SEimm;

signextend test(immediate, SEimm);

initial begin
$display("Immediate | Sign Extended");
immediate = 0010000010001000; #200
$display("%b %b", immediate, SEimm);

immediate = 1000000000000000; #200
$display("%b %b", immediate, SEimm);


end

endmodule
