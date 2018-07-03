module BCD (input [3:0] Data,
				output reg [13:0] Segments);
				
always @(*)
	case (Data)
4'b0000: Segments = 14'b11111101111110; //0
4'b0001: Segments = 14'b11111100110000; //1
4'b0010: Segments = 14'b11111101101101; //2
4'b0011: Segments = 14'b11111101111001; //3
4'b0100:	Segments = 14'b11111100110011; //4
4'b0101: Segments = 14'b11111101011011; //5
4'b0110:	Segments = 14'b11111101011111; //6
4'b0111:	Segments = 14'b11111101110000; //7
4'b1000: Segments = 14'b11111101111111; //8
4'b1001: Segments = 14'b11111101111011; //9
4'b1010: Segments = 14'b01100001111110; //10
4'b1011: Segments = 14'b01100000110000; //11
4'b1100:	Segments = 14'b01100001101101; //12
4'b1101:	Segments = 14'b01100001111001; //13
4'b1110:	Segments = 14'b01100000110011; //14
4'b1111:	Segments = 14'b01100001011011; //15
endcase
 
endmodule 