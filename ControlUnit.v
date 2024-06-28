module ControlUnit(
    input  [3:0]     i_opcode,
    output          branchD, flushD, RegWriteD, MemWriteD, MemToRegD, immediateD, forwardD,
    output [1:0]    alufuncD
);

OpcodeDecoder   inst_OpcodeDecoder(
    .i_opcode(i_opcode),
    .branch(branchD),
    .flush(flushD),
    .RegWrite(RegWriteD),
    .MemWrite(MemWriteD),
    .MemToReg(MemToRegD),
    .immediate(immediateD),
    .forward(forwardD),
    .o_alufunc(alufuncD)
);

endmodule