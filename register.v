module register4(
    input [3:0] d,
    input clk,
    input rstn,
    input we,
    output [3:0] q);

    wire and1;

    wire q0;
    wire q1;
    wire q2;
    wire q3;

    dff dff0(
        .d(d[0]),
        .rstn(rstn),
        .clk(and1),
        .q(q0)
    );

    dff dff1(
        .d(d[1]),
        .rstn(rstn),
        .clk(and1),
        .q(q1)
    );

    dff dff2(
        .d(d[2]),
        .rstn(rstn),
        .clk(and1),
        .q(q2)
    );

    dff dff3(
        .d(d[3]),
        .rstn(rstn),
        .clk(and1),
        .q(q3)
    );

    assign and1 = clk & we;
    assign { q3, q2, q1, q0 } = q;

endmodule