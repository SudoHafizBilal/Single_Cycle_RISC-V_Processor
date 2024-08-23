module Mux(
	input logic [31:0] reg_a,
	input logic [31:0] reg_b,
	input logic sel,
	output logic [31:0] muxout);

always_comb begin
	case(sel) 
		  1'b0:	muxout = reg_a;
		  1'b1:	muxout = reg_b;
	endcase
end	
endmodule