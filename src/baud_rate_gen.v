module baud_rate_gen #(
    parameter CLOCK_RATE = 50000000,
    parameter BAUD_RATE = 9600
)(
    input wire clk,
    input wire rst,
    output reg rxclk, // 16x oversampling for RX
    output reg txclk
);

    parameter MAX_RATE_RX = CLOCK_RATE / (BAUD_RATE * 16);
    parameter MAX_RATE_TX = CLOCK_RATE / BAUD_RATE;
    parameter RX_CNT_WIDTH = $clog2(MAX_RATE_RX);
    parameter TX_CNT_WIDTH = $clog2(MAX_RATE_TX);

    reg [RX_CNT_WIDTH-1:0] rx_cnt;
    reg [TX_CNT_WIDTH-1:0] tx_cnt;

    // RX Clock Generation (16x Baud)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_cnt <= 0;
            rxclk <= 0;
        end else begin
            if (rx_cnt == MAX_RATE_RX[RX_CNT_WIDTH-1:0]) begin
                rx_cnt <= 0;
                rxclk <= ~rxclk;
            end else begin
                rx_cnt <= rx_cnt + 1;
            end
        end
    end

    // TX Clock Generation (1x Baud)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_cnt <= 0;
            txclk <= 0;
        end else begin
            if (tx_cnt == MAX_RATE_TX[TX_CNT_WIDTH-1:0]) begin
                tx_cnt <= 0;
                txclk <= ~txclk;
            end else begin
                tx_cnt <= tx_cnt + 1;
            end
        end
    end

endmodule
