module a_register(
	input [7:0] bus,
	input clk,
	input clr,
	input ai,
	output [7:0] out
);

	register8 register8(
		.d(bus),
		.clk(clk),
		.clr(clr),
		.we(ai),
		.q(out)
	);

endmodule

module b_register(
	input [7:0] bus,
	input clk,
	input clr,
	input bi,
	output [7:0] out
);

	register8 register8(
		.d(bus),
		.clk(clk),
		.clr(clr),
		.we(bi),
		.q(out)
	);

endmodule

module out_register(
	input [7:0] bus,
	input clk,
	input clr,
	input oi,
	output [7:0] out
);

	register8 register8(
		.d(bus),
		.clk(clk),
		.clr(clr),
		.we(oi),
		.q(out)
	);

endmodule

module instruction_register(
	input [7:0] bus,
	input clk,
	input clr,
	input ii,
	output [7:0] out
);

	register8 register8(
		.d(bus),
		.clk(clk),
		.clr(clr),
		.we(ii),
		.q(out)
	);

endmodule

module mar_register(
	input [3:0] bus,
	input clk,
	input clr,
	input mi,
	output [3:0] out
);

	register4 register4(
		.d(bus),
		.clk(clk),
		.clr(clr),
		.we(mi),
		.q(out)
	);

endmodule