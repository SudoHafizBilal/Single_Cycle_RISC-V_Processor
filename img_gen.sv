module img_gen(
	input logic [31:0] inst,
	output logic [31:0] bit32
	);
	always_comb begin
		case (inst [6:0])
			7'b0000011 : bit32 = {{20{inst[31]}},inst [31:20]}; // I-L_type
			7'b0010011 : bit32 = {{20{inst[31]}},inst [31:20]}; // I_type
			7'b0100011 : bit32 = {{20{inst[31]}},inst [31:25] ,inst [11:7]}; // S_type
			7'b1100011 : bit32 = {{19{inst[31]}},inst[31],inst[7],inst [30:25],inst [11:8],1'b0}; // B_type
			7'b0110111 : bit32 = {inst[31:12],12'b0}; //U_type(lui)
			7'b0010111 : bit32 = {inst[31:12],12'b0}; // U_type(auipc)
			7'b1101111 : bit32 = {{11{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21],1'b0}; //J_type(lal)
			7'b1100111 : bit32 = {{20{inst[31]}}, inst[31:20]}; //J_type(lalr)
			default: bit32 = 32'b0;
		endcase
	end
		
endmodule
