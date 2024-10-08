module UART_RX (
	output [7:0] o_rx_data,
	output RxDone,
	input i_rxd,
	input i_clk_rx,
	input clk,
	input reset
);

parameter 	idle = 4'b0000, 
			start = 4'b0001, 
			load1 = 4'b0010, 
			load2 = 4'b0011, 
			load3 = 3'b0100, 
			load4 = 4'b0101, 
			load5 = 4'b0110, 
			load6 = 4'b0111, 
			load7 = 4'b1000, 
			load8 = 4'b1001, 
			stop = 4'b1010;

reg [7:0]   r_rx_data;

reg [3:0] 	cnt;
reg [3:0] 	state_reg, state_next;

reg [2:0]	save;
reg 		rxins;
reg 		next;
reg 		cnts;
reg			done_sig_reg;
reg			done_sig;

always @(posedge clk or negedge reset) begin
	if(!reset | cnts) begin 
		cnt <= 0;
		next <= 0;
	end
	else if(cnt == 4'b1111 && i_clk_rx) begin
		cnt <= 0;
		next <= 1;
	end
	else if(i_clk_rx) cnt <= cnt + 1;
	else next <= 0;
end

//sampling
always@(posedge clk)begin
	if(!reset | cnt == 4'b0001) begin
		save <= 0;
		rxins <= 0;
	end
	else begin 
		save[0] <= (cnt == 4'b0011)? i_rxd : save[0];
		save[1] <= (cnt == 4'b0111)? i_rxd : save[1];
		save[2] <= (cnt == 4'b1011)? i_rxd : save[2];
		rxins <= ((save[0] + save[1] + save[2] ) > 1)? 1 : 0;
	end
end

always @(posedge clk or negedge reset) begin
	if(!reset || (state_reg > 4'b1010)) state_reg <= idle;
	else state_reg <= state_next;
end


always @(posedge clk or negedge reset) begin
	if(!reset)begin
		done_sig_reg <= 'b0;
	end
	else begin
		done_sig_reg <= done_sig;
	end
end

assign RxDone = (done_sig_reg != done_sig) && (done_sig_reg==0);

always @(*) begin
	state_next = state_reg;
	cnts = 0;
	done_sig = 0;
	//r_rx_data = r_rx_data;
	case (state_reg)
		4'b0000 : begin
			if(!i_rxd) begin 
				state_next = start;
				cnts = 1;
			end
			else done_sig = 0;
		end
		4'b0001 : begin
			if(next) state_next = load1;
			else ;
		end
		4'b0010 : begin
			if(next) state_next = load2;
		end
		4'b0011 : begin
			if(next) state_next = load3;
		end
		4'b0100 : begin
			if(next) state_next = load4;
		end
		4'b0101 : begin
			if(next) state_next = load5;
		end
		4'b0110 : begin
			if(next) state_next = load6;
		end
		4'b0111 : begin
			if(next) state_next = load7;
		end
		4'b1000 : begin
			if(next) state_next = load8;
		end
		4'b1001 : begin
			if(next) state_next = stop;
		end
		4'b1010 : begin
			if(next) state_next = idle;
			else done_sig = 1;
		end
		default : begin
			state_next = idle;
			done_sig = 0;
		end
	endcase
end

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		r_rx_data <= 0;
	end
	else if(state_reg > 1 | state_reg < 10) begin
		r_rx_data[state_reg - 2] <= rxins;
	end
end

assign o_rx_data = RxDone ? r_rx_data : 0;

endmodule