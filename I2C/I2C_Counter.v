module I2C_Counter (input SYNCED_CLK,
						  input RST,
						  input [10:0] SHIFT_REG,
						  output reg [8:0] DATA_REG,
						  output reg VALID_PACK);

reg [3:0] COUNTER;
reg START, STOP;
wire DATA;

assign DATA = SHIFT_REG[10];

always@(negedge SYNCED_CLK)
	if(!RST)
		begin
			START<=0;
			COUNTER<=0;
			STOP<=0;
		end
	else
		begin
			if(DATA==0 & COUNTER==0)
				begin
					START<=1;
					COUNTER<=COUNTER+1;
					DATA_REG<=SHIFT_REG[9:1];
				end
			
			if(DATA==1 & COUNTER==10)
				begin
					STOP<=1;
					COUNTER<=0;
					VALID_PACK<=1;
				end
			
			if(START==1 & COUNTER<10)
				COUNTER<=COUNTER+1;
				
			if(DATA==0 & COUNTER==10)
				VALID_PACK<=0;
		end

endmodule 
		