// Apurv Goel
// EE 271
// NetId - ag2304
// Date - 06/04/2019

// Initialise the DE1-SoC board with the logic of hazard lights
module DE1_SoC (CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY,
					 LEDR, SW);
					 
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	inout logic [35:0] GPIO_0;
	logic [9:0] randomInput;
	
	logic resetLight, key;
	logic[2:0] LS, RS;
	
	logic left, right;

	logic [7:0] rowSink,orangeDriver, greenDriver;

	assign GPIO_0[11:0] = 12'b00000000000;

	assign GPIO_0[19:12] = rowSink;

	assign GPIO_0[27:20] = orangeDriver;
	
	assign GPIO_0[35:28] = greenDriver;

	logic keyl, keyr, keyd, keyu, reset, pause;
	logic L, R, up, down, resetGame;
	logic [3:0] level;
	logic [7:0][7:0] obsMove, frogMove;

	logic [31:0] clk;
	parameter whichClock = 10;
	clock_divider cdiv (CLOCK_50, clk);
	
	// Hook up FSM inputs and outputs.
	// logic reset, w, out;
	assign reset = SW[9];	// Reset when KEY[0] is pressed.
	
	logic hardReset; 

	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

   meta m1(.clk(clk[whichClock]), .reset(reset | hardReset), .in(~KEY[0]), .out(keyr));
	meta m2(.clk(clk[whichClock]), .reset(reset | hardReset), .in(~KEY[1]), .out(keyl));
	meta m3(.clk(clk[whichClock]), .reset(reset | hardReset), .in(~KEY[2]), .out(keyd));
	meta m4(.clk(clk[whichClock]), .reset(reset | hardReset), .in(~KEY[3]), .out(keyu));
	meta m5(.clk(clk[whichClock]), .reset(reset | hardReset), .in(SW[1]), .out(level[0]));
	meta m6(.clk(clk[whichClock]), .reset(reset | hardReset), .in(SW[2]), .out(level[1]));
	meta m7(.clk(clk[whichClock]), .reset(reset | hardReset), .in(SW[3]), .out(level[2]));
	meta m8(.clk(clk[whichClock]), .reset(reset | hardReset), .in(SW[4]), .out(level[3]));
	meta m9(.clk(clk[whichClock]), .reset(reset | hardReset), .in(SW[0]), .out(pause));

	
	
	userInput u (.clk(clk[whichClock]), .reset(reset | hardReset), .w(keyu), .out(up));
   userInput d(.clk(clk[whichClock]), .reset(reset | hardReset), .w(keyd), .out(down));
	userInput r (.clk(clk[whichClock]), .reset(reset | hardReset), .w(keyr), .out(R));
	userInput le (.clk(clk[whichClock]), .reset(reset | hardReset), .w(keyl), .out(L));

	frog f(.clk(clk[whichClock]), .reset(reset | hardReset), .resetGame, .pause, .left(L), .right(R), .up, .down, .frogPrev(frogMove), .frogNext(frogMove));
  
	obstacle o(.clk(clk[whichClock]), .reset(reset | hardReset), .resetGame, .pause, .obsPrev(obsMove), .obsNext(obsMove), .level);

   count c(.clk(clk[whichClock]), .reset(reset | hardReset), .up, .finalRow(frogMove[7]), .display(HEX0), .resetEverything(hardReset));

	lose l(.clk(clk[whichClock]), .obsMove, .frogMove, .resetGame);

	led_matrix_driver test (.clock(clk[whichClock]), .red_array(obsMove), .green_array(frogMove), .red_driver(orangeDriver), .green_driver(greenDriver), .row_sink(rowSink));

	//hazardlight h (.clk(clk[whichClock]), .reset, .w(SW), .out(LEDR));
	
endmodule
	
// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ...
// [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);    
	input logic clock;    
	output logic [31:0] divided_clocks;    
	
	initial begin        
		divided_clocks <= 0;   
	end   

	always_ff @(posedge clock) begin        
		divided_clocks <= divided_clocks + 1;
    end
endmodule
  