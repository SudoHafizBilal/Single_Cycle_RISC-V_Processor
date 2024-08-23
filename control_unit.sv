module Control_unit(
    input logic [6:0] opcode,
	input logic [2:0] fun3,
	input logic [6:0] fun7,
    output logic [3:0] alu_op,
	output logic [2:0] br_type,
	output logic reg_wr,
	output logic sel_B,
	output logic rd_en,
	output logic [1:0] wb_sel,
	output logic wr_en,
	output logic sel_A
);

always_comb begin
	if(opcode == 7'b0110011) begin //for R_type
		reg_wr = 1'b1;
		sel_B = 1'b0;
		sel_A = 1'b1;
		wb_sel = 2'b01;
		rd_en = 1'b0;
		wr_en = 1'b0;
		br_type = 3'b011;
		case({fun7,fun3})
			10'b0000000000:	alu_op = 4'b0000; //add
            10'b0100000000:	alu_op = 4'b0001; //subt
            10'b0000000111:	alu_op = 4'b0010; //and
			10'b0000000110:	alu_op = 4'b0011; //or
            10'b0000000100:	alu_op = 4'b0100; //xor
	        10'b0000000001:	alu_op = 4'b0101; //sll
	        10'b0000000101:	alu_op = 4'b0110; //srl
            10'b0000000010:	alu_op = 4'b0111; //slt
			10'b0100000101:	alu_op = 4'b1000; //sra
			10'b0000000011:	alu_op = 4'b1001; //sltu
		endcase
end
	else if (opcode == 7'b0010011) begin //for I_type 
		sel_B =1'b1;
		sel_A = 1'b1;	
		reg_wr = 1'b1;
		wb_sel = 2'b01;
		rd_en = 1'b0;
		wr_en = 1'b0;
		br_type = 3'b011;
		case({fun3})
			3'b000:	alu_op = 4'b0000; //addi
            3'b111:	alu_op = 4'b0010; //andi
			3'b110:	alu_op = 4'b0011; //ori
            3'b100:	alu_op = 4'b0100; //xori
	        3'b001:	alu_op = 4'b0101; //slli
	        3'b101:	alu_op = 4'b0110; //srli
            3'b010:	alu_op = 4'b0111; //slti
			3'b101:	alu_op = 4'b1000; //srai
			3'b011:	alu_op = 4'b1001; //sltui
		endcase
end
	else if(opcode == 7'b0000011) begin //for L_type
		reg_wr = 1'b1;
		sel_B = 1'b1;
		sel_A = 1'b1;
		alu_op = 4'b0000;
		rd_en = 1'b1;
		wb_sel = 2'b10;
		wr_en = 1'b0;
		br_type = 3'b011;
		
end
	else if(opcode == 7'b0100011) begin //for S_type
		alu_op = 4'b0000;
		reg_wr = 1'b0;
		sel_B = 1'b1;
		rd_en = 1'b0;
		wr_en = 1'b1;
		br_type = 3'b011;
end
	else if(opcode == 7'b1100011) begin // B_type
		br_type = fun3;
		alu_op = 4'b0000;
		sel_A = 1'b0;
		sel_B = 1'b1;
		reg_wr = 1'b0;
		wr_en = 1'b0;
		rd_en = 1'b0;
end
	else if(opcode == 7'b0110111) begin // U_type(LUI)
		br_type = 3'b011;
		alu_op = 4'b1111;
		sel_B = 1'b1;
		reg_wr = 1'b1;
		wr_en = 1'b0;
		rd_en = 1'b0;
		wb_sel = 2'b01;
end
	else if(opcode == 7'b0010111) begin // U_type(AUIPC)
		br_type = 3'b011;
		alu_op = 4'b0000;
		sel_A = 1'b0;
		sel_B = 1'b1;
		reg_wr = 1'b1;
		wr_en = 1'b0;
		rd_en = 1'b0;
		wb_sel = 2'b01;
end
	else if(opcode == 7'b1101111) begin // J_type(JAL)
		br_type = 3'b010;
		alu_op = 4'b0000;
		sel_A = 1'b0;
		sel_B = 1'b1;
		reg_wr = 1'b1;
		wr_en = 1'b0;
		rd_en = 1'b0;
		wb_sel = 2'b00;
end
	else if(opcode == 7'b1100111) begin // J_type(JALR)
		br_type = 3'b010;
		alu_op = 4'b0000;
		sel_A = 1'b1;
		sel_B = 1'b1;
		reg_wr = 1'b1;
		wr_en = 1'b0;
		rd_en = 1'b0;
		wb_sel = 2'b00;
end
	else begin
		reg_wr = 1'b0;
		wr_en = 1'b0;
		rd_en = 1'b0;
		wb_sel = 2'bx;
		sel_A = 1'bx;
		sel_B = 1'bx;
		alu_op = 4'bx;
		br_type = 3'bx;
end
end
endmodule