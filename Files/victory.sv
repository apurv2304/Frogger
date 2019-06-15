// Apurv Goel
// EE 271
// NetId:- ag2304
// 05/10/2019

// Defines the working of declaring winner in tug of war game
module victory (clk, reset, L, R, LL, RL, LS, RS, resetLight);
	input logic clk, reset;
	
	output logic resetLight;
	
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	
	input logic L, R, LL, RL;
	
	
	// when lightOn is true, the center light should be on.
	output logic[2:0] LS, RS;
		
	// Next State logic
	
	
	// Output logic - could also be another always, or part of above blo
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset) begin					
												LS <= 0; RS <= 0;
												resetLight <= 1'b1;
	   end
		else if ((LS == 3'b111) || (RS == 3'b111)) begin 
		                              LS <= LS; RS <= RS;
											   resetLight <= 1'b0;
		end	
		else if (LL & ~R & L) begin   
												LS <= LS + 1;
		                              RS <= RS;
		                              resetLight <= 1'b1;
		end 	
		else if (RL & R & ~L) begin 	
												RS <= RS + 1;
												LS <= LS;
												resetLight <= 1'b1;
		end
		else begin                  	
												LS <= LS; RS <= RS;
												resetLight <= 1'b0;
	   end
			
	end
endmodule

// Test the functionality of victory module
module victory_testbench();

	logic clk, reset, L, R, LL, RL,  resetLight;
	logic[2:0] LS, RS;
	
	
	victory dut (.clk, .reset, .L, .R, .LL, .RL, .LS, .RS, .resetLight);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;

	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

   
	initial begin
	   reset <= 1; 		             								  @(posedge clk);
		L <= 0; R <= 0; LL <= 0; RL <= 0;                       @(posedge clk);
		reset <= 0;                  									  @(posedge clk);
																				  @(posedge clk);
		          															  @(posedge clk);
																				  @(posedge clk);
																				  @(posedge clk);
		L <= 0; R <= 1; LL <= 0;  RL<= 0;						  	  @(posedge clk);
																				  @(posedge clk);
																				  @(posedge clk);
		      								 								  @(posedge clk);
																				  @(posedge clk);			 
		L <= 1; R <= 1; LL <= 0; RL <= 0;						  	  @(posedge clk);
																				  @(posedge clk);			 
																				  @(posedge clk);			 
																				  @(posedge clk);			 
																				  @(posedge clk);
		L <= 1; R <= 1; LL <= 1; RL <= 0;						  	  @(posedge clk);
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);
		L <= 0; R <= 1; LL <= 1; RL <= 0;   					  	  @(posedge clk);
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);
		L <= 0; R <= 1; LL <= 0; RL <= 1;						  	  @(posedge clk);
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);
		L <= 1; R <= 0; LL <= 0; RL <= 0;						  	  @(posedge clk);
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);
		L <= 1; R <= 0; LL <= 1; RL <= 0;						  	  @(posedge clk);
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);	
																				  @(posedge clk);
   end 
endmodule

	