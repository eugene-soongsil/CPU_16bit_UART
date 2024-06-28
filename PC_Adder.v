module PC_Adder(
    input  [11:0]   i_pcOld,
    output [11:0]   o_pcNew
);

assign o_pcNew = i_pcOld + 12'd1;

endmodule