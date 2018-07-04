module RAM_Ctrl (input MasterClock,		//the board oscillator clock
					  input ChipEnable,			//whether the RAM is active or not
					  input WriteEnable,		//whether the current operation is write
					  input OutputEnable,		//whether the current operation is read
					  input UpperB, LowerB,	//which byte of the memory location is being written/read
					  input [17:0] Address,	//selected address
					  inout [7:0] Data);		//colour byte (0-2 Blue, 3-4 Green, 5-7 Red)

always@(posedge MasterClock)
	if(!ChipEnable)
		begin
			
		end
		
endmodule 