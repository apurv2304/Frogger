// Apurv Goel
// EE 271
// NetId:- ag2304
// 06/04/2019

// Checks if the player lost or not and if he did then resets the playfield
module lose (clk, obsMove, frogMove, resetGame); 
    input logic clk;
    input logic [7:0][7:0] obsMove, frogMove;
    output logic resetGame;

    always_ff @(posedge clk) begin
        if (((obsMove[0] & frogMove[0]) != 8'b00000000) | ((obsMove[1] & frogMove[1]) != 8'b00000000) |
            ((obsMove[2] & frogMove[2]) != 8'b00000000) | ((obsMove[3] & frogMove[3]) != 8'b00000000) |
            ((obsMove[4] & frogMove[4]) != 8'b00000000) | ((obsMove[5] & frogMove[5]) != 8'b00000000) |
				((obsMove[6] & frogMove[6]) != 8'b00000000) | ((obsMove[7] & frogMove[7]) != 8'b00000000))
        begin
            resetGame <= 1'b1;
        end
        else begin
            resetGame <= 1'b0;
        end
    end
endmodule

// Tests the functionality of lose module
module lose_testbench ();
	logic clk;
	logic [7:0][7:0] obsMove, frogMove;
	logic resetGame;
	
	lose dut (.clk, .obsMove, .frogMove, .resetGame);
	
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		obsMove <= {      {8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000}
							  };
		frogMove <= {     {8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000},
								{8'b00000000}
							  };

		frogMove[0] <= 8'b01000000; obsMove[0] <= 8'b01000000;   @(posedge clk);  //collision
		frogMove[0] <= 8'b01000000; obsMove[0] <= 8'b00100000;   @(posedge clk);
		frogMove[1] <= 8'b00001000; obsMove[1] <= 8'b10001000;   @(posedge clk);  // collosion
		frogMove[1] <= 8'b01000000; obsMove[1] <= 8'b00000100;   @(posedge clk);
		frogMove[2] <= 8'b00100000; obsMove[2] <= 8'b00100000;   @(posedge clk);  //collision
		frogMove[2] <= 8'b01000000; obsMove[2] <= 8'b10000000;   @(posedge clk);
		frogMove[3] <= 8'b00010000; obsMove[3] <= 8'b00010000;   @(posedge clk);  // collision
		frogMove[3] <= 8'b01000000; obsMove[3] <= 8'b10000000;   @(posedge clk);
		frogMove[4] <= 8'b00010000; obsMove[4] <= 8'b00010000;   @(posedge clk);  //collision
		frogMove[4] <= 8'b01000000; obsMove[4] <= 8'b10000000;   @(posedge clk);
		frogMove[5] <= 8'b00000100; obsMove[5] <= 8'b00000100;   @(posedge clk);  // collision
		frogMove[5] <= 8'b01000000; obsMove[5] <= 8'b10000000;   @(posedge clk);
		frogMove[6] <= 8'b00000100; obsMove[6] <= 8'b00000100;   @(posedge clk);  // collision
		frogMove[6] <= 8'b01000000; obsMove[6] <= 8'b10000000;   @(posedge clk);
		frogMove[7] <= 8'b00000010; obsMove[7] <= 8'b00000010;   @(posedge clk);  // collision
		frogMove[7] <= 8'b01000000; obsMove[2] <= 8'b10000000;   @(posedge clk);
	$stop; // End the simulation
	end
	 
endmodule 