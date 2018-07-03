module I2C_Top (input SCLK,
					 input SDATA,
					 input CLK, RST,
					 output NEW_CODE,
					 output [7:0] CODE);
					 
reg SYNCED_CLK;
reg [10:0] SHIFT_REG;
reg [7:0] DATA_REG;
wire VALID_PACK;

always@(posedge CLK)
	SYNCED_CLK<=SCLK;

always@(posedge SYNCED_CLK)
	SHIFT_REG<={SHIFT_REG[9:0],SDATA};
	
I2C_Control DUT1(.SYNCED_CLK(SYNCED_CLK),
					  .RST(RST),
					  .DATA(SDATA),
					  .VALID_PACK(VALID_PACK));
					  

endmodule 