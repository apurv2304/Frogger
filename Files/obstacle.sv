// Apurv Goel
// EE 271
// NetId:- ag2304
// 06/04/2019

// Handles the movement of obstacles in the frogger game
module obstacle(clk, reset, resetGame, pause, obsPrev, obsNext, level);
    input logic clk, reset, resetGame, pause;
    input logic [7:0][7:0] obsPrev;
    output logic [7:0][7:0] obsNext; 
    input logic [3:0] level;
    logic enable, level1, level2, level3, level4;
	
  	 integer i;

    always_comb begin
		if (level == 4'b0010) begin
			enable = level2;
		end else if (level == 4'b0100) begin
			enable = level3;
		end else if (level == 4'b1000) begin
			enable = level4;
		end else begin
			enable = level1;
		end
    end
	
	level_one l1(.clk(clk), .enable(level1));
	level_two l2(.clk(clk), .enable(level2));
	level_three l3(.clk(clk), .enable(level3));
	level_four l4(.clk(clk), .enable(level4));
	
    always_ff @(posedge clk) begin
        if (reset | resetGame) begin
            obsNext <= {
                        {8'b00000000},
                        {8'b00110110},
                        {8'b01100110},
                        {8'b01100000},
                        {8'b11000011},
                        {8'b01100000},
                        {8'b01100011},
                        {8'b00000000}
                       };
        end
        else if (pause) begin
            obsNext <= obsPrev;
        end
        else if (enable) begin
            for (i = 2; i < 7; i=i+2) begin 
                obsNext[i] <= {obsPrev[i][0], obsPrev[i][7:1]};
            end
				for (i = 1; i < 7; i=i+2) begin
					 obsNext[i] <= {obsPrev[i][6:0], obsPrev[i][7]};
				end
		  end
        else begin
            obsNext <= obsPrev;
        end
    end
endmodule

// Tests the functionality of obstacle
module obstacle_testbench ();
	logic clk, reset, resetGame, pause; 
	logic [3:0] level; 
	logic [7:0][7:0] obsMove;
	obstacle dut (.clk, .reset, .resetGame, .pause, .obsPrev(obsMove), .obsNext(obsMove), .level );

	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	initial begin	
			obsMove <= { {8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11110111}
							  };
			reset <= 1;	resetGame <= 0; 	pause<=0;									@(posedge clk);
																									@(posedge clk);
			reset <= 0;										level = 4'b1000;				@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
													pause <=1;			   					@(posedge clk);
																									@(posedge clk); 
																									@(posedge clk);
																									@(posedge clk);
												pause <=0;			   						@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
																									@(posedge clk);
		

		$stop; // End the simulation
	 end
	 
endmodule 
