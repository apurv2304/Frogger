module count (clk, reset, up, finalRow, display, resetEverything);
    input logic clk, reset, up;
    input logic [7:0] finalRow;
    output logic [6:0] display;
	 output logic resetEverything;
    logic won;

    enum logic [2:0] {zero = 3'b000, one = 3'b001, two = 3'b010,
                      three = 3'b011, four = 3'b100, five = 3'b101} ps, ns;
    
    assign won = up & (finalRow != 8'b00000000);

    always_comb begin
        case(ps)
            zero: if (won) begin
                    ns = one;
                    display = 7'b1111001;
						  resetEverything = 1'b0;
                  end
                  else begin
                    ns = ps;
                    display = 7'b1000000;
						  resetEverything = 1'b0;
                  end
            one: if (won) begin
                    ns = two;
                    display = 7'b0100100;
						  resetEverything = 1'b0;
                  end
                  else begin
                    ns = ps;
                    display = 7'b1111001;
						  resetEverything = 1'b0;
                  end
            two: if (won) begin
                    ns = three;
                    display = 7'b0110000;
						  resetEverything = 1'b0;
                  end
                  else begin
                    ns = ps;
                    display = 7'b0100100;
						  resetEverything = 1'b0;
                  end
            three: if (won) begin
                    ns = four;
                    display = 7'b0011001;
						  resetEverything = 1'b0;
                  end
                  else begin
                    ns = ps;
                    display = 7'b0110000;
						  resetEverything = 1'b0;
                  end
            four: if (won) begin
                    ns = five;
                    display = 7'b0010010;
						  resetEverything = 1'b0;
                  end
                  else begin
                    ns = ps;
                    display = 7'b0011001;
						  resetEverything = 1'b0;
                  end
				five: if (won) begin
                    ns = ps;
						  display = 7'b1111111;
						  resetEverything = 1'b1;
                  end
                  else begin
                    ns = ps;
                    display = 7'b0010010;
						  resetEverything = 1'b0;
                  end
				
        endcase
    end
    always_ff @(posedge clk) begin
        if (reset) begin
            ps <= zero;
        end
        else begin
            ps <= ns;
        end
    end

endmodule

module count_testbench ();
	logic clk, reset, up, resetEverything;
	logic [7:0] finalRow;
	logic [6:0] display;
	
	count dut (.clk, .reset, .up, .finalRow, .display, .resetEverything);
	
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		reset <= 1;	up <= 0; finalRow <= 8'b00000000;         @(posedge clk);
		reset <= 0;;											         @(posedge clk);
																		   	@(posedge clk);
		up <= 1; finalRow <= 8'b10000000;							@(posedge clk);
		up <= 0; finalRow <= 8'b01000000;							@(posedge clk);
		up <= 1; finalRow <= 8'b00100000;							@(posedge clk);
		up <= 1; finalRow <= 8'b00010000;							@(posedge clk);
		up <= 1; finalRow <= 8'b00001000;							@(posedge clk);
		up <= 0; finalRow <= 8'b00000100;							@(posedge clk);
		up <= 1; finalRow <= 8'b00000010;							@(posedge clk);
		up <= 1; finalRow <= 8'b00000010;							@(posedge clk);
		up <= 1; finalRow <= 8'b00000010;							@(posedge clk);
		reset <= 1;														   @(posedge clk);
	$stop;
	end
endmodule

