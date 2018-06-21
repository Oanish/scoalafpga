module VGA_Freq_Div (input CLK, RST,
							input MODE,
							output reg P_CLK);

reg [31:0] COUNTER;

always@(posedge CLK)
	case(MODE)
		0:{P_CLK, COUNTER} <= COUNTER + 16'h80000000;
		1:{P_CLK, COUNTER} <= COUNTER + 16'h100000000;
	endcase

/*always@(posedge CLK)
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
					COUNTER <= COUNTER + 1;*/

endmodule 