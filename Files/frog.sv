// Apurv Goel
// EE 271
// NetId:- ag2304
// 06/04/2019

// Handles the movement of prog in frogger according to user input
module frog(clk, reset, resetGame, pause, left, right, up, down, frogPrev, frogNext);
    input logic clk, left, right, up, down, reset, resetGame, pause;
    input logic [7:0][7:0] frogPrev;
    output logic [7:0][7:0] frogNext;
	 logic frogger;
	 integer i;
	 
    always_ff @(posedge clk) begin
        if (reset | resetGame | (up & (frogPrev[7] != 8'b00000000))) begin
            frogNext <= {{8'b00000000},
                         {8'b00000000},
                         {8'b00000000},
                         {8'b00000000},
                         {8'b00000000},
                         {8'b00000000},
                         {8'b00000000},
                         {8'b00001000}
                         };
        end
        else if (pause | (down & (frogPrev[0] != 8'b00000000))) begin 
            frogNext <= frogPrev;
        end
        else if (down) begin
            frogNext[7] <= 8'b00000000;
            frogNext[6:0] <= frogPrev[7:1];
        end 
        else if (up) begin
            frogNext[0] <= 8'b00000000;
            frogNext[7:1] <= frogPrev[6:0];
        end
        else if (left & (frogPrev[0][7] | frogPrev[1][7] | frogPrev[2][7] | 
                         frogPrev[3][7] | frogPrev[4][7] | frogPrev[5][7] |
                         frogPrev[6][7] | frogPrev[7][7])) begin
            for (i = 0; i < 7; i++) begin
                frogNext[i] <= {frogPrev[i][6:0], frogPrev[i][7]};
            end
        end
        else if (left) begin
            for (i = 0; i < 7; i++) begin
                frogNext[i] <= {frogPrev[i][6:0], 1'b0};
            end
        end
        else if (right & (frogPrev[0][0] | frogPrev[1][0] | frogPrev[2][0] | 
                          frogPrev[3][0] | frogPrev[4][0] | frogPrev[5][0] |
                          frogPrev[6][0] | frogPrev[7][0])) begin
            for (i = 0; i < 7; i++) begin
                frogNext[i] <= {frogPrev[i][0], frogPrev[i][7:1]};
            end
        end
        else if (right) begin
            for (i = 0; i < 7; i++) begin
                frogNext[i] <= {1'b0, frogPrev[i][7:1]};
            end
		  end
        else begin
            frogNext <= frogPrev;
        end
    end
endmodule
    
// Tests the functionality of frogger
module frog_testbench ();
	logic clk, reset, resetGame, left, right, up, down, pause;
	logic [7:0][7:0] frogMove;
	
	frog dut (.clk, .reset, .resetGame, .pause, .left, .right, .up, .down , .frogPrev(frogMove), .frogNext(frogMove));

	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	initial begin	

			reset <= 1;	resetGame<= 0; left <= 0; right<=0; up <= 0; down <= 0;	pause<=0;	@(posedge clk);
																														@(posedge clk);
			reset <= 0; 																							@(posedge clk);
												left <= 1; 															@(posedge clk);
												left <= 1; 															@(posedge clk);
															  right <= 1;										   @(posedge clk);
															  right <= 1;										   @(posedge clk);
																						down <= 1; 					@(posedge clk); // Should remian same
																						down <= 0; 					@(posedge clk);
																			up <= 1; 								@(posedge clk);
																														@(posedge clk); // Should be two rows up at the mid position
																			up <= 0;								   @(posedge clk);
															  right <= 1;											@(posedge clk);
																														@(posedge clk);
																														@(posedge clk);
																														@(posedge clk);
																														@(posedge clk);
																														@(posedge clk); // Should reach right and stay the same
															  right <= 0; 											@(posedge clk);
		$stop; // End the simulation
	 end
	 
endmodule 


