`timescale 1ns/1ps
module  Team4_CPU_tb;

reg             clk, reset, uart_en;
reg     [1:0]   uart_sel;
reg     [15:0]  uart_data;
wire    [15:0]  DataOut;
wire            done;

Team4_CPU   inst_CPU(
    .clk(clk),
    .reset(reset),
    .uart_en(uart_en),
    .uart_sel(uart_sel),
    .uart_data(uart_data),
    .DataOut(DataOut),
    .done(done)
);

task cpusim(
    input [15:0] udata,
    input [1:0] sel
);
begin
    @(posedge clk)
    uart_en <= 1'b1;
    uart_sel <= sel;
    uart_data <= udata;
    @(posedge clk)
    uart_en <= 1'b0;
end
endtask

initial begin
    clk = 0; reset = 1;
    #10
    reset = 0;
    #10
    reset = 1;
end

initial begin
    #80
    cpusim(16'd10,2'd1);
    #1000
    cpusim(16'd20,2'd1);
    #1000
    cpusim(16'd30,2'd1);
    #1000
    cpusim(16'd40,2'd1);
    #1000
    cpusim(16'd100,2'd2); //1
    #2000
    cpusim(16'd200,2'd2); //2
    #2000
    cpusim(16'd300,2'd2); //3 done error
    #2000
    cpusim(16'd400,2'd2); //4 
    #2000
    cpusim(16'd500,2'd2); //5
    #2000
    cpusim(16'd600,2'd2); //6
    #2000
    cpusim(16'd700,2'd2); //7
    #2000
    cpusim(16'd800,2'd2); //8 done error
    #2000
    cpusim(16'd900,2'd2); //9 done error
    #2000
    $finish;
end

always begin
    #50
    clk = ~clk;
end

endmodule