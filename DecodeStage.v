module DecodeStage(
    input            clk,
    input            reset,
    input            write_en,
    input  [3:0]     destAddW,
    input  [15:0]    i_write_data,
    input            immediateC,
    input  [15:0]    i_inst,
    input            InstBranch,
    input   [15:0]   pcD,
    output  [15:0]   PC_branch,
    output [3:0]     opcodeDP,
    output [3:0]     destaddD,
    output [3:0]     srcAdd1, srcAdd2,
    output [15:0]    srcdataD1, srcdataD2
);

BranchDetect    inst_BranchDetect(
    .InstBranch(InstBranch),
    .destaddD(destaddD),
    .pcD(pcD),
    .PC_branch(PC_branch)//out
);

Register_File    inst_ResisterFile(
    .clk(clk),
    .reset(reset),
    .i_write_en(write_en),
    .immediateC(immediateC),
    .i_read_add1(srcAdd1),
    .i_read_add2(srcAdd2),
    .i_write_add(destAddW),
    .i_write_data(i_write_data),
    .o_read_data1(srcdataD1), //out
    .o_read_data2(srcdataD2)
);
 
assign srcAdd1 = i_inst[11:8];
assign srcAdd2 = i_inst[7:4];
assign destaddD = i_inst[3:0];
assign opcodeDP = i_inst[15:12];

endmodule
    