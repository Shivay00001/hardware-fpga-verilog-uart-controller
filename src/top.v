module uart_testbench;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] data_in;
    wire tx_pin;
    wire tx_busy;

    // Instantiate Baud Gen (Simulation simplified: driving TX directly with test clock)
    // Instantiate TX
    uart_tx u_tx (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .data_in(data_in),
        .tx_pin(tx_pin),
        .tx_busy(tx_busy)
    );

    // Clock gen
    always #5 clk = ~clk;

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, uart_testbench);
        
        clk = 0;
        rst = 1;
        tx_start = 0;
        data_in = 8'hA5; // 10100101
        
        #20 rst = 0;
        
        #20 tx_start = 1;
        #10 tx_start = 0;
        
        wait(!tx_busy);
        #100;
        
        $display("Test Complete: Check Loopback or Waveform");
        $finish;
    end

endmodule
