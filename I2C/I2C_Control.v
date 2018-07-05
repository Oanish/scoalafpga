module I2C_Control (input CLK, SYNCED_CLK, RST,
						  input SDATA,
						  output [7:0] CODE,
						  output reg NEW_CODE);

wire [7:0] DATA_REG;
wire PARITY_BIT;

wire VALID_PACK;
wire VALID_PARITY;
wire VALID_CODE;

I2C_Counter DUT1(.SYNCED_CLK(SYNCED_CLK),
					  .RST(RST),
					  .SDATA(SDATA),
					  .DATA_REG(DATA_REG),
					  .PARITY_BIT(PARITY_BIT),
					  .VALID_PACK(VALID_PACK));
					  
assign VALID_PARITY = (DATA_REG[0]~^DATA_REG[7]~^DATA_REG[6]~^DATA_REG[5]~^DATA_REG[4]~^DATA_REG[3]~^DATA_REG[2]~^DATA_REG[1])~^PARITY_BIT;
assign VALID_CODE = VALID_PARITY & VALID_PACK & CLK;

always@(posedge CLK)
	NEW_CODE<=VALID_CODE;
	
assign CODE = DATA_REG;

endmodule 