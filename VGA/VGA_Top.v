module VGA_Top (input CLK, RST,
					 input Rset, Gset, Bset,
					 input MODE,
					 //input [3:0] Ri, Gi, Bi,
					 input [3:0] Colour,
					 output DISP_ACTIVE,
					 output HSYNC, VSYNC,
					 output [11:0] XPOS, YPOS,
					 output [3:0] Ro, Go, Bo);

wire P_CLK;
wire H_ACTIVE, V_ACTIVE;
wire Mem_HSYNC, Mem_VSYNC;
reg [11:0] H_VIS, V_VIS;
reg [7:0] H_FRONT, V_FRONT;
reg [7:0] H_SYNC, V_SYNC;
reg [7:0] H_BACK, V_BACK;
reg [31:0] VAL;

//assign Ro=Ri;											//colour assignments
//assign Go=Gi;
//assign Bo=Bi;
VGA_Colour_Mem DUT0(.CLK(CLK),
						  .RST(RST),
						  .Colour(Colour),
						  .Rset(Rset),
						  .Gset(Gset),
						  .Bset(Bset),
						  .Ro(Ro),
						  .Go(Go),
						  .Bo(Bo));

always@(MODE)											//choosing the parameters
	case(MODE)
		0: begin
				VAL=2;
				H_VIS=640;
				H_FRONT=16;
				H_SYNC=96;
				H_BACK=48;
				V_VIS=480;
				V_FRONT=10;
				V_SYNC=2;
				V_BACK=33;
			end
		//1:VAL=;
		//2:VAL=;
		//3:VAL=;
		1: begin
				VAL=1;
				H_VIS=800;
				H_FRONT=56;
				H_SYNC=120;
				H_BACK=64;
				V_VIS=600;
				V_FRONT=37;
				V_SYNC=6;
				V_BACK=23;
			end
	endcase
					 
VGA_Freq_Div DUT1(.CLK(CLK),						//frequency divider
						.RST(RST),
						.VAL(VAL),
						.P_CLK(P_CLK));
						
VGA_Sync_Calc DUT2(.P_CLK(P_CLK),				//calculating X position and Horizontal sync
						 .RST(RST),
						 .VIS(H_VIS),
						 .FRONT(H_FRONT),
						 .SYNC(H_SYNC),
						 .BACK(H_BACK),
						 .OUT_SYNC(Mem_HSYNC),
						 .POSITION(XPOS),
						 .ACTIVE_ZONE(H_ACTIVE));
						 
VGA_Sync_Calc DUT3(.P_CLK(Mem_HSYNC),				//calculating Y position and Vertical sync
						 .RST(RST),
						 .VIS(V_VIS),
						 .FRONT(V_FRONT),
						 .SYNC(V_SYNC),
						 .BACK(V_BACK),
						 .OUT_SYNC(Mem_VSYNC),
						 .POSITION(YPOS),
						 .ACTIVE_ZONE(V_ACTIVE));
						 
assign HSYNC = (MODE)? !Mem_HSYNC : Mem_HSYNC;
assign VSYNC = (MODE)? !Mem_VSYNC : Mem_VSYNC;
assign DISP_ACTIVE = H_ACTIVE & V_ACTIVE;		//checking if the current position is within the visible display
		
endmodule 