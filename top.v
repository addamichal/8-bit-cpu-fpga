`include "clock_divider.v"
`include "uart_send.v"
`include "uart_receive.v"
`include "seven_seg_ctrl.v"
`include "seven_seg_hex.v"
`include "program_counter.v"
`include "registers.v"
`include "adder.v"
`include "ram.v"
`include "alu.v"
`include "control_logic.v"
`include "instruction_counter.v"
`include "register.v"
`include "dmux.v"
`include "dff.v"

`default_nettype none

module top(
	input CLK,
	input BTN_N, BTN1, BTN2, BTN3,
	// input RX, output TX,
	output LEDR_N, LEDG_N,
	output LED1, LED2, LED3, LED4, LED5,
	output P1A1, P1A2, P1A3, P1A4, P1A7, P1A8, P1A9, P1A10,
	input P1B1, P1B2, P1B3, P1B4, P1B7, P1B8, P1B9, P1B10
);

wire clr = ~BTN_N;

wire [7:0] seven_segment;
wire [7:0] dip;
assign { P1A10, P1A9, P1A8, P1A7, P1A4, P1A3, P1A2, P1A1 } = seven_segment;
assign { P1B10, P1B9, P1B8, P1B7, P1B4, P1B3, P1B2, P1B1 } = dip;

wire clk;

clock_divider #(.MAX_COUNT(12000000/100)) clock_divider(
	.clk(CLK),
	.rst(hlt),
	.out(clk)
);

seven_seg_ctrl seven_segment_ctrl (
	.CLK(CLK),
	.din(out),
	.dout(seven_segment)
);

wire [7:0] bus;

// signals
wire hlt, mi, ri, ro, io, ii, ai, ao, eo, su, bi, oi, ce, co, j, fi;

wire [7:0] out;
wire [2:0] step;
wire [3:0] instruction;
wire [3:0] address;

wire [3:0] pc;
wire [7:0] a_reg;
wire [7:0] b_reg;
wire [7:0] instr_reg;
wire [3:0] mar;
wire [7:0] alu_out;
wire [7:0] out_reg;
wire [7:0] out_ram;
wire cf;
wire zf;


assign bus = 
	co ? pc : 
	ao ? a_reg : 
	eo ? alu_out :
	ro ? out_ram :
	io ? instr_reg[3:0] : 0;

assign instruction = instr_reg[7:4];
assign address = bus[3:0];
assign out = out_reg;


program_counter program_counter(
	.bus(address),
	.clk(clk),
	.clr(clr),
	.ce(ce),
	.j(j),
	.out(pc)
);

a_register a_register(
	.bus(bus),
	.clk(clk),
	.clr(clr),
	.ai(ai),
	.out(a_reg)
);

b_register b_register(
	.bus(bus),
	.clk(clk),
	.clr(clr),
	.bi(bi),
	.out(b_reg)
);

alu alu(
	.a(a_reg),
	.b(b_reg),
	.clk(clk),
	.clr(clr),
	.su(su),
	.fi(fi),
	.out(alu_out),
	.cf(cf),
	.zf(zf)
);

out_register out_register(
	.bus(bus),
	.clk(clk),
	.clr(clr),
	.oi(oi),
	.out(out_reg)
);

ram ram(
	.mar_bus(address),
	.mi(mi),
	.clk(clk),
	.clr(clr),
	.ram_bus(bus),
	.ri(ri),
	.mar(mar),
	.ram_value(out_ram)
);

instruction_register instruction_register(
	.bus(bus),
	.clk(clk),
	.clr(clr),
	.ii(ii),
	.out(instr_reg)
);

instruction_counter instruction_counter(
	.clk(clk),
	.clr(clr),
	.out(step)
);

control_logic control_logic(
	.instruction(instruction),
	.step(step),
	.zf(zf),
	.cf(cf),
	.hlt(hlt),
	.mi(mi),
	.ri(ri),
	.ro(ro),
	.io(io),
	.ii(ii),
	.ai(ai),
	.ao(ao),
	.eo(eo),
	.su(su),
	.bi(bi),
	.oi(oi),
	.ce(ce),
	.co(co),
	.j(j),
	.fi(fi)
);

assign LED1 = clk;
assign LED2 = pc[0];
assign LED3 = pc[1];
assign LED4 = pc[2];
assign LED5 = pc[3];

assign LEDG_N = ~zf;
assign LEDR_N = ~cf;

endmodule