module WriteBackRegister(
    input                   clk, reset,
    input                   MemToRegM, RegWriteM, MemWriteMin,
    input       [3:0]       destAddM,
    input       [15:0]      MemReadDataM,
    input       [15:0]      alu_resultMin,
    output  reg             MemWriteW,
    output  reg             MemToRegW, RegWriteW,
    output  reg [3:0]       destAddW,
    output  reg [15:0]      MemReadDataW, alu_resultW
);

always@(posedge clk or negedge reset)begin
    if(~reset)begin
        MemToRegW    <= 1'b0;
        RegWriteW    <= 1'b0;
        MemReadDataW <= 16'h0000;
        alu_resultW  <= 16'h0000;
        destAddW     <= 4'b0000;
        MemWriteW    <= 1'b0;
    end
    else begin
        MemToRegW    <= MemToRegM;
        RegWriteW    <= RegWriteM;
        MemReadDataW <= MemReadDataM;
        alu_resultW  <= alu_resultMin;
        destAddW     <= destAddM;
        MemWriteW    <= MemWriteMin;
    end
end

endmodule