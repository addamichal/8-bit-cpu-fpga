module register(
    input d,
    input clk,
    input clr,
    input we,
    output q
);

    wire and1;
    assign and1 = clk & we;

    dff dff(
        .d(d),
        .clr(clr),
        .clk(and1),
        .q(q)
    );

endmodule

module register4(
    input [3:0] d,
    input clk,
    input clr,
    input we,
    output [3:0] q);

    wire q0;
    wire q1;
    wire q2;
    wire q3;

    register register0(
        .d(d[0]),
        .clr(clr),
        .clk(clk),
        .we(we),
        .q(q0)
    );

    register register1(
        .d(d[1]),
        .clr(clr),
        .clk(clk),
        .we(we),
        .q(q1)
    );

    register register2(
        .d(d[2]),
        .clr(clr),
        .clk(clk),
        .we(we),
        .q(q2)
    );

    register register3(
        .d(d[3]),
        .clr(clr),
        .clk(clk),
        .we(we),
        .q(q3)
    );

    assign { q3, q2, q1, q0 } = q;

endmodule

module register8(
    input [7:0] d,
    input clk,
    input clr,
    input we,
    output [7:0] q);

    register4 register4_0(
        .d(d[3:0]),
        .clk(clk),
        .clr(clr),
        .we(we),
        .q(q[3:0])
    );

    register4 register4_1(
        .d(d[7:4]),
        .clk(clk),
        .clr(clr),
        .we(we),
        .q(q[7:4])
    );

endmodule
