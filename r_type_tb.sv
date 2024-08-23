module tb_r_type;

    // Testbench signals
    logic clk;
    logic rst;

    // Instantiate the r_type module
    r_type uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initial conditions
        rst = 1;
        #10;
        
        // Release reset
        rst = 0;
        #100;

        // Add more test cases here if needed
        
        // Finish simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time: %0t | clk: %b | rst: %b | pc_out: %h | inst: %h | aluout: %h", 
                 $time, clk, rst, uut.pc_out, uut.inst, uut.aluout);
    end

endmodule
