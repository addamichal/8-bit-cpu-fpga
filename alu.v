module alu(
	input [7:0] a,
	input [7:0] b,
	input clk,
	input clr,
	input su,
	input fi,
	output [7:0] out,
	output reg cf,
	output reg zf
);

	wire [7:0] b_in;

	assign b_in[0] = b[0] ^ su;
	assign b_in[1] = b[1] ^ su;
	assign b_in[2] = b[2] ^ su;
	assign b_in[3] = b[3] ^ su;
	assign b_in[4] = b[4] ^ su;
	assign b_in[5] = b[5] ^ su;
	assign b_in[6] = b[6] ^ su;
	assign b_in[7] = b[7] ^ su;

	wire is_zero;
	wire is_carry;

	adder8 adder8(
		.a(a),
		.b(b_in),
		.carry_in(su),
		.sum(out),
		.carry_out(is_carry)
	);

	wire nor1;
	wire nor2;
	wire nor3;
	wire nor4;

	assign nor1 = ~(out[0] | out[1]);
	assign nor2 = ~(out[2] | out[3]);
	assign nor3 = ~(out[4] | out[5]);
	assign nor4 = ~(out[6] | out[7]);

	assign is_zero = nor1 & nor2 & nor3 & nor4;

	always @(posedge clk or posedge clr) begin
		if(clr == 1'b1) begin
			cf <= 0;
			zf <= 0;
		end else if(fi == 1'b1) begin
			cf <= is_carry;
			zf <= is_zero;
		end
	end

endmodule