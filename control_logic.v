module control_logic(
	input [3:0] instruction,
	input zf,
	input cf,
    input [2:0] step,
	output hlt, mi, ri, ro, io, ii, ai, ao, eo, su, bi, oi, ce, co, j, fi
);

parameter [3:0] NOP = 'b0000; 
parameter [3:0] LDA = 'b0001; 
parameter [3:0] ADD = 'b0010; 
parameter [3:0] SUB = 'b0011; 
parameter [3:0] STA = 'b0100;
parameter [3:0] LDI = 'b0101;
parameter [3:0] JMP = 'b0110;
parameter [3:0] JC = 'b0111;
parameter [3:0] JZ = 'b1000;

parameter [3:0] OUT = 'b1110;
parameter [3:0] HLT = 'b1111;


assign mi = (step == 0) || (step == 2 && (instruction == LDA || instruction == ADD || instruction == SUB || instruction == STA));
assign co = step == 0;
assign ro = (step == 1) || (step == 3 && (instruction == LDA || instruction == ADD || instruction == SUB));
assign ii = step == 1;
assign ce = step == 1;
assign io = (step == 2 && (instruction == LDA || instruction == ADD || instruction == SUB || instruction == STA || instruction == LDI || instruction == JMP || (instruction == JZ && zf) || (instruction == JC && cf)));
assign ai = (step == 3 && instruction == LDA) || (step == 4 && instruction == ADD) || (step == 4 && instruction == SUB) || (step == 2 && instruction == LDI);
assign bi = (step == 3 && instruction == ADD) || (step == 3 && instruction == SUB);
assign eo = (step == 4 && instruction == ADD) || (step == 4 && instruction == SUB);
assign su = (step == 4 && instruction == SUB);
assign j = (step == 2 && (instruction == JMP || (instruction == JZ && zf) || (instruction == JC && cf)));
assign ao = (step == 3 && instruction == STA) || (step == 2 && instruction == OUT);
assign ri = (step == 3 && instruction == STA);
assign oi = (step == 2 && instruction == OUT);
assign hlt = (step == 2 && instruction == HLT);
assign fi = (step == 4 && instruction == ADD) || (step == 4 && instruction == SUB);


endmodule