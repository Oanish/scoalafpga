module VGA_Freq_Div (input CLK, RST,
							input MODE,
							output reg P_CLK);

reg [31:0] COUNTER;

always@(posedge CLK)
	case(MODE)
		0:{P_CLK, COUNTER} <= COUNTER + 16'h80000000;
		1:{P_CLK, COUNTER} <= COUNTER + 16'h100000000;
	endcase
	
endmodule 