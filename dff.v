module dff(
	input d,
	input clr,
	input clk,
	output reg q,
	output qn);

	always @(posedge clk or posedge clr)
		if(clr)
			q <= 0;
		else
			q <= d;
	
	assign qn = ~q;
endmodule