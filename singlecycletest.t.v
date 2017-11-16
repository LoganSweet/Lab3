`include "singlestream.v"


module singlecycletest();

reg clk;

initial clk=0;
always #10 clk=!clk;

singlestream test1(clk);

initial begin
$dumpfile("cpu.vcd");
$dumpvars();

#20000
$finish;
end



endmodule
