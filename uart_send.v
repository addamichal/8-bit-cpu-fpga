module uart_send(
	input clk,
    input rst,
	input ready,
	input [7:0] payload,
	output reg tx,
	output reg busy,
    output reg done
);

wire clk_div;

clock_divider #(.MAX_COUNT(625)) clock_divider(
	.clk(clk),
	.rst(rst),
	.out(clk_div)
);

localparam STATE_IDLE = 2'b00;
localparam STATE_START_BIT = 2'b01;
localparam STATE_SENDING = 2'b10;
localparam STATE_END = 2'b11;

reg [2:0] send_index = 3'd0;
reg [2:0] sent_ending_big_index = 3'd0;
reg [1:0] state = STATE_IDLE;

always @ (posedge clk_div or posedge rst) begin
	if(rst == 1'b1) begin
		state <= STATE_IDLE;
		send_index <= 3'd0;
		done <= 0;
	end else begin
		case (state)
			STATE_IDLE: begin
				if(ready == 1) begin
					done <= 0;
					state <= STATE_START_BIT;
					send_index <= 3'd0;
				end
			end

			STATE_START_BIT: begin
				busy <= 1;
				state <= STATE_SENDING;
				send_index <= 3'd0;
			end

			STATE_SENDING: begin
				if(send_index == 3'd7) begin
					state <= STATE_END;
					send_index <= 3'd0;
				end else begin
					send_index <= send_index + 1;
				end
			end

			STATE_END: begin
				if(sent_ending_big_index == 3'd0) begin
					state <= STATE_IDLE;
					done <= 1;
					busy <= 0;
					sent_ending_big_index <= 3'd0;
				end else begin
					sent_ending_big_index <= sent_ending_big_index + 1;
				end
			end

			default: state <= STATE_IDLE;
		endcase
	end
end

always @(posedge clk_div) begin
	case (state)
		STATE_IDLE: begin
			tx <= 1;
		end

		STATE_START_BIT: begin
			tx <= 0;
		end

		STATE_SENDING: begin
			tx <= payload[send_index];
		end

		STATE_END: begin
			tx <= 1;
		end
	endcase
end


endmodule
