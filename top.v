`include "clock_divider.v"
`include "uart_send.v"
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

reg stopped = 0;
reg done;
reg busy;

reg [4:0] counter = 0;
reg [1000: 0] start = "Hello World!";
reg [7:0] payload;

always @(posedge done or posedge rst) begin
	if(rst) begin
		counter = 0;
		stopped <= 0;
	end else if(counter == 4'd12) begin
		stopped <= 1;
	end else begin
		counter <= counter + 1;
		payload <= start[((11 - counter) + 1) * 8 : (11 - counter) * 8];
	end
end

uart_send uart_send(
	.clk(CLK),
	.rst(rst),
	.ready(~stopped),
	.tx(TX),
	.payload(payload),
	.busy(busy),
	.done(done)
);

seven_seg_ctrl seven_segment_ctrl (
	.CLK(CLK),
	.din(counter),
	.dout(seven_segment)
);

assign LED1 = done;

endmodule