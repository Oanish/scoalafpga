module I2C_Control (input CLK, SYNCED_CLK, RST,
						  input SDATA,
						  output [7:0] CODE,
						  output reg NEW_CODE);

reg [10:0] SHIFT_REG;
wire [8:0] DATA_REG;
wire VALID_PACK;
wire DATA_PARITY;
wire VALID_PARITY;
wire VALID_CODE;

always@(posedge SYNCED_CLK)
	if(!RST)
		SHIFT_REG<=11'b0;
	else
		SHIFT_REG<={SHIFT_REG[9:0],SDATA};

I2C_Counter DUT1(.SYNCED_CLK(SYNCED_CLK),
					  .RST(RST),
					  .SHIFT_REG(SHIFT_REG),
					  .DATA_REG(DATA_REG),
					  .VALID_PACK(VALID_PACK));
					  
assign DATA_PARITY = DATA_REG[8]~^DATA_REG[7]~^DATA_REG[6]~^DATA_REG[5]~^DATA_REG[4]~^DATA_REG[3]~^DATA_REG[2]~^DATA_REG[1];
assign VALID_PARITY = DATA_PARITY~^DATA_REG[0];
assign VALID_CODE = VALID_PARITY & VALID_PACK & CLK;

always@(posedge CLK)
	NEW_CODE<=VALID_CODE;
	
assign CODE = (NEW_CODE)?DATA_REG[8:1]:8'bz;

endmodule 