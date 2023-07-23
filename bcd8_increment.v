// BCD (Binary Coded Decimal) counter
module bcd8_increment (
	input [7:0] din,
	output reg [7:0] dout
);
	always @* begin
		case (1'b1)
			din[7:0] == 8'h 99:
				dout = 0;
			din[3:0] == 4'h 9:
				dout = {din[7:4] + 4'd 1, 4'h 0};
			default:
				dout = {din[7:4], din[3:0] + 4'd 1};
		endcase
	end
endmodule