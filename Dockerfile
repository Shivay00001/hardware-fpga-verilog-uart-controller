FROM ubuntu:22.04

RUN apt-get update && apt-get install -y iverilog

WORKDIR /app
COPY . .

CMD ["iverilog", "-o", "uart_sim", "src/top.v", "src/uart_tx.v"]
