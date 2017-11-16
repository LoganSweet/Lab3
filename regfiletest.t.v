`include "regfile.v"

module regfiletest();

wire[31:0]	ReadData1;	// Contents of first register read
wire[31:0]	ReadData2;	// Contents of second register read
reg[31:0]	WriteData;	// Contents to write to register
reg[4:0]	ReadRegister1;	// Address of first register to read
reg[4:0]	ReadRegister2;	// Address of second register to read
reg[4:0]	WriteRegister;	// Address of register to write
reg		RegWrite;	// Enable writing of register when High
reg		Clk;

regfile Reg(ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);

initial begin
$display("Read1 | Read2 | Write | Add1Read |Add2Read | AddWrite   |Enable| Clk");
$display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");

WriteData = 32'b1111; ReadRegister1 = 5'b0000; ReadRegister2 = 5'b0000; WriteRegister = 5'b11; RegWrite = 1; Clk = 1; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);


WriteData = 32'b1111; ReadRegister1 = 5'b0000; ReadRegister2 = 5'b0000; WriteRegister = 5'b11; RegWrite = 0; Clk = 0; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk); 

WriteData = 32'b1111; ReadRegister1 = 5'b0011; ReadRegister2 = 5'b0000; WriteRegister = 5'b11; RegWrite = 0; Clk = 1; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);

WriteData = 32'b1111; ReadRegister1 = 5'b0011; ReadRegister2 = 5'b0000; WriteRegister = 5'b11; RegWrite = 0; Clk = 0; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);

WriteData = 32'b1111; ReadRegister1 = 5'b0011; ReadRegister2 = 5'b0000; WriteRegister = 5'b11; RegWrite = 0; Clk = 1; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);

WriteData = 32'b1111; ReadRegister1 = 5'b0110; ReadRegister2 = 5'b0010; WriteRegister = 5'b11; RegWrite = 0; Clk = 0; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);

WriteData = 32'b1111; ReadRegister1 = 5'b0110; ReadRegister2 = 5'b0010; WriteRegister = 5'b11; RegWrite = 0; Clk = 1; #200
$display("%b  | %b  | %b  | %b	 | %b   | %b	| %b | %b ", ReadData1[3:0], ReadData2[3:0], WriteData[3:0], ReadRegister1, ReadRegister2, WriteRegister, RegWrite, Clk);


end

	

endmodule

