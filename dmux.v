module dmux(
    input in1,
    input in2,
    input sel,
    output out
);

    assign out = (in1 & ~sel) | (in2 & sel);

endmodule

module dmux4(
    input[3:0] in1,
    input[3:0] in2,
    input sel,
    output [3:0] out
);

    wire out0;
    wire out1;
    wire out2;
    wire out3;

    dmux dmux_0(
        .in1(in1[0]),
        .in2(in2[0]),
        .sel(sel),
        .out(out0)
    );

    dmux dmux_1(
        .in1(in1[1]),
        .in2(in2[1]),
        .sel(sel),
        .out(out1)
    );

    dmux dmux_2(
        .in1(in1[2]),
        .in2(in2[2]),
        .sel(sel),
        .out(out2)
    );

    dmux dmux_3(
        .in1(in1[3]),
        .in2(in2[3]),
        .sel(sel),
        .out(out3)
    );

    assign { out3, out2, out1, out0 } = out;

endmodule