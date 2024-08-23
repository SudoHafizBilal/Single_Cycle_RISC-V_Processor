module r_type(	
	input logic clk,
	input logic rst
);

	reg [31:0] inst; //
	reg [6:0] opcode; //
	reg [2:0] fun3; // 
	reg [6:0] fun7; //
	reg [4:0] rs1; //
	reg [4:0] rs2; // 
	reg [4:0] rd; //
	reg [31:0] rdata1; //
	reg [31:0] rdata2; //
	reg [31:0] pc_out; //
	reg [31:0] cont; //
	reg [31:0] aluout; //
	reg [31:0] bit32; //
	reg [31:0] alu_in_b; //
	reg [31:0] alu_in_a; //
	reg [31:0] memout; //
	reg [31:0] wrdata; //
	reg [31:0] muxout3; //
	
	logic reg_wr; //
	reg [3:0] alu_op; //
	reg [2:0] br_type;
	logic sel_B; //
	logic rd_en; //
	logic [1:0] wb_sel; //
	logic wr_en; //
	logic br_taken; //
	logic sel_A; //
		
		Mux mux_3(.reg_a(cont),.reg_b(aluout),.muxout(muxout3),.sel(br_taken));
		Inst_mem Inst_(.Addr(pc_out),.Inst(inst));
		program_counter pc(.clk(clk),.rst(rst),.pc_in(muxout3),.pc_out(pc_out));
		counter Cont(.pc_out(pc_out),.cont(cont));		
		Decoder Dec(.Inst(inst),.opcode(opcode),.rd(rd),.rs1(rs1),.rs2(rs2),.fun3(fun3),.fun7(fun7));		
		img_gen gen(.inst(inst),.bit32(bit32));
		Control_unit Cu(.opcode(opcode),.fun3(fun3),.fun7(fun7),.alu_op(alu_op),.reg_wr(reg_wr),.sel_B(sel_B),.rd_en(rd_en),.wb_sel(wb_sel),.wr_en(wr_en),.sel_A(sel_A),.br_type(br_type));		
		reg_file file(.rdata1(rdata1),.rdata2(rdata2),.raddr1(rs1),.raddr2(rs2),.wr_add(rd),.wr_data(wrdata),.clk(clk),.rst(rst),.reg_wr(reg_wr));		
		Mux mux_4(.reg_a(pc_out),.reg_b(rdata1),.muxout(alu_in_a),.sel(sel_A));
		Mux mux_1(.reg_a(rdata2),.reg_b(bit32),.muxout(alu_in_b),.sel(sel_B));
		ALU_unit alu(.reg_a(alu_in_a),.reg_b(alu_in_b),.aluout(aluout),.alu_op(alu_op));
		Branch_cond BC(.rs1(rdata1),.rs2(rdata2),.br_type(br_type),.br_taken(br_taken));
		memory mem(.memout(memout),.wr_add(aluout),.wr_data(rdata2),.rd_en(rd_en),.wr_en(wr_en),.clk(clk));		
		mux_3by1 mux_2(.rega(cont),.regb(aluout),.regc(memout),.regd(wrdata),.sel(wb_sel));

endmodule