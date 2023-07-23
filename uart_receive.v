module uart_receive(
    input clk,
    input rst,
    input rx,
    output reg [7:0] payload,
    output reg done
);

wire clk_div;

clock_divider #(.MAX_COUNT(625)) clock_divider(
	.clk(clk),
	.rst(rst),
	.out(clk_div)
);

localparam STATE_IDLE = 2'b00;
localparam STATE_RECEIVING = 2'b01;
localparam STATE_END = 2'b10;

reg [2:0] receive_index = 3'd0;
reg [2:0] ending_bit_index = 3'd0;
reg [1:0] state = STATE_IDLE;

always @ (posedge clk_div or posedge rst) begin
    if(rst == 1'b1) begin
        state <= STATE_IDLE;
        receive_index <= 3'd0;
        done <= 0;
    end else begin
		case(state)
			STATE_IDLE: begin
                done <= 0;
				if(rx == 0) begin
					state <= STATE_RECEIVING;
					receive_index <= 3'd0;
				end
			end

			STATE_RECEIVING: begin
				if(receive_index == 3'd7) begin
					state <= STATE_IDLE;
                    done <= 1;
					receive_index <= 0;
				end else begin
					payload[receive_index] = rx;
					receive_index <= receive_index + 1;
				end
			end
		endcase
    end
end


endmodule