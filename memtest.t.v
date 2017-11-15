`include "datamemory.v"

module memtest();

  reg clk;
  reg regWE;
  reg[31:0] Addr;
  reg[31:0] DataIn;
  wire[31:0]  DataOut;
  
  datamemory test(clk, regWE, Addr, DataIn, DataOut);
   
  initial begin
  $display("Clk | Address | RegWE | DataIn | DataOut ");
  clk = 1;  Addr = 32'b11; regWE = 0; DataIn = 32'b1010; #400
  $display("%b   |%b 	| %b | %b  |  %b ", clk, Addr[3:0], regWE, DataIn[3:0], DataOut[3:0]);
  
    clk = 0;  Addr = 32'b11; regWE = 1; DataIn = 32'b1010; #400
  $display("%b   |%b 	| %b | %b  |  %b ", clk, Addr[3:0], regWE, DataIn[3:0], DataOut[3:0]);
  
  clk = 1;  Addr = 32'b11; regWE = 1; DataIn = 32'b1010; #4000
  $display("%b   |%b 	| %b | %b  |  %b ", clk, Addr[3:0], regWE, DataIn[3:0], DataOut[3:0]);

  clk = 0;  Addr = 32'b01; regWE = 1; DataIn = 32'b1100; #4000
  $display("%b   |%b 	| %b | %b  |  %b ", clk, Addr[3:0], regWE, DataIn[3:0], DataOut[3:0]);
  clk = 1;  Addr = 32'b01; regWE = 1; DataIn = 32'b1100; #4000
  $display("%b   |%b 	| %b | %b  |  %b ", clk, Addr[3:0], regWE, DataIn[3:0], DataOut[3:0]);


  
  end

endmodule
