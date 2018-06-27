module I2C_Counter (input SYNCED_CLK,
						  input RST,
						  input [10:0] DATA,
						  output VALID_PACK);

reg [3:0] COUNTER;
reg START, STOP;

always@(negedge SYNCED_CLK)
	begin
	if(!RST)
		COUNTER<=0;
	else
		if(COUNTER == 10)
			COUNTER<=0;
		else
			COUNTER<=COUNTER+1;
			
	if(DATA[10] == 0)
		START<=1;
	if(DATA[0] == 1)
		STOP<=1;
	end
	
assign VALID_PACK = (START & STOP & (COUNTER == 10)) ? 1 : 0;

endmodule 
		