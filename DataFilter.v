module DataFilter(
    input               clk,
    input               reset,
    input               CPU_Done,
    input               RxDone,
    input   [7:0]       RxData,
    input   [15:0]      i_CPU_Data,
    output              CPU_Enable,
    output              TxEn,
    output   [7:0]      TxData,
    output   [15:0]     o_CPU_Data
);

RXtoCPU_DataFilter  RXtoCPU(
    .RxData(RxData),
    .RxDone(RxDone),
    .clk(clk),
    .reset(reset),
    .CPU_Data(o_CPU_Data), //output
    .CPU_Enable(CPU_Enable)
);

CPUtoTX_DataFilter  CPUtoTX(
    .CPU_Data(i_CPU_Data),
    .CPU_Done(CPU_Done),
    .clk(clk),
    .reset(reset),
    .TxData(TxData), //output
    .TxEn(TxEn)
);

endmodule