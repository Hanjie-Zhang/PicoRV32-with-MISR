`timescale 1 ns / 1 ps

// Minimal PicoRV32 testbench with bit-flip injector
// Ports and memory behavior follow the reference testbench you provided.

module tb_picorv32_inject;
    // clock / reset
    reg clk = 1;
    reg resetn = 0;
    wire trap;

    always #5 clk = ~clk; // 10 ns period

    // dump vcd if requested via +vcd
    initial begin
        if ($test$plusargs("vcd")) begin
            $dumpfile("tb_picorv32_inject.vcd");
            $dumpvars(0, tb_picorv32_inject);
        end
        force uut.misr_en_q = 1'b0;
        /* Example reset timing: keep same as reference */
        repeat (100) @(posedge clk);
        resetn <= 1'b0;
        repeat (100) @(posedge clk);
        resetn <= 1'b1;
        release uut.misr_en_q;
        // continue until finish in other initial block
    end

    // ----- core <-> memory interface (match your reference) -----
    wire mem_valid;
    wire mem_instr;
    reg  mem_ready;
    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [3:0]  mem_wstrb;
    reg  [31:0] mem_rdata;

    // Instantiate picorv32 (port names match your reference)
    picorv32 uut (
        .clk       (clk),
        .resetn    (resetn),
        .trap      (trap),
        .mem_valid (mem_valid),
        .mem_instr (mem_instr),
        .mem_ready (mem_ready),
        .mem_addr  (mem_addr),
        .mem_wdata (mem_wdata),
        .mem_wstrb (mem_wstrb),
        .mem_rdata (mem_rdata)
    );

    // ----- memory array (256 words) ---
    reg [31:0] memory [0:1023]; 

    initial begin
        force uut.reg_sh = 5'b0;      
        force uut.instr_beq = 1'b0;   
        force uut.instr_bne = 1'b0;   
  
    end
    initial begin
  
        for (i = 0; i < 1024; i = i + 1) memory[i] = 32'h00000013; 
        memory[0] = 32'h00100093; // addi x1, x0, 1      
        memory[1] = 32'h40000137; // lui  x2, 0x40000     
        memory[2] = 32'h00112023; // sw   x1, 0(x2)       
        memory[3] = 32'h00a00193; // addi x3, x0, 10
        memory[4] = 32'h00140213; // addi x4, x0, 20
        memory[5] = 32'h004182b3; // add  x5, x3, x4
        memory[6] = 32'h00012023; // sw   x0, 0(x2)       
        memory[7] = 32'h0000006f; // loop: j loop
    end

    // integers at module scope
    integer i;
    integer word_index;

    // Simple memory initial contents (small program like your ref)
    //initial begin
        // initialize memory to a small program or NOPs
        // sample program similar to your reference:
       // memory[0] = 32'h3fc00093; // li x1,1020
        //memory[1] = 32'h0000a023; // sw x0,0(x1)
        //memory[2] = 32'h0000a103; // lw x2,0(x1)
        //memory[3] = 32'h00110113; // addi x2,x2,1
        //memory[4] = 32'h0020a023; // sw x2,0(x1)
        //memory[5] = 32'hff5ff06f; // j <loop>
        // rest fill with nop-like
        //for (i = 6; i < 256; i = i + 1) memory[i] = 32'h00000013;
    //end

    // ----- memory model: respond in 1 cycle (similar to reference) -----
    reg mem_pending;
    always @(posedge clk) begin
        if (!resetn) begin
            mem_ready <= 0;
            mem_rdata <= 32'h0;
            mem_pending <= 0;
        end else begin
            mem_ready <= 0;
            if (mem_valid && !mem_pending) begin
                // compute word index (byte addr -> word addr)
                word_index = mem_addr[9:2]; // supports addresses 0..1023
                if (word_index < 0) word_index = 0;
                if (word_index > 1023) word_index = 1023;

                // writes if wstrb asserted (byte enables)
                if (mem_wstrb[0]) memory[word_index][7:0]   <= mem_wdata[7:0];
                if (mem_wstrb[1]) memory[word_index][15:8]  <= mem_wdata[15:8];
                if (mem_wstrb[2]) memory[word_index][23:16] <= mem_wdata[23:16];
                if (mem_wstrb[3]) memory[word_index][31:24] <= mem_wdata[31:24];

                // supply read data (for both reads and write-back)
                mem_rdata <= memory[word_index];

                // pulse ready for one cycle
                mem_ready <= 1;
                mem_pending <= 1;
            end else begin
                mem_pending <= 0;
            end
        end
    end

    // log memory transactions (like reference)
    always @(posedge clk) begin
        if (mem_valid && mem_ready) begin
            if (mem_instr)
                $display("ifetch 0x%08x: 0x%08x", mem_addr, mem_rdata);
            else if (|mem_wstrb)
                $display("write  0x%08x: 0x%08x (wstrb=%b)", mem_addr, mem_wdata, mem_wstrb);
            else
                $display("read   0x%08x: 0x%08x", mem_addr, mem_rdata);
        end
    end

    // ----- Fault injector (bit-flip) -----
    // injector parameters (module scope)
    reg inj_enabled;
    reg [31:0] inj_period;
    reg [63:0] inj_rng;
    reg [31:0] cycle_cnt;
    integer inj_word;
    integer inj_bit;

    initial begin
        inj_enabled = 0;               // enable by default
        inj_period  = 1000;            // flip every 1000 cycles
        inj_rng     = 64'hDEADBEEF12345678;
        cycle_cnt   = 0;
    end

    // xorshift64 RNG
    task rng_next;
    begin
        inj_rng = inj_rng ^ (inj_rng << 13);
        inj_rng = inj_rng ^ (inj_rng >> 7);
        inj_rng = inj_rng ^ (inj_rng << 17);
    end
    endtask

    // injector flips bits synchronous to clock
    always @(posedge clk) begin
        if (!resetn) begin
            cycle_cnt <= 0;
        end else begin
            cycle_cnt <= cycle_cnt + 1;
            if (inj_enabled) begin
                if ((cycle_cnt % inj_period) == 0) begin
                    rng_next();
                    inj_word = inj_rng % 256;
                    inj_bit  = inj_rng[4:0] % 32;
                    // blocking assign to memory word (acceptable here)
                    memory[inj_word] = memory[inj_word] ^ (32'h1 << inj_bit);
                    $display("INJECT @ cycle %0d: word=%0d bit=%0d new=0x%08x",
                             cycle_cnt, inj_word, inj_bit, memory[inj_word]);
                end
            end
        end
    end

    // ----- Test control: stop condition and finish -----
    integer max_cycles;
    initial begin
        max_cycles = 200000;

        wait (resetn == 1);
        while (!trap && cycle_cnt < max_cycles) begin
            @(posedge clk);
        end
        if (trap) $display("CORE TRAP observed at cycle %0d", cycle_cnt);
        else $display("Reached max cycles (%0d).", max_cycles);
        $finish;
    end

initial begin

    $dumpfile("picorv32_misr_test.vcd"); 
    $dumpvars(0, tb_picorv32_inject);
end

    always @(posedge clk) begin
        if (!resetn) begin
            force uut.misr_en_q = 1'b0; 
        end else if (mem_valid && mem_ready && |mem_wstrb && mem_addr == 32'h40000000) begin
            if (mem_wdata === 32'h1) begin
                force uut.misr_en_q = 1'b1;
            end else begin
                force uut.misr_en_q = 1'b0;
            end
        end
    end
    integer k;
    reg alu_has_x;
 
    always @(uut.alu_out_q) begin
        alu_has_x = 0;
  
        for (k = 0; k < 32; k = k + 1) begin
            if (uut.alu_out_q[k] === 1'bx) begin
                alu_has_x = 1;
            end
        end
        if (alu_has_x) begin
            force uut.alu_out_q = 32'h00000000;
        end else begin
            release uut.alu_out_q;
        end
    end
endmodule

