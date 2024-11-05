module CPU_UART_TOP(
    input               clk,
    input               reset,
    input   [1:0]       UartSel,
    input               RxData,
    output              TxData
);

wire                w_CPU_Enable, w_CPU_Done, w_RxDone, f_write;
wire    [7:0]       w_RxData, w_TxData;
wire    [15:0]      w_o_CPU_Data, w_i_CPU_Data;

CPU_Top           CPU(
    .clk(clk),
    .reset(reset),
    .uart_en(w_CPU_Enable),
    .uart_data(w_o_CPU_Data),
    .uart_sel(UartSel),
    .DataOut(w_i_CPU_Data), //out
    .done(w_CPU_Done)
);

DataFilter          Filter(
    .clk(clk),
    .reset(reset),
    .CPU_Done(w_CPU_Done),
    .RxDone(w_RxDone),
    .RxData(w_RxData),
    .i_CPU_Data(w_i_CPU_Data),
    .CPU_Enable(w_CPU_Enable), //output
    .TxEn(f_write),
    .TxData(w_TxData),
    .o_CPU_Data(w_o_CPU_Data)
);

UART_TOP            UART(
    .clk(clk),
    .reset(reset),
    .f_write(f_write),
    .i_TxData(w_TxData),
    .i_RxData(RxData),
    .o_RxDone(w_RxDone), //output
    .o_TxD(TxData),
    .o_RxD(w_RxData)
);

endmodule