module RXtoCPU_DataFilter(
    input [7:0] RxData,
    input RxDone,
    input clk,
    input reset,
    output reg [15:0] CPU_Data,
    output CPU_Enable
);

reg [15:0]  data_buffer;
reg [1:0]   state, next_state;
reg         CPU_Enable, DataEn; //r_DataEn;
//wire        DataEn_edge;

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
                if(RxDone)
                    next_state = MSB;
                else
                    next_state = IDLE;
        end
        MSB : begin
                if(RxDone)           
                    next_state = LSB;
                else
                    next_state = MSB;
        end
        LSB : begin
                    next_state = IDLE;
        end
        default :   
                    next_state = state;
    endcase
end

always@(posedge clk or negedge reset)begin
    if(~reset)
        data_buffer <= 0;
    else if(RxDone && state == IDLE)
        data_buffer[15:8] = RxData;
    else if(RxDone && state == MSB)
        data_buffer[7:0] = RxData;
    else if(state == LSB)
        DataEn = 1'b1;
    else if(state == IDLE)begin
        data_buffer <= 0;
        DataEn = 1'b0;
    end
end


//Check CPU_Data <- databuffer data
/*always @(*) begin
    DataEn = 1'b0;
    data_buffer = data_buffer; //makez flipflop?
    case(state)
        IDLE : 
            data_buffer = 16'd0;
        MSB : begin
            data_buffer[15:8] = RxData;
        end
        LSB : begin
            data_buffer[7:0] = RxData;
            DataEn = 1'b1;
        end
    endcase
end
//Enable edge
always@(posedge clk or negedge reset)begin
    if(!reset)
        r_DataEn <= 1'b0;
    else
        r_DataEn <= DataEn;
end
assign DataEn_edge = (DataEn != r_DataEn) && DataEn;
*/

always@(posedge clk or negedge reset) begin
    if (!reset)begin
        CPU_Data   <= 16'd0;
        CPU_Enable <= 1'b0;
    end
    else if (DataEn)begin
        CPU_Data   <= data_buffer;
        CPU_Enable <= 1'b1;
    end
    else begin
        CPU_Data   <= 16'd0;
        CPU_Enable <= 1'b0;
    end
end
              
endmodule