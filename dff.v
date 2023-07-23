module dff(
	input d,
	input rstn,
	input clk,
	output reg q,
	output qn);

	always @(posedge clk or negedge rstn)
		if(!rstn)
			q <= 0;
		else
			q <= d;
	
	assign qn = ~q;
endmodule