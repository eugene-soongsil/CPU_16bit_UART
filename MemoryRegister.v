module MemoryRegister(
    input               clk, reset,
    input               MemWriteE, MemToRegE, RegWriteE,
    input       [3:0]   destAddE,
    input       [15:0]  alu_resultE,
    output reg  [3:0]   destAddM,
    output reg          MemWriteM, MemToRegM, RegWriteM,
    output reg  [15:0]  alu_resultM
);

always@(posedge clk or negedge reset)begin
    if(~reset)begin
        MemWriteM   <= 1'b0;
        MemToRegM   <= 1'b0;
        RegWriteM   <= 1'b0;
        alu_resultM <= 16'h0000;
        destAddM    <= 4'b0000;
    end
    else begin
        MemWriteM   <= MemWriteE;
        MemToRegM   <= MemToRegE;
        RegWriteM   <= RegWriteE;
        alu_resultM <= alu_resultE;
        destAddM    <= destAddE;
    end
end

endmodule