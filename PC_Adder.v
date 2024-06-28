module PC_Adder(
    input  [15:0]   i_pcOld,
    output [15:0]   o_pcNew
);

assign o_pcNew = i_pcOld + 16'd1;

endmodule