module VGA_Sync_Calc (input P_CLK, RST,
							 input [11:0] VIS,
							 input [7:0] FRONT, SYNC, BACK,
							 output reg OUT_SYNC,
							 output reg [11:0] POSITION,
							 output reg ACTIVE_ZONE);
							 
reg [11:0] COUNTER;

always@(posedge P_CLK)
	if(!RST)																			//reset
		begin
			COUNTER <= 0;
			OUT_SYNC <= 1;
		end
	else
		begin
			//sync calc
			if(COUNTER == VIS+BACK+SYNC+FRONT-1)							//end of screen
				begin
					OUT_SYNC <= 1;
					COUNTER <= 0;
				end
			else
				if(COUNTER < VIS+BACK-1 | COUNTER > VIS+BACK+SYNC-1)  //outside sync pixels
					begin
						OUT_SYNC <= 1;
						COUNTER <= COUNTER + 1;
					end
				else																	//inside sync pixels
					begin
						OUT_SYNC <= 0;
						COUNTER <= COUNTER + 1;
					end
					
			// position & active zone calc	
			if(COUNTER < VIS-1)													//active zone
				begin
					POSITION <= COUNTER + 1;
					ACTIVE_ZONE <= 1;
				end
			else																		//inactive zone
				begin
					POSITION <= 0;
					ACTIVE_ZONE <= 0;
				end
		end

endmodule 