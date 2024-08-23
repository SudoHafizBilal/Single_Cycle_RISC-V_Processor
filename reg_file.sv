module reg_file(
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] wr_add,
    input [31:0] wr_data,
    input logic clk, 
    input logic rst,
    input logic reg_wr,
    output [31:0] rdata1,
    output [31:0] rdata2
);
    
    reg [31:0] registers [31:0];   
    // Read data from registers
    assign rdata1 = registers[raddr1];
    assign rdata2 = registers[raddr2];

    // Write data to registers
    always @(negedge clk) begin
	   if (rst) begin
                registers <= '{default:0};
				registers[9] <= 32'b01000110101000011111000110110111;
				registers[18] <= 32'b11111111111111110000000000000000;
        end else begin
            if (reg_wr) begin
                registers[wr_add] <= wr_data;
            end
        end
    end
endmodule
