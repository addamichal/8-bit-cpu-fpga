module a_register(
	input [7:0] bus,
	input clk,
	input clr,
	input ai,
	output reg [7:0] out
);

always @(posedge clk or posedge clr) begin
	if(clr == 1'b1) begin
		out <= 0;
	end else if(ai == 1'b1) begin
		out <= bus;
	end
end

endmodule

module b_register(
	input [7:0] bus,
	input clk,
	input clr,
	input bi,
	output reg [7:0] out
);

always @(posedge clk or posedge clr) begin
	if(clr == 1'b1) begin
		out <= 0;
	end else if(bi == 1'b1) begin
		out <= bus;
	end
end

endmodule

module out_register(
	input [7:0] bus,
	input clk,
	input clr,
	input oi,
	output reg [7:0] out
);

always @(posedge clk or posedge clr) begin
	if(clr) begin
		out <= 0;
	end else if(oi) begin
		out <= bus;
	end
end

endmodule

module instruction_register(
	input [7:0] bus,
	input clk,
	input clr,
	input ii,
	output reg [7:0] out
);

always @(posedge clk or posedge clr) begin
	if(clr) begin
		out <= 0;
	end else if(ii) begin
		out <= bus;
	end
end

endmodule