`timescale 1ns/1ps

module slave#(parameter WIDTH = 8)(
	input 			clk,
	input 			rst,
	input 			ready_en,
	input 			valid,
	input 	   [WIDTH-1:0] 	sdata_in,
	output reg 		ready,
	output reg [WIDTH-1:0] 	sdata_out
	);

  always @(posedge clk) begin
	if (rst)
		ready <= 1'b0;
	else  	ready <= ready_en;
	end

  always @ (posedge clk) begin
        if (rst)
            	sdata_out <= {WIDTH{1'b0}};                 
        else if (valid && ready)
            	sdata_out <= sdata_in;              
        else 
            	sdata_out <= {WIDTH{1'b0}};
  end      

endmodule
