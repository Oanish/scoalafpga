module I2C_Top (input SCLK,
					 input [10:0] SDATA,
					 input CLK, RST,
					 output NEW_CODE,
					 output [7:0] CODE);
					 
reg SYNCED_CLK;
reg [10:0] SYNCED_DATA;
reg [10:0] SHIFT_REG;
reg [7:0] DATA_REG;
wire VALID_PACK;

always@(posedge CLK)
	begin
		SYNCED_CLK<=SCLK;
		SYNCED_DATA<=SDATA;
	end

always@(posedge SYNCED_CLK)
	begin
		SHIFT_REG<=SYNCED_DATA;
		DATA_REG<=SHIFT_REG[9:2];
	end
	
I2C_Counter DUT1(.SYNCED_CLK(SYNCED_CLK),
					  .RST(RST),
					  .DATA(SYNCED_DATA),
					  .VALID_PACK(VALID_PACK));
					  

endmodule 