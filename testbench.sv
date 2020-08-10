// Code your testbench here
// or browse Examples

// testbench to add 2 numbers in a microprocessor
/*
module t_MIPS;
  reg clk1, clk2;
  integer k;
  
  MIPS32_pipe MUT(clk1, clk2);
  
  initial 
    begin
      clk1 = 0; clk2 = 0;
      repeat(20)
        begin
          #5 clk1 = 1; #5 clk1 = 0;
          #5 clk2 = 1; #5 clk2 = 0;
        end
    end
  
  initial 
    begin
      for(k=0; k<31; k = k+1)
        MUT.RegFile[k] = k;
      
      MUT.Memory[0] = 32'h2401_000a;	// ADDI R1,R0,10
      MUT.Memory[1] = 32'h2402_0014;	// ADDI R2,R0,20
      MUT.Memory[2] = 32'h2403_0019;	// ADDI R3,R0,30
      MUT.Memory[3] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[4] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[5] = 32'h0022_2000;	// ADD R4,R2,R1
      MUT.Memory[6] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[7] = 32'h0083_2800;	// ADD R5,R4,R3
      MUT.Memory[8] = 32'hfc00_0000;	// HLT
      
      MUT.HALTED = 0;
      MUT.TAKEN_BRANCH = 0;
      MUT.PC = 0;
      
      #280
      for(k=0; k<6; k = k+1)
        $display("R%1d - %2d", k, MUT.RegFile[k]);
    end
  
  initial
    begin
      $dumpfile("MIPS.vcd");
      $dumpvars(0,t_MIPS);
      #300 $finish;
    end
  
endmodule
*/

// testbench for factorial
/*
module t_MIPS;
  reg clk1, clk2;
  integer k;
  
  MIPS32_pipe MUT(clk1, clk2);
  
  initial 
    begin
      clk1 = 0; clk2 = 0;
      repeat(200)
        begin
          #5 clk1 = 1; #5 clk1 = 0;
          #5 clk2 = 1; #5 clk2 = 0;
        end
    end
  
  initial 
    begin
      
      MUT.Memory[0] = 32'h280a_00c8;	// ADDI R10,R0,200
      MUT.Memory[1] = 32'h2802_0001;	// ADDI R2,R0,1
      MUT.Memory[2] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[3] = 32'h2143_0000;	// LW R3,0(R10)
      MUT.Memory[4] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[5] = 32'h1443_1000;	// Loop: MUL R2,R2,R3
      MUT.Memory[6] = 32'h2c63_0001;	// SUBI R3,R3,1
      MUT.Memory[7] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[8] = 32'h3460_fffc;	// BNEQZ R3,Loop
      MUT.Memory[9] = 32'h2542_fffe;	// SW R2,-2(R10)
      MUT.Memory[10] = 32'hfc00_0000;	// HLT
      
      MUT.Memory[200] = 6;	// Put the number of which you want to find factorial 
      MUT.HALTED = 0;
      MUT.TAKEN_BRANCH = 0;
      MUT.PC = 0;
      
      #2000
      $display("Mem[200] = %2d, Mem[198] = %6d", MUT.Memory[200], MUT.Memory[198]);
    end
  
  initial
    begin
      $dumpfile("MIPS.vcd");
      $dumpvars(0,t_MIPS);
      $monitor("R2: %4d, R3: %1d", MUT.RegFile[2], MUT.RegFile[3]);
      #3000 $finish;
    end
  
endmodule
*/

// testbench to find nth Fibonacci number
module t_MIPS;
  reg clk1, clk2;
  integer k;
  
  MIPS32_pipe MUT(clk1, clk2);
  
  initial 
    begin
      clk1 = 0; clk2 = 0;
      repeat(200)
        begin
          #5 clk1 = 1; #5 clk1 = 0;
          #5 clk2 = 1; #5 clk2 = 0;
        end
    end
  
  initial 
    begin
      
      MUT.Memory[0] = 32'h2809_00c8;	// ADDI R9,R0,200
      MUT.Memory[1] = 32'h0000_0800;	// ADD R1,R0,R0
      MUT.Memory[2] = 32'h2802_0001;	// ADDI R2,R0,1
      MUT.Memory[3] = 32'h212a_0000;	// LW R10,0(R9)
      MUT.Memory[4] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[5] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[6] = 32'h2d4a_0002;	// SUBI R10,R10,2
      MUT.Memory[7] = 32'h0022_1800;	// Loop: ADD R3,R1,R2
      MUT.Memory[8] = 32'h0040_0800;	// ADD R1,R2,R0
      MUT.Memory[9] = 32'h0060_1000;	// ADD R2,R3,R0
      MUT.Memory[10] = 32'h2d4a_0001;	// SUBI R10,R10,1
      MUT.Memory[11] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[12] = 32'h0ce7_7800;	// OR R7,R7,R7 - Dummy Inst
      MUT.Memory[13] = 32'h3540_fff9;	// BNEQZ R10,Loop(-7)
      MUT.Memory[14] = 32'h2523_fffe;	// SW R3,-2(R9)
      MUT.Memory[15] = 32'hfc00_0000;	// HLT
      
      MUT.Memory[200] = 10;	// Put the n value  
      MUT.HALTED = 0;
      MUT.TAKEN_BRANCH = 0;
      MUT.PC = 0;
      
      #2000
      $display("Mem[200] = %2d, Mem[198] = %6d", MUT.Memory[200], MUT.Memory[198]);
    end
  
  initial
    begin
      $dumpfile("MIPS.vcd");
      $dumpvars(0,t_MIPS);
      $monitor("R1: %2d, R2: %2d, R3: %2d, R10: %2d", MUT.RegFile[1], MUT.RegFile[2], MUT.RegFile[3], MUT.RegFile[10]);
      #3000 $finish;
    end
  
endmodule