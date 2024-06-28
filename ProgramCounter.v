module ProgramCounter(
    input                clk,
    input                reset,
    input                enable,
    input                done,
    input       [15:0]   uart_inst,
    input                uart_inst_en,
    input                InstBranch,
    input       [15:0]   PC_branch,
    input       [15:0]   i_pcOld,
    output reg           uart_inst_enF,
    output reg  [15:0]   uart_instF,
    output      [15:0]   o_pcNew
);

reg     [15:0]      r_pcNew;
reg                 r_uart_inst_en;

always@(posedge clk or negedge reset)begin
    if(~reset || done)begin
        r_uart_inst_en <= 1'b0;
    end
    else if(uart_inst_en == 1'b1)
        r_uart_inst_en <= 1'b1;
end

//normal register
always@(posedge clk or negedge reset)begin
    if(~reset)
        uart_inst_enF <= 1'b0;
    else
        uart_inst_enF <= uart_inst_en;
end

always@(posedge clk or negedge reset)begin
    if(~reset)begin
        r_pcNew    <= 0;
        uart_instF <= 0;
    end
    else if(!enable && r_uart_inst_en)begin
        r_pcNew    <= i_pcOld;
        uart_instF <= uart_inst;
    end
    else if(InstBranch)begin
        r_pcNew    <= PC_branch;
        uart_instF <= PC_branch;
    end
end

assign o_pcNew = r_pcNew;

endmodule