module MemoryStage(
    input               clk, reset,
    input               MemWriteM,
    input       [3:0]   destAddM,
    input       [15:0]  alu_resultM,
    output              MemWriteMout, //edit
    output      [15:0]  MemReadDataM,
    output      [15:0]  alu_resultMout
);

MemoryData  inst_MemoryData(
    .clk(clk),
    .reset(reset),
    .addrM(destAddM),
    .write_en(MemWriteM),
    .write_dataM(alu_resultM),
    .read_dataM(MemReadDataM) //out
);

assign MemWriteMout = MemWriteM;
assign alu_resultMout = alu_resultM;

endmodule