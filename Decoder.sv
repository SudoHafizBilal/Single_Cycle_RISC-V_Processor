module Decoder(
	input logic [31:0] Inst,
	output logic [4:0] rd,
	output logic [4:0] rs1,
	output logic [4:0] rs2,
	output logic [2:0] fun3,
	output logic [6:0] fun7,
	output logic [6:0] opcode);
	
	always_comb 
		begin
			case(Inst[6:0]) 
				7'b0110011: begin                               //R_type
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = Inst [14:12];
										rs1 = Inst [19:15];
										rs2 = Inst [24:20];
										fun7 = Inst [31:25];
									end
				7'b0010011: begin                               //I_type
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = Inst [14:12];
										rs1 = Inst [19:15];
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
				7'b0000011: begin                               //L_type
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = Inst [14:12];
										rs1 = Inst [19:15];
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
			    7'b0100011: begin                               //S_type
										opcode = Inst [6:0];
										rd = 5'b0;
										fun3 = Inst [14:12];
										rs1 = Inst [19:15];
										rs2 = Inst [24:20];
										fun7 = 7'b0;
									end
				7'b1100011: begin                              //B_type
										opcode = Inst [6:0];
										rd = 5'b0;
										fun3 = Inst [14:12];
										rs1 = Inst [19:15];
										rs2 = Inst [24:20];
										fun7 = 7'b0;
									end
				7'b0110111: begin                              //U_type(LUI)
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = 3'b0;
										rs1 = 5'b0;
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
				7'b0010111: begin                              //U_type(AUIPC)
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = 3'b0;
										rs1 = 5'b0;
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
				7'b1101111: begin                              //J_type(JAL)
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = 3'b0;
										rs1 = 5'b0;
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
				7'b1100111: begin                              //J_type(JALR)
										opcode = Inst [6:0];
										rd = Inst [11:7];
										fun3 = Inst [14:12];
										rs1 = Inst [19:15];
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
				default: begin                             
										opcode = 7'b0;
										rd = 5'b0;
										fun3 = 3'b0;
										rs1 = 5'b0;
										rs2 = 5'b0;
										fun7 = 7'b0;
									end
			endcase
		end
endmodule