module VGA_Sync_Calc (input CLK, P_CLK, RST,
							 input [11:0] VIS,
							 input [7:0] FRONT, SYNC, BACK,
							 output OUT_SYNC,
							 output [11:0] POSITION,
							 output ACTIVE_ZONE,
							 output reg SIG_CLK);
							 
reg [11:0] COUNTER;

always@(posedge P_CLK)
	if(!RST)	
		begin
			COUNTER <= 0;
			SIG_CLK <= 0;
		end
	else
		if(COUNTER == VIS+BACK+SYNC+FRONT-1)		//end of screen
			begin
				COUNTER <= 0;
				SIG_CLK <= 1;
			end
		else
			begin
				COUNTER <= COUNTER + 1;
				SIG_CLK <= 0;
			end
			
assign POSITION = (ACTIVE_ZONE) ? COUNTER : 0;
assign ACTIVE_ZONE = (COUNTER < VIS) ? 1 : 0;
assign OUT_SYNC = ((COUNTER >= VIS+FRONT) & (COUNTER < VIS+FRONT+SYNC)) ? 0 : 1;
//assign SIG_CLK = (COUNTER == VIS+BACK+SYNC+FRONT-1) ? 1 : 0;

endmodule  