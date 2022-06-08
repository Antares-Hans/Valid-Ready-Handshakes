`timescale 1ns / 1ps

module handshakes_tb ();

	parameter		WIDTH = 8;
	reg 			clk,rst;
	reg 			valid_en;
	reg 			ready_en;
	wire  			m_valid;
	wire  			m_ready;
	wire  			s_valid;
	wire  			s_ready;
	wire 	[WIDTH-1:0] 	m_data_out;
	wire 	[WIDTH-1:0] 	s_data_in;
	wire 	[WIDTH-1:0] 	s_data_out;
	wire 	[7:0] 		addr;
	wire 	[7:0] 		data_mem;

  initial begin
	clk = 1'b1;
	rst = 1'b1;
	#20 rst = 1'b0;
 	foreach (mem_test.memory[i]) begin
		mem_test.memory[i]=i+1;
	end
  end

  always #10 clk = ~clk;	

  initial begin
		valid_en = 1'b0;
//start
	#20 	valid_en = 1'b0;
	#20 	valid_en = 1'b0;
//normal
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
//slave_busy, reg_data
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20 	valid_en = 1'b1;
	#20	valid_en = 1'b1;
//read_reg, master_idle
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b0;
	#20 	valid_en = 1'b0;
//slave_busy, normal
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
//master_idle, passthrough
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
//random
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b0;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b1;
	#20	valid_en = 1'b0;
  end

  initial begin
		ready_en = 1'b0;
//start
	#20 	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
//normal
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b1;
	#20	ready_en = 1'b1;
//slave_busy, reg_data
	#20 	ready_en = 1'b0;
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b0;
//read_reg, master_idle
	#20 	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
//slave_busy, normal
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
//master_idle, passthrough
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
//random
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b0;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b0;
	#20 	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b0;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b0;
	#20  	ready_en = 1'b1;
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b1;
	#20 	ready_en = 1'b1;
	#20  	ready_en = 1'b0;
	#20  	ready_en = 1'b0;
  end

  top_handshakes top_handshakes_dut(
	.clk(clk), 
	.rst(rst), 
	.valid_en(valid_en), 
	.ready_en(ready_en), 
	.m_valid(m_valid), 
	.m_ready(m_ready), 
	.s_valid(s_valid), 
	.s_ready(s_ready), 
	.m_data_in(data_mem),
	.m_data_out(m_data_out),
	.s_data_in(s_data_in),
	.s_data_out(s_data_out),
	.addr(addr)
	);

  mem mem_test(
        .addr(addr),
        .data_out(data_mem)
    	);

endmodule


module mem(
	input	[7:0]	addr,
    	output 	[7:0] 	data_out
	);

  reg [7:0] memory [255:0];

  assign data_out = memory[addr];

endmodule
