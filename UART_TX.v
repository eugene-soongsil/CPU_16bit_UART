module UART_TX (
	output o_txd,
	output reg TxDone, 
	input[7:0] i_switch,
	input TxStart,
	input i_clk_tx,
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
			stop = 4'b1010, 
			read_state = 4'b1011;

reg [3:0] 	cnt;
reg [2:0] 	tcnt;
reg [3:0] 	state_reg, state_next;
reg 		next;
reg 		cnts;
reg 		txout_reg;

//16 counter
always @(posedge clk or negedge reset) begin
	if(!reset | cnts) begin 
		cnt <= 0;
		next <= 0;
	end
	else if(cnt == 4'b1111 && i_clk_tx) begin
		cnt <= 0;
		next <= 1;
	end
	else if(i_clk_tx) cnt <= cnt + 1;
	else next <= 0;
end

always @(posedge clk or negedge reset) begin
	if(!reset || (state_reg > 4'b1010)) state_reg <= idle;
	else state_reg <= state_next;
end

always @(*) begin
	state_next = state_reg;
	cnts = 0;
	TxDone = 0; 
	txout_reg = 1;
	case (state_reg)
		4'b0000 : begin
			if(TxStart) begin 
				state_next = start;
				cnts = 1; //start state�??�� count�? ?��?�� ?���? ?��?�� reset
			end
			else txout_reg = 1;
		end
		4'b0001 : begin
			if(next) begin 
				state_next = load1;
				txout_reg = 0;
			end
			else txout_reg = 0;
		end
		4'b0010 : begin
			if(next) begin 
				state_next = load2;
				txout_reg = i_switch[0];
			end
			else txout_reg = i_switch[0];
		end
		4'b0011 : begin
			if(next) begin
				state_next = load3;
				txout_reg = i_switch[1];
			end
			else txout_reg = i_switch[1];
		end
		4'b0100 : begin
			if(next) begin
				state_next = load4;
				txout_reg = i_switch[2];
			end
			else txout_reg = i_switch[2];
		end
		4'b0101 : begin
			if(next) begin
				state_next = load5;
				txout_reg = i_switch[3];
			end
			else txout_reg = i_switch[3];
		end
		4'b0110 : begin
			if(next) begin
				state_next = load6;
				txout_reg = i_switch[4];
			end
			else txout_reg = i_switch[4];
		end
		4'b0111 : begin
			if(next) begin
				state_next = load7;
				txout_reg = i_switch[5];
			end
			else txout_reg = i_switch[5];
		end
		4'b1000 : begin
			if(next) begin
				state_next = load8;
				txout_reg = i_switch[6];
			end
			else txout_reg = i_switch[6];
		end
		4'b1001 : begin
			if(next) begin
				state_next = stop;
				txout_reg = i_switch[7];
			end
			else txout_reg = i_switch[7];
		end
		4'b1010 : begin
			if(next) begin
				state_next = read_state;
				txout_reg = 1;
				TxDone = 1;				
			end
			else txout_reg = 1;
		end
		4'b1011 : begin
			state_next = idle;
		end
		default : begin
			state_next = idle;
			txout_reg = 1;
		end
	endcase
end

assign o_txd = txout_reg;

endmodule