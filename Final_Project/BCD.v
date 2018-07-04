module BCD (input [3:0] Data,
				output reg [13:0] Segments);
				
always @(*)
	case (Data)
4'b0000: Segments = 14'b10000001000000; //0
4'b0001: Segments = 14'b10000001111001; //1
4'b0010: Segments = 14'b10000000100100; //2
4'b0011: Segments = 14'b10000000110000; //3
4'b0100:	Segments = 14'b10000000011001; //4
4'b0101: Segments = 14'b10000000010010; //5
4'b0110:	Segments = 14'b10000000000010; //6
4'b0111:	Segments = 14'b10000001111000; //7
4'b1000: Segments = 14'b10000000000000; //8
4'b1001: Segments = 14'b10000000010000; //9

4'b1010: Segments = 14'b11110011000000; //10
4'b1011: Segments = 14'b11110011111001; //11
4'b1100:	Segments = 14'b11110010100100; //12
4'b1101:	Segments = 14'b11110010110000; //13
4'b1110:	Segments = 14'b11110010011001; //14
4'b1111:	Segments = 14'b11110010010010; //15
default: Segments = 14'b11111111111111; //blank
endcase
 
endmodule 