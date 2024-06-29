module Instruction_Mem(
    input      [15:0] PCAdd_pc,
    output     [15:0] M_instruction
); //instruction memory(fetch)

    reg [15:0] instM[4095:0];

    initial begin
            //100 ADD 2 DATA
				instM[100] = 16'b0000_1101_0000_0000;
				instM[101] = 16'b0000_1101_0001_0001;
				instM[102] = 16'b0110_1111_0000_1111; //pipeline
				instM[103] = 16'b0110_1111_0000_1111; //pipeline
				instM[104] = 16'b0010_0000_0001_0010;
				instM[105] = 16'b0110_1111_0000_1111; //pipeline
				instM[106] = 16'b0110_1111_0000_1111; //pipeline
				instM[107] = 16'b0001_0010_0000_1111;
            //200 ADD 3 DATA
				instM[200] = 16'b0000_1101_0000_0000;
				instM[201] = 16'b0000_1101_0001_0001;
				instM[202] = 16'b0000_1101_0010_0010;
				instM[203] = 16'b0110_1111_0000_1111; //pipeline
				instM[204] = 16'b0010_0000_0001_0011;
				instM[205] = 16'b0010_0010_0011_0100;
				instM[206] = 16'b0110_1111_0000_1111; //pipeline
				instM[207] = 16'b0110_1111_0000_1111; //pipeline
				instM[208] = 16'b0001_0100_0000_1111;
			//300 ADD 4 DATA
				instM[300] = 16'b0000_1101_0000_0000;
				instM[301] = 16'b0000_1101_0001_0001;
				instM[302] = 16'b0000_1101_0010_0010;
				instM[303] = 16'b0000_1101_0011_0011;
				instM[304] = 16'b0010_0000_0001_0100;
				instM[305] = 16'b0110_1111_0000_1111; //pipeline
				instM[306] = 16'b0010_0010_0011_0101;
				instM[307] = 16'b0010_0100_0101_0110;
				instM[308] = 16'b0110_1111_0000_1111; //pipeline
				instM[309] = 16'b0110_1111_0000_1111; //pipeline
				instM[310] = 16'b0001_0110_0000_1111;
			//400 SUB 2 DATA
				instM[400] = 16'b0000_1101_0000_0000;
				instM[401] = 16'b0000_1101_0001_0001;
				instM[402] = 16'b0110_1111_0000_1111; //pipeline
				instM[403] = 16'b0110_1111_0000_1111; //pipeline
				instM[404] = 16'b0011_0000_0001_0010;
				instM[405] = 16'b0110_1111_0000_1111; //pipeline
				instM[406] = 16'b0110_1111_0000_1111; //pipeline
				instM[407] = 16'b0001_0010_0000_1111;
			//500 SUB 3 DATA 				   
				instM[500] = 16'b0000_1101_0000_0000;
				instM[501] = 16'b0000_1101_0001_0001;
				instM[502] = 16'b0000_1101_0010_0010;
				instM[503] = 16'b0110_1111_0000_1111; //pipeline
				instM[504] = 16'b0011_0000_0001_0011;
				instM[505] = 16'b0011_0011_0010_0100;
				instM[506] = 16'b0110_1111_0000_1111; //pipeline
				instM[507] = 16'b0110_1111_0000_1111; //pipeline
				instM[508] = 16'b0001_0100_0000_1111;
			//600 SUB 4 DATA -> 세원이형이 잘못만듬   
				instM[600] = 16'b0000_1101_0000_0000;
				instM[601] = 16'b0000_1101_0001_0001;
				instM[602] = 16'b0000_1101_0010_0010;
				instM[603] = 16'b0000_1101_0011_0011;
				instM[604] = 16'b0011_0000_0001_0100;
				instM[605] = 16'b0110_1111_0000_1111; //pipeline
				instM[606] = 16'b0011_0010_0011_0101;
				instM[607] = 16'b0011_0100_0101_0110;
				instM[608] = 16'b0110_1111_0000_1111; //pipeline
				instM[609] = 16'b0110_1111_0000_1111; //pipeline
				instM[610] = 16'b0001_0110_0000_1111;
			//700 MUL 2 DATA				   
				instM[700] = 16'b0000_1101_0000_0000;
				instM[701] = 16'b0000_1101_0001_0001;
				instM[702] = 16'b0110_1111_0000_1111; //pipeline
				instM[703] = 16'b0110_1111_0000_1111; //pipeline
				instM[704] = 16'b0100_0000_0001_0010;
				instM[705] = 16'b0110_1111_0000_1111; //pipeline
				instM[706] = 16'b0110_1111_0000_1111; //pipeline
				instM[707] = 16'b0001_0010_0000_1111;
			//800 MUL 3 DATA	   
				instM[800] = 16'b0000_1101_0000_0000;
				instM[801] = 16'b0000_1101_0001_0001;
				instM[802] = 16'b0000_1101_0010_0010;
				instM[803] = 16'b0110_1111_0000_1111; //pipeline
				instM[804] = 16'b0100_0000_0001_0011;
				instM[805] = 16'b0100_0010_0011_0100;
				instM[806] = 16'b0110_1111_0000_1111; //pipeline
				instM[807] = 16'b0110_1111_0000_1111; //pipeline
				instM[808] = 16'b0001_0100_0000_1111;
			//900 MUL 4 DATA
				instM[900] = 16'b0000_1101_0000_0000;
				instM[901] = 16'b0000_1101_0001_0001;
				instM[902] = 16'b0000_1101_0010_0010;
				instM[903] = 16'b0000_1101_0011_0011;
				instM[904] = 16'b0100_0000_0001_0100;
				instM[905] = 16'b0110_1111_0000_1111; //pipeline
				instM[906] = 16'b0100_0010_0011_0101;
				instM[907] = 16'b0100_0100_0101_0110;
				instM[908] = 16'b0110_1111_0000_1111; //pipeline
				instM[909] = 16'b0110_1111_0000_1111; //pipeline
				instM[910] = 16'b0001_0110_0000_1111;
			end

    assign M_instruction = instM[PCAdd_pc];

endmodule