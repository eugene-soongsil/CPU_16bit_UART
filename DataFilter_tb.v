`timescale 1ns/1ps

module DataFilter_tb;

    reg clk;
    reg reset;
    reg CPU_Done;
    reg RxDone;
    reg [7:0] RxData;
    reg [15:0] i_CPU_Data;
    wire CPU_Enable;
    wire TxEn;
    wire [7:0] TxData;
    wire [15:0] o_CPU_Data;

    // DataFilter 모듈 인스턴스화
    DataFilter uut (
        .clk(clk),
        .reset(reset),
        .CPU_Done(CPU_Done),
        .RxDone(RxDone),
        .RxData(RxData),
        .i_CPU_Data(i_CPU_Data),
        .CPU_Enable(CPU_Enable),
        .TxEn(TxEn),
        .TxData(TxData),
        .o_CPU_Data(o_CPU_Data)
    );

task rx_in(
    input [7:0] rxin1,
    input [7:0] rxin2
);
begin
    @(posedge clk)
    RxData <= rxin1;
    RxDone <= 1'b1;
    #100
    RxData <= 8'd0;
    RxDone <= 1'b0;
    #1000
    RxData <= rxin2;
    RxDone <= 1'b1;
    #100
    RxData <= 8'd0;
    RxDone <= 1'b0;
    #1000;
end
endtask

task tx_in(
    input [15:0] cpudata
);
begin
    @(posedge clk)
    i_CPU_Data <= cpudata;
    CPU_Done <= 1'b1;
    #200;
end
endtask

initial begin
    clk = 0; reset = 1;
    CPU_Done = 0; RxDone= 0;
    RxData = 8'd0; i_CPU_Data = 16'd0;
    #10
    reset = 0;
    #10
    reset = 1;
end

initial begin
    rx_in(8'h12, 8'h34);
    rx_in(8'h45, 8'h67);
    rx_in(8'h99, 8'h67);
    rx_in(8'h13, 8'h55);
    rx_in(8'h25, 8'h34);
    rx_in(8'h05, 8'h74);
    

    tx_in(16'h1234);
    tx_in(16'h5678);
    tx_in(16'h1020);
    tx_in(16'h3040);
    tx_in(16'h5060);
    tx_in(16'h7080);
    #1000;
    $finish;
end

always begin
    #50
    clk = ~clk;
end

endmodule
