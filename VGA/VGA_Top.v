module VGA_Top (input CLK, RST,
					 input MODE,
					 output DISP_ACTIVE,
					 output HSYNC, VSYNC,
					 output [3:0] Ro, Go, Bo);

wire P_CLK;
wire Mem_HSYNC, Mem_VSYNC;
wire [11:0] XPOS, YPOS;
wire H_ACTIVE, V_ACTIVE;
reg [11:0] H_VIS, V_VIS;
reg [7:0] H_FRONT, V_FRONT;
reg [7:0] H_SYNC, V_SYNC;
reg [7:0] H_BACK, V_BACK;
wire H_SIG, V_SIG;

always@(MODE)				//choosing the parameters
	case(MODE)
		0: begin
				H_VIS=640;
				H_FRONT=16;
				H_SYNC=96;
				H_BACK=48;
				V_VIS=480;
				V_FRONT=10;
				V_SYNC=2;
				V_BACK=33;
			end
		1: begin
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

assign Ro = (DISP_ACTIVE) ? 4'b1111 : 4'b0;		//colour assignments
assign Go = 4'b0;
assign Bo = 4'b0;

VGA_Freq_Div DUT1(.CLK(CLK),							//frequency divider
						.RST(RST),
						.MODE(MODE),
						.P_CLK(P_CLK));
						
VGA_Sync_Calc DUT2(.CLK(CLK),							//calculating X position and Horizontal sync
						 .P_CLK((MODE)?CLK:P_CLK),				
						 .RST(RST),
						 .VIS(H_VIS),
						 .FRONT(H_FRONT),
						 .SYNC(H_SYNC),
						 .BACK(H_BACK),
						 .OUT_SYNC(Mem_HSYNC),
						 .POSITION(XPOS),
						 .ACTIVE_ZONE(H_ACTIVE),
						 .SIG_CLK(H_SIG));
						 
VGA_Sync_Calc DUT3(.CLK(CLK),							//calculating Y position and Vertical sync
						 .P_CLK(H_SIG),
						 .RST(RST),
						 .VIS(V_VIS),
						 .FRONT(V_FRONT),
						 .SYNC(V_SYNC),
						 .BACK(V_BACK),
						 .OUT_SYNC(Mem_VSYNC),
						 .POSITION(YPOS),
						 .ACTIVE_ZONE(V_ACTIVE),
						 .SIG_CLK(V_SIG));

assign DISP_ACTIVE = H_ACTIVE & V_ACTIVE;						 
assign HSYNC = (MODE)? !Mem_HSYNC : Mem_HSYNC;
assign VSYNC = (MODE)? !Mem_VSYNC : Mem_VSYNC;		
		
endmodule 