module ram(
	input [3:0] mar_bus,
	input mi,
	input clk,
	input clr,
	input [7:0] ram_bus,
	input ri,
	output reg [3:0] mar,
	output [7:0] ram_value
);

reg [7:0] ram [0:15];

initial begin
	ram[0] = 0;
	ram[1] = 0;
	ram[2] = 0;
	ram[3] = 0;
	ram[4] = 0;
	ram[5] = 0;
end

always @(posedge clk or posedge clr) begin
	if(clr) begin
		mar <= 0;
	end else if(mi) begin
		mar <= mar_bus;
	end
end

always @(posedge clk) begin
	if(ri) begin
		if(ri) begin
			ram[mar] <= ram_bus;
		end
	end
end

assign ram_value = ram[mar];

endmodule