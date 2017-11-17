iverilog -o testmux mux.t.v
./testmux
iverilog -o testdec dec.t.v 
./testdec
# to be included - memory, register, ALU, FSM?

