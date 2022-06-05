`timescale 1ns/1ps

module master#(parameter WIDTH = 8)(
	input		 	clk,
	input			rst,
	input			valid_en,
	input 			ready,
	input	   [WIDTH-1:0]	mdata_in,
	output reg 		valid,
	output reg [WIDTH-1:0] 	mdata_out,
	output reg [7:0] 	addr
	);

  always @(posedge clk) begin
	if (rst)
		valid <= 1'b0;
	else
		valid <= valid_en;
  end

  always @(posedge clk) begin
	if (rst)
		mdata_out <= {WIDTH{1'b0}};
	else if (valid && ready)
		mdata_out <= mdata_in;
	else 
		mdata_out <= mdata_out;
  end

  always @(posedge clk) begin
       	if (rst)
            	addr <= 8'b0;
        else begin
		if (addr == 8'hff)
            		addr <= 8'b0;
		else if (valid && ready)
			addr <= addr + 8'b1;
		else addr <= addr; 
	end	
  end
//通过addr访问memory取数据；

endmodule
