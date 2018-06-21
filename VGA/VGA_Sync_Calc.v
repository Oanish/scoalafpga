module VGA_Sync_Calc (input CLK, P_CLK, RST,
							 input [11:0] VIS,
							 input [7:0] FRONT, SYNC, BACK,
							 output OUT_SYNC,
							 output [11:0] POSITION,
							 output ACTIVE_ZONE);
							 
reg [11:0] COUNTER;

always@(posedge CLK)
	if(!RST)	
			COUNTER <= 0;
	else
		if(P_CLK)
			if(COUNTER == VIS+BACK+SYNC+FRONT-1)		//end of screen
				COUNTER <= 0;
			else
				COUNTER <= COUNTER + 1;
			
assign POSITION = (COUNTER < VIS) ? COUNTER : 0;
assign ACTIVE_ZONE = (COUNTER < VIS) ? 1 : 0;
assign OUT_SYNC = (COUNTER >= VIS+BACK-1 & COUNTER <= VIS+BACK+SYNC-1) ? 0 : 1;

endmodule 