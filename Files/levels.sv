// Apurv Goel
// EE 271
// NetId:- ag2304
// 06/04/2019

// In all the modules in this file, we set the levels of the player in
// obstacles by speeding the obstacles through these.

module level_one (clk, enable);

	input logic clk;
	output logic enable;
	logic [16:0] num = 17'b00000000000000001;
	
	always @(posedge clk)
		if (num == 17'b00000000000000000) begin
			enable <= 1'b1;
			num <= 17'b00000000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 17'b00000000000000001;
		end
		
endmodule

module level_two (clk, enable);

	input logic clk;
	output logic enable;
	logic [15:0] num = 16'b0000000000000000;
	
	always @(posedge clk)
		if (num == 16'b0000000000000000) begin
			enable <= 1'b1;
			num <= 16'b0000000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 16'b0000000000000001;
		end
		
endmodule

module level_three (clk, enable);

	input logic clk;
	output logic enable;
	logic [14:0] num = 15'b000000000000000;
	
	always @(posedge clk)
		if (num == 15'b000000000000000) begin
			enable <= 1'b1;
			num <= 15'b00000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 15'b00000000000001;
		end
		
endmodule

module level_four (clk, enable);

	input logic clk;
	output logic enable;
	logic [11:0] num = 11'b000000000000;
	
	always @(posedge clk)
		if (num == 11'b000000000000) begin
			enable <= 1'b1;
			num <= 11'b000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 11'b000000000001;
		end
		
endmodule


