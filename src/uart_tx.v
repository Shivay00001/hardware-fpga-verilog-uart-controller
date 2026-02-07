module uart_tx(
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] data_in,
    output reg tx_pin,
    output reg tx_busy
);

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [2:0] state;
    reg [2:0] bit_index;
    reg [7:0] tx_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx_pin <= 1'b1; // Idle High
            tx_busy <= 0;
            bit_index <= 0;
            tx_data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx_pin <= 1'b1;
                    if (tx_start) begin
                        state <= START;
                        tx_busy <= 1;
                        tx_data <= data_in;
                    end else begin
                        tx_busy <= 0;
                    end
                end
                
                START: begin
                    tx_pin <= 1'b0; // Start Bit (Low)
                    state <= DATA;
                    bit_index <= 0;
                end
                
                DATA: begin
                    tx_pin <= tx_data[bit_index];
                    if (bit_index == 7) begin
                        state <= STOP;
                    end else begin
                        bit_index <= bit_index + 1;
                    end
                end
                
                STOP: begin
                    tx_pin <= 1'b1; // Stop Bit (High)
                    state <= IDLE;
                    tx_busy <= 0;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
