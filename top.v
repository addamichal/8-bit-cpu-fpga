`include "clock_divider.v"
`include "uart_send.v"
`include "uart_receive.v"
`include "seven_seg_ctrl.v"
`include "seven_seg_hex.v"


`default_nettype none

module top(
	input CLK,
	input BTN_N, BTN1, BTN2, BTN3,
	input RX, output TX,
	output LED1, LED2, LED3, LED4, LED5,
	output P1A1, P1A2, P1A3, P1A4, P1A7, P1A8, P1A9, P1A10,
	input P1B1, P1B2, P1B3, P1B4, P1B7, P1B8, P1B9, P1B10
);

wire [7:0] seven_segment;
wire [7:0] dip;
assign { P1A10, P1A9, P1A8, P1A7, P1A4, P1A3, P1A2, P1A1 } = seven_segment;
assign { P1B10, P1B9, P1B8, P1B7, P1B4, P1B3, P1B2, P1B1 } = dip;

wire rst = ~BTN_N;

wire received;
wire [7:0] receive_payload;
reg [7:0] send_payload;

uart_receive uart_receive(
	.clk(CLK),
	.rst(rst),
	.rx(RX),
	.done(received),
	.payload(receive_payload)
);

uart_send uart_send(
	.clk(CLK),
	.rst(rst),
	.ready(received),
	.tx(TX),
	.payload(send_payload)
);

always @(posedge received) begin
	send_payload <= receive_payload;
end




seven_seg_ctrl seven_segment_ctrl (
	.CLK(CLK),
	.din(send_payload),
	.dout(seven_segment)
);

assign LED1 = RX;

endmodule