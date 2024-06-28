module BranchDetect(
    input                   InstBranch,
    input       [3:0]       destaddD,
    input       [15:0]      pcD,
    output reg  [15:0]      PC_branch
);

always@(*)begin
    if(InstBranch)
        PC_branch = pcD - destaddD;
    else
        PC_branch = pcD;
end

endmodule