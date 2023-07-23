module program_counter(
		input [3:0] bus,
		input clk,
		input clr,
		input ce,
		input j,		
		output reg [3:0] out
	);

	always @(posedge clk or posedge clr) begin
		if(clr == 1'b1) begin
			out <= 0;
		end else if(j == 1'b1) begin
			out <= bus;
		end else if (ce == 1'b1) begin
			out <= out + 1;
		end
	end

endmodule