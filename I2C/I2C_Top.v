module I2C_Top (input CLK, RST,			//board oscillator clock and system reset
					 input SCLK,				//clock signal from keyboard
					 input SDATA,				//data signal from keyboard
					 output NEW_CODE,			//whether a new valid code is detected
					 output [13:0] CODE);		//valid code
					 
reg SYNCED_CLK;
wire [7:0] RAW_CODE;

always@(posedge CLK)
	SYNCED_CLK<=SCLK;
	
I2C_Control DUT1(.CLK(CLK),
					  .SYNCED_CLK(SYNCED_CLK),
					  .RST(RST),
					  .SDATA(SDATA),
					  .CODE(RAW_CODE),
					  .NEW_CODE(NEW_CODE));
					  
BCD DUT2(.BINARY(RAW_CODE[7:4]),
			.SEGMENTS(CODE[13:7]));
			
BCD DUT3(.BINARY(RAW_CODE[3:0]),
			.SEGMENTS(CODE[6:0]));
			
endmodule 