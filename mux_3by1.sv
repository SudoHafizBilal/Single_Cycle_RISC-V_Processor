module mux_3by1(
	input logic [31:0] rega,
	input logic [31:0] regb,
	input logic [31:0] regc,
	input logic [1:0] sel,
	output logic [31:0] regd
	);
	
	always_comb begin
		case (sel)
			2'b00: regd = rega;
			2'b01: regd = regb;
			2'b10: regd = regc;
			default:regd = 32'b0;
		endcase
	end
endmodule		