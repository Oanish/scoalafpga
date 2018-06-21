module Testbench;

reg CLK;
reg RST;
reg MODE;
reg [3:0] Colour;
wire DISP_ACTIVE;
wire HSYNC, VSYNC;
wire [11:0] XPOS, YPOS;
wire [3:0] Ro, Go, Bo;

VGA_Top DUT(.CLK(CLK),
				.RST(RST),
				.MODE(MODE),
				.Colour(Colour),
				.DISP_ACTIVE(DISP_ACTIVE),
				.HSYNC(HSYNC),
				.VSYNC(VSYNC),
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
#20 RST=1; MODE=1; Colour=15;
#500 $stop;
end

endmodule 