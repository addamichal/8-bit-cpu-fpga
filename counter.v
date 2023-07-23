module counter(
    input clk, 
    input rstn,
    output[3:0] out);

wire [3:0] q_out;
wire [3:0] sum_out;

adder4 adder4(
    .a(q_out),
    .b(1),
	.carry_in(0),
    .sum(sum_out)
);

register4 register4(
    .d(sum_out),
    .clk(clk),
    .rstn(rstn),
    .we(1),
    .q(q_out)
);

assign out = q_out;

endmodule
