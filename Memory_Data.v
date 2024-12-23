module MemoryData(
    input                  clk, reset, write_en,
    input      [3:0]       addrM,
    input                  uart_mem_en, //edit
    input      [15:0]      uart_mem,
    input      [15:0]      write_dataM,
    output     [15:0]      read_dataM
);//32Byte memory RAM
//done signal?

integer i;
integer k;

reg [15:0] mem[15:0];

always@(posedge clk or negedge reset)begin
    if(~reset)begin
        for(i=0; i<16; i=i+1)begin
            mem[i] <= i;
        end
        k <= 0;
    end
    else if(uart_mem_en)begin
        mem[k] <= uart_mem;
        k <= k + 1;
    end
    else if(write_en)
        mem[addrM] <= write_dataM;
end

assign read_dataM = mem[write_dataM];

endmodule

//CRC를 넣어서 데이터를 보내면 data랑 같이
//CRC가 포함된 UART, ALU에 CRC연산 추가?