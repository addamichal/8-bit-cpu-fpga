module half_adder(
    input a,
    input b,
    output sum,
    output carry
);

assign sum = a ^ b; // bitwise xor
assign carry = a & b; // bitwise adn

endmodule

module full_adder(
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
);

wire s_1;
wire c_1;
wire c_2;

half_adder half_adder1(.a(a),
    .b(b),
    .sum(s_1),
    .carry(c_1)
);

half_adder half_adder2(.a(carry_in),
    .b(s_1),
    .sum(sum),
    .carry(c_2)
);

assign carry_out = c_1 | c_2;

endmodule

module adder4(
    input [3:0] a,
    input [3:0] b,
    input carry_in,
    output [3:0] sum,
    output carry_out
);
    wire sum_0;
    wire sum_1;
    wire sum_2;
    wire sum_3;

    wire carry_out_0;
    wire carry_out_1;
    wire carry_out_2;

    full_adder full_adder0(
        .a(a[0]),
        .b(b[0]),
        .carry_in(carry_in),
        .sum(sum_0),
        .carry_out(carry_out_0)
    );

    full_adder full_adder1(
        .a(a[1]),
        .b(b[1]),
        .carry_in(carry_out_0),
        .sum(sum_1),
        .carry_out(carry_out_1)
    );

    full_adder full_adder2(
        .a(a[2]),
        .b(b[2]),
        .carry_in(carry_out_1),
        .sum(sum_2),
        .carry_out(carry_out_2)
    );

    full_adder full_adder3(
        .a(a[3]),
        .b(b[3]),
        .carry_in(carry_out_2),
        .sum(sum_3),
        .carry_out(carry_out)
    );

    assign { sum_3, sum_2, sum_1, sum_0 } = sum;

endmodule