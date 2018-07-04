module I2C_Top (input CLK, RST,			//board oscillator clock and system reset
					 input SCLK,				//clock signal from keyboard
					 input SDATA,				//data signal from keyboard
					 output NEW_CODE,			//whether a new valid code is detected
					 output [7:0] CODE);		//valid code
					 
reg SYNCED_CLK;

always@(posedge CLK)
	SYNCED_CLK<=SCLK;
	
I2C_Control DUT1(.CLK(CLK),
					  .SYNCED_CLK(SYNCED_CLK),
					  .RST(RST),
					  .SDATA(SDATA),
					  .CODE(CODE),
					  .NEW_CODE(NEW_CODE));
					  
endmodule 