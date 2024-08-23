module memory(
	input logic [31:0] wr_add,
	input logic [31:0] wr_data,
	input logic rd_en,
	input logic wr_en,
	input logic clk,
	output logic [31:0] memout);
	
	reg [31:0] Memory [31:0] = '{default:32'b0};
	
	always_comb 
		begin
			if (rd_en) begin
				memout = Memory[wr_add];
			end else begin
				memout = 32'b0;
			end
		end

	always @(negedge clk )
		begin
			if (wr_en) begin
				Memory[wr_add] <= wr_data;
			end
		end

endmodule
