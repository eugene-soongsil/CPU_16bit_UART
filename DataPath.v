module DataPath(
    input               clk, reset,
    input               uart_en, //uart
    input   [1:0]       uart_sel,
    input   [15:0]      uart_data,
    input               stallF, stallD, forwardA, forwardB,
    input               InstBranch, flushD,
    input               flushC, RegWriteC, MemWriteC, MemToRegC, immediateC,
    input   [1:0]       alufuncC,
    output              RegWriteE, MemToRegE,//to DH
    output  [3:0]       srcAdd1, srcAdd2, destAddE,
    output  [3:0]       opcodeDP,
    output  [15:0]      ResultW, RegDataA, RegDataB, alu_resultE
);

wire                    RegWriteM, RegWriteW, MemToRegM, MemToRegW,
                        MemWriteE, MemWriteM, forwardE, MemWriteW, MemWriteMout;
wire    [1:0]           aluFuncE;
wire    [3:0]           forward_addE,
                        destAddD, 
                        //destAddE, 
                        destAddM, 
                        destAddW;
wire    [15:0]          w_pcNew, w_pcF, w_pcD, PC_branch;
wire    [15:0]          w_instF, w_instD, srcDataE1, srcDataE2,
                        //alu_resultE,
                        alu_resultM, alu_resultW, MemReadDataM, MemReadDataW,
                        alu_resultMout, srcDataD1, srcDataD2;
wire    [15:0]          uart_instF;
wire                    uart_inst_enF;

wire     uart_inst_en, uart_mem_en;

assign uart_inst_en = (uart_sel == 2'd2 && uart_en)? 1'b1 : 1'b0;
assign uart_mem_en = (uart_sel == 2'd1 && uart_en)? 1'b1 : 1'b0;

ProgramCounter      inst_ProgramCounter(
    .clk(clk),
    .reset(reset),
    .enable(stallF),
    .done(MemWriteW),
    .uart_inst(uart_data),
    .uart_inst_en(uart_inst_en),
    .InstBranch(InstBranch),
    .PC_branch(PC_branch),
    .i_pcOld(w_pcF), //from fetchstage
    .o_pcNew(w_pcNew), //out
    .uart_inst_enF(uart_inst_enF),
    .uart_instF(uart_instF)
);

FetchStage          inst_FetchStage(
    .uart_instF(uart_instF),
    .uart_inst_enF(uart_inst_enF),
    .i_pcF(w_pcNew),
    .o_pcF(w_pcF), //out
    .o_instF(w_instF)
);

DecodeRegister      inst_DecodeRegister(
    .clk(clk),
    .reset(reset),
    .enable(stallD),
    .flushD(flushD),
    .pcF(w_pcF),
    .instF(w_instF),
    .pcD(w_pcD), //out
    .instD(w_instD)
);

DecodeStage         inst_DecodeStage(
    .clk(clk),
    .reset(reset),
    .write_en(RegWriteW),
    .destAddW(destAddW),
    .i_write_data(ResultW),
    .immediateC(immediateC),
    .i_inst(w_instD),
    .InstBranch(InstBranch),
    .pcD(w_pcD),
    .PC_branch(PC_branch), //out
    .opcodeDP(opcodeDP),
    .destaddD(destAddD),
    .srcAdd1(srcAdd1),
    .srcAdd2(srcAdd2),
    .srcdataD1(srcDataD1),
    .srcdataD2(srcDataD2)
);

MUX_16bit           inst_MUX_RegDataA(
    .in1(alu_resultE),
    .in2(srcDataD1),
    .sel(forwardA),
    .out(RegDataA)
);

MUX_16bit           inst_MUX_RegDataB(
    .in1(alu_resultE),
    .in2(srcDataD2),
    .sel(forwardB),
    .out(RegDataB)
);

ExcuteRegister      inst_ExcuteRegister(
    .clk(clk),
    .reset(reset),
    .RegWriteC(RegWriteC),
    .MemWriteC(MemWriteC),
    .MemToRegC(MemToRegC),
    .alufuncC(alufuncC), //CU
    .srcDataD1(RegDataA),
    .srcDataD2(RegDataB),
    .destAddD(destAddD),
    .flushC(flushC),
    .RegWriteE(RegWriteE), //out
    .MemWriteE(MemWriteE),
    .MemToRegE(MemToRegE),
    .alufuncE(aluFuncE),
    .srcDataE1(srcDataE1),
    .srcDataE2(srcDataE2),
    .destAddE(destAddE)
);

ExcuteStage         inst_ExcuteStage(
    .aluFuncE(aluFuncE),
    .srcDataE1(srcDataE1),
    .srcDataE2(srcDataE2),
    .alu_resultE(alu_resultE) //out
);

MemoryRegister      inst_MemoryRegister(
    .clk(clk),
    .reset(reset),
    .destAddE(destAddE),
    .MemWriteE(MemWriteE),
    .MemToRegE(MemToRegE),
    .RegWriteE(RegWriteE),
    .alu_resultE(alu_resultE),
    .destAddM(destAddM),//out
    .MemWriteM(MemWriteM),
    .MemToRegM(MemToRegM),
    .RegWriteM(RegWriteM),
    .alu_resultM(alu_resultM)
);

MemoryStage         inst_MemoryStage(
    .clk(clk),
    .reset(reset),
    .MemWriteM(MemWriteM),
    .destAddM(destAddM), //edit
    .alu_resultM(alu_resultM),
    .uart_mem(uart_data),
    .uart_mem_en(uart_mem_en),
    .MemReadDataM(MemReadDataM), //out
    .MemWriteMout(MemWriteMout),
    .alu_resultMout(alu_resultMout)
);

WriteBackRegister   inst_WriteBackRegister(
    .clk(clk),
    .reset(reset),
    .destAddM(destAddM),
    .MemToRegM(MemToRegM),
    .RegWriteM(RegWriteM),
    .MemWriteMin(MemWriteMout),
    .MemReadDataM(MemReadDataM),
    .alu_resultMin(alu_resultMout),
    .destAddW(destAddW),//out
    .MemToRegW(MemToRegW),
    .RegWriteW(RegWriteW),
    .MemReadDataW(MemReadDataW),
    .MemWriteW(MemWriteW),
    .alu_resultW(alu_resultW)
);

WriteBackStage      inst_WritebackStage(
    .MemToRegW(MemToRegW),
    .MemWriteW(MemWriteW),
    .MemReadDataW(MemReadDataW),
    .alu_resultW(alu_resultW),
    .done(done),
    .ResultW(ResultW) //out
);

endmodule