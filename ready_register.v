`timescale 1ns / 1ps
//ready打拍；valid和data可为寄存器输出，也将打拍；
module ready_register#(parameter WIDTH = 8) (
	input			clk,
	input			rst,
	input			m_valid,
        output	reg		m_ready,
        input	   [WIDTH-1:0]  m_data,
        output  reg      	s_valid,
        input              	s_ready,
        output	reg[WIDTH-1:0] 	s_data
        );
  reg 			reg_full;         
  reg 			reg_valid;
  reg 	[WIDTH-1:0] 	reg_data;   
  wire 			reg_ready;    
      
  always @(posedge clk) begin 
   	if (rst) begin
		reg_full <= 0 ;
		s_valid <= 0;
		s_data <= {WIDTH{1'b0}};
	end

   	else if(!reg_full) begin          
            	if (reg_ready) begin
             		s_valid <= m_valid;
			s_data <= m_data;               
            	end
            	else begin
              		reg_valid <= m_valid;
			reg_data <= m_data;
               		reg_full <= !reg_full;
            	end
           end
	   else begin 
		if(reg_ready) begin
            		s_valid <= reg_valid;
			s_data <= reg_data;              
               		reg_full <= !reg_full;
		end
		else begin
			s_valid <= s_valid;
			s_data <= s_data;              
               		reg_full <= reg_full;
		end             
           end
  end

  always @(posedge clk) begin
	if (rst) 
		m_ready <= 1'b1; 
	else 	
		m_ready <= reg_ready;
  end

  assign reg_ready = s_ready || ~s_valid; 
	
endmodule
	
/* valid和data可为组合逻辑不打拍输出；
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
//缓存信号拉高，reg_data将存入m_data，否则保持；
	
  always @(posedge clk) begin
	if (rst)  
		reg_valid <= 1'b0;
	else if (reg_valid)
		reg_valid <= ~s_ready;
	else
		reg_valid <= reg_signal;
  end
//如果寄存器已存入缓存数据，那么reg_valid取决于~s_ready；
//若s_ready拉高, 那么数据将被下行接收，reg_valid将拉低；  
//若s_ready拉低, 那么数据将留在reg，reg_valid将拉高；
//如果寄存器已没有缓存数据，那么reg_valid取决于reg_signal，有缓存信号就拉高；
 
  always @(posedge clk) begin
	if (rst) 
		m_ready <= 1'b0; //Reset can be 1.
	  else m_ready <= s_ready || (~reg_valid && ~reg_signal);
  end
//m_ready由下行s_ready和reg的缓存状态决定；
//也可以在reg中没有缓存数据也没有将缓存数据的信号时，直接拉高，先缓存一级数据。可以消除burst气泡；
//因为即使slave没有ready，reg也可以拉高m_ready，先缓存一级数据。可以消除burst气泡；

  assign reg_signal = m_ready && m_valid && ~s_ready;//能够缓存一级数据的信号；
  assign s_valid = m_ready ? m_valid : reg_valid;
  assign s_data  = m_ready ? m_data  : reg_data;
 
 endmodule
*/	
