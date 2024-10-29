module Register_File(
    input              clk,
    input              reset,
    input              i_write_en,
    input              immediateC,
    input       [3:0]  i_read_add1,
    input       [3:0]  i_read_add2,
    input       [3:0]  i_write_add,
    input       [15:0] i_write_data,
    output reg  [15:0] o_read_data1,
    output reg  [15:0] o_read_data2
);

//resister initialize and write-back(excute)
reg [15:0] registers [0:15];

integer i;
always@(posedge clk or negedge reset)begin //negedge clk for 1clock cycle
    if (~reset) begin
        for (i = 0; i < 16; i = i + 1)begin
            registers[i] <= 16'h0000;
        end
    end
    else if (i_write_en) begin
        registers[i_write_add] <= i_write_data;
    end
end

always@(*)begin
    if(~reset)begin
        o_read_data1 = 0;
        o_read_data2 = 0;
    end
    else if(immediateC)begin
        o_read_data1 = registers[i_read_add1];
        o_read_data2 = {12'd0, i_read_add2};
    end
    else begin
        o_read_data1 = registers[i_read_add1];
        o_read_data2 = registers[i_read_add2];
    end
end

endmodule