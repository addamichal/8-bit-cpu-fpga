module counter4(
    input clk, 
    input clr,
    output[3:0] out);

wire [3:0] q_out;
wire [3:0] sum_out;

adder4 adder4(
    .a(q_out),
    .b(4'd0),
	.carry_in(1'd1),
    .sum(sum_out)
);

register4 register4(
    .d(sum_out),
    .clk(clk),
    .clr(clr),
    .we(1'd1),
    .q(q_out)
);

assign out = q_out;

endmodule
