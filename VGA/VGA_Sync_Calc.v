module VGA_Sync_Calc (input CLK, P_CLK, RST,
							 input MODE,
							 output [11:0] XPOS, YPOS,
							 output HSYNC, VSYNC,
							 output DISP_ACTIVE);
							 
reg [11:0] H_COUNTER, V_COUNTER;
wire H_ACTIVE, V_ACTIVE;
reg [11:0] H_VIS, V_VIS;
reg [7:0] H_FRONT, V_FRONT;
reg [7:0] H_SYNC, V_SYNC;
reg [7:0] H_BACK, V_BACK;

always@(MODE)																											//choosing the parameters
	case(MODE)
		0: begin
				//VAL=2;
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
				//VAL=1;
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

//always@(posedge CLK)
//	if(!RST)	
//			COUNTER <= 0;
//	else
//		if(P_CLK)
//			if(COUNTER == VIS+BACK+SYNC+FRONT-1)		//end of screen
//				COUNTER <= 0;
//			else
//				COUNTER <= COUNTER + 1;


always@(posedge CLK)
	begin
		if (!RST)  																										//reset
        begin
            H_COUNTER <= 0;
            V_COUNTER <= 0;
        end
        if (P_CLK)  																									//once per pixel
        begin
            if (H_COUNTER == H_VIS+H_BACK+H_SYNC+H_FRONT-1)  											//end of line
            begin
                H_COUNTER <= 0;
                V_COUNTER <= V_COUNTER + 1;
            end
            else 
                H_COUNTER <= H_COUNTER + 1;

            if (V_COUNTER == V_VIS+V_BACK+V_SYNC+V_FRONT-1)  											//end of screen
                V_COUNTER <= 0;
        end
    end


assign DISP_ACTIVE = H_ACTIVE & V_ACTIVE;																		//checking if the current position is within the visible display
	 
assign XPOS = (H_COUNTER < H_VIS) ? H_COUNTER : 0;
assign H_ACTIVE = (H_COUNTER < H_VIS) ? 1 : 0;
assign HSYNC = (H_COUNTER >= H_VIS+H_BACK-1 & H_COUNTER <= H_VIS+H_BACK+H_SYNC-1) ? 0 : 1;

assign YPOS = (V_COUNTER < V_VIS) ? V_COUNTER : 0;
assign V_ACTIVE = (V_COUNTER < V_VIS) ? 1 : 0;
assign VSYNC = (V_COUNTER >= V_VIS+V_BACK-1 & V_COUNTER <= V_VIS+V_BACK+V_SYNC-1) ? 0 : 1;

endmodule 