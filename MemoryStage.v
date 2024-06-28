module MemoryStage(
    input               clk, reset,
    input               MemWriteM,
    input       [3:0]   destAddM,
    input       [15:0]  alu_resultM,
    input       [15:0]  uart_mem,
    input               uart_mem_en,
    output              MemWriteMout, //edit
    output      [15:0]  MemReadDataM,
    output      [15:0]  alu_resultMout
);

MemoryData  inst_MemoryData(
    .clk(clk),
    .reset(reset),
    .uart_mem(uart_mem),
    .uart_mem_en(uart_mem_en),
    .addrM(destAddM),
    .write_en(MemWriteM),
    .write_dataM(alu_resultM),
    .read_dataM(MemReadDataM) //out
);

assign MemWriteMout = MemWriteM;
assign alu_resultMout = alu_resultM;

endmodule