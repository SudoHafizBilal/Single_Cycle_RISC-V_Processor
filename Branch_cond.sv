module Branch_cond(
	input logic [31:0] rs1,
	input logic [31:0] rs2,
	input logic [2:0] br_type,
	output logic br_taken
	);
	
	always_comb begin
		case (br_type)
			3'b000: br_taken = (rs1 == rs2);  // beq
            3'b001: br_taken = (rs1 != rs2);  // bne
            3'b100: br_taken = ($signed(rs1) < $signed(rs2));  // blt
            3'b101: br_taken = ($signed(rs1) >= $signed(rs2)); // bge
            3'b110: br_taken = (rs1 < rs2);   // bltu
            3'b111: br_taken = (rs1 >= rs2);  // bgeu
            3'b011: br_taken = 1'b0;
			3'b010: br_taken = 1'b1;
			default: br_taken = 1'bx;
		endcase
	end
	
endmodule