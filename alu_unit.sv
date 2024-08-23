module ALU_unit(
	input logic [31:0] reg_a,
	input logic [31:0] reg_b,
	input logic [3:0] alu_op,
	output logic [31:0] aluout);

always_comb 
	begin
		case (alu_op)
			4'b0000:	aluout = reg_a + reg_b; //add
			4'b0001:	aluout = reg_a - reg_b; //sub
			4'b0010:	aluout = reg_a & reg_b; //and
			4'b0011:	aluout = reg_a | reg_b; //or
			4'b0100:	aluout = reg_a ^ reg_b; //xor 
			4'b0101:	aluout = reg_a << reg_b; //sll
			4'b0110:	aluout = reg_a >> reg_b; //srl
			4'b0111:	aluout = (reg_a < reg_b) ? 32'b1 : 32'b0; //slt
			4'b1000:	aluout = $signed(reg_a) >>> reg_b; //sra 
			4'b1001:	aluout = ($unsigned(reg_a) < $unsigned(reg_b)) ? 32'b1 : 32'b0; //sltu
			4'b1111:	aluout = reg_b; //lui
			default:	aluout = 32'b0;
		endcase
	end
endmodule