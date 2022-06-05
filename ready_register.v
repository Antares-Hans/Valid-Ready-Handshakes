`timescale 1ns / 1ps

module ready_register#(parameter WIDTH = 8) (
	input			clk,
	input			rst,
	input			m_valid,
        output	reg		m_ready,
        input	[WIDTH-1:0]  	m_data,
        output             	s_valid,
        input              	s_ready,
        output	[WIDTH-1:0] 	s_data
        );

  wire			reg_signal;
  reg	[WIDTH-1:0]	reg_data;
  reg			reg_valid;


  always @(posedge clk) begin
	if (rst)  
		reg_data <= {WIDTH{1'b0}};
	else if (reg_signal) 
		reg_data <= m_data;
 	else 
		reg_data <= reg_data;
  end

  always @(posedge clk) begin
	if (rst)  
		reg_valid <= 1'b0;
	else if (reg_valid)
		reg_valid <= ~s_ready;
	else
		reg_valid <= reg_signal;
  end
//Note: If now buffer has data, then next valid would be ~READY_DOWN:   
//If downstream is ready, next cycle will be un-valid.    
//If downstream is not ready, keeping high. 
// If now buffer has no data, then next valid would be store_data, 1 for store;
 
  always @(posedge clk) begin
	if (rst) 
		m_ready <= 1'b0; //Reset can be 1.
	else m_ready <= s_ready || (~reg_valid && ~reg_signal); //Bubule clampping
  end
//Downstream valid and data.
//Bypass

  assign reg_signal = m_ready && m_valid && ~s_ready;
  assign s_valid = m_ready ? m_valid : reg_valid;
  assign s_data  = m_ready ? m_data  : reg_data;

endmodule
