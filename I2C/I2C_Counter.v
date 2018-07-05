module I2C_Counter (input SYNCED_CLK,
						  input RST,
						  input SDATA,
						  output reg [7:0] DATA_REG,
						  output reg PARITY_BIT,
						  output VALID_PACK);

reg [3:0] COUNTER;
reg START, STOP;

always@(negedge SYNCED_CLK)
	if(!RST)
		begin
			START<=0;
			COUNTER<=0;
			STOP<=0;
		end
	else
		begin
			case(COUNTER)
				0: if(SDATA==0)
						START<=1;
				1:	DATA_REG[0]<=SDATA;
				2: DATA_REG[1]<=SDATA;
				3: DATA_REG[2]<=SDATA;
				4: DATA_REG[3]<=SDATA;
				5: DATA_REG[4]<=SDATA;
				6: DATA_REG[5]<=SDATA;
				7: DATA_REG[6]<=SDATA;
				8: DATA_REG[7]<=SDATA;
				9: PARITY_BIT<=SDATA;
				10: if (SDATA==1)
						STOP<=1;
			endcase
			
			if(COUNTER==10)
				COUNTER<=0;
			else
				COUNTER<=COUNTER+1;
		end

assign VALID_PACK = START&STOP;

endmodule 
		