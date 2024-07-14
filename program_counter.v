module program_counter(
		input [3:0] bus,
		input clk,
		input clr,
		input ce,
		input j,		
		output [3:0] out
	);

	wire [3:0] adder_out;
	wire [3:0] dmux_out;
	wire [3:0] result;

	dmux4 dmux4(
		.in1(adder_out),
		.in2(bus),
		.sel(j),
		.out(dmux_out)
	);

	register4 register4(
		.d(dmux_out),
		.clr(clr),
		.clk(clk),
		.we(1'd1),
		.q(result)
	);

	adder4 adder4(
		.a(result),
		.b(4'd0),
		.carry_in(ce),
		.sum(adder_out)
	);

	assign out = result;

endmodule