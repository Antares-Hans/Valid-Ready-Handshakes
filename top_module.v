`timescale 1ns/1ps

module top_handshakes#( parameter WIDTH = 8)(
	input 			clk,
	input 			rst,
	input 			valid_en,
	input 			ready_en,
	output 			m_valid,
	output 			m_ready,
	output 			s_valid,
	output 			s_ready,
	input  	[WIDTH-1:0] 	m_data_in,
	output 	[WIDTH-1:0] 	m_data_out,
	output 	[WIDTH-1:0] 	s_data_in,
	output 	[WIDTH-1:0] 	s_data_out,
	output 	[7:0]		addr
	);

/*不打拍;
  master master_test(
	.clk(clk), 
	.rst(rst), 
	.valid_en(valid_en), 
	.ready(m_ready), 
	.mdata_in(m_data_in),
	.valid(m_valid),
	.mdata_out(m_data_out), 
	.addr(addr)
	);

  slave slave_test(
	.clk(clk), 
	.rst(rst), 
	.ready_en(ready_en), 
	.valid(s_valid), 
	.sdata_in(s_data_in), 
	.ready(s_ready), 
	.sdata_out(s_data_out)
	);

  assign m_ready=s_ready;
  assign s_valid=m_valid;
  assign s_data_in=m_data_out;
*/

/*valid打拍;
  master master_test(
	.clk(clk), 
	.rst(rst), 
	.valid_en(valid_en), 
	.ready(m_ready), 
	.mdata_in(m_data_in),
	.valid(m_valid),
	.mdata_out(m_data_out), 
	.addr(addr)
	);

  valid_register valid_register_test(
	.clk(clk), 
	.rst(rst), 
	.m_valid(m_valid), 
	.m_ready(m_ready), 
	.m_data (m_data_out), 
	.s_valid(s_valid), 
	.s_ready(s_ready),
	.s_data(s_data_in)
	);

  slave slave_test(
	.clk(clk), 
	.rst(rst), 
	.ready_en(ready_en), 
	.valid(s_valid), 
	.sdata_in(s_data_in), 
	.ready(s_ready), 
	.sdata_out(s_data_out)
	);
*/

/*ready打拍；valid如不打拍，要用组合逻辑输出valid和data;
  master master_test(
	.clk(clk), 
	.rst(rst), 
	.valid_en(valid_en), 
	.ready(m_ready), 
	.mdata_in(m_data_in),
	.valid(m_valid),
	.mdata_out(m_data_out), 
	.addr(addr)
	);

  ready_register ready_register_test(
	.clk(clk), 
	.rst(rst), 
	.m_valid(m_valid), 
	.m_ready(m_ready), 
	.m_data(m_data_out), 
	.s_valid(s_valid), 
	.s_ready(s_ready),
	.s_data (s_data_in)
	);

  slave slave_test(
	.clk(clk), 
	.rst(rst), 
	.ready_en(ready_en), 
	.valid(s_valid), 
	.sdata_in(s_data_in), 
	.ready(s_ready), 
	.sdata_out(s_data_out)
	);
*/

//valid和ready都打拍，寄存器输出valid和data;
  wire 			valid_connect;
  wire 			ready_connect;
  wire  [WIDTH-1:0] 	data_connect;

  master master_test(
	.clk(clk), 
	.rst(rst), 
	.valid_en(valid_en), 
	.ready(m_ready), 
	.mdata_in(m_data_in),
	.valid(m_valid),
	.mdata_out(m_data_out), 
	.addr(addr)
	);
/*
  valid_register valid_register_test(
	.clk(clk), 
	.rst(rst), 
	.m_valid(m_valid), 
	.m_ready(m_ready), 
	.m_data (m_data_out), 
	.s_valid(valid_connect), 
	.s_ready(ready_connect),
	.s_data(data_connect)
	);

  ready_register ready_register_test(
	.clk(clk), 
	.rst(rst), 
	.m_valid(valid_connect), 
	.m_ready(ready_connect), 
	.m_data(data_connect), 
	.s_valid(s_valid), 
	.s_ready(s_ready),
	.s_data (s_data_in)
	);
*/
  ready_register ready_register_test(
	.clk(clk), 
	.rst(rst), 
	.m_valid(m_valid), 
	.m_ready(m_ready), 
	.m_data(m_data_out), 
	.s_valid(s_valid), 
	.s_ready(s_ready),
	.s_data (s_data_in)
	);

  slave slave_test(
	.clk(clk), 
	.rst(rst), 
	.ready_en(ready_en), 
	.valid(s_valid), 
	.sdata_in(s_data_in), 
	.ready(s_ready), 
	.sdata_out(s_data_out)
	);

endmodule
