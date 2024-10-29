module ALU(
    input        [1:0]    ALU_func,
    input        [15:0]   ALU_srcdata_1,
    input        [15:0]   ALU_srcdata_2,
    output  reg  [15:0]   ALU_result
);

parameter   ADD = 2'b00,
            SUB = 2'b01,
            MUL = 2'b10,
            SLT = 2'b11;

always@(*)begin
    ALU_result = 16'h0000;
    case(ALU_func)
            ADD: ALU_result = ALU_srcdata_1 + ALU_srcdata_2; 
            SUB: ALU_result = ALU_srcdata_1 - ALU_srcdata_2;
            MUL: ALU_result = ALU_srcdata_1 * ALU_srcdata_2; //Timing issue - shift
            SLT: ALU_result = (ALU_srcdata_1 < ALU_srcdata_2) ? {{(15){1'b0}}, 1'b1} :  {(16){1'b0}};
    endcase
end

endmodule