// Apurv Goel
// EE 271
// NetId :- ag2304
// Date:- 05/10/2019

// Manages the user input 
module userInput(clk, w, out, reset);

	input logic clk, w, reset;
	output logic out;
	
	// State variables
	enum logic {A = 1'b0, B = 1'b1} ps, ns;
	
	// Next state logic and output logic
	always_comb begin
		case(ps)
			A: if (w) begin 
								  ns = B;
			                out = 1;
			   end
				else begin    ns = A;
				             out = 0;
				end
			B: if (w) begin 
								  ns = B;
			                out = 0;
			   end
				else begin    ns = A;
				             out = 0;
			   end       	
		endcase
	end
	
   // DFF's
	always_ff @(posedge clk) begin
		if(reset) begin
			ps <= A;
		end
		else begin
	      ps <= ns;
		end
	end
endmodule

// Tests the functionality of userInput
module userInput_testbench();
   logic  clk, reset, w;
   logic  out;

	userInput dut (.clk, .w, .out, .reset);

	// Set up the clock.
   parameter CLOCK_PERIOD=100;
   initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design.  Each line is a clock cycle.
   initial begin
											            @(posedge clk);
			   	reset <= 1;        			   @(posedge clk);
					reset <= 0; w <= 0;     	   @(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
									w <= 1;		 		@(posedge clk);
															@(posedge clk);
									         			@(posedge clk);
									w <= 0;     		@(posedge clk);
															@(posedge clk);
															@(posedge clk);
									w <= 1;     		@(posedge clk);
															@(posedge clk);
															@(posedge clk);
				$stop; // End the simulation.
		end
endmodule 