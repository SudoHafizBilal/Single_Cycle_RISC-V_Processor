module counter(
	input logic [31:0] pc_out,
	output logic [31:0] cont
	);
	
	always_comb begin
		cont = pc_out + 4;
	end
endmodule