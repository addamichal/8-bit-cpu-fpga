`include "clock_divider.v"
`include "uart_send.v"

`default_nettype none

module top(
	input CLK,
	input BTN_N, input BTN1, input BTN2, input BTN3,
	input RX, output TX,
	output LED1, output LED2, output LED3, output LED4, output LED5
);

wire rst = ~BTN_N;

reg stopped = 0;
reg done;
reg busy;

reg [4:0] counter = 0;
reg [1000: 0] start = "Hello Monika!";
reg [7:0] payload;

always @(posedge done or posedge rst) begin
	if(rst) begin
		counter = 0;
		stopped <= 0;
	end else if(counter == 4'd13) begin
		stopped <= 1;
	end else begin
		counter <= counter + 1;
		payload <= start[((12 - counter) + 1) * 8 : (12 - counter) * 8];
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

assign LED1 = done;

endmodule