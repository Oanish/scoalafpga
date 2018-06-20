module Testbench;

reg CLK;
reg RST;
reg [3:0] MODE;
reg [7:0] Ri, Gi, Bi;
wire DISP_ACTIVE;
wire HSYNC, VSYNC, HSYNC_N, VSYNC_N;
wire [11:0] XPOS, YPOS;
wire [7:0] Ro, Go, Bo;

VGA_Top DUT(.CLK(CLK),
				.RST(RST),
				.MODE(MODE),
				.Ri(Ri),
				.Gi(Gi),
				.Bi(Bi),
				.DISP_ACTIVE(DISP_ACTIVE),
				.HSYNC(HSYNC),
				.VSYNC(VSYNC),
				.HSYNC_N(HSYNC_N),
				.VSYNC_N(VSYNC_N),
				.XPOS(XPOS),
				.YPOS(YPOS),
				.Ro(Ro),
				.Go(Go),
				.Bo(Bo));

initial begin
CLK=0;
forever #10 CLK=!CLK;
end

initial begin
RST=0;
#20 RST=1; MODE=4;
#500 $stop;
end

endmodule 