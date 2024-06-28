module MUX_16bit(
    input  [15:0] in1,
    input [15:0]  in2,
    input         sel,
    output      [15:0] out
);

assign out = (sel) ? in1 : in2;

endmodule