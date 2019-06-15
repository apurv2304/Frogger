// Apurv Goel
// EE 271
// NetId:- ag2304
// 05/10/2019

// Handles metstability of input
module meta (clk, reset, in, out);

	input logic in, clk, reset;
	output logic out;
	
	logic temp;
	
	// DFF's
	always_ff @(posedge clk) begin
		if (reset) 
			out <= 0;
		else begin
			temp <= in;
			out <= temp;
	   end
	end	
endmodule
