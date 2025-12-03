module testbench();
  logic        clk, reset, memwrite;
  logic [31:0] pc, instr;
  logic [31:0] writedata, addr, readdata;
  logic [9:0] leds;
    
    top dut (
        .CLOCK_50(clk),
        .KEY({reset, 3'b111}),
        .LEDR(leds)
    )

  // initialize test
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars(0);
      reset <= 1; #15 reset <= 0;
      $monitor("%3t PC=%h instr=%h aluIn1=%h aluIn2=%h addr=%h writedata=%h memwrite=%b readdata=%h writeBackData=%h", $time, cpu.PC, cpu.instr, cpu.SrcA, cpu.SrcB, addr, writedata, memwrite, readdata, cpu.writeBackData);
      #12000 $writememh("riscv.out", ram.RAM);
      //$writememh("cpu_regs.out", cpu.RegisterBank);
      $finish;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    if (memwrite)
      if (writedata === 32'h6d73e55f) begin
        #50 $display("Simulation succeeded!");
        //$writememh("riscv.out", ram.RAM);
        $finish;
      end
endmodule