module I2C_Control ()

reg [3:0] Counter;

always@(negedge SYNCED_CLK)