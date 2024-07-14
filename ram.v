module ram(
	input clk,
	input clr,
	input [7:0] bus,
	input ri,
	input [3:0] ram_address,
	output [7:0] ram_value
);

reg [7:0] ram [0:15];

initial begin
	$readmemb("bootloader.txt", ram);
end

always @(posedge clk) begin
	if(ri) begin
		if(ri) begin
			ram[ram_address] <= bus;
		end
	end
end

assign ram_value = ram[ram_address];

endmodule
