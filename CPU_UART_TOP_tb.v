`timescale  1ns/1ps
module CPU_UART_TOP_tb;

wire o_txout;

reg i_rxin;
reg clk;
reg rst;
reg [15:0] i_data;
reg [1:0] uart_sel;

reg data_frame;

CPU_UART_TOP UUT(
	.TxData(o_txout),
	.RxData(i_rxin),
	.UartSel(uart_sel),
	.clk(clk),
	.reset(rst)
);

initial begin
	clk = 0;
	#1 rst = 0;
	#1 rst = 1;
	i_rxin = 1;
	uart_sel = 0;
	data_frame = 0;
end

always begin
	#5 clk = ~clk;
end

task rx_in(
	input [15:0] i_data,
	input [1:0]	sel
);
begin
	@(posedge clk)
	uart_sel <= sel;
	data_frame <= 1'b0;
	i_rxin <= 1'b0;
	#104160
	i_rxin <= i_data[8];
	#104160
	i_rxin <= i_data[9];
	#104160
	i_rxin <= i_data[10];
	#104160
	i_rxin <= i_data[11];
	#104160
	i_rxin <= i_data[12];
	#104160
	i_rxin <= i_data[13];
	#104160
	i_rxin <= i_data[14];
	#104160
	i_rxin <= i_data[15];
	#104160
	i_rxin <= 1'b1;
	#104160
	i_rxin <= 1'b0;
	#104160
	i_rxin <= i_data[0];
	#104160
	i_rxin <= i_data[1];
	#104160
	i_rxin <= i_data[2];
	#104160
	i_rxin <= i_data[3];
	#104160
	i_rxin <= i_data[4];
	#104160
	i_rxin <= i_data[5];
	#104160
	i_rxin <= i_data[6];
	#104160
	i_rxin <= i_data[7];
	#104160
	i_rxin <= 1'b1;
	#104160
	uart_sel <= 2'd0;
	@(posedge clk)
	data_frame <= 1'b1;
end
endtask

initial begin
	#1000000
	rx_in(16'h20F2, 2'h1);
	rx_in(16'h1104, 2'h1);	
	rx_in(16'h0113, 2'h1);
	rx_in(16'h0024, 2'h1);
	
	rx_in(16'h0064, 2'h2); //100
	//rx_in(16'h0190, 2'h2); //400 error	
	rx_in(16'h00C8, 2'h2); //200
	rx_in(16'h012C, 2'h2); //300
	rx_in(16'h0190, 2'h2); //400

	rx_in(16'h01F4, 2'h2); //500
	rx_in(16'h0258, 2'h2); //600
	rx_in(16'h02BC, 2'h2); //700
	//rx_in(16'h02BC, 2'h2); //700 error
	rx_in(16'h0320, 2'h2); //800
	rx_in(16'h0384, 2'h2); //900
	#1000000
	$finish;
end

endmodule