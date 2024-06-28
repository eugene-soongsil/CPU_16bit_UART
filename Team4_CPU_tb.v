`timescale 1ns/1ps
module  Team4_CPU_tb();

reg             clk, reset;
wire    [15:0]  DataOut;

Team4_CPU   inst_CPU(
    .clk(clk),
    .reset(reset),
    .DataOut(DataOut)
);

initial begin
    clk = 0; reset = 1;
    #10
    reset = 0;
    #10
    reset = 1;
    #1500   
    $finish;
end

always begin
    #50
    clk = ~clk;
end

endmodule