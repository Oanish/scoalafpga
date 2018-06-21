module VGA_Top (input CLK, RST,
					 //input Rset, Gset, Bset,
					 input MODE,
					 //input [3:0] Ri, Gi, Bi,
					 //input [3:0] Colour,
					 output DISP_ACTIVE,
					 output HSYNC, VSYNC,
					 output [3:0] Ro, Go, Bo);

wire P_CLK;
wire Mem_HSYNC, Mem_VSYNC;
//reg [31:0] VAL;
wire [11:0] XPOS, YPOS;


// Four overlapping squares						//colour assignments
wire sq_a, sq_b, sq_c, sq_d;	

assign sq_a = ((XPOS > 120) & (YPOS >  40) & (XPOS < 280) & (YPOS < 200)) ? 1 : 0;
assign sq_b = ((XPOS > 200) & (YPOS > 120) & (XPOS < 360) & (YPOS < 280)) ? 1 : 0;
assign sq_c = ((XPOS > 280) & (YPOS > 200) & (XPOS < 440) & (YPOS < 360)) ? 1 : 0;
assign sq_d = ((XPOS > 360) & (YPOS > 280) & (XPOS < 520) & (YPOS < 440)) ? 1 : 0;

assign Ro[3] = sq_b;         // square b is red
assign Go[3] = sq_a | sq_d;  // squares a and d are green
assign Bo[3] = sq_c;         // square c is blue

/*assign Ro=Colour;											
assign Go=Colour;
assign Bo=Colour;*/
/*VGA_Colour_Mem DUT0(.CLK(CLK),
						  .RST(RST),
						  .Colour(Colour),
						  .Rset(Rset),
						  .Gset(Gset),
						  .Bset(Bset),
						  .Ro(Ro),
						  .Go(Go),
						  .Bo(Bo));*/
					 
VGA_Freq_Div DUT1(.CLK(CLK),							//frequency divider
						.RST(RST),
						.MODE(MODE),
						.P_CLK(P_CLK));
						
/*VGA_Sync_Calc DUT2(.CLK(CLK),						//calculating X position and Horizontal sync
						 .P_CLK(P_CLK),				
						 .RST(RST),
						 .VIS(H_VIS),
						 .FRONT(H_FRONT),
						 .SYNC(H_SYNC),
						 .BACK(H_BACK),
						 .OUT_SYNC(Mem_HSYNC),
						 .POSITION(XPOS),
						 .ACTIVE_ZONE(H_ACTIVE));
						 
VGA_Sync_Calc DUT3(.CLK(CLK),							//calculating Y position and Vertical sync
						 .P_CLK(Mem_HSYNC),
						 .RST(RST),
						 .VIS(V_VIS),
						 .FRONT(V_FRONT),
						 .SYNC(V_SYNC),
						 .BACK(V_BACK),
						 .OUT_SYNC(Mem_VSYNC),
						 .POSITION(YPOS),
						 .ACTIVE_ZONE(V_ACTIVE));*/

VGA_Sync_Calc DUT2(.CLK(CLK),
						 .P_CLK(P_CLK),
						 .RST(RST),
						 .MODE(MODE),
						 .XPOS(XPOS),
						 .YPOS(YPOS),
						 .HSYNC(HSYNC),
						 .VSYNC(VSYNC),
						 .DISP_ACTIVE(DISP_ACTIVE));
						 
//assign HSYNC = (MODE)? !Mem_HSYNC : Mem_HSYNC;
//assign VSYNC = (MODE)? !Mem_VSYNC : Mem_VSYNC;		
		
endmodule 