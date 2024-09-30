module data_filter(
    input [15:0] i_data,
    input i_enable,
    input clk,
    input reset,
    output reg [7:0] o_data,
    output o_enable
);

reg [15:0]  data_buffer;
reg [1:0]   state, next_state;
reg         msb_enable, lsb_enable;

localparam  IDLE = 2'b00, lsb_state = 2'b01, msb_state = 2'b10;

always@(posedge clk or negedge reset) begin
    if (!reset)
        state <= IDLE;
    else 
        state <= next_state;
end

always @(*) begin
    case(state)
        IDLE : begin
                if (i_enable) 
                    next_state = lsb_state;
                else
                    next_state = IDLE;
        end
        lsb_state :            
                    next_state = msb_state;
        msb_state : 
                    next_state = IDLE;
        default :   next_state = state;
    endcase
end

always @(*) begin
    lsb_enable = 0;
    msb_enable = 0;
    case(state)
        IDLE : o_data = 8'b0;
        lsb_state : begin
            o_data = data_buffer[15:8];
            lsb_enable =1'b1;
        end
        msb_state : begin
            o_data = data_buffer[7:0];
            msb_enable = 1'b1;
        end
        default : o_data = 8'b0;
    endcase
end

always@(posedge clk or negedge reset) begin
    if (!reset)
        data_buffer <= 0;

    else if (state == IDLE && i_enable)
        data_buffer <= i_data;
end

assign o_enable = (lsb_enable || msb_enable)? 1: 0;
              
endmodule