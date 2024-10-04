module CPUtoTX_DataFilter(
    input [15:0] CPU_Data,
    input CPU_Done,
    input clk,
    input reset,
    output reg [7:0] TxData,
    output TxEn
);

reg [15:0]  data_buffer;
reg [1:0]   state, next_state;
reg         TxEn;

localparam  IDLE = 2'b00, MSB = 2'b01, LSB = 2'b10;

always@(posedge clk or negedge reset) begin
    if (!reset)
        state <= IDLE;
    else 
        state <= next_state;
end

always @(*) begin
    case(state)
        IDLE : begin
                if (CPU_Done)
                    next_state = MSB;
                else
                    next_state = IDLE;
        end
        MSB :            
                    next_state = LSB;
        LSB : 
                    next_state = IDLE;
        default :   
                    next_state = state;
    endcase
end

always @(*) begin
    TxEn = 0;
    case(state)
        IDLE : 
            TxData = 8'd0;
        MSB : begin
            TxData = data_buffer[15:8];
            TxEn = 1;
        end
        LSB : begin
            TxData = data_buffer[7:0];
            TxEn = 1;
        end
        default : 
            TxData = 8'd0;
    endcase
end

always@(posedge clk or negedge reset) begin
    if (!reset)
        data_buffer <= 0;

    else if (state == IDLE && CPU_Done)
        data_buffer <= CPU_Data;
end

//assign TxEn = (lsb_enable || msb_enable)? 1: 0;
              
endmodule