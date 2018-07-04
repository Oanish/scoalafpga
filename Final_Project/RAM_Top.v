module RAM_Top (input MasterClock,				//the board oscillator clock
					 input [3:0] Data,				//the data input from switches 6-9
					 input [3:0] Address,			//the address input from switches 0-3
					 input WriteEnable,				//the write operation select from key 3
					 input OutputEnable,				//the read operation select from key 2
					 output [13:0] DigitAddr,		//the current address shown on digits 2-3
					 output [13:0] DigitData,		//the data at the current address shown on digits 0-1					 
					 inout [3:0] DT,					//the data for the embedded SRAM
					 output [3:0] AD,					//the address for the embedded SRAM
					 output reg WE, OE, CE);		//control signals for the embedded SRAM
					 
wire [3:0] Data_Wire;

always@(posedge MasterClock)
	if(!WriteEnable)
		begin
			CE <= 0;
			WE <= 0;
		end
	else
		if(!OutputEnable)
			begin
				CE <= 0;
				if (CE == 0)
					OE <= 0;
			end
		else
			begin
				CE <= 1;
				WE <= 1;
				OE <= 1;
			end
			
assign DT = (WE==0)?Data:(OE==0)?DT:4'bz;
assign AD = Address;

BCD DUT1 (.Data(AD),
			 .Segments(DigitAddr));

BCD DUT2 (.Data(DT),
			 .Segments(DigitData));

endmodule 