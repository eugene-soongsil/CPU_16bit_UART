module WriteBackStage(
    input               MemToRegW,
    input               MemWriteW,
    input       [15:0]  MemReadDataW, alu_resultW,
    output              done,
    output      [15:0]  ResultW,
    output      [15:0]  MemReadDataWout
);

assign MemReadDataWout = MemToRegW ? MemReadDataW : alu_resultW;
assign ResultW = MemWriteW ? alu_resultW : 0;
assign done = MemWriteW;

endmodule
//STA시에만 ResultW값 내보내도록
//done -> fetch stage 연결    