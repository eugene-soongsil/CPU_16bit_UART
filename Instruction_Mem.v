module Instruction_Mem(
    input      [15:0] PCAdd_pc,
    output     [15:0] M_instruction
); //instruction memory(fetch)

    reg [15:0] instM[4095:0];

    //Data forward
    /*initial begin //4+2+1+2+1 = 10, r5 <- 10
        instM[0] = 16'b0110_0001_0100_0001; //r1 = r1 + 4
        instM[1] = 16'b0110_0001_0010_0010; //r2 = r1 + 2
        instM[2] = 16'b0110_0010_0001_0011; //r3 = r2 + 1
        instM[3] = 16'b0110_0011_0010_0100; //r4 = r3 + 2
        instM[4] = 16'b0110_0100_0001_0101; //r5 = r4 + 1
    end*/

    //Branch
    initial begin 
        instM[0] = 16'b0110_0001_0100_0001; //r1 = r1 + 4
        instM[1] = 16'b0110_0010_0100_0010; //r2 = r2 + 4
        instM[2] = 16'b0110_0011_0001_0011; //r3 = r3 + 1
        instM[3] = 16'b0110_0100_0001_0100; //r4 = r4 + 1
        instM[4] = 16'b0111_0001_0001_0001; //r1 = r1 - 1
        instM[5] = 16'b1001_0001_0001_0101; //BNE r1, 1
        //if(r1=1)
        instM[6] = 16'b0110_0001_0100_0010; //r2 = r1 + 4
        instM[7] = 16'b0110_0010_0100_0011; //r3 = r2 + 4
        instM[8] = 16'b0110_1111_0000_1111; //unused
        instM[9] = 16'b0110_1111_0000_1111; //unused
        instM[10] = 16'b0010_0011_0010_0100; //r4 = r3 + r2
    end

    //Load and Store
    /*initial begin
        instM[0] = 16'b0000_0001_0100_0001; //r1 = mem[r1 + 4], (r1 = 4)
        instM[1] = 16'b0110_0010_0100_0010; //r2 = r2 + 4
        instM[2] = 16'b0110_0011_0001_0011; //r3 = r3 + 1
        instM[3] = 16'b0110_0001_1111_0001; //r1 = r1 + 15
        instM[4] = 16'b0001_0001_0000_0000; //mem[r1] = r1
    end*/
    

    //Datafoward with LDA
    /*initial begin
        instM[0] = 16'b0000_0000_1111_0001; //r1 = mem[15](15)
        instM[1] = 16'b0110_1000_0000_1000; //unused
        instM[2] = 16'b0110_1000_0000_1000; //unused
        instM[3] = 16'b0110_0001_0010_0010; //r2 = r1 + 2
        instM[4] = 16'b0110_0010_0001_0011; //r3 = r2 + 1
        instM[5] = 16'b0110_0011_0010_0100; //r4 = r3 + 2
        instM[6] = 16'b0110_0100_0001_0101; //r5 = r4 + 1
    end*/

    assign M_instruction = instM[PCAdd_pc];

endmodule