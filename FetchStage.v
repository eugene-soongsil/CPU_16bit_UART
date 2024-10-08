module FetchStage(
    input               reset,
    input   [15:0]      uart_instF,
    input               uart_inst_enF,
    input   [15:0]      i_pcF,
    output  [15:0]      o_pcF,
    output  [15:0]      o_instF
);//PC behavior

wire         [15:0]      pc_sel;

assign      pc_sel = uart_inst_enF ? uart_instF : i_pcF;

PC_Adder    inst_PCAdder(
    .i_pcOld(pc_sel),
    .o_pcNew(o_pcF)
);

Instruction_Mem     inst_InstMem(
    .reset(reset),
    .PCAdd_pc(pc_sel),
    .M_instruction(o_instF)
);

endmodule