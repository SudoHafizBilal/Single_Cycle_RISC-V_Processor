module Inst_mem(
	input logic [31:0] Addr,
	output logic [31:0] Inst
	);
	
	reg [31:0] inst_mem [31:0] = '{default:32'b0};
	
	initial begin
		$readmemh("/home/hafiz/Documents/riscv/arch/build/gcd.txt",inst_mem);
	end
	
	always_comb 
		begin
			Inst = inst_mem[Addr[31:2]];
		end

endmodule
			