module HazardUnit(
    input               branch,
    input               flush,
    input               RegWriteE,
    input               MemToRegE,
    input               immediateD,
    input               forwardD,
    input    [3:0]      srcAdd1, srcAdd2, destAddE,
    input    [15:0]     srcData1, srcData2, alu_resultE,
    output  reg         stallF, stallD,
    output  reg         forwardA, forwardB,
    output  reg         flushD, flushE,
    output  reg         InstBranch
);

reg lwstall;

always@(*)begin
    if(branch && (srcData1 != srcData2) && alu_resultE)
        InstBranch = 1'b1;
    else
        InstBranch = 1'b0;
end

always@(*)begin
    if(MemToRegE && ((srcAdd1 == destAddE)||(srcAdd2 == destAddE)))
        lwstall = 1'b1;
    else
        lwstall = 1'b0;
end

always@(*)begin
    if(forwardD && RegWriteE && (srcAdd1 == destAddE))//edit
        forwardA = 1'b1;
    else
        forwardA = 1'b0;
end

always@(*)begin
    if(!immediateD && forwardD && RegWriteE && (srcAdd2 == destAddE))
        forwardB = 1'b1;
    else
        forwardB = 1'b0;
end

always@(*)begin
    if(lwstall || InstBranch)begin
        stallF = 1'b1;
        stallD = 1'b1;
    end
    else begin
        stallF = 1'b0;
        stallD = 1'b0;
    end
end

always@(*)begin
    if(lwstall || (InstBranch &&flush))
        flushE = 1'b1;
    else
        flushE = 1'b0;
end

always@(*)begin
    if(InstBranch)begin
        flushD = 1'b1;
    end
    else begin
        flushD = 1'b0;
    end
end

endmodule