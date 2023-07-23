`include "clock_divider.v"
`include "uart_send.v"
`include "uart_receive.v"
`include "seven_seg_ctrl.v"
`include "seven_seg_hex.v"
`include "program_counter.v"
`include "registers.v"
`include "adder.v"
`include "ram.v"

`default_nettype none

module top(
	input CLK,
	input BTN_N, BTN1, BTN2, BTN3,
	// input RX, output TX,
	output LED1, LED2, LED3, LED4, LED5,
	output P1A1, P1A2, P1A3, P1A4, P1A7, P1A8, P1A9, P1A10,
	input P1B1, P1B2, P1B3, P1B4, P1B7, P1B8, P1B9, P1B10
);

wire rst = ~BTN_N;
wire [7:0] seven_segment;
wire [7:0] dip;
assign { P1A10, P1A9, P1A8, P1A7, P1A4, P1A3, P1A2, P1A1 } = seven_segment;
assign { P1B10, P1B9, P1B8, P1B7, P1B4, P1B3, P1B2, P1B1 } = dip;


wire clk_div;

clock_divider #(.MAX_COUNT(12000000/2)) clock_divider(
	.clk(CLK),
	.rst(rst),
	.out(clk_div)
);

seven_seg_ctrl seven_segment_ctrl (
	.CLK(CLK),
	.din(out),
	.dout(seven_segment)
);

wire [7:0] out;
wire [7:0] bus;
wire [3:0] instruction;

instruction_register instruction_register(
	.bus(dip),
	.clk(clk_div),
	.clr(rst),
	.ii(BTN1),
	.out(out)
);

assign bus = dip;
assign instruction = out[7:4];
assign LED1 = clk_div;

assign LED2 = instruction[0];
assign LED3 = instruction[1];
assign LED4 = instruction[2];
assign LED5 = instruction[3];

endmodule