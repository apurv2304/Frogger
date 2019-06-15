// Apurv Goel
// EE 271
// NetId - ag2304
// Date - 04/13/2019

// Initialises the seg7 to display numbers 0 to 9 on DE1-SoC board
module seg7_display(SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;
	
	seg7 display(.bcd(SW[9:6]), .leds(HEX0));
	
endmodule

// Checks for functionality of seg7_display
module seg7_display_testbench();

	logic [9:0] SW;
	logic [6:0] HEX0;
	
	seg7_display dut(.SW, .HEX0);
	
	integer i;
	
	initial begin
		for (i=0; i<2**4; i++) begin
			{SW[9:6]} = i; #10;
		end
	end
endmodule
