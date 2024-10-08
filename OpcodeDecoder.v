module OpcodeDecoder(
    input   [3:0]       i_opcode,
    output   reg        branch,
    output   reg        flush,
    output   reg        RegWrite,
    output   reg        MemToReg,
    output   reg        MemWrite,
    output   reg        immediate,
    output   reg        forward,
    output   reg [1:0]  o_alufunc
); //to excute register

reg [8:0] flag;

parameter 
          LDA_imm       = 4'b0000,
          STA_imm       = 4'b0001,
          CAL_add       = 4'b0010,
          CAL_sub       = 4'b0011,
          CAL_mul       = 4'b0100,
          CAL_SLT       = 4'b0101,
          IMM_add       = 4'b0110,
          IMM_sub       = 4'b0111,
          IMM_mul       = 4'b1000,
          BAF_immsub    = 4'b1001,
          BAF_regsub    = 4'b1010,
          NONE          = 4'b1111;

 always @(*) begin
    // 기본값 설정 (디폴트 상태)
    {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b00_0000000;

    case(i_opcode)
        LDA_imm     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b00_0010111;
        STA_imm     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b00_0001010;
        CAL_add     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b00_0010001;
        CAL_sub     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b01_0010001;
        CAL_mul     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b10_0010001;
        CAL_SLT     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b11_0010001;
        IMM_add     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b00_0010011;
        IMM_sub     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b01_0010011;
        IMM_mul     : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b10_0010011;
        BAF_immsub  : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b01_1100010;
        BAF_regsub  : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b01_1100000;
        NONE        : {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = 9'b00_0000000;
    endcase
end
/* 
always @(*) begin
    {o_alufunc, branch, flush, RegWrite, MemWrite, MemToReg, immediate, forward} = flag;
end

always @(*) begin
    flag = 9'b00_0000000;
    case(i_opcode[3:0])
        LDA_imm     : flag =    9'b00_0010111;
        STA_imm     : flag =    9'b00_0001010;//forward edit
        CAL_add     : flag =    9'b00_0010001;
        CAL_sub     : flag =    9'b01_0010001;
        CAL_mul     : flag =    9'b10_0010001;
        CAL_SLT     : flag =    9'b11_0010001;
        IMM_add     : flag =    9'b00_0010011;
        IMM_sub     : flag =    9'b01_0010011;
        IMM_mul     : flag =    9'b10_0010011;
        BAF_immsub  : flag =    9'b01_1100010;
        BAF_regsub  : flag =    9'b01_1100000;
        NONE        : flag =    9'b00_0000000;
    endcase
end
*/

endmodule