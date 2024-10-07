module UART_TOP(
    input           clk,
    input           reset,
    input           f_write, //from datafilter
    input [7:0]     i_TxData,
    input           i_RxData,
    output          o_RxDone,
    output          o_TxD,
    output [7:0]    o_RxD
);

wire            w_clk_rx, w_clk_tx, empty, TxDone;
wire [7:0]      w_TxIn;

UART_TX         Tx(
    .clk(clk),
    .reset(reset),
    .i_clk_tx(w_clk_tx),
    .i_switch(w_TxIn),
    .TxStart(!empty),
    .TxDone(TxDone),
    .o_txd(o_TxD)
);

UART_RX         Rx(
    .clk(clk),
    .reset(reset),
    .i_clk_rx(w_clk_rx),
    .i_rxd(i_RxData),
    .RxDone(o_RxDone),
    //.RxStopBit(),
    .o_rx_data(o_RxD)
);

FIFO            fifo(
    .clk(clk),
    .reset(reset),
    .rd(TxDone),
    .wr(f_write),
    .wr_data(i_TxData),
    .empty(empty),
    .full(),
    .rd_data(w_TxIn)
);

clk_div         BRG(
    .clk(clk),
    .reset(reset),
    .o_clk_rx(w_clk_rx),
    .o_clk_tx(w_clk_tx)
);

endmodule