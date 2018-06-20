module VGA_Freq_Div (input CLK, RST,
							input [31:0] VAL,
							output reg P_CLK);

reg [31:0] COUNTER;

always@(posedge CLK)
	if(!RST)											//reset
		begin
			COUNTER <= 0;
			P_CLK <= 0;
		end
	else
		if(VAL == 1)								//keep frequency
			P_CLK <= CLK;
			else
				if(COUNTER == VAL-1)				//invert condition
					begin
						P_CLK = !P_CLK;
						COUNTER <= 0;
					end
				else									//incrementation
					COUNTER <= COUNTER + 1;

endmodule 