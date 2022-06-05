`timescale 1ns/1ps

module valid_register#(parameter WIDTH = 8)(
	input 			clk,
	input 			rst,
	input 			m_valid,
	output 			m_ready,
	input 	   [WIDTH-1:0]	m_data,
	output reg 		s_valid,
	input 			s_ready,
	output reg [WIDTH-1:0] 	s_data
	);

  always @(posedge clk)begin
   	if (rst)
		s_valid <= 1'd0;
   	else if (m_ready)
		s_valid <= m_valid;
   	else
		s_valid <=s_valid;
  end
 
  always @(posedge clk)begin
   	if (rst)
       		s_data <= 'd0;
   	else if (m_valid && m_ready)
       		s_data <=  m_data;
	else 
		s_data<=s_data;
  end
 
  assign m_ready = s_ready || ~s_valid;

endmodule
