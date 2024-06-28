module WriteBackStage(
    input               MemToRegW,
    input               MemWriteW,
    input       [15:0]  MemReadDataW, alu_resultW,
    output              done,
    output      [15:0]  ResultW
);

assign ResultW = MemToRegW ? MemReadDataW : alu_resultW;

endmodule
//STA시에만 ResultW값 내보내도록