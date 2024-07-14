module instruction_counter(
	input clk,
	input clr,
	output [2:0] out
);

	wire reset;
	wire [3:0] counter_out;

	counter4 counter4(
		.clk(~clk),
		.clr(clr | reset),
		.out(counter_out)
	);

	assign reset = counter_out[0] && counter_out[2];
	assign out = counter_out[2:0];

endmodule