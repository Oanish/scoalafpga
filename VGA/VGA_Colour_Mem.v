module VGA_Colour_Mem (input CLK, RST,
							  input Rset, Gset, Bset,
							  input [3:0] Colour,
							  output reg [3:0] Ro, Go, Bo);
							  
always@(posedge CLK)
	if(!RST)
		begin
			Ro <= 0;
			Go <= 0;
			Bo <= 0;
		end
	else
		if(!Rset)
			Ro <= Colour;
		else
			if (!Gset)
				Go <= Colour;
			else
				if (!Bset)
					Bo <= Colour;

endmodule 