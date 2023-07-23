module instruction_counter(
	input clk,
	input clr,
	output reg [2:0] out
);

always @(negedge clk or posedge clr) begin
	if(clr) begin
		out <= 0;
	end else begin
		if(out == 3'd5) begin
			out <= 0;
		end else begin
			out <= out + 1;
		end
	end
end

endmodule