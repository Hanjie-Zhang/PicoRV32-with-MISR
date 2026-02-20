/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : L-2016.03-SP1
// Date      : Sun Feb 15 23:35:00 2026
/////////////////////////////////////////////////////////////


module picorv32 ( clk, resetn, trap, mem_valid, mem_instr, mem_ready, mem_addr, 
        mem_wdata, mem_wstrb, mem_rdata, mem_la_read, mem_la_write, 
        mem_la_addr, mem_la_wdata, mem_la_wstrb, pcpi_valid, pcpi_insn, 
        pcpi_rs1, pcpi_rs2, pcpi_wr, pcpi_rd, pcpi_wait, pcpi_ready, irq, eoi, 
        trace_valid, trace_data );
  output [31:0] mem_addr;
  output [31:0] mem_wdata;
  output [3:0] mem_wstrb;
  input [31:0] mem_rdata;
  output [31:0] mem_la_addr;
  output [31:0] mem_la_wdata;
  output [3:0] mem_la_wstrb;
  output [31:0] pcpi_insn;
  output [31:0] pcpi_rs1;
  output [31:0] pcpi_rs2;
  input [31:0] pcpi_rd;
  input [31:0] irq;
  output [31:0] eoi;
  output [35:0] trace_data;
  input clk, resetn, mem_ready, pcpi_wr, pcpi_wait, pcpi_ready;
  output trap, mem_valid, mem_instr, mem_la_read, mem_la_write, pcpi_valid,
         trace_valid;
  wire   n8083, n8087, n8088, n8089, n8091, n8092, n8093, n8072, n8073, n8074,
         n8075, n8076, n8077, n8078, n8079, n8080, n8081, n8082, n8084, n8085,
         n8086, n8090, n8094, mem_do_rinst, mem_do_prefetch, mem_do_rdata,
         mem_do_wdata, N216, N217, N218, N219, N220, N221, N222, N223, N224,
         N225, N226, N227, N228, N229, N230, N231, instr_lui, instr_auipc,
         instr_jal, instr_jalr, instr_beq, instr_bne, instr_blt, instr_bge,
         instr_bltu, instr_bgeu, instr_lb, instr_lh, instr_lw, instr_lbu,
         instr_lhu, instr_sb, instr_sh, instr_sw, instr_addi, instr_slti,
         instr_sltiu, instr_xori, instr_ori, instr_andi, instr_slli,
         instr_srli, instr_srai, instr_add, instr_sub, instr_sll, instr_slt,
         instr_sltu, instr_xor, instr_srl, instr_sra, instr_or, instr_and,
         instr_rdcycle, instr_rdcycleh, instr_rdinstr, instr_rdinstrh,
         instr_fence, is_beq_bne_blt_bge_bltu_bgeu, is_lb_lh_lw_lbu_lhu,
         is_sb_sh_sw, is_alu_reg_imm, is_alu_reg_reg, N282, is_lui_auipc_jal,
         is_lui_auipc_jal_jalr_addi_add_sub, N284, is_slti_blt_slt, N285,
         is_sltiu_bltu_sltu, N286, is_lbu_lhu_lw, is_compare, decoder_trigger,
         decoder_pseudo_trigger, is_slli_srli_srai,
         is_jalr_addi_slti_sltiu_xori_ori_andi, is_sll_srl_sra, N375, N379,
         latched_store, latched_branch, latched_stalu, \cpuregs[1][31] ,
         \cpuregs[1][30] , \cpuregs[1][29] , \cpuregs[1][28] ,
         \cpuregs[1][27] , \cpuregs[1][26] , \cpuregs[1][25] ,
         \cpuregs[1][24] , \cpuregs[1][23] , \cpuregs[1][22] ,
         \cpuregs[1][21] , \cpuregs[1][20] , \cpuregs[1][19] ,
         \cpuregs[1][18] , \cpuregs[1][17] , \cpuregs[1][16] ,
         \cpuregs[1][15] , \cpuregs[1][14] , \cpuregs[1][13] ,
         \cpuregs[1][12] , \cpuregs[1][11] , \cpuregs[1][10] , \cpuregs[1][9] ,
         \cpuregs[1][8] , \cpuregs[1][7] , \cpuregs[1][6] , \cpuregs[1][5] ,
         \cpuregs[1][4] , \cpuregs[1][3] , \cpuregs[1][2] , \cpuregs[1][1] ,
         \cpuregs[1][0] , \cpuregs[2][31] , \cpuregs[2][30] , \cpuregs[2][29] ,
         \cpuregs[2][28] , \cpuregs[2][27] , \cpuregs[2][26] ,
         \cpuregs[2][25] , \cpuregs[2][24] , \cpuregs[2][23] ,
         \cpuregs[2][22] , \cpuregs[2][21] , \cpuregs[2][20] ,
         \cpuregs[2][19] , \cpuregs[2][18] , \cpuregs[2][17] ,
         \cpuregs[2][16] , \cpuregs[2][15] , \cpuregs[2][14] ,
         \cpuregs[2][13] , \cpuregs[2][12] , \cpuregs[2][11] ,
         \cpuregs[2][10] , \cpuregs[2][9] , \cpuregs[2][8] , \cpuregs[2][7] ,
         \cpuregs[2][6] , \cpuregs[2][5] , \cpuregs[2][4] , \cpuregs[2][3] ,
         \cpuregs[2][2] , \cpuregs[2][1] , \cpuregs[2][0] , \cpuregs[3][31] ,
         \cpuregs[3][30] , \cpuregs[3][29] , \cpuregs[3][28] ,
         \cpuregs[3][27] , \cpuregs[3][26] , \cpuregs[3][25] ,
         \cpuregs[3][24] , \cpuregs[3][23] , \cpuregs[3][22] ,
         \cpuregs[3][21] , \cpuregs[3][20] , \cpuregs[3][19] ,
         \cpuregs[3][18] , \cpuregs[3][17] , \cpuregs[3][16] ,
         \cpuregs[3][15] , \cpuregs[3][14] , \cpuregs[3][13] ,
         \cpuregs[3][12] , \cpuregs[3][11] , \cpuregs[3][10] , \cpuregs[3][9] ,
         \cpuregs[3][8] , \cpuregs[3][7] , \cpuregs[3][6] , \cpuregs[3][5] ,
         \cpuregs[3][4] , \cpuregs[3][3] , \cpuregs[3][2] , \cpuregs[3][1] ,
         \cpuregs[3][0] , \cpuregs[4][31] , \cpuregs[4][30] , \cpuregs[4][29] ,
         \cpuregs[4][28] , \cpuregs[4][27] , \cpuregs[4][26] ,
         \cpuregs[4][25] , \cpuregs[4][24] , \cpuregs[4][23] ,
         \cpuregs[4][22] , \cpuregs[4][21] , \cpuregs[4][20] ,
         \cpuregs[4][19] , \cpuregs[4][18] , \cpuregs[4][17] ,
         \cpuregs[4][16] , \cpuregs[4][15] , \cpuregs[4][14] ,
         \cpuregs[4][13] , \cpuregs[4][12] , \cpuregs[4][11] ,
         \cpuregs[4][10] , \cpuregs[4][9] , \cpuregs[4][8] , \cpuregs[4][7] ,
         \cpuregs[4][6] , \cpuregs[4][5] , \cpuregs[4][4] , \cpuregs[4][3] ,
         \cpuregs[4][2] , \cpuregs[4][1] , \cpuregs[4][0] , \cpuregs[5][31] ,
         \cpuregs[5][30] , \cpuregs[5][29] , \cpuregs[5][28] ,
         \cpuregs[5][27] , \cpuregs[5][26] , \cpuregs[5][25] ,
         \cpuregs[5][24] , \cpuregs[5][23] , \cpuregs[5][22] ,
         \cpuregs[5][21] , \cpuregs[5][20] , \cpuregs[5][19] ,
         \cpuregs[5][18] , \cpuregs[5][17] , \cpuregs[5][16] ,
         \cpuregs[5][15] , \cpuregs[5][14] , \cpuregs[5][13] ,
         \cpuregs[5][12] , \cpuregs[5][11] , \cpuregs[5][10] , \cpuregs[5][9] ,
         \cpuregs[5][8] , \cpuregs[5][7] , \cpuregs[5][6] , \cpuregs[5][5] ,
         \cpuregs[5][4] , \cpuregs[5][3] , \cpuregs[5][2] , \cpuregs[5][1] ,
         \cpuregs[5][0] , \cpuregs[6][31] , \cpuregs[6][30] , \cpuregs[6][29] ,
         \cpuregs[6][28] , \cpuregs[6][27] , \cpuregs[6][26] ,
         \cpuregs[6][25] , \cpuregs[6][24] , \cpuregs[6][23] ,
         \cpuregs[6][22] , \cpuregs[6][21] , \cpuregs[6][20] ,
         \cpuregs[6][19] , \cpuregs[6][18] , \cpuregs[6][17] ,
         \cpuregs[6][16] , \cpuregs[6][15] , \cpuregs[6][14] ,
         \cpuregs[6][13] , \cpuregs[6][12] , \cpuregs[6][11] ,
         \cpuregs[6][10] , \cpuregs[6][9] , \cpuregs[6][8] , \cpuregs[6][7] ,
         \cpuregs[6][6] , \cpuregs[6][5] , \cpuregs[6][4] , \cpuregs[6][3] ,
         \cpuregs[6][2] , \cpuregs[6][1] , \cpuregs[6][0] , \cpuregs[7][31] ,
         \cpuregs[7][30] , \cpuregs[7][29] , \cpuregs[7][28] ,
         \cpuregs[7][27] , \cpuregs[7][26] , \cpuregs[7][25] ,
         \cpuregs[7][24] , \cpuregs[7][23] , \cpuregs[7][22] ,
         \cpuregs[7][21] , \cpuregs[7][20] , \cpuregs[7][19] ,
         \cpuregs[7][18] , \cpuregs[7][17] , \cpuregs[7][16] ,
         \cpuregs[7][15] , \cpuregs[7][14] , \cpuregs[7][13] ,
         \cpuregs[7][12] , \cpuregs[7][11] , \cpuregs[7][10] , \cpuregs[7][9] ,
         \cpuregs[7][8] , \cpuregs[7][7] , \cpuregs[7][6] , \cpuregs[7][5] ,
         \cpuregs[7][4] , \cpuregs[7][3] , \cpuregs[7][2] , \cpuregs[7][1] ,
         \cpuregs[7][0] , \cpuregs[8][31] , \cpuregs[8][30] , \cpuregs[8][29] ,
         \cpuregs[8][28] , \cpuregs[8][27] , \cpuregs[8][26] ,
         \cpuregs[8][25] , \cpuregs[8][24] , \cpuregs[8][23] ,
         \cpuregs[8][22] , \cpuregs[8][21] , \cpuregs[8][20] ,
         \cpuregs[8][19] , \cpuregs[8][18] , \cpuregs[8][17] ,
         \cpuregs[8][16] , \cpuregs[8][15] , \cpuregs[8][14] ,
         \cpuregs[8][13] , \cpuregs[8][12] , \cpuregs[8][11] ,
         \cpuregs[8][10] , \cpuregs[8][9] , \cpuregs[8][8] , \cpuregs[8][7] ,
         \cpuregs[8][6] , \cpuregs[8][5] , \cpuregs[8][4] , \cpuregs[8][3] ,
         \cpuregs[8][2] , \cpuregs[8][1] , \cpuregs[8][0] , \cpuregs[9][31] ,
         \cpuregs[9][30] , \cpuregs[9][29] , \cpuregs[9][28] ,
         \cpuregs[9][27] , \cpuregs[9][26] , \cpuregs[9][25] ,
         \cpuregs[9][24] , \cpuregs[9][23] , \cpuregs[9][22] ,
         \cpuregs[9][21] , \cpuregs[9][20] , \cpuregs[9][19] ,
         \cpuregs[9][18] , \cpuregs[9][17] , \cpuregs[9][16] ,
         \cpuregs[9][15] , \cpuregs[9][14] , \cpuregs[9][13] ,
         \cpuregs[9][12] , \cpuregs[9][11] , \cpuregs[9][10] , \cpuregs[9][9] ,
         \cpuregs[9][8] , \cpuregs[9][7] , \cpuregs[9][6] , \cpuregs[9][5] ,
         \cpuregs[9][4] , \cpuregs[9][3] , \cpuregs[9][2] , \cpuregs[9][1] ,
         \cpuregs[9][0] , \cpuregs[10][31] , \cpuregs[10][30] ,
         \cpuregs[10][29] , \cpuregs[10][28] , \cpuregs[10][27] ,
         \cpuregs[10][26] , \cpuregs[10][25] , \cpuregs[10][24] ,
         \cpuregs[10][23] , \cpuregs[10][22] , \cpuregs[10][21] ,
         \cpuregs[10][20] , \cpuregs[10][19] , \cpuregs[10][18] ,
         \cpuregs[10][17] , \cpuregs[10][16] , \cpuregs[10][15] ,
         \cpuregs[10][14] , \cpuregs[10][13] , \cpuregs[10][12] ,
         \cpuregs[10][11] , \cpuregs[10][10] , \cpuregs[10][9] ,
         \cpuregs[10][8] , \cpuregs[10][7] , \cpuregs[10][6] ,
         \cpuregs[10][5] , \cpuregs[10][4] , \cpuregs[10][3] ,
         \cpuregs[10][2] , \cpuregs[10][1] , \cpuregs[10][0] ,
         \cpuregs[11][31] , \cpuregs[11][30] , \cpuregs[11][29] ,
         \cpuregs[11][28] , \cpuregs[11][27] , \cpuregs[11][26] ,
         \cpuregs[11][25] , \cpuregs[11][24] , \cpuregs[11][23] ,
         \cpuregs[11][22] , \cpuregs[11][21] , \cpuregs[11][20] ,
         \cpuregs[11][19] , \cpuregs[11][18] , \cpuregs[11][17] ,
         \cpuregs[11][16] , \cpuregs[11][15] , \cpuregs[11][14] ,
         \cpuregs[11][13] , \cpuregs[11][12] , \cpuregs[11][11] ,
         \cpuregs[11][10] , \cpuregs[11][9] , \cpuregs[11][8] ,
         \cpuregs[11][7] , \cpuregs[11][6] , \cpuregs[11][5] ,
         \cpuregs[11][4] , \cpuregs[11][3] , \cpuregs[11][2] ,
         \cpuregs[11][1] , \cpuregs[11][0] , \cpuregs[12][31] ,
         \cpuregs[12][30] , \cpuregs[12][29] , \cpuregs[12][28] ,
         \cpuregs[12][27] , \cpuregs[12][26] , \cpuregs[12][25] ,
         \cpuregs[12][24] , \cpuregs[12][23] , \cpuregs[12][22] ,
         \cpuregs[12][21] , \cpuregs[12][20] , \cpuregs[12][19] ,
         \cpuregs[12][18] , \cpuregs[12][17] , \cpuregs[12][16] ,
         \cpuregs[12][15] , \cpuregs[12][14] , \cpuregs[12][13] ,
         \cpuregs[12][12] , \cpuregs[12][11] , \cpuregs[12][10] ,
         \cpuregs[12][9] , \cpuregs[12][8] , \cpuregs[12][7] ,
         \cpuregs[12][6] , \cpuregs[12][5] , \cpuregs[12][4] ,
         \cpuregs[12][3] , \cpuregs[12][2] , \cpuregs[12][1] ,
         \cpuregs[12][0] , \cpuregs[13][31] , \cpuregs[13][30] ,
         \cpuregs[13][29] , \cpuregs[13][28] , \cpuregs[13][27] ,
         \cpuregs[13][26] , \cpuregs[13][25] , \cpuregs[13][24] ,
         \cpuregs[13][23] , \cpuregs[13][22] , \cpuregs[13][21] ,
         \cpuregs[13][20] , \cpuregs[13][19] , \cpuregs[13][18] ,
         \cpuregs[13][17] , \cpuregs[13][16] , \cpuregs[13][15] ,
         \cpuregs[13][14] , \cpuregs[13][13] , \cpuregs[13][12] ,
         \cpuregs[13][11] , \cpuregs[13][10] , \cpuregs[13][9] ,
         \cpuregs[13][8] , \cpuregs[13][7] , \cpuregs[13][6] ,
         \cpuregs[13][5] , \cpuregs[13][4] , \cpuregs[13][3] ,
         \cpuregs[13][2] , \cpuregs[13][1] , \cpuregs[13][0] ,
         \cpuregs[14][31] , \cpuregs[14][30] , \cpuregs[14][29] ,
         \cpuregs[14][28] , \cpuregs[14][27] , \cpuregs[14][26] ,
         \cpuregs[14][25] , \cpuregs[14][24] , \cpuregs[14][23] ,
         \cpuregs[14][22] , \cpuregs[14][21] , \cpuregs[14][20] ,
         \cpuregs[14][19] , \cpuregs[14][18] , \cpuregs[14][17] ,
         \cpuregs[14][16] , \cpuregs[14][15] , \cpuregs[14][14] ,
         \cpuregs[14][13] , \cpuregs[14][12] , \cpuregs[14][11] ,
         \cpuregs[14][10] , \cpuregs[14][9] , \cpuregs[14][8] ,
         \cpuregs[14][7] , \cpuregs[14][6] , \cpuregs[14][5] ,
         \cpuregs[14][4] , \cpuregs[14][3] , \cpuregs[14][2] ,
         \cpuregs[14][1] , \cpuregs[14][0] , \cpuregs[15][31] ,
         \cpuregs[15][30] , \cpuregs[15][29] , \cpuregs[15][28] ,
         \cpuregs[15][27] , \cpuregs[15][26] , \cpuregs[15][25] ,
         \cpuregs[15][24] , \cpuregs[15][23] , \cpuregs[15][22] ,
         \cpuregs[15][21] , \cpuregs[15][20] , \cpuregs[15][19] ,
         \cpuregs[15][18] , \cpuregs[15][17] , \cpuregs[15][16] ,
         \cpuregs[15][15] , \cpuregs[15][14] , \cpuregs[15][13] ,
         \cpuregs[15][12] , \cpuregs[15][11] , \cpuregs[15][10] ,
         \cpuregs[15][9] , \cpuregs[15][8] , \cpuregs[15][7] ,
         \cpuregs[15][6] , \cpuregs[15][5] , \cpuregs[15][4] ,
         \cpuregs[15][3] , \cpuregs[15][2] , \cpuregs[15][1] ,
         \cpuregs[15][0] , \cpuregs[16][31] , \cpuregs[16][30] ,
         \cpuregs[16][29] , \cpuregs[16][28] , \cpuregs[16][27] ,
         \cpuregs[16][26] , \cpuregs[16][25] , \cpuregs[16][24] ,
         \cpuregs[16][23] , \cpuregs[16][22] , \cpuregs[16][21] ,
         \cpuregs[16][20] , \cpuregs[16][19] , \cpuregs[16][18] ,
         \cpuregs[16][17] , \cpuregs[16][16] , \cpuregs[16][15] ,
         \cpuregs[16][14] , \cpuregs[16][13] , \cpuregs[16][12] ,
         \cpuregs[16][11] , \cpuregs[16][10] , \cpuregs[16][9] ,
         \cpuregs[16][8] , \cpuregs[16][7] , \cpuregs[16][6] ,
         \cpuregs[16][5] , \cpuregs[16][4] , \cpuregs[16][3] ,
         \cpuregs[16][2] , \cpuregs[16][1] , \cpuregs[16][0] ,
         \cpuregs[17][31] , \cpuregs[17][30] , \cpuregs[17][29] ,
         \cpuregs[17][28] , \cpuregs[17][27] , \cpuregs[17][26] ,
         \cpuregs[17][25] , \cpuregs[17][24] , \cpuregs[17][23] ,
         \cpuregs[17][22] , \cpuregs[17][21] , \cpuregs[17][20] ,
         \cpuregs[17][19] , \cpuregs[17][18] , \cpuregs[17][17] ,
         \cpuregs[17][16] , \cpuregs[17][15] , \cpuregs[17][14] ,
         \cpuregs[17][13] , \cpuregs[17][12] , \cpuregs[17][11] ,
         \cpuregs[17][10] , \cpuregs[17][9] , \cpuregs[17][8] ,
         \cpuregs[17][7] , \cpuregs[17][6] , \cpuregs[17][5] ,
         \cpuregs[17][4] , \cpuregs[17][3] , \cpuregs[17][2] ,
         \cpuregs[17][1] , \cpuregs[17][0] , \cpuregs[18][31] ,
         \cpuregs[18][30] , \cpuregs[18][29] , \cpuregs[18][28] ,
         \cpuregs[18][27] , \cpuregs[18][26] , \cpuregs[18][25] ,
         \cpuregs[18][24] , \cpuregs[18][23] , \cpuregs[18][22] ,
         \cpuregs[18][21] , \cpuregs[18][20] , \cpuregs[18][19] ,
         \cpuregs[18][18] , \cpuregs[18][17] , \cpuregs[18][16] ,
         \cpuregs[18][15] , \cpuregs[18][14] , \cpuregs[18][13] ,
         \cpuregs[18][12] , \cpuregs[18][11] , \cpuregs[18][10] ,
         \cpuregs[18][9] , \cpuregs[18][8] , \cpuregs[18][7] ,
         \cpuregs[18][6] , \cpuregs[18][5] , \cpuregs[18][4] ,
         \cpuregs[18][3] , \cpuregs[18][2] , \cpuregs[18][1] ,
         \cpuregs[18][0] , \cpuregs[19][31] , \cpuregs[19][30] ,
         \cpuregs[19][29] , \cpuregs[19][28] , \cpuregs[19][27] ,
         \cpuregs[19][26] , \cpuregs[19][25] , \cpuregs[19][24] ,
         \cpuregs[19][23] , \cpuregs[19][22] , \cpuregs[19][21] ,
         \cpuregs[19][20] , \cpuregs[19][19] , \cpuregs[19][18] ,
         \cpuregs[19][17] , \cpuregs[19][16] , \cpuregs[19][15] ,
         \cpuregs[19][14] , \cpuregs[19][13] , \cpuregs[19][12] ,
         \cpuregs[19][11] , \cpuregs[19][10] , \cpuregs[19][9] ,
         \cpuregs[19][8] , \cpuregs[19][7] , \cpuregs[19][6] ,
         \cpuregs[19][5] , \cpuregs[19][4] , \cpuregs[19][3] ,
         \cpuregs[19][2] , \cpuregs[19][1] , \cpuregs[19][0] ,
         \cpuregs[20][31] , \cpuregs[20][30] , \cpuregs[20][29] ,
         \cpuregs[20][28] , \cpuregs[20][27] , \cpuregs[20][26] ,
         \cpuregs[20][25] , \cpuregs[20][24] , \cpuregs[20][23] ,
         \cpuregs[20][22] , \cpuregs[20][21] , \cpuregs[20][20] ,
         \cpuregs[20][19] , \cpuregs[20][18] , \cpuregs[20][17] ,
         \cpuregs[20][16] , \cpuregs[20][15] , \cpuregs[20][14] ,
         \cpuregs[20][13] , \cpuregs[20][12] , \cpuregs[20][11] ,
         \cpuregs[20][10] , \cpuregs[20][9] , \cpuregs[20][8] ,
         \cpuregs[20][7] , \cpuregs[20][6] , \cpuregs[20][5] ,
         \cpuregs[20][4] , \cpuregs[20][3] , \cpuregs[20][2] ,
         \cpuregs[20][1] , \cpuregs[20][0] , \cpuregs[21][31] ,
         \cpuregs[21][30] , \cpuregs[21][29] , \cpuregs[21][28] ,
         \cpuregs[21][27] , \cpuregs[21][26] , \cpuregs[21][25] ,
         \cpuregs[21][24] , \cpuregs[21][23] , \cpuregs[21][22] ,
         \cpuregs[21][21] , \cpuregs[21][20] , \cpuregs[21][19] ,
         \cpuregs[21][18] , \cpuregs[21][17] , \cpuregs[21][16] ,
         \cpuregs[21][15] , \cpuregs[21][14] , \cpuregs[21][13] ,
         \cpuregs[21][12] , \cpuregs[21][11] , \cpuregs[21][10] ,
         \cpuregs[21][9] , \cpuregs[21][8] , \cpuregs[21][7] ,
         \cpuregs[21][6] , \cpuregs[21][5] , \cpuregs[21][4] ,
         \cpuregs[21][3] , \cpuregs[21][2] , \cpuregs[21][1] ,
         \cpuregs[21][0] , \cpuregs[22][31] , \cpuregs[22][30] ,
         \cpuregs[22][29] , \cpuregs[22][28] , \cpuregs[22][27] ,
         \cpuregs[22][26] , \cpuregs[22][25] , \cpuregs[22][24] ,
         \cpuregs[22][23] , \cpuregs[22][22] , \cpuregs[22][21] ,
         \cpuregs[22][20] , \cpuregs[22][19] , \cpuregs[22][18] ,
         \cpuregs[22][17] , \cpuregs[22][16] , \cpuregs[22][15] ,
         \cpuregs[22][14] , \cpuregs[22][13] , \cpuregs[22][12] ,
         \cpuregs[22][11] , \cpuregs[22][10] , \cpuregs[22][9] ,
         \cpuregs[22][8] , \cpuregs[22][7] , \cpuregs[22][6] ,
         \cpuregs[22][5] , \cpuregs[22][4] , \cpuregs[22][3] ,
         \cpuregs[22][2] , \cpuregs[22][1] , \cpuregs[22][0] ,
         \cpuregs[23][31] , \cpuregs[23][30] , \cpuregs[23][29] ,
         \cpuregs[23][28] , \cpuregs[23][27] , \cpuregs[23][26] ,
         \cpuregs[23][25] , \cpuregs[23][24] , \cpuregs[23][23] ,
         \cpuregs[23][22] , \cpuregs[23][21] , \cpuregs[23][20] ,
         \cpuregs[23][19] , \cpuregs[23][18] , \cpuregs[23][17] ,
         \cpuregs[23][16] , \cpuregs[23][15] , \cpuregs[23][14] ,
         \cpuregs[23][13] , \cpuregs[23][12] , \cpuregs[23][11] ,
         \cpuregs[23][10] , \cpuregs[23][9] , \cpuregs[23][8] ,
         \cpuregs[23][7] , \cpuregs[23][6] , \cpuregs[23][5] ,
         \cpuregs[23][4] , \cpuregs[23][3] , \cpuregs[23][2] ,
         \cpuregs[23][1] , \cpuregs[23][0] , \cpuregs[24][31] ,
         \cpuregs[24][30] , \cpuregs[24][29] , \cpuregs[24][28] ,
         \cpuregs[24][27] , \cpuregs[24][26] , \cpuregs[24][25] ,
         \cpuregs[24][24] , \cpuregs[24][23] , \cpuregs[24][22] ,
         \cpuregs[24][21] , \cpuregs[24][20] , \cpuregs[24][19] ,
         \cpuregs[24][18] , \cpuregs[24][17] , \cpuregs[24][16] ,
         \cpuregs[24][15] , \cpuregs[24][14] , \cpuregs[24][13] ,
         \cpuregs[24][12] , \cpuregs[24][11] , \cpuregs[24][10] ,
         \cpuregs[24][9] , \cpuregs[24][8] , \cpuregs[24][7] ,
         \cpuregs[24][6] , \cpuregs[24][5] , \cpuregs[24][4] ,
         \cpuregs[24][3] , \cpuregs[24][2] , \cpuregs[24][1] ,
         \cpuregs[24][0] , \cpuregs[25][31] , \cpuregs[25][30] ,
         \cpuregs[25][29] , \cpuregs[25][28] , \cpuregs[25][27] ,
         \cpuregs[25][26] , \cpuregs[25][25] , \cpuregs[25][24] ,
         \cpuregs[25][23] , \cpuregs[25][22] , \cpuregs[25][21] ,
         \cpuregs[25][20] , \cpuregs[25][19] , \cpuregs[25][18] ,
         \cpuregs[25][17] , \cpuregs[25][16] , \cpuregs[25][15] ,
         \cpuregs[25][14] , \cpuregs[25][13] , \cpuregs[25][12] ,
         \cpuregs[25][11] , \cpuregs[25][10] , \cpuregs[25][9] ,
         \cpuregs[25][8] , \cpuregs[25][7] , \cpuregs[25][6] ,
         \cpuregs[25][5] , \cpuregs[25][4] , \cpuregs[25][3] ,
         \cpuregs[25][2] , \cpuregs[25][1] , \cpuregs[25][0] ,
         \cpuregs[26][31] , \cpuregs[26][30] , \cpuregs[26][29] ,
         \cpuregs[26][28] , \cpuregs[26][27] , \cpuregs[26][26] ,
         \cpuregs[26][25] , \cpuregs[26][24] , \cpuregs[26][23] ,
         \cpuregs[26][22] , \cpuregs[26][21] , \cpuregs[26][20] ,
         \cpuregs[26][19] , \cpuregs[26][18] , \cpuregs[26][17] ,
         \cpuregs[26][16] , \cpuregs[26][15] , \cpuregs[26][14] ,
         \cpuregs[26][13] , \cpuregs[26][12] , \cpuregs[26][11] ,
         \cpuregs[26][10] , \cpuregs[26][9] , \cpuregs[26][8] ,
         \cpuregs[26][7] , \cpuregs[26][6] , \cpuregs[26][5] ,
         \cpuregs[26][4] , \cpuregs[26][3] , \cpuregs[26][2] ,
         \cpuregs[26][1] , \cpuregs[26][0] , \cpuregs[27][31] ,
         \cpuregs[27][30] , \cpuregs[27][29] , \cpuregs[27][28] ,
         \cpuregs[27][27] , \cpuregs[27][26] , \cpuregs[27][25] ,
         \cpuregs[27][24] , \cpuregs[27][23] , \cpuregs[27][22] ,
         \cpuregs[27][21] , \cpuregs[27][20] , \cpuregs[27][19] ,
         \cpuregs[27][18] , \cpuregs[27][17] , \cpuregs[27][16] ,
         \cpuregs[27][15] , \cpuregs[27][14] , \cpuregs[27][13] ,
         \cpuregs[27][12] , \cpuregs[27][11] , \cpuregs[27][10] ,
         \cpuregs[27][9] , \cpuregs[27][8] , \cpuregs[27][7] ,
         \cpuregs[27][6] , \cpuregs[27][5] , \cpuregs[27][4] ,
         \cpuregs[27][3] , \cpuregs[27][2] , \cpuregs[27][1] ,
         \cpuregs[27][0] , \cpuregs[28][31] , \cpuregs[28][30] ,
         \cpuregs[28][29] , \cpuregs[28][28] , \cpuregs[28][27] ,
         \cpuregs[28][26] , \cpuregs[28][25] , \cpuregs[28][24] ,
         \cpuregs[28][23] , \cpuregs[28][22] , \cpuregs[28][21] ,
         \cpuregs[28][20] , \cpuregs[28][19] , \cpuregs[28][18] ,
         \cpuregs[28][17] , \cpuregs[28][16] , \cpuregs[28][15] ,
         \cpuregs[28][14] , \cpuregs[28][13] , \cpuregs[28][12] ,
         \cpuregs[28][11] , \cpuregs[28][10] , \cpuregs[28][9] ,
         \cpuregs[28][8] , \cpuregs[28][7] , \cpuregs[28][6] ,
         \cpuregs[28][5] , \cpuregs[28][4] , \cpuregs[28][3] ,
         \cpuregs[28][2] , \cpuregs[28][1] , \cpuregs[28][0] ,
         \cpuregs[29][31] , \cpuregs[29][30] , \cpuregs[29][29] ,
         \cpuregs[29][28] , \cpuregs[29][27] , \cpuregs[29][26] ,
         \cpuregs[29][25] , \cpuregs[29][24] , \cpuregs[29][23] ,
         \cpuregs[29][22] , \cpuregs[29][21] , \cpuregs[29][20] ,
         \cpuregs[29][19] , \cpuregs[29][18] , \cpuregs[29][17] ,
         \cpuregs[29][16] , \cpuregs[29][15] , \cpuregs[29][14] ,
         \cpuregs[29][13] , \cpuregs[29][12] , \cpuregs[29][11] ,
         \cpuregs[29][10] , \cpuregs[29][9] , \cpuregs[29][8] ,
         \cpuregs[29][7] , \cpuregs[29][6] , \cpuregs[29][5] ,
         \cpuregs[29][4] , \cpuregs[29][3] , \cpuregs[29][2] ,
         \cpuregs[29][1] , \cpuregs[29][0] , \cpuregs[30][31] ,
         \cpuregs[30][30] , \cpuregs[30][29] , \cpuregs[30][28] ,
         \cpuregs[30][27] , \cpuregs[30][26] , \cpuregs[30][25] ,
         \cpuregs[30][24] , \cpuregs[30][23] , \cpuregs[30][22] ,
         \cpuregs[30][21] , \cpuregs[30][20] , \cpuregs[30][19] ,
         \cpuregs[30][18] , \cpuregs[30][17] , \cpuregs[30][16] ,
         \cpuregs[30][15] , \cpuregs[30][14] , \cpuregs[30][13] ,
         \cpuregs[30][12] , \cpuregs[30][11] , \cpuregs[30][10] ,
         \cpuregs[30][9] , \cpuregs[30][8] , \cpuregs[30][7] ,
         \cpuregs[30][6] , \cpuregs[30][5] , \cpuregs[30][4] ,
         \cpuregs[30][3] , \cpuregs[30][2] , \cpuregs[30][1] ,
         \cpuregs[30][0] , \cpuregs[31][31] , \cpuregs[31][30] ,
         \cpuregs[31][29] , \cpuregs[31][28] , \cpuregs[31][27] ,
         \cpuregs[31][26] , \cpuregs[31][25] , \cpuregs[31][24] ,
         \cpuregs[31][23] , \cpuregs[31][22] , \cpuregs[31][21] ,
         \cpuregs[31][20] , \cpuregs[31][19] , \cpuregs[31][18] ,
         \cpuregs[31][17] , \cpuregs[31][16] , \cpuregs[31][15] ,
         \cpuregs[31][14] , \cpuregs[31][13] , \cpuregs[31][12] ,
         \cpuregs[31][11] , \cpuregs[31][10] , \cpuregs[31][9] ,
         \cpuregs[31][8] , \cpuregs[31][7] , \cpuregs[31][6] ,
         \cpuregs[31][5] , \cpuregs[31][4] , \cpuregs[31][3] ,
         \cpuregs[31][2] , \cpuregs[31][1] , \cpuregs[31][0] , N918, N919,
         N920, N921, N922, N923, N924, N925, N926, N927, N928, N929, N930,
         N931, N932, N933, N934, N935, N936, N937, N938, N939, N940, N941,
         N942, N943, N944, N945, N946, N947, N948, N949, N950, N951, N952,
         N953, N954, N955, N956, N957, N958, N959, N960, N961, N962, N963,
         N964, N965, N966, N967, N968, N969, N970, N971, N972, N973, N974,
         N975, N976, N977, N978, N979, N980, N981, N1599, N1600, latched_is_lu,
         latched_is_lh, latched_is_lb, N1906, N1907, N1908, N1909, N1910,
         N1911, N1912, N1913, N1914, N1915, N1916, N1917, N1918, N1919, N1920,
         N1921, N1922, N1923, N1924, N1925, N1926, N1927, N1928, N1929, N1930,
         N1931, N1932, N1933, N1934, N1935, N1936, N1937, N1938, N1939, N1940,
         N1941, N1942, N2097, N2106, N2107, n2511, n2512, n2513, n2514, n2515,
         n2516, n2517, n2518, n2519, n2520, n2521, n2522, n2523, n2524, n2525,
         n2526, n2527, n2528, n2529, n2530, n2531, n2532, n2533, n2534, n2535,
         n2536, n2537, n2538, n2539, n2540, n2541, n2542, n2543, n2545, n2546,
         n2547, n2548, n2549, n2550, n2551, n2552, n2553, n2554, n2555, n2556,
         n2557, n2558, n2559, n2560, n2561, n2562, n2563, n2564, n2565, n2566,
         n2567, n2568, n2569, n2570, n2571, n2572, n2573, n2574, n2575, n2576,
         n2577, n2578, n2579, n2580, n2581, n2582, n2583, n2584, n2585, n2586,
         n2587, n2588, n2589, n2590, n2591, n2592, n2593, n2594, n2595, n2596,
         n2597, n2598, n2599, n2600, n2601, n2602, n2603, n2604, n2605, n2606,
         n2607, n2608, n2609, n2610, n2611, n2612, n2613, n2614, n2615, n2616,
         n2617, n2618, n2619, n2620, n2621, n2622, n2623, n2624, n2625, n2626,
         n2627, n2628, n2629, n2630, n2631, n2632, n2633, n2634, n2635, n2636,
         n2637, n2638, n2639, n2640, n2641, n2642, n2643, n2644, n2645, n2646,
         n2647, n2648, n2649, n2650, n2651, n2652, n2653, n2654, n2655, n2656,
         n2657, n2658, n2659, n2660, n2661, n2662, n2663, n2664, n2665, n2666,
         n2667, n2668, n2669, n2670, n2671, n2672, n2673, n2674, n2675, n2676,
         n2677, n2678, n2679, n2680, n2681, n2682, n2683, n2684, n2685, n2686,
         n2687, n2688, n2689, n2690, n2691, n2692, n2693, n2694, n2695, n2696,
         n2697, n2698, n2699, n2700, n2701, n2702, n2703, n2704, n2705, n2706,
         n2707, n2708, n2709, n2710, n2711, n2712, n2713, n2714, n2715, n2716,
         n2717, n2718, n2719, n2720, n2721, n2722, n2723, n2724, n2725, n2726,
         n2727, n2728, n2729, n2730, n2731, n2732, n2733, n2734, n2735, n2736,
         n2737, n2738, n2739, n2740, n2741, n2742, n2743, n2744, n2745, n2746,
         n2747, n2748, n2749, n2750, n2751, n2752, n2753, n2754, n2755, n2756,
         n2757, n2758, n2759, n2760, n2761, n2762, n2763, n2764, n2765, n2766,
         n2767, n2768, n2769, n2770, n2771, n2772, n2773, n2774, n2775, n2776,
         n2777, n2778, n2779, n2780, n2781, n2782, n2783, n2784, n2785, n2786,
         n2787, n2788, n2789, n2790, n2791, n2792, n2793, n2794, n2795, n2796,
         n2797, n2798, n2799, n2800, n2801, n2802, n2803, n2804, n2805, n2806,
         n2807, n2808, n2809, n2810, n2811, n2812, n2813, n2814, n2815, n2816,
         n2817, n2818, n2819, n2820, n2821, n2822, n2823, n2824, n2825, n2826,
         n2827, n2828, n2829, n2830, n2831, n2832, n2833, n2834, n2835, n2836,
         n2837, n2838, n2839, n2840, n2841, n2842, n2843, n2844, n2845, n2846,
         n2847, n2848, n2849, n2850, n2851, n2852, n2853, n2854, n2855, n2856,
         n2857, n2858, n2859, n2860, n2861, n2862, n2863, n2864, n2865, n2866,
         n2867, n2868, n2869, n2870, n2871, n2872, n2873, n2874, n2875, n2876,
         n2877, n2878, n2879, n2880, n2881, n2882, n2883, n2884, n2885, n2886,
         n2887, n2888, n2889, n2890, n2891, n2892, n2893, n2894, n2895, n2896,
         n2897, n2898, n2899, n2900, n2901, n2902, n2903, n2904, n2905, n2906,
         n2907, n2908, n2909, n2910, n2911, n2912, n2913, n2914, n2915, n2916,
         n2917, n2918, n2919, n2920, n2921, n2922, n2923, n2924, n2925, n2926,
         n2927, n2928, n2929, n2930, n2931, n2932, n2933, n2934, n2935, n2936,
         n2937, n2938, n2939, n2940, n2941, n2942, n2943, n2944, n2945, n2946,
         n2947, n2948, n2949, n2950, n2951, n2952, n2953, n2954, n2955, n2956,
         n2957, n2958, n2959, n2960, n2961, n2962, n2963, n2964, n2965, n2966,
         n2967, n2968, n2969, n2970, n2971, n2972, n2973, n2974, n2975, n2976,
         n2977, n2978, n2979, n2980, n2981, n2982, n2983, n2984, n2985, n2986,
         n2987, n2988, n2989, n2990, n2991, n2992, n2993, n2994, n2995, n2996,
         n2997, n2998, n2999, n3000, n3001, n3002, n3003, n3004, n3005, n3006,
         n3007, n3008, n3009, n3010, n3011, n3012, n3013, n3014, n3015, n3016,
         n3017, n3018, n3019, n3020, n3021, n3022, n3023, n3024, n3025, n3026,
         n3027, n3028, n3029, n3030, n3031, n3032, n3033, n3034, n3035, n3036,
         n3037, n3038, n3039, n3040, n3041, n3042, n3043, n3044, n3045, n3046,
         n3047, n3048, n3049, n3050, n3051, n3052, n3053, n3054, n3055, n3056,
         n3057, n3058, n3059, n3060, n3061, n3062, n3063, n3064, n3065, n3066,
         n3067, n3068, n3069, n3070, n3071, n3072, n3073, n3074, n3075, n3076,
         n3077, n3078, n3079, n3080, n3081, n3082, n3083, n3084, n3085, n3086,
         n3087, n3088, n3089, n3090, n3091, n3092, n3093, n3094, n3095, n3096,
         n3097, n3098, n3099, n3100, n3101, n3102, n3103, n3104, n3105, n3106,
         n3107, n3108, n3109, n3110, n3111, n3112, n3113, n3114, n3115, n3116,
         n3117, n3118, n3119, n3120, n3121, n3122, n3123, n3124, n3125, n3126,
         n3127, n3128, n3129, n3130, n3131, n3132, n3133, n3134, n3135, n3136,
         n3137, n3138, n3139, n3140, n3141, n3142, n3143, n3144, n3145, n3146,
         n3147, n3148, n3149, n3150, n3151, n3152, n3153, n3154, n3155, n3156,
         n3157, n3158, n3159, n3160, n3161, n3162, n3163, n3164, n3165, n3166,
         n3167, n3168, n3169, n3170, n3171, n3172, n3173, n3174, n3175, n3176,
         n3177, n3178, n3179, n3180, n3181, n3182, n3183, n3184, n3185, n3186,
         n3187, n3188, n3189, n3190, n3191, n3192, n3193, n3194, n3195, n3196,
         n3197, n3198, n3199, n3200, n3201, n3202, n3203, n3204, n3205, n3206,
         n3207, n3208, n3209, n3210, n3211, n3212, n3213, n3214, n3215, n3216,
         n3217, n3218, n3219, n3220, n3221, n3222, n3223, n3224, n3225, n3226,
         n3227, n3228, n3229, n3230, n3231, n3232, n3233, n3234, n3235, n3236,
         n3237, n3238, n3239, n3240, n3241, n3242, n3243, n3244, n3245, n3246,
         n3247, n3248, n3249, n3250, n3251, n3252, n3253, n3254, n3255, n3256,
         n3257, n3258, n3259, n3260, n3261, n3262, n3263, n3264, n3265, n3266,
         n3267, n3268, n3269, n3270, n3271, n3272, n3273, n3274, n3275, n3276,
         n3277, n3278, n3279, n3280, n3281, n3282, n3283, n3284, n3285, n3286,
         n3287, n3288, n3289, n3290, n3291, n3292, n3293, n3294, n3295, n3296,
         n3297, n3298, n3299, n3300, n3301, n3302, n3303, n3304, n3305, n3306,
         n3307, n3308, n3309, n3310, n3311, n3312, n3313, n3314, n3315, n3316,
         n3317, n3318, n3319, n3320, n3321, n3322, n3323, n3324, n3325, n3326,
         n3327, n3328, n3329, n3330, n3331, n3332, n3333, n3334, n3335, n3336,
         n3337, n3338, n3339, n3340, n3341, n3342, n3343, n3344, n3345, n3346,
         n3347, n3348, n3349, n3350, n3351, n3352, n3353, n3354, n3355, n3356,
         n3357, n3358, n3359, n3360, n3361, n3362, n3363, n3364, n3365, n3366,
         n3367, n3368, n3369, n3370, n3371, n3372, n3373, n3374, n3375, n3376,
         n3377, n3378, n3379, n3380, n3381, n3382, n3383, n3384, n3385, n3386,
         n3387, n3388, n3389, n3390, n3391, n3392, n3393, n3394, n3395, n3396,
         n3397, n3398, n3399, n3400, n3401, n3402, n3403, n3404, n3405, n3406,
         n3407, n3408, n3409, n3410, n3411, n3412, n3413, n3414, n3415, n3416,
         n3417, n3418, n3419, n3420, n3421, n3422, n3423, n3424, n3425, n3426,
         n3427, n3428, n3429, n3430, n3431, n3432, n3433, n3434, n3435, n3436,
         n3437, n3438, n3439, n3440, n3441, n3442, n3443, n3444, n3445, n3446,
         n3447, n3448, n3449, n3450, n3451, n3452, n3453, n3454, n3455, n3456,
         n3457, n3458, n3459, n3460, n3461, n3462, n3463, n3464, n3465, n3466,
         n3467, n3468, n3469, n3470, n3471, n3472, n3473, n3474, n3475, n3476,
         n3477, n3478, n3479, n3480, n3481, n3482, n3483, n3484, n3485, n3486,
         n3487, n3488, n3489, n3490, n3491, n3492, n3493, n3494, n3495, n3496,
         n3497, n3498, n3499, n3500, n3501, n3502, n3503, n3504, n3505, n3506,
         n3507, n3508, n3509, n3510, n3511, n3512, n3513, n3514, n3515, n3516,
         n3517, n3518, n3519, n3520, n3521, n3522, n3523, n3524, n3525, n3526,
         n3527, n3528, n3529, n3530, n3531, n3532, n3533, n3534, n3535, n3536,
         n3537, n3538, n3539, n3540, n3541, n3542, n3543, n3544, n3545, n3546,
         n3547, n3548, n3549, n3550, n3551, n3552, n3553, n3554, n3555, n3556,
         n3557, n3558, n3559, n3560, n3561, n3562, n3563, n3564, n3565, n3566,
         n3567, n3568, n3569, n3570, n3571, n3572, n3573, n3574, n3575, n3576,
         n3577, n3578, n3579, n3580, n3581, n3582, n3583, n3584, n3585, n3586,
         n3587, n3588, n3589, n3590, n3591, n3592, n3593, n3594, n3595, n3596,
         n3597, n3598, n3599, n3600, n3601, n3602, n3603, n3604, n3605, n3606,
         n3607, n3608, n3609, n3610, n3611, n3612, n3613, n3614, n3615, n3616,
         n3617, n3618, n3619, n3620, n3621, n3622, n3623, n3624, n3625, n3626,
         n3627, n3628, n3629, n3630, n3631, n3632, n3633, n3634, n3635, n3636,
         n3637, n3638, n3639, n3640, n3641, n3642, n3643, n3644, n3645, n3646,
         n3647, n3648, n3649, n3650, n3651, n3652, n3653, n3654, n3655, n3656,
         n3657, n3658, n3659, n3660, n3661, n3662, n3663, n3664, n3665, n3666,
         n3667, n3668, n3669, n3670, n3671, n3672, n3673, n3674, n3675, n3676,
         n3677, n3678, n3679, n3680, n3681, n3682, n3683, n3684, n3687, n3688,
         n3689, n3690, n3691, n3692, n3693, n3694, n3695, n3696, n3697, n3698,
         n3699, n3700, n3701, n3702, n3703, n3704, n3706, n3707, n3708, n3709,
         n3710, n3711, n3712, n3713, n3714, n3715, n3716, n3717, n3718, n3719,
         n3720, n3721, n3722, n3723, n3724, n3725, n3726, n3727, n3728, n3729,
         n3730, n3731, n3732, n3733, n3734, n3735, n3736, n3737, n3738, n3739,
         n3740, n3741, n3742, n3743, n3744, n3745, n3746, n3747, n3748, n3749,
         n3750, n3751, n3752, n3753, n3754, n3755, n3756, n3757, n3758, n3759,
         n3760, n3761, n3762, n3763, n3764, n3765, n3766, n3767, n3768, n3769,
         n3770, n3771, n3772, n3773, n3774, n3775, n3776, n3777, n3778, n3779,
         n3780, n3781, n3782, n3783, n3784, n3785, n3786, n3787, n3788, n3789,
         n3790, n3791, n3792, n3793, n3794, n3795, n3796, n3798, n3799, n3800,
         n3801, n3802, n3803, n3804, n3805, n3806, n3807, n3808, n3809, n3810,
         n3811, n3812, n3813, n3814, n3815, n3816, n3817, n3818, n3819, n3820,
         n3821, n3822, n3823, n3824, n3825, n3826, n3827, n3828, n3830, n3831,
         n3832, n3833, n3834, n3835, n3836, n3837, n3838, n3839, n3840, n3841,
         n3842, n3843, n3844, n3845, n3846, n3847, n3848, n3849, n3850, n3851,
         n3852, n3853, n3854, n3855, n3856, n3857, n3858, n3859, n3860, n3861,
         n3862, n3863, n3864, n3865, n3866, n3867, n3868, n3869, n3870, n3871,
         n3872, n3873, n3874, n3875, n3876, n3877, n3878, n3879, n3880, n3881,
         n3882, n3883, n3884, n3885, n3886, n3887, n3888, n3889, n3890, n3891,
         n3892, n3893, n3894, n3895, n3896, n3897, n3898, n3900, n3901, n3902,
         n3903, n3904, n3905, n3906, n3907, n3908, n3909, n3910, n3911, n3912,
         n3913, n3914, n3915, n3916, n3917, n3918, n3919, n3920, n3921, n3922,
         n3923, n3924, n3925, n3926, n3927, n3928, n3929, n3930, n3931, n3932,
         n3935, n3936, n3937, n3938, n3939, n3940, n3941, n3942, n3943, n3944,
         n3945, n3946, n3947, n3948, n3949, n3950, n3951, n3952, n3953, n3954,
         n3955, n3956, n3957, n3958, n3959, n3960, n3961, n3962, n3963, n3964,
         n3965, n3966, n3967, n3968, n3969, n3970, n3971, n3972, n3973, n3974,
         n3975, n3976, n3977, n3978, net13612, net16302, net16303, net16308,
         net16317, net16327, net16329, net16330, net16336, net16337, net16338,
         net16339, net16340, net16341, net16345, net16348, net16349, net16357,
         net16359, net16360, net16361, net16362, net16363, net16364, net16365,
         net16367, net16372, net16448, net16449, net16451, net16452, net16453,
         net16466, net16467, net16468, net16540, net22659, net22708, net22737,
         net22738, net22739, net22947, net22948, net23007, net23069, net23071,
         net23072, net23329, net23610, net23636, net23637, net23989, net24034,
         net24127, net24129, net24197, net24198, net24444, net24496, net24498,
         net24543, net24545, net24598, net24605, net24864, net25183, net25574,
         net25636, net25657, net25698, net25729, net25784, net25813, net25842,
         net25850, net25875, net26030, net26058, net26085, net26087, net26114,
         net26141, net26169, net26211, net26243, net26273, net26329, net26359,
         net26388, net26417, net26445, net26475, net26526, net26558, net26587,
         net26624, net26648, net26650, net26760, net27408, net27439, net27467,
         net29419, net29439, net29438, net29472, net29471, net29607, net29606,
         net30049, net30048, net30310, net30309, net30307, net30386, net30391,
         net30390, net30389, net30424, net30423, net30422, net30497, net30496,
         net30495, net30494, net30554, net30560, net30578, net30596, net30598,
         net30609, net30608, net30625, net30656, net30659, net30668, net30690,
         net30702, net30713, net25787, net25786, net25637, net26390, net26389,
         net26195, net26194, net26167, net26166, net25845, net25844, net25816,
         net25815, net26276, net26275, net26588, net26560, net24504, net24503,
         net26477, net26476, net26419, net26418, net26214, net26213, net26060,
         net26059, net25700, net25699, net25576, net25575, net24449, net24447,
         net26447, net26446, net26331, net26330, net26116, net26115, net25731,
         net25730, net24201, net24199, net26528, net26361, net26360, net30680,
         net26559, net26527, net26246, net26245, net26110, net26109, net26054,
         net26053, net25873, net25872, net24609, net24608, net24547, net24546,
         net24135, net24133, n3981, n3982, n3983, n3984, n3985, n3987, n3988,
         n3989, n3990, n3991, n3992, n3993, n3994, n3995, n3996, n3997, n3998,
         n3999, n4000, n4001, n4002, n4003, n4004, n4005, n4006, n4007, n4008,
         n4009, n4011, n4012, n4013, n4014, n4015, n4016, n4017, n4020, n4021,
         n4022, n4023, n4024, n4025, n4026, n4027, n4028, n4029, n4030, n4031,
         n4032, n4034, n4035, n4036, n4037, n4038, n4039, n4040, n4041, n4042,
         n4043, n4044, n4045, n4046, n4047, n4049, n4050, n4051, n4052, n4053,
         n4054, n4055, n4056, n4057, n4058, n4059, n4060, n4061, n4062, n4063,
         n4064, n4065, n4066, n4067, n4068, n4069, n4070, n4071, n4072, n4073,
         n4074, n4075, n4076, n4077, n4078, n4079, n4080, n4081, n4082, n4083,
         n4084, n4085, n4086, n4087, n4088, n4089, n4090, n4091, n4092, n4093,
         n4094, n4095, n4096, n4097, n4098, n4099, n4100, n4101, n4102, n4103,
         n4104, n4105, n4106, n4107, n4108, n4109, n4110, n4111, n4112, n4113,
         n4114, n4115, n4116, n4121, n4122, n4123, n4124, n4125, n4126, n4128,
         n4129, n4130, n4131, n4132, n4133, n4134, n4135, n4136, n4137, n4138,
         n4139, n4140, n4141, n4142, n4143, n4144, n4145, n4146, n4147, n4148,
         n4149, n4150, n4151, n4152, n4153, n4154, n4155, n4156, n4157, n4158,
         n4159, n4160, n4161, n4162, n4163, n4164, n4165, n4166, n4167, n4168,
         n4169, n4170, n4171, n4172, n4173, n4174, n4175, n4176, n4177, n4178,
         n4179, n4180, n4181, n4182, n4183, n4184, n4185, n4186, n4187, n4188,
         n4192, n4193, n4194, n4195, n4196, n4197, n4198, n4199, n4200, n4201,
         n4202, n4203, n4204, n4205, n4206, n4207, n4208, n4209, n4212, n4213,
         n4214, n4215, n4216, n4217, n4218, n4219, n4220, n4221, n4222, n4223,
         n4224, n4225, n4226, n4227, n4228, n4229, n4230, n4231, n4232, n4233,
         n4234, n4235, n4236, n4237, n4238, n4240, n4241, n4242, n4243, n4244,
         n4245, n4246, n4247, n4248, n4249, n4250, n4251, n4252, n4253, n4254,
         n4255, n4256, n4257, n4258, n4259, n4260, n4261, n4262, n4263, n4264,
         n4265, n4266, n4267, n4268, n4269, n4270, n4271, n4272, n4273, n4274,
         n4275, n4276, n4277, n4278, n4279, n4280, n4281, n4282, n4283, n4284,
         n4285, n4286, n4287, n4288, n4289, n4290, n4291, n4292, n4293, n4294,
         n4295, n4296, n4297, n4298, n4299, n4300, n4301, n4302, n4303, n4304,
         n4305, n4306, n4307, n4308, n4309, n4310, n4311, n4312, n4313, n4314,
         n4315, n4316, n4317, n4318, n4319, n4320, n4321, n4322, n4323, n4324,
         n4325, n4326, n4327, n4328, n4329, n4330, n4331, n4332, n4333, n4334,
         n4335, n4336, n4337, n4338, n4339, n4340, n4341, n4342, n4343, n4344,
         n4345, n4346, n4347, n4348, n4349, n4350, n4351, n4352, n4353, n4354,
         n4355, n4356, n4357, n4358, n4359, n4360, n4361, n4362, n4363, n4364,
         n4365, n4366, n4367, n4368, n4369, n4370, n4371, n4372, n4373, n4374,
         n4375, n4376, n4377, n4378, n4379, n4380, n4381, n4382, n4383, n4384,
         n4385, n4386, n4387, n4388, n4389, n4390, n4391, n4392, n4393, n4394,
         n4395, n4396, n4397, n4398, n4399, n4400, n4401, n4402, n4403, n4404,
         n4405, n4406, n4407, n4408, n4409, n4410, n4411, n4412, n4413, n4414,
         n4415, n4416, n4417, n4418, n4419, n4420, n4421, n4422, n4423, n4424,
         n4425, n4426, n4427, n4428, n4429, n4430, n4431, n4432, n4433, n4434,
         n4435, n4436, n4437, n4438, n4439, n4440, n4441, n4442, n4443, n4444,
         n4445, n4446, n4447, n4448, n4449, n4450, n4451, n4452, n4453, n4454,
         n4455, n4456, n4457, n4458, n4459, n4460, n4461, n4462, n4463, n4464,
         n4465, n4466, n4467, n4468, n4469, n4470, n4471, n4472, n4473, n4474,
         n4475, n4476, n4477, n4478, n4479, n4480, n4481, n4482, n4483, n4484,
         n4485, n4486, n4487, n4488, n4489, n4490, n4491, n4492, n4493, n4494,
         n4495, n4496, n4497, n4498, n4499, n4500, n4501, n4502, n4503, n4504,
         n4505, n4506, n4507, n4508, n4509, n4510, n4511, n4512, n4513, n4514,
         n4515, n4516, n4517, n4518, n4519, n4520, n4521, n4522, n4523, n4524,
         n4525, n4526, n4527, n4528, n4529, n4530, n4531, n4532, n4533, n4534,
         n4535, n4536, n4537, n4538, n4539, n4540, n4541, n4542, n4543, n4544,
         n4545, n4546, n4547, n4548, n4549, n4550, n4551, n4552, n4553, n4554,
         n4555, n4556, n4557, n4558, n4559, n4560, n4561, n4562, n4563, n4564,
         n4565, n4566, n4567, n4568, n4569, n4570, n4571, n4572, n4573, n4574,
         n4575, n4576, n4577, n4578, n4579, n4580, n4581, n4582, n4583, n4584,
         n4585, n4586, n4587, n4588, n4589, n4590, n4591, n4592, n4593, n4594,
         n4595, n4596, n4597, n4598, n4599, n4600, n4601, n4602, n4603, n4604,
         n4605, n4606, n4607, n4608, n4609, n4610, n4611, n4612, n4613, n4614,
         n4615, n4616, n4617, n4618, n4619, n4620, n4621, n4622, n4623, n4624,
         n4625, n4626, n4627, n4628, n4629, n4630, n4631, n4632, n4633, n4634,
         n4635, n4636, n4637, n4638, n4639, n4640, n4641, n4642, n4643, n4644,
         n4645, n4646, n4647, n4648, n4649, n4650, n4651, n4652, n4653, n4654,
         n4655, n4656, n4657, n4658, n4659, n4660, n4661, n4662, n4663, n4664,
         n4665, n4666, n4667, n4668, n4669, n4670, n4671, n4672, n4673, n4674,
         n4675, n4676, n4677, n4678, n4679, n4680, n4681, n4682, n4683, n4684,
         n4685, n4686, n4687, n4688, n4689, n4690, n4691, n4692, n4693, n4694,
         n4695, n4696, n4697, n4698, n4699, n4700, n4701, n4702, n4703, n4704,
         n4705, n4706, n4707, n4708, n4709, n4710, n4711, n4712, n4713, n4714,
         n4715, n4716, n4717, n4718, n4719, n4720, n4721, n4722, n4723, n4724,
         n4725, n4726, n4727, n4728, n4729, n4730, n4731, n4732, n4733, n4734,
         n4735, n4736, n4737, n4738, n4739, n4740, n4741, n4742, n4743, n4744,
         n4745, n4746, n4747, n4748, n4749, n4750, n4751, n4752, n4753, n4754,
         n4755, n4756, n4757, n4758, n4759, n4760, n4761, n4762, n4763, n4764,
         n4765, n4766, n4767, n4768, n4769, n4770, n4771, n4772, n4773, n4774,
         n4775, n4776, n4777, n4778, n4779, n4780, n4781, n4782, n4783, n4784,
         n4785, n4786, n4787, n4788, n4789, n4790, n4791, n4792, n4793, n4794,
         n4795, n4796, n4797, n4798, n4799, n4800, n4801, n4802, n4803, n4804,
         n4805, n4806, n4807, n4808, n4809, n4810, n4811, n4812, n4813, n4814,
         n4815, n4816, n4817, n4818, n4819, n4820, n4821, n4822, n4823, n4824,
         n4825, n4826, n4827, n4828, n4829, n4830, n4831, n4832, n4833, n4834,
         n4835, n4836, n4837, n4838, n4839, n4840, n4841, n4842, n4843, n4844,
         n4845, n4846, n4847, n4848, n4849, n4850, n4851, n4852, n4853, n4854,
         n4855, n4856, n4857, n4858, n4859, n4860, n4861, n4862, n4863, n4864,
         n4865, n4866, n4867, n4868, n4869, n4870, n4871, n4872, n4873, n4874,
         n4875, n4876, n4877, n4878, n4879, n4880, n4881, n4882, n4883, n4884,
         n4885, n4886, n4887, n4888, n4889, n4890, n4891, n4892, n4893, n4894,
         n4895, n4896, n4897, n4898, n4899, n4900, n4901, n4902, n4903, n4904,
         n4905, n4906, n4907, n4908, n4909, n4910, n4911, n4912, n4913, n4914,
         n4915, n4916, n4917, n4918, n4919, n4920, n4921, n4922, n4923, n4924,
         n4925, n4926, n4927, n4928, n4929, n4930, n4931, n4932, n4933, n4934,
         n4935, n4936, n4937, n4938, n4939, n4940, n4941, n4942, n4943, n4944,
         n4945, n4946, n4947, n4948, n4949, n4950, n4951, n4952, n4953, n4954,
         n4955, n4956, n4957, n4958, n4959, n4960, n4961, n4962, n4963, n4964,
         n4965, n4966, n4967, n4968, n4969, n4970, n4971, n4972, n4973, n4974,
         n4975, n4976, n4977, n4978, n4979, n4980, n4981, n4982, n4983, n4984,
         n4985, n4986, n4987, n4988, n4989, n4990, n4991, n4992, n4993, n4994,
         n4995, n4996, n4997, n4998, n4999, n5000, n5001, n5002, n5003, n5004,
         n5005, n5006, n5007, n5008, n5009, n5010, n5011, n5012, n5013, n5014,
         n5015, n5016, n5017, n5018, n5019, n5020, n5021, n5022, n5023, n5024,
         n5025, n5026, n5027, n5028, n5029, n5030, n5031, n5032, n5033, n5034,
         n5035, n5036, n5037, n5038, n5039, n5040, n5041, n5042, n5043, n5044,
         n5045, n5046, n5047, n5048, n5049, n5050, n5051, n5052, n5053, n5054,
         n5055, n5056, n5057, n5058, n5059, n5060, n5061, n5062, n5063, n5064,
         n5065, n5066, n5067, n5068, n5069, n5070, n5071, n5072, n5073, n5074,
         n5075, n5076, n5077, n5078, n5079, n5080, n5081, n5082, n5083, n5084,
         n5085, n5086, n5087, n5088, n5089, n5090, n5091, n5092, n5093, n5094,
         n5095, n5096, n5097, n5098, n5099, n5100, n5101, n5102, n5103, n5104,
         n5105, n5106, n5107, n5108, n5109, n5110, n5111, n5112, n5113, n5114,
         n5115, n5116, n5117, n5118, n5119, n5120, n5121, n5122, n5123, n5124,
         n5125, n5126, n5127, n5128, n5129, n5130, n5131, n5132, n5133, n5134,
         n5135, n5136, n5137, n5138, n5139, n5140, n5141, n5142, n5143, n5144,
         n5145, n5146, n5147, n5148, n5149, n5150, n5151, n5152, n5153, n5154,
         n5155, n5156, n5157, n5158, n5159, n5160, n5161, n5162, n5163, n5164,
         n5165, n5166, n5167, n5168, n5169, n5170, n5171, n5172, n5173, n5174,
         n5175, n5176, n5177, n5178, n5179, n5180, n5181, n5182, n5183, n5184,
         n5185, n5186, n5187, n5188, n5189, n5190, n5191, n5192, n5193, n5194,
         n5195, n5196, n5197, n5198, n5199, n5200, n5201, n5202, n5203, n5204,
         n5205, n5206, n5207, n5208, n5209, n5210, n5211, n5212, n5213, n5214,
         n5215, n5216, n5217, n5218, n5219, n5220, n5221, n5222, n5223, n5224,
         n5225, n5226, n5227, n5228, n5229, n5230, n5231, n5232, n5233, n5234,
         n5235, n5236, n5237, n5238, n5239, n5240, n5241, n5242, n5243, n5244,
         n5245, n5246, n5247, n5248, n5249, n5250, n5251, n5252, n5253, n5254,
         n5255, n5256, n5257, n5258, n5259, n5260, n5261, n5262, n5263, n5264,
         n5265, n5266, n5267, n5268, n5269, n5270, n5271, n5272, n5273, n5274,
         n5275, n5276, n5277, n5278, n5279, n5280, n5281, n5282, n5283, n5284,
         n5285, n5286, n5287, n5288, n5289, n5290, n5291, n5292, n5293, n5294,
         n5295, n5296, n5297, n5298, n5299, n5300, n5301, n5302, n5303, n5304,
         n5305, n5306, n5307, n5308, n5309, n5310, n5311, n5312, n5313, n5314,
         n5315, n5316, n5317, n5318, n5319, n5320, n5321, n5322, n5323, n5324,
         n5325, n5326, n5327, n5328, n5329, n5330, n5331, n5332, n5333, n5334,
         n5335, n5336, n5337, n5338, n5339, n5340, n5341, n5342, n5343, n5344,
         n5345, n5346, n5347, n5348, n5349, n5350, n5351, n5352, n5353, n5354,
         n5355, n5356, n5357, n5358, n5359, n5360, n5361, n5362, n5363, n5364,
         n5365, n5366, n5367, n5368, n5369, n5370, n5371, n5372, n5373, n5374,
         n5375, n5376, n5377, n5378, n5379, n5380, n5381, n5382, n5383, n5384,
         n5385, n5386, n5387, n5388, n5389, n5390, n5391, n5392, n5393, n5394,
         n5395, n5396, n5397, n5398, n5399, n5400, n5401, n5402, n5403, n5404,
         n5405, n5406, n5407, n5408, n5409, n5410, n5411, n5412, n5413, n5414,
         n5415, n5416, n5417, n5418, n5419, n5420, n5421, n5422, n5423, n5424,
         n5425, n5426, n5427, n5428, n5429, n5430, n5431, n5432, n5433, n5434,
         n5435, n5436, n5437, n5438, n5439, n5440, n5441, n5442, n5443, n5444,
         n5445, n5446, n5447, n5448, n5449, n5450, n5451, n5452, n5453, n5454,
         n5455, n5456, n5457, n5458, n5459, n5460, n5461, n5462, n5463, n5464,
         n5465, n5466, n5467, n5468, n5469, n5470, n5471, n5472, n5473, n5474,
         n5475, n5476, n5477, n5478, n5479, n5480, n5481, n5482, n5483, n5484,
         n5485, n5486, n5487, n5488, n5489, n5490, n5491, n5492, n5493, n5494,
         n5495, n5496, n5497, n5498, n5499, n5500, n5501, n5502, n5503, n5504,
         n5505, n5506, n5507, n5508, n5509, n5510, n5511, n5512, n5513, n5514,
         n5515, n5516, n5517, n5518, n5519, n5520, n5521, n5522, n5523, n5524,
         n5525, n5526, n5527, n5528, n5529, n5530, n5531, n5532, n5533, n5534,
         n5535, n5536, n5537, n5538, n5539, n5540, n5541, n5542, n5543, n5544,
         n5545, n5546, n5547, n5548, n5549, n5550, n5551, n5552, n5553, n5554,
         n5555, n5556, n5557, n5558, n5559, n5560, n5561, n5562, n5563, n5564,
         n5565, n5566, n5567, n5568, n5569, n5570, n5571, n5572, n5573, n5574,
         n5575, n5576, n5577, n5578, n5579, n5580, n5581, n5582, n5583, n5584,
         n5585, n5586, n5587, n5588, n5589, n5590, n5591, n5592, n5593, n5594,
         n5595, n5596, n5597, n5598, n5599, n5600, n5601, n5602, n5603, n5604,
         n5605, n5606, n5607, n5608, n5609, n5610, n5611, n5612, n5613, n5614,
         n5615, n5616, n5617, n5618, n5619, n5620, n5621, n5622, n5623, n5624,
         n5625, n5626, n5627, n5628, n5629, n5630, n5631, n5632, n5633, n5634,
         n5635, n5636, n5637, n5638, n5639, n5640, n5641, n5642, n5643, n5644,
         n5645, n5646, n5647, n5648, n5649, n5650, n5651, n5652, n5653, n5654,
         n5655, n5656, n5657, n5658, n5659, n5660, n5661, n5662, n5663, n5664,
         n5665, n5666, n5667, n5668, n5669, n5670, n5671, n5672, n5673, n5674,
         n5675, n5676, n5677, n5678, n5679, n5680, n5681, n5682, n5683, n5684,
         n5685, n5686, n5687, n5688, n5689, n5690, n5691, n5692, n5693, n5694,
         n5695, n5696, n5697, n5698, n5699, n5700, n5701, n5702, n5703, n5704,
         n5705, n5706, n5707, n5708, n5709, n5710, n5711, n5712, n5713, n5714,
         n5715, n5716, n5717, n5718, n5719, n5720, n5721, n5722, n5723, n5724,
         n5725, n5726, n5727, n5728, n5729, n5730, n5731, n5732, n5733, n5734,
         n5735, n5736, n5737, n5738, n5739, n5740, n5741, n5742, n5743, n5744,
         n5745, n5746, n5747, n5748, n5749, n5750, n5751, n5752, n5753, n5754,
         n5755, n5756, n5757, n5758, n5759, n5760, n5761, n5762, n5763, n5764,
         n5765, n5766, n5767, n5768, n5769, n5770, n5771, n5772, n5773, n5774,
         n5775, n5776, n5777, n5778, n5779, n5780, n5781, n5782, n5783, n5784,
         n5785, n5786, n5787, n5788, n5789, n5790, n5791, n5792, n5793, n5794,
         n5795, n5796, n5797, n5798, n5799, n5800, n5801, n5802, n5803, n5804,
         n5805, n5806, n5807, n5808, n5809, n5810, n5811, n5812, n5813, n5814,
         n5815, n5816, n5817, n5818, n5819, n5820, n5821, n5822, n5823, n5824,
         n5825, n5826, n5827, n5828, n5829, n5830, n5831, n5832, n5833, n5834,
         n5835, n5836, n5837, n5838, n5839, n5840, n5841, n5842, n5843, n5844,
         n5845, n5846, n5847, n5848, n5849, n5850, n5851, n5852, n5853, n5854,
         n5855, n5856, n5857, n5858, n5859, n5860, n5861, n5862, n5863, n5864,
         n5865, n5866, n5867, n5868, n5869, n5870, n5871, n5872, n5873, n5874,
         n5875, n5876, n5877, n5878, n5879, n5880, n5881, n5882, n5883, n5884,
         n5885, n5886, n5887, n5888, n5889, n5890, n5891, n5892, n5893, n5894,
         n5895, n5896, n5897, n5898, n5899, n5900, n5901, n5902, n5903, n5904,
         n5905, n5906, n5907, n5908, n5909, n5910, n5911, n5912, n5913, n5914,
         n5915, n5916, n5917, n5918, n5919, n5920, n5921, n5922, n5923, n5924,
         n5925, n5926, n5927, n5928, n5929, n5930, n5931, n5932, n5933, n5934,
         n5935, n5936, n5937, n5938, n5939, n5940, n5941, n5942, n5943, n5944,
         n5945, n5946, n5947, n5948, n5949, n5950, n5951, n5952, n5953, n5954,
         n5955, n5956, n5957, n5958, n5959, n5960, n5961, n5962, n5963, n5964,
         n5965, n5966, n5967, n5968, n5969, n5970, n5971, n5972, n5973, n5974,
         n5975, n5976, n5977, n5978, n5979, n5980, n5981, n5982, n5983, n5984,
         n5985, n5986, n5987, n5988, n5989, n5990, n5991, n5992, n5993, n5994,
         n5995, n5996, n5997, n5998, n5999, n6000, n6001, n6002, n6003, n6004,
         n6005, n6006, n6007, n6008, n6009, n6010, n6011, n6012, n6013, n6014,
         n6015, n6016, n6017, n6018, n6019, n6020, n6021, n6022, n6023, n6024,
         n6025, n6026, n6027, n6028, n6029, n6030, n6031, n6032, n6033, n6034,
         n6035, n6036, n6037, n6038, n6039, n6040, n6041, n6042, n6043, n6044,
         n6045, n6046, n6047, n6048, n6049, n6050, n6051, n6052, n6053, n6054,
         n6055, n6056, n6057, n6058, n6059, n6060, n6061, n6062, n6063, n6064,
         n6065, n6066, n6067, n6068, n6069, n6070, n6071, n6072, n6073, n6074,
         n6075, n6076, n6077, n6078, n6079, n6080, n6081, n6082, n6083, n6084,
         n6085, n6086, n6087, n6088, n6089, n6090, n6091, n6092, n6093, n6094,
         n6095, n6096, n6097, n6098, n6099, n6100, n6101, n6102, n6103, n6104,
         n6105, n6106, n6107, n6108, n6109, n6110, n6111, n6112, n6113, n6114,
         n6115, n6116, n6117, n6118, n6119, n6120, n6121, n6122, n6123, n6124,
         n6125, n6126, n6127, n6128, n6129, n6130, n6131, n6132, n6133, n6134,
         n6135, n6136, n6137, n6138, n6139, n6140, n6141, n6142, n6143, n6144,
         n6145, n6146, n6147, n6148, n6149, n6150, n6151, n6152, n6153, n6154,
         n6155, n6156, n6157, n6158, n6159, n6160, n6161, n6162, n6163, n6164,
         n6165, n6166, n6167, n6168, n6169, n6170, n6171, n6172, n6173, n6174,
         n6175, n6176, n6177, n6178, n6179, n6180, n6181, n6182, n6183, n6184,
         n6185, n6186, n6187, n6188, n6189, n6190, n6191, n6192, n6193, n6194,
         n6195, n6196, n6197, n6198, n6199, n6200, n6201, n6202, n6203, n6204,
         n6205, n6206, n6207, n6208, n6209, n6210, n6211, n6212, n6213, n6214,
         n6215, n6216, n6217, n6218, n6219, n6220, n6221, n6222, n6223, n6224,
         n6225, n6226, n6227, n6228, n6229, n6230, n6231, n6232, n6233, n6234,
         n6235, n6236, n6237, n6238, n6239, n6240, n6241, n6242, n6243, n6244,
         n6245, n6246, n6247, n6248, n6249, n6250, n6251, n6252, n6253, n6254,
         n6255, n6256, n6257, n6258, n6259, n6260, n6261, n6262, n6263, n6264,
         n6265, n6266, n6267, n6268, n6269, n6270, n6271, n6272, n6273, n6274,
         n6275, n6276, n6277, n6278, n6279, n6280, n6281, n6282, n6283, n6284,
         n6285, n6286, n6287, n6288, n6289, n6290, n6291, n6292, n6293, n6294,
         n6295, n6296, n6297, n6298, n6299, n6300, n6301, n6302, n6303, n6304,
         n6305, n6306, n6307, n6308, n6309, n6310, n6311, n6312, n6313, n6314,
         n6315, n6316, n6317, n6318, n6319, n6320, n6321, n6322, n6323, n6324,
         n6325, n6326, n6327, n6328, n6329, n6330, n6331, n6332, n6333, n6334,
         n6335, n6336, n6337, n6338, n6339, n6340, n6341, n6342, n6343, n6344,
         n6345, n6346, n6347, n6348, n6349, n6350, n6351, n6352, n6353, n6354,
         n6355, n6356, n6357, n6358, n6359, n6360, n6361, n6362, n6363, n6364,
         n6365, n6366, n6367, n6368, n6369, n6370, n6371, n6372, n6373, n6374,
         n6375, n6376, n6377, n6378, n6379, n6380, n6381, n6382, n6383, n6384,
         n6385, n6386, n6387, n6388, n6389, n6390, n6391, n6392, n6393, n6394,
         n6395, n6396, n6397, n6398, n6399, n6400, n6401, n6402, n6403, n6404,
         n6405, n6406, n6407, n6408, n6409, n6410, n6411, n6412, n6413, n6414,
         n6415, n6416, n6417, n6418, n6419, n6420, n6421, n6422, n6423, n6424,
         n6425, n6426, n6427, n6428, n6429, n6430, n6431, n6432, n6433, n6434,
         n6435, n6436, n6437, n6438, n6439, n6440, n6441, n6442, n6443, n6444,
         n6445, n6446, n6447, n6448, n6449, n6450, n6451, n6452, n6453, n6454,
         n6455, n6456, n6457, n6458, n6459, n6460, n6461, n6462, n6463, n6464,
         n6465, n6466, n6467, n6468, n6469, n6470, n6471, n6472, n6473, n6474,
         n6475, n6476, n6477, n6478, n6479, n6480, n6481, n6482, n6483, n6484,
         n6485, n6486, n6487, n6488, n6489, n6490, n6491, n6492, n6493, n6494,
         n6495, n6496, n6497, n6498, n6499, n6500, n6501, n6502, n6503, n6504,
         n6505, n6506, n6507, n6508, n6509, n6510, n6511, n6512, n6513, n6514,
         n6515, n6516, n6517, n6518, n6519, n6520, n6521, n6522, n6523, n6524,
         n6525, n6526, n6527, n6528, n6529, n6530, n6531, n6532, n6533, n6534,
         n6535, n6536, n6537, n6538, n6539, n6540, n6541, n6542, n6543, n6544,
         n6545, n6546, n6547, n6548, n6549, n6550, n6551, n6552, n6553, n6554,
         n6555, n6556, n6557, n6558, n6559, n6560, n6561, n6562, n6563, n6564,
         n6565, n6566, n6567, n6568, n6569, n6570, n6571, n6572, n6573, n6574,
         n6575, n6576, n6577, n6578, n6579, n6580, n6581, n6582, n6583, n6584,
         n6585, n6586, n6587, n6588, n6589, n6590, n6591, n6592, n6593, n6594,
         n6595, n6596, n6597, n6598, n6599, n6600, n6601, n6602, n6603, n6604,
         n6605, n6606, n6607, n6608, n6609, n6610, n6611, n6612, n6613, n6614,
         n6615, n6616, n6617, n6618, n6619, n6620, n6621, n6622, n6623, n6624,
         n6625, n6626, n6627, n6628, n6629, n6630, n6631, n6632, n6633, n6634,
         n6635, n6636, n6637, n6638, n6639, n6640, n6641, n6642, n6643, n6644,
         n6645, n6646, n6647, n6648, n6649, n6650, n6651, n6652, n6653, n6654,
         n6655, n6656, n6657, n6658, n6659, n6660, n6661, n6662, n6663, n6664,
         n6665, n6666, n6667, n6668, n6669, n6670, n6671, n6672, n6673, n6674,
         n6675, n6676, n6677, n6678, n6679, n6680, n6681, n6682, n6683, n6684,
         n6685, n6686, n6687, n6688, n6689, n6690, n6691, n6692, n6693, n6694,
         n6695, n6696, n6697, n6698, n6699, n6700, n6701, n6702, n6703, n6704,
         n6705, n6706, n6707, n6708, n6709, n6710, n6711, n6712, n6713, n6714,
         n6715, n6716, n6717, n6718, n6719, n6720, n6721, n6722, n6723, n6724,
         n6725, n6726, n6727, n6728, n6729, n6730, n6731, n6732, n6733, n6734,
         n6735, n6736, n6737, n6738, n6739, n6740, n6741, n6742, n6743, n6744,
         n6745, n6746, n6747, n6748, n6749, n6750, n6751, n6752, n6753, n6754,
         n6755, n6756, n6757, n6758, n6759, n6760, n6761, n6762, n6763, n6764,
         n6765, n6766, n6767, n6768, n6769, n6770, n6771, n6772, n6773, n6774,
         n6775, n6776, n6777, n6778, n6779, n6780, n6781, n6782, n6783, n6784,
         n6785, n6786, n6787, n6788, n6789, n6790, n6791, n6792, n6793, n6794,
         n6795, n6796, n6797, n6798, n6799, n6800, n6801, n6802, n6803, n6804,
         n6805, n6806, n6807, n6808, n6809, n6810, n6811, n6812, n6813, n6814,
         n6815, n6816, n6817, n6818, n6819, n6820, n6821, n6822, n6823, n6824,
         n6825, n6826, n6827, n6828, n6829, n6830, n6831, n6832, n6833, n6834,
         n6835, n6836, n6837, n6838, n6839, n6840, n6841, n6842, n6843, n6844,
         n6845, n6846, n6847, n6848, n6849, n6850, n6851, n6852, n6853, n6854,
         n6855, n6856, n6857, n6858, n6859, n6860, n6861, n6862, n6863, n6864,
         n6865, n6866, n6867, n6868, n6869, n6870, n6871, n6872, n6873, n6874,
         n6875, n6876, n6877, n6878, n6879, n6880, n6881, n6882, n6883, n6884,
         n6885, n6886, n6887, n6888, n6889, n6890, n6891, n6892, n6893, n6894,
         n6895, n6896, n6897, n6898, n6899, n6900, n6901, n6902, n6903, n6904,
         n6905, n6906, n6907, n6908, n6909, n6910, n6911, n6912, n6913, n6914,
         n6915, n6916, n6917, n6918, n6919, n6920, n6921, n6922, n6923, n6924,
         n6925, n6926, n6927, n6928, n6929, n6930, n6931, n6932, n6933, n6934,
         n6935, n6936, n6937, n6938, n6939, n6940, n6941, n6942, n6943, n6944,
         n6945, n6946, n6947, n6948, n6949, n6950, n6951, n6952, n6953, n6954,
         n6955, n6956, n6957, n6958, n6959, n6960, n6961, n6962, n6963, n6964,
         n6965, n6966, n6967, n6968, n6969, n6970, n6971, n6972, n6973, n6974,
         n6975, n6976, n6977, n6978, n6979, n6980, n6981, n6982, n6983, n6984,
         n6985, n6986, n6987, n6988, n6989, n6990, n6991, n6992, n6993, n6994,
         n6995, n6996, n6997, n6998, n6999, n7000, n7001, n7002, n7003, n7004,
         n7005, n7006, n7007, n7008, n7009, n7010, n7011, n7012, n7013, n7014,
         n7015, n7016, n7017, n7018, n7019, n7020, n7021, n7022, n7023, n7024,
         n7025, n7026, n7027, n7028, n7029, n7030, n7031, n7032, n7033, n7034,
         n7035, n7036, n7037, n7038, n7039, n7040, n7041, n7042, n7043, n7044,
         n7045, n7046, n7047, n7048, n7049, n7050, n7051, n7052, n7053, n7054,
         n7055, n7056, n7057, n7058, n7059, n7060, n7061, n7062, n7063, n7064,
         n7065, n7066, n7067, n7068, n7069, n7070, n7071, n7072, n7073, n7074,
         n7075, n7077, n7078, n7079, n7080, n7081, n7082, n7083, n7084, n7085,
         n7086, n7087, n7088, n7089, n7090, n7091, n7092, n7093, n7094, n7095,
         n7096, n7097, n7098, n7099, n7100, n7101, n7102, n7103, n7104, n7105,
         n7106, n7107, n7108, n7109, n7110, n7111, n7112, n7113, n7114, n7115,
         n7116, n7117, n7118, n7119, n7120, n7121, n7122, n7123, n7124, n7125,
         n7126, n7127, n7128, n7129, n7130, n7131, n7132, n7133, n7134, n7135,
         n7136, n7137, n7138, n7139, n7140, n7141, n7142, n7143, n7144, n7145,
         n7146, n7147, n7148, n7149, n7150, n7151, n7152, n7153, n7154, n7155,
         n7156, n7157, n7158, n7159, n7160, n7161, n7162, n7163, n7164, n7165,
         n7166, n7167, n7168, n7169, n7170, n7171, n7172, n7173, n7174, n7175,
         n7176, n7177, n7178, n7179, n7180, n7181, n7182, n7183, n7184, n7185,
         n7186, n7187, n7188, n7189, n7190, n7191, n7192, n7193, n7194, n7195,
         n7196, n7197, n7198, n7199, n7200, n7201, n7202, n7203, n7204, n7205,
         n7206, n7207, n7208, n7209, n7210, n7211, n7212, n7213, n7214, n7215,
         n7216, n7217, n7218, n7219, n7220, n7221, n7222, n7223, n7224, n7225,
         n7226, n7227, n7228, n7229, n7230, n7231, n7232, n7233, n7234, n7235,
         n7236, n7237, n7238, n7239, n7240, n7241, n7242, n7243, n7244, n7245,
         n7246, n7247, n7248, n7249, n7250, n7251, n7252, n7253, n7254, n7255,
         n7256, n7257, n7258, n7259, n7260, n7261, n7262, n7263, n7264, n7265,
         n7266, n7267, n7268, n7269, n7270, n7271, n7272, n7273, n7274, n7275,
         n7276, n7277, n7278, n7279, n7280, n7281, n7282, n7283, n7284, n7285,
         n7286, n7288, n7289, n7290, n7291, n7292, n7293, n7294, n7295, n7296,
         n7297, n7298, n7299, n7300, n7301, n7302, n7303, n7304, n7305, n7306,
         n7307, n7308, n7309, n7310, n7311, n7312, n7313, n7314, n7315, n7316,
         n7317, n7318, n7319, n7320, n7321, n7322, n7323, n7324, n7325, n7326,
         n7327, n7328, n7329, n7330, n7331, n7332, n7333, n7334, n7335, n7336,
         n7337, n7339, n7340, n7341, n7342, n7343, n7344, n7345, n7346, n7347,
         n7348, n7349, n7350, n7351, n7352, n7353, n7354, n7355, n7356, n7357,
         n7358, n7359, n7360, n7361, n7362, n7363, n7364, n7365, n7366, n7367,
         n7368, n7369, n7370, n7371, n7372, n7373, n7374, n7375, n7376, n7377,
         n7378, n7379, n7380, n7381, n7382, n7383, n7384, n7385, n7386, n7387,
         n7388, n7389, n7390, n7391, n7392, n7393, n7394, n7395, n7396, n7397,
         n7398, n7399, n7400, n7401, n7402, n7403, n7404, n7405, n7406, n7407,
         n7408, n7409, n7410, n7411, n7412, n7413, n7414, n7415, n7416, n7417,
         n7418, n7419, n7420, n7421, n7422, n7423, n7424, n7425, n7426, n7427,
         n7428, n7429, n7430, n7431, n7432, n7433, n7434, n7435, n7436, n7437,
         n7438, n7439, n7440, n7441, n7442, n7443, n7444, n7445, n7446, n7447,
         n7448, n7449, n7450, n7451, n7452, n7453, n7454, n7455, n7456, n7457,
         n7458, n7459, n7460, n7461, n7462, n7463, n7464, n7465, n7466, n7467,
         n7468, n7469, n7470, n7471, n7472, n7473, n7474, n7475, n7476, n7477,
         n7478, n7479, n7480, n7481, n7482, n7483, n7484, n7485, n7486, n7487,
         n7488, n7489, n7490, n7491, n7492, n7493, n7494, n7495, n7496, n7497,
         n7498, n7499, n7500, n7501, n7502, n7503, n7504, n7505, n7506, n7507,
         n7508, n7509, n7510, n7511, n7512, n7513, n7514, n7515, n7516, n7517,
         n7518, n7519, n7520, n7521, n7522, n7523, n7524, n7525, n7526, n7527,
         n7528, n7529, n7530, n7531, n7532, n7533, n7534, n7535, n7536, n7537,
         n7538, n7539, n7540, n7541, n7542, n7543, n7544, n7545, n7546, n7547,
         n7548, n7549, n7550, n7551, n7552, n7553, n7554, n7555, n7556, n7557,
         n7558, n7559, n7560, n7561, n7562, n7563, n7564, n7565, n7566, n7567,
         n7568, n7569, n7570, n7571, n7572, n7573, n7574, n7575, n7576, n7577,
         n7578, n7579, n7580, n7581, n7582, n7583, n7584, n7585, n7586, n7587,
         n7588, n7589, n7590, n7591, n7592, n7593, n7594, n7595, n7596, n7597,
         n7598, n7599, n7600, n7601, n7602, n7603, n7604, n7605, n7606, n7607,
         n7608, n7609, n7610, n7611, n7612, n7613, n7614, n7615, n7616, n7617,
         n7618, n7619, n7620, n7621, n7622, n7623, n7624, n7625, n7626, n7627,
         n7628, n7629, n7630, n7631, n7632, n7633, n7634, n7635, n7636, n7637,
         n7638, n7639, n7640, n7641, n7642, n7643, n7644, n7645, n7646, n7647,
         n7648, n7649, n7650, n7651, n7652, n7653, n7654, n7655, n7656, n7657,
         n7658, n7659, n7660, n7661, n7662, n7663, n7664, n7665, n7666, n7667,
         n7668, n7669, n7670, n7671, n7672, n7673, n7674, n7675, n7676, n7677,
         n7678, n7679, n7680, n7681, n7682, n7683, n7684, n7685, n7686, n7687,
         n7688, n7689, n7690, n7691, n7692, n7693, n7694, n7695, n7696, n7697,
         n7698, n7699, n7700, n7701, n7702, n7703, n7704, n7705, n7706, n7707,
         n7708, n7709, n7710, n7711, n7712, n7713, n7714, n7715, n7716, n7717,
         n7718, n7719, n7720, n7721, n7722, n7723, n7724, n7725, n7726, n7727,
         n7728, n7729, n7730, n7731, n7732, n7733, n7734, n7735, n7736, n7737,
         n7738, n7739, n7740, n7741, n7742, n7743, n7744, n7745, n7746, n7747,
         n7748, n7749, n7750, n7751, n7752, n7753, n7754, n7755, n7756, n7757,
         n7758, n7759, n7760, n7761, n7762, n7763, n7764, n7765, n7766, n7767,
         n7768, n7769, n7770, n7771, n7772, n7773, n7774, n7775, n7776, n7777,
         n7778, n7779, n7780, n7781, n7782, n7783, n7784, n7785, n7786, n7787,
         n7788, n7789, n7790, n7791, n7792, n7793, n7794, n7795, n7796, n7797,
         n7798, n7799, n7800, n7801, n7802, n7803, n7804, n7805, n7806, n7807,
         n7808, n7809, n7810, n7811, n7812, n7813, n7814, n7815, n7816, n7817,
         n7818, n7819, n7820, n7821, n7822, n7823, n7824, n7825, n7826, n7827,
         n7828, n7829, n7830, n7831, n7832, n7833, n7834, n7835, n7836, n7837,
         n7838, n7839, n7840, n7841, n7842, n7843, n7844, n7845, n7846, n7847,
         n7848, n7849, n7850, n7851, n7852, n7853, n7854, n7855, n7856, n7857,
         n7858, n7859, n7860, n7861, n7862, n7863, n7864, n7865, n7866, n7867,
         n7868, n7869, n7870, n7871, n7872, n7873, n7874, n7875, n7876, n7877,
         n7878, n7879, n7880, n7881, n7882, n7883, n7884, n7885, n7886, n7887,
         n7888, n7889, n7890, n7891, n7892, n7893, n7894, n7895, n7896, n7897,
         n7898, n7899, n7900, n7901, n7902, n7903, n7904, n7905, n7906, n7907,
         n7908, n7909, n7910, n7911, n7912, n7913, n7914, n7915, n7916, n7917,
         n7918, n7919, n7920, n7921, n7922, n7923, n7924, n7925, n7926, n7927,
         n7928, n7929, n7930, n7931, n7932, n7933, n7934, n7935, n7936, n7937,
         n7938, n7939, n7940, n7941, n7942, n7943, n7944, n7945, n7946, n7947,
         n7948, n7949, n7950, n7951, n7952, n7953, n7954, n7955, n7956, n7957,
         n7958, n7959, n7960, n7961, n7962, n7963, n7964, n7965, n7966, n7967,
         n7968, n7969, n7970, n7971, n7972, n7973, n7974, n7975, n7976, n7977,
         n7978, n7979, n7980, n7981, n7982, n7983, n7984, n7985, n7986, n7987,
         n7988, n7989, n7990, n7991, n7992, n7993, n7994, n7995, n7996, n7997,
         n7998, n7999, n8000, n8001, n8002, n8003, n8004, n8005, n8006, n8007,
         n8008, n8009, n8010, n8011, n8012, n8013, n8014, n8015, n8016, n8017,
         n8018, n8019, n8020, n8021, n8022, n8023, n8024, n8025, n8026, n8027,
         n8028, n8029, n8030, n8031, n8032, n8033, n8034, n8035, n8036, n8037,
         n8038, n8039, n8040, n8041, n8042, n8043, n8044, n8045, n8046, n8047,
         n8048, n8049, n8050, n8051, n8052, n8053, n8054, n8055, n8056, n8057,
         n8058, n8059, n8060, n8061, n8062, n8063, n8064, n8065, n8066, n8067,
         n8068, n8069, n8070, n8071;
  wire   [1:0] mem_state;
  wire   [31:0] mem_rdata_q;
  wire   [1:0] mem_wordsize;
  wire   [31:0] mem_rdata_word;
  wire   [31:0] decoded_imm;
  wire   [4:0] decoded_rd;
  wire   [31:0] decoded_imm_j;
  wire   [7:0] cpu_state;
  wire   [31:0] reg_out;
  wire   [31:0] reg_next_pc;
  wire   [31:0] alu_out;
  wire   [31:0] reg_pc;
  wire   [31:0] alu_out_q;
  wire   [4:0] latched_rd;
  wire   [63:0] count_cycle;
  wire   [63:0] count_instr;
  wire   [4:0] reg_sh;

  wire is_fcx_addr; 
  wire is_system_op;
  wire is_misr_csr_addr;
  wire is_misr_write_stroke;
  wire misr_en_d, misr_en_q;
  wire eco_misr_rst;
  wire [31:0] sig_data;
  wire [31:0] sig_ctrl;
  wire [31:0] eco_reg_out_d;
  wire [31:0] sig_mux_out;

  assign mem_la_addr[1] = 1'b0;
  assign mem_la_addr[0] = 1'b0;
  assign pcpi_valid = 1'b0;
  assign eoi[31] = 1'b0;
  assign eoi[30] = 1'b0;
  assign eoi[29] = 1'b0;
  assign eoi[28] = 1'b0;
  assign eoi[27] = 1'b0;
  assign eoi[26] = 1'b0;
  assign eoi[25] = 1'b0;
  assign eoi[24] = 1'b0;
  assign eoi[23] = 1'b0;
  assign eoi[22] = 1'b0;
  assign eoi[21] = 1'b0;
  assign eoi[20] = 1'b0;
  assign eoi[19] = 1'b0;
  assign eoi[18] = 1'b0;
  assign eoi[17] = 1'b0;
  assign eoi[16] = 1'b0;
  assign eoi[15] = 1'b0;
  assign eoi[14] = 1'b0;
  assign eoi[13] = 1'b0;
  assign eoi[12] = 1'b0;
  assign eoi[11] = 1'b0;
  assign eoi[10] = 1'b0;
  assign eoi[9] = 1'b0;
  assign eoi[8] = 1'b0;
  assign eoi[7] = 1'b0;
  assign eoi[6] = 1'b0;
  assign eoi[5] = 1'b0;
  assign eoi[4] = 1'b0;
  assign eoi[3] = 1'b0;
  assign eoi[2] = 1'b0;
  assign eoi[1] = 1'b0;
  assign eoi[0] = 1'b0;
  assign trace_valid = 1'b0;
  assign trace_data[35] = 1'b0;
  assign trace_data[34] = 1'b0;
  assign trace_data[33] = 1'b0;
  assign trace_data[32] = 1'b0;
  assign trace_data[31] = 1'b0;
  assign trace_data[30] = 1'b0;
  assign trace_data[29] = 1'b0;
  assign trace_data[28] = 1'b0;
  assign trace_data[27] = 1'b0;
  assign trace_data[26] = 1'b0;
  assign trace_data[25] = 1'b0;
  assign trace_data[24] = 1'b0;
  assign trace_data[23] = 1'b0;
  assign trace_data[22] = 1'b0;
  assign trace_data[21] = 1'b0;
  assign trace_data[20] = 1'b0;
  assign trace_data[19] = 1'b0;
  assign trace_data[18] = 1'b0;
  assign trace_data[17] = 1'b0;
  assign trace_data[16] = 1'b0;
  assign trace_data[15] = 1'b0;
  assign trace_data[14] = 1'b0;
  assign trace_data[13] = 1'b0;
  assign trace_data[12] = 1'b0;
  assign trace_data[11] = 1'b0;
  assign trace_data[10] = 1'b0;
  assign trace_data[9] = 1'b0;
  assign trace_data[8] = 1'b0;
  assign trace_data[7] = 1'b0;
  assign trace_data[6] = 1'b0;
  assign trace_data[5] = 1'b0;
  assign trace_data[4] = 1'b0;
  assign trace_data[3] = 1'b0;
  assign trace_data[2] = 1'b0;
  assign trace_data[1] = 1'b0;
  assign trace_data[0] = 1'b0;
  assign pcpi_insn[9] = 1'b0;
  assign pcpi_insn[8] = 1'b0;
  assign pcpi_insn[7] = 1'b0;
  assign pcpi_insn[6] = 1'b0;
  assign pcpi_insn[5] = 1'b0;
  assign pcpi_insn[4] = 1'b0;
  assign pcpi_insn[3] = 1'b0;
  assign pcpi_insn[2] = 1'b0;
  assign pcpi_insn[1] = 1'b0;
  assign pcpi_insn[31] = 1'b0;
  assign pcpi_insn[30] = 1'b0;
  assign pcpi_insn[29] = 1'b0;
  assign pcpi_insn[28] = 1'b0;
  assign pcpi_insn[27] = 1'b0;
  assign pcpi_insn[26] = 1'b0;
  assign pcpi_insn[25] = 1'b0;
  assign pcpi_insn[24] = 1'b0;
  assign pcpi_insn[23] = 1'b0;
  assign pcpi_insn[22] = 1'b0;
  assign pcpi_insn[21] = 1'b0;
  assign pcpi_insn[20] = 1'b0;
  assign pcpi_insn[19] = 1'b0;
  assign pcpi_insn[18] = 1'b0;
  assign pcpi_insn[17] = 1'b0;
  assign pcpi_insn[16] = 1'b0;
  assign pcpi_insn[15] = 1'b0;
  assign pcpi_insn[14] = 1'b0;
  assign pcpi_insn[13] = 1'b0;
  assign pcpi_insn[12] = 1'b0;
  assign pcpi_insn[11] = 1'b0;
  assign pcpi_insn[10] = 1'b0;
  assign pcpi_insn[0] = 1'b0;
  assign mem_addr[0] = 1'b0;
  assign mem_addr[1] = 1'b0;
  assign pcpi_rs1[1] = net30596;
  assign pcpi_rs1[7] = net30656;
  assign pcpi_rs1[3] = net30659;
  assign pcpi_rs1[11] = net30668;
  assign pcpi_rs1[5] = net30690;
  assign pcpi_rs1[6] = net30702;
  assign pcpi_rs1[2] = net30713;

  DFFX1_RVT \count_cycle_reg[63]  ( .D(N981), .CLK(clk), .Q(count_cycle[63]), 
        .QN(n8067) );
  DFFX1_RVT \count_cycle_reg[62]  ( .D(N980), .CLK(clk), .Q(count_cycle[62]), 
        .QN(n4217) );
  DFFX1_RVT \count_cycle_reg[61]  ( .D(N979), .CLK(clk), .Q(count_cycle[61])
         );
  DFFX1_RVT \count_cycle_reg[60]  ( .D(N978), .CLK(clk), .Q(count_cycle[60])
         );
  DFFX1_RVT \count_cycle_reg[59]  ( .D(N977), .CLK(clk), .Q(count_cycle[59])
         );
  DFFX1_RVT \count_cycle_reg[58]  ( .D(N976), .CLK(clk), .Q(count_cycle[58])
         );
  DFFX1_RVT \count_cycle_reg[57]  ( .D(N975), .CLK(clk), .Q(count_cycle[57]), 
        .QN(n4264) );
  DFFX1_RVT \count_cycle_reg[56]  ( .D(N974), .CLK(clk), .Q(count_cycle[56]), 
        .QN(n4262) );
  DFFX1_RVT \count_cycle_reg[55]  ( .D(N973), .CLK(clk), .Q(count_cycle[55]), 
        .QN(n4332) );
  DFFX1_RVT \count_cycle_reg[54]  ( .D(N972), .CLK(clk), .Q(count_cycle[54]), 
        .QN(n4306) );
  DFFX1_RVT \count_cycle_reg[53]  ( .D(N971), .CLK(clk), .Q(count_cycle[53]), 
        .QN(n4315) );
  DFFX1_RVT \count_cycle_reg[52]  ( .D(N970), .CLK(clk), .Q(count_cycle[52]), 
        .QN(n4290) );
  DFFX1_RVT \count_cycle_reg[51]  ( .D(N969), .CLK(clk), .Q(count_cycle[51]), 
        .QN(n4269) );
  DFFX1_RVT \count_cycle_reg[50]  ( .D(N968), .CLK(clk), .Q(count_cycle[50])
         );
  DFFX1_RVT \count_cycle_reg[49]  ( .D(N967), .CLK(clk), .Q(count_cycle[49])
         );
  DFFX1_RVT \count_cycle_reg[48]  ( .D(N966), .CLK(clk), .Q(count_cycle[48])
         );
  DFFX1_RVT \count_cycle_reg[47]  ( .D(N965), .CLK(clk), .Q(count_cycle[47])
         );
  DFFX1_RVT \count_cycle_reg[46]  ( .D(N964), .CLK(clk), .Q(count_cycle[46])
         );
  DFFX1_RVT \count_cycle_reg[45]  ( .D(N963), .CLK(clk), .Q(count_cycle[45])
         );
  DFFX1_RVT \count_cycle_reg[44]  ( .D(N962), .CLK(clk), .Q(count_cycle[44])
         );
  DFFX1_RVT \count_cycle_reg[43]  ( .D(N961), .CLK(clk), .Q(count_cycle[43])
         );
  DFFX1_RVT \count_cycle_reg[42]  ( .D(N960), .CLK(clk), .Q(count_cycle[42])
         );
  DFFX1_RVT \count_cycle_reg[41]  ( .D(N959), .CLK(clk), .Q(count_cycle[41])
         );
  DFFX1_RVT \count_cycle_reg[40]  ( .D(N958), .CLK(clk), .Q(count_cycle[40])
         );
  DFFX1_RVT \count_cycle_reg[39]  ( .D(N957), .CLK(clk), .Q(count_cycle[39])
         );
  DFFX1_RVT \count_cycle_reg[38]  ( .D(N956), .CLK(clk), .Q(count_cycle[38])
         );
  DFFX1_RVT \count_cycle_reg[37]  ( .D(N955), .CLK(clk), .Q(count_cycle[37])
         );
  DFFX1_RVT \count_cycle_reg[36]  ( .D(N954), .CLK(clk), .Q(count_cycle[36])
         );
  DFFX1_RVT \count_cycle_reg[35]  ( .D(N953), .CLK(clk), .Q(count_cycle[35])
         );
  DFFX1_RVT \count_cycle_reg[34]  ( .D(N952), .CLK(clk), .Q(count_cycle[34])
         );
  DFFX1_RVT \count_cycle_reg[33]  ( .D(N951), .CLK(clk), .Q(count_cycle[33]), 
        .QN(n8068) );
  DFFX1_RVT \count_cycle_reg[32]  ( .D(N950), .CLK(clk), .Q(count_cycle[32])
         );
  DFFX1_RVT \count_cycle_reg[31]  ( .D(N949), .CLK(clk), .Q(count_cycle[31])
         );
  DFFX1_RVT \count_cycle_reg[30]  ( .D(N948), .CLK(clk), .Q(count_cycle[30])
         );
  DFFX1_RVT \count_cycle_reg[29]  ( .D(N947), .CLK(clk), .Q(count_cycle[29])
         );
  DFFX1_RVT \count_cycle_reg[28]  ( .D(N946), .CLK(clk), .Q(count_cycle[28])
         );
  DFFX1_RVT \count_cycle_reg[27]  ( .D(N945), .CLK(clk), .Q(count_cycle[27])
         );
  DFFX1_RVT \count_cycle_reg[26]  ( .D(N944), .CLK(clk), .Q(count_cycle[26])
         );
  DFFX1_RVT \count_cycle_reg[25]  ( .D(N943), .CLK(clk), .Q(count_cycle[25])
         );
  DFFX1_RVT \count_cycle_reg[24]  ( .D(N942), .CLK(clk), .Q(count_cycle[24]), 
        .QN(n4261) );
  DFFX1_RVT \count_cycle_reg[23]  ( .D(N941), .CLK(clk), .Q(count_cycle[23])
         );
  DFFX1_RVT \count_cycle_reg[22]  ( .D(N940), .CLK(clk), .Q(count_cycle[22]), 
        .QN(n4305) );
  DFFX1_RVT \count_cycle_reg[21]  ( .D(N939), .CLK(clk), .Q(count_cycle[21]), 
        .QN(n4314) );
  DFFX1_RVT \count_cycle_reg[20]  ( .D(N938), .CLK(clk), .Q(count_cycle[20])
         );
  DFFX1_RVT \count_cycle_reg[19]  ( .D(N937), .CLK(clk), .Q(count_cycle[19])
         );
  DFFX1_RVT \count_cycle_reg[18]  ( .D(N936), .CLK(clk), .Q(count_cycle[18])
         );
  DFFX1_RVT \count_cycle_reg[17]  ( .D(N935), .CLK(clk), .Q(count_cycle[17])
         );
  DFFX1_RVT \count_cycle_reg[16]  ( .D(N934), .CLK(clk), .Q(count_cycle[16])
         );
  DFFX1_RVT \count_cycle_reg[15]  ( .D(N933), .CLK(clk), .Q(count_cycle[15])
         );
  DFFX1_RVT \count_cycle_reg[14]  ( .D(N932), .CLK(clk), .Q(count_cycle[14])
         );
  DFFX1_RVT \count_cycle_reg[13]  ( .D(N931), .CLK(clk), .Q(count_cycle[13])
         );
  DFFX1_RVT \count_cycle_reg[12]  ( .D(N930), .CLK(clk), .Q(count_cycle[12])
         );
  DFFX1_RVT \count_cycle_reg[11]  ( .D(N929), .CLK(clk), .Q(count_cycle[11])
         );
  DFFX1_RVT \count_cycle_reg[10]  ( .D(N928), .CLK(clk), .Q(count_cycle[10])
         );
  DFFX1_RVT \count_cycle_reg[9]  ( .D(N927), .CLK(clk), .Q(count_cycle[9]) );
  DFFX1_RVT \count_cycle_reg[8]  ( .D(N926), .CLK(clk), .Q(count_cycle[8]) );
  DFFX1_RVT \count_cycle_reg[7]  ( .D(N925), .CLK(clk), .Q(count_cycle[7]) );
  DFFX1_RVT \count_cycle_reg[6]  ( .D(N924), .CLK(clk), .Q(count_cycle[6]) );
  DFFX1_RVT \count_cycle_reg[5]  ( .D(N923), .CLK(clk), .Q(count_cycle[5]), 
        .QN(n4221) );
  DFFX1_RVT \count_cycle_reg[4]  ( .D(N922), .CLK(clk), .Q(count_cycle[4]), 
        .QN(n4222) );
  DFFX1_RVT \count_cycle_reg[3]  ( .D(N921), .CLK(clk), .Q(count_cycle[3]), 
        .QN(n4228) );
  DFFX1_RVT \count_cycle_reg[2]  ( .D(N920), .CLK(clk), .Q(count_cycle[2]), 
        .QN(n4227) );
  DFFX1_RVT \count_cycle_reg[1]  ( .D(N919), .CLK(clk), .Q(count_cycle[1]), 
        .QN(n4225) );
  DFFX1_RVT \count_cycle_reg[0]  ( .D(N918), .CLK(clk), .Q(count_cycle[0]), 
        .QN(n4226) );
  DFFX1_RVT \reg_pc_reg[31]  ( .D(n3766), .CLK(clk), .Q(reg_pc[31]) );
  DFFX1_RVT \reg_op1_reg[31]  ( .D(n3709), .CLK(clk), .Q(pcpi_rs1[31]), .QN(
        net16372) );
  DFFX1_RVT mem_do_rinst_reg ( .D(n3708), .CLK(clk), .Q(mem_do_rinst), .QN(
        n7980) );
  DFFX1_RVT \mem_state_reg[1]  ( .D(n3702), .CLK(clk), .Q(mem_state[1]), .QN(
        n4545) );
  DFFX1_RVT \mem_state_reg[0]  ( .D(n3703), .CLK(clk), .Q(mem_state[0]), .QN(
        n4546) );
  DFFX1_RVT \decoded_imm_j_reg[31]  ( .D(n3607), .CLK(clk), .Q(
        decoded_imm_j[31]) );
  DFFX1_RVT \decoded_imm_reg[30]  ( .D(n3577), .CLK(clk), .Q(decoded_imm[30])
         );
  DFFX1_RVT \reg_op2_reg[30]  ( .D(n3900), .CLK(clk), .Q(pcpi_rs2[30]), .QN(
        n8024) );
  DFFX1_RVT \alu_out_q_reg[30]  ( .D(alu_out[30]), .CLK(clk), .Q(alu_out_q[30]) );
  DFFX1_RVT \cpuregs_reg[1][30]  ( .D(n2604), .CLK(clk), .Q(\cpuregs[1][30] )
         );
  DFFX1_RVT \reg_op1_reg[30]  ( .D(n3710), .CLK(clk), .Q(pcpi_rs1[30]), .QN(
        net16452) );
  DFFX1_RVT \reg_op1_reg[29]  ( .D(n3711), .CLK(clk), .Q(pcpi_rs1[29]), .QN(
        net16540) );
  DFFX1_RVT \reg_op1_reg[28]  ( .D(n3712), .CLK(clk), .Q(pcpi_rs1[28]), .QN(
        net16345) );
  DFFX1_RVT \reg_op1_reg[26]  ( .D(n3714), .CLK(clk), .Q(n8072), .QN(net16339)
         );
  DFFX1_RVT \reg_op1_reg[25]  ( .D(n3715), .CLK(clk), .Q(pcpi_rs1[25]), .QN(
        net16364) );
  DFFX1_RVT \reg_op1_reg[24]  ( .D(n3716), .CLK(clk), .Q(n8073), .QN(net16451)
         );
  DFFX1_RVT \reg_op1_reg[22]  ( .D(n3718), .CLK(clk), .Q(n8075), .QN(net16467)
         );
  DFFX1_RVT \reg_op1_reg[21]  ( .D(n3719), .CLK(clk), .Q(pcpi_rs1[21]), .QN(
        net16453) );
  DFFX1_RVT \reg_op1_reg[20]  ( .D(n3720), .CLK(clk), .Q(pcpi_rs1[20]), .QN(
        net16349) );
  DFFX1_RVT \reg_op1_reg[19]  ( .D(n3721), .CLK(clk), .Q(n8076), .QN(net16362)
         );
  DFFX1_RVT \reg_op1_reg[18]  ( .D(n3722), .CLK(clk), .Q(n8077), .QN(net16365)
         );
  DFFX1_RVT \reg_op1_reg[17]  ( .D(n3723), .CLK(clk), .Q(n8078), .QN(net16361)
         );
  DFFX1_RVT \reg_op1_reg[16]  ( .D(n3724), .CLK(clk), .Q(pcpi_rs1[16]), .QN(
        net16357) );
  DFFX1_RVT \reg_op1_reg[12]  ( .D(n3728), .CLK(clk), .Q(n8082), .QN(net16303)
         );
  DFFX1_RVT \reg_op1_reg[11]  ( .D(n3729), .CLK(clk), .Q(n8083), .QN(net16317)
         );
  DFFX1_RVT \reg_op1_reg[10]  ( .D(n3730), .CLK(clk), .Q(n8084), .QN(net16340)
         );
  DFFX1_RVT \reg_op1_reg[9]  ( .D(n3731), .CLK(clk), .Q(n8085), .QN(net13612)
         );
  DFFX1_RVT \reg_op1_reg[8]  ( .D(n3732), .CLK(clk), .Q(n8086), .QN(net16337)
         );
  DFFX1_RVT \reg_op1_reg[4]  ( .D(n3736), .CLK(clk), .Q(n8090), .QN(net16330)
         );
  DFFX1_RVT \alu_out_q_reg[4]  ( .D(alu_out[4]), .CLK(clk), .Q(alu_out_q[4])
         );
  DFFX1_RVT \cpuregs_reg[1][4]  ( .D(n2578), .CLK(clk), .Q(\cpuregs[1][4] ) );
  DFFX1_RVT \reg_sh_reg[4]  ( .D(N1942), .CLK(clk), .Q(reg_sh[4]), .QN(n4292)
         );
  DFFX1_RVT \cpuregs_reg[1][1]  ( .D(n2575), .CLK(clk), .Q(\cpuregs[1][1] ) );
  DFFX1_RVT \reg_op1_reg[1]  ( .D(n3739), .CLK(clk), .Q(n8093), .QN(net16466)
         );
  DFFX1_RVT \reg_next_pc_reg[31]  ( .D(n3798), .CLK(clk), .Q(reg_next_pc[31])
         );
  DFFX1_RVT \count_instr_reg[0]  ( .D(n3893), .CLK(clk), .Q(count_instr[0]), 
        .QN(n8002) );
  DFFX1_RVT \count_instr_reg[1]  ( .D(n3892), .CLK(clk), .Q(count_instr[1]), 
        .QN(n8056) );
  DFFX1_RVT \count_instr_reg[2]  ( .D(n3891), .CLK(clk), .Q(count_instr[2]) );
  DFFX1_RVT \count_instr_reg[3]  ( .D(n3890), .CLK(clk), .Q(count_instr[3]), 
        .QN(n8063) );
  DFFX1_RVT \count_instr_reg[4]  ( .D(n3889), .CLK(clk), .Q(count_instr[4]) );
  DFFX1_RVT \count_instr_reg[5]  ( .D(n3888), .CLK(clk), .Q(count_instr[5]) );
  DFFX1_RVT \count_instr_reg[6]  ( .D(n3887), .CLK(clk), .Q(count_instr[6]), 
        .QN(n8060) );
  DFFX1_RVT \count_instr_reg[7]  ( .D(n3886), .CLK(clk), .Q(count_instr[7]) );
  DFFX1_RVT \count_instr_reg[8]  ( .D(n3885), .CLK(clk), .Q(count_instr[8]) );
  DFFX1_RVT \count_instr_reg[9]  ( .D(n3884), .CLK(clk), .Q(count_instr[9]) );
  DFFX1_RVT \count_instr_reg[10]  ( .D(n3883), .CLK(clk), .Q(count_instr[10])
         );
  DFFX1_RVT \count_instr_reg[11]  ( .D(n3882), .CLK(clk), .Q(count_instr[11])
         );
  DFFX1_RVT \count_instr_reg[12]  ( .D(n3881), .CLK(clk), .Q(count_instr[12]), 
        .QN(n8003) );
  DFFX1_RVT \count_instr_reg[13]  ( .D(n3880), .CLK(clk), .Q(count_instr[13])
         );
  DFFX1_RVT \count_instr_reg[14]  ( .D(n3879), .CLK(clk), .Q(count_instr[14])
         );
  DFFX1_RVT \count_instr_reg[15]  ( .D(n3878), .CLK(clk), .Q(count_instr[15])
         );
  DFFX1_RVT \count_instr_reg[16]  ( .D(n3877), .CLK(clk), .Q(count_instr[16])
         );
  DFFX1_RVT \count_instr_reg[17]  ( .D(n3876), .CLK(clk), .Q(count_instr[17])
         );
  DFFX1_RVT \count_instr_reg[18]  ( .D(n3875), .CLK(clk), .Q(count_instr[18]), 
        .QN(n8062) );
  DFFX1_RVT \count_instr_reg[19]  ( .D(n3874), .CLK(clk), .Q(count_instr[19]), 
        .QN(n4270) );
  DFFX1_RVT \count_instr_reg[20]  ( .D(n3873), .CLK(clk), .Q(count_instr[20])
         );
  DFFX1_RVT \count_instr_reg[21]  ( .D(n3872), .CLK(clk), .Q(count_instr[21]), 
        .QN(n8064) );
  DFFX1_RVT \count_instr_reg[22]  ( .D(n3871), .CLK(clk), .Q(count_instr[22])
         );
  DFFX1_RVT \count_instr_reg[23]  ( .D(n3870), .CLK(clk), .Q(count_instr[23]), 
        .QN(n8058) );
  DFFX1_RVT \count_instr_reg[24]  ( .D(n3869), .CLK(clk), .Q(count_instr[24])
         );
  DFFX1_RVT \count_instr_reg[25]  ( .D(n3868), .CLK(clk), .Q(count_instr[25]), 
        .QN(n4265) );
  DFFX1_RVT \count_instr_reg[26]  ( .D(n3867), .CLK(clk), .Q(count_instr[26])
         );
  DFFX1_RVT \count_instr_reg[27]  ( .D(n3866), .CLK(clk), .Q(count_instr[27])
         );
  DFFX1_RVT \count_instr_reg[28]  ( .D(n3865), .CLK(clk), .Q(count_instr[28])
         );
  DFFX1_RVT \count_instr_reg[29]  ( .D(n3864), .CLK(clk), .Q(count_instr[29])
         );
  DFFX1_RVT \count_instr_reg[30]  ( .D(n3863), .CLK(clk), .Q(count_instr[30])
         );
  DFFX1_RVT \count_instr_reg[31]  ( .D(n3862), .CLK(clk), .Q(count_instr[31])
         );
  DFFX1_RVT \count_instr_reg[32]  ( .D(n3861), .CLK(clk), .Q(count_instr[32])
         );
  DFFX1_RVT \count_instr_reg[33]  ( .D(n3860), .CLK(clk), .Q(count_instr[33]), 
        .QN(n8059) );
  DFFX1_RVT \count_instr_reg[34]  ( .D(n3859), .CLK(clk), .Q(count_instr[34]), 
        .QN(n8054) );
  DFFX1_RVT \count_instr_reg[35]  ( .D(n3858), .CLK(clk), .Q(count_instr[35])
         );
  DFFX1_RVT \count_instr_reg[36]  ( .D(n3857), .CLK(clk), .Q(count_instr[36])
         );
  DFFX1_RVT \count_instr_reg[37]  ( .D(n3856), .CLK(clk), .Q(count_instr[37])
         );
  DFFX1_RVT \count_instr_reg[38]  ( .D(n3855), .CLK(clk), .Q(count_instr[38])
         );
  DFFX1_RVT \count_instr_reg[39]  ( .D(n3854), .CLK(clk), .Q(count_instr[39])
         );
  DFFX1_RVT \count_instr_reg[40]  ( .D(n3853), .CLK(clk), .Q(count_instr[40])
         );
  DFFX1_RVT \count_instr_reg[41]  ( .D(n3852), .CLK(clk), .Q(count_instr[41])
         );
  DFFX1_RVT \count_instr_reg[42]  ( .D(n3851), .CLK(clk), .Q(count_instr[42])
         );
  DFFX1_RVT \count_instr_reg[43]  ( .D(n3850), .CLK(clk), .Q(count_instr[43])
         );
  DFFX1_RVT \count_instr_reg[44]  ( .D(n3849), .CLK(clk), .Q(count_instr[44])
         );
  DFFX1_RVT \count_instr_reg[45]  ( .D(n3848), .CLK(clk), .Q(count_instr[45])
         );
  DFFX1_RVT \count_instr_reg[46]  ( .D(n3847), .CLK(clk), .Q(count_instr[46])
         );
  DFFX1_RVT \count_instr_reg[47]  ( .D(n3846), .CLK(clk), .Q(count_instr[47])
         );
  DFFX1_RVT \count_instr_reg[48]  ( .D(n3845), .CLK(clk), .Q(count_instr[48])
         );
  DFFX1_RVT \count_instr_reg[49]  ( .D(n3844), .CLK(clk), .Q(count_instr[49])
         );
  DFFX1_RVT \count_instr_reg[50]  ( .D(n3843), .CLK(clk), .Q(count_instr[50])
         );
  DFFX1_RVT \count_instr_reg[51]  ( .D(n3842), .CLK(clk), .Q(count_instr[51])
         );
  DFFX1_RVT \count_instr_reg[52]  ( .D(n3841), .CLK(clk), .Q(count_instr[52])
         );
  DFFX1_RVT \count_instr_reg[53]  ( .D(n3840), .CLK(clk), .Q(count_instr[53])
         );
  DFFX1_RVT \count_instr_reg[54]  ( .D(n3839), .CLK(clk), .Q(count_instr[54])
         );
  DFFX1_RVT \count_instr_reg[55]  ( .D(n3838), .CLK(clk), .Q(count_instr[55])
         );
  DFFX1_RVT \count_instr_reg[56]  ( .D(n3837), .CLK(clk), .Q(count_instr[56])
         );
  DFFX1_RVT \count_instr_reg[57]  ( .D(n3836), .CLK(clk), .Q(count_instr[57])
         );
  DFFX1_RVT \count_instr_reg[58]  ( .D(n3835), .CLK(clk), .Q(count_instr[58])
         );
  DFFX1_RVT \count_instr_reg[59]  ( .D(n3834), .CLK(clk), .Q(count_instr[59])
         );
  DFFX1_RVT \count_instr_reg[60]  ( .D(n3833), .CLK(clk), .Q(count_instr[60])
         );
  DFFX1_RVT \count_instr_reg[61]  ( .D(n3832), .CLK(clk), .Q(count_instr[61])
         );
  DFFX1_RVT \count_instr_reg[62]  ( .D(n3831), .CLK(clk), .Q(count_instr[62])
         );
  DFFX1_RVT \count_instr_reg[63]  ( .D(n3830), .CLK(clk), .Q(count_instr[63]), 
        .QN(n8057) );
  DFFX1_RVT is_sll_srl_sra_reg ( .D(n3627), .CLK(clk), .Q(is_sll_srl_sra), 
        .QN(n8055) );
  DFFX1_RVT \cpu_state_reg[3]  ( .D(n3669), .CLK(clk), .Q(cpu_state[3]), .QN(
        n4643) );
  DFFX1_RVT trap_reg ( .D(N2097), .CLK(clk), .Q(trap) );
  DFFX1_RVT mem_valid_reg ( .D(n3704), .CLK(clk), .Q(mem_valid), .QN(n4637) );
  DFFX1_RVT \decoded_rd_reg[0]  ( .D(n3695), .CLK(clk), .Q(decoded_rd[0]) );
  DFFX1_RVT \decoded_rd_reg[1]  ( .D(n3696), .CLK(clk), .Q(decoded_rd[1]) );
  DFFX1_RVT \decoded_rd_reg[2]  ( .D(n3697), .CLK(clk), .Q(decoded_rd[2]) );
  DFFX1_RVT \decoded_rd_reg[3]  ( .D(n3698), .CLK(clk), .Q(decoded_rd[3]) );
  DFFX1_RVT \decoded_rd_reg[4]  ( .D(n3699), .CLK(clk), .Q(decoded_rd[4]) );
  DFFX1_RVT \decoded_imm_j_reg[12]  ( .D(n3615), .CLK(clk), .Q(
        decoded_imm_j[12]) );
  DFFX1_RVT \decoded_imm_j_reg[13]  ( .D(n3614), .CLK(clk), .Q(
        decoded_imm_j[13]) );
  DFFX1_RVT \decoded_imm_j_reg[14]  ( .D(n3613), .CLK(clk), .Q(
        decoded_imm_j[14]) );
  DFFX1_RVT \decoded_imm_j_reg[15]  ( .D(n3612), .CLK(clk), .Q(
        decoded_imm_j[15]), .QN(n8019) );
  DFFX1_RVT \decoded_imm_j_reg[16]  ( .D(n3611), .CLK(clk), .Q(
        decoded_imm_j[16]), .QN(n7982) );
  DFFX1_RVT \decoded_imm_j_reg[17]  ( .D(n3610), .CLK(clk), .Q(
        decoded_imm_j[17]), .QN(n8013) );
  DFFX1_RVT \decoded_imm_j_reg[18]  ( .D(n3609), .CLK(clk), .Q(
        decoded_imm_j[18]), .QN(n7978) );
  DFFX1_RVT \decoded_imm_j_reg[11]  ( .D(n3616), .CLK(clk), .Q(
        decoded_imm_j[11]), .QN(n7979) );
  DFFX1_RVT \decoded_imm_j_reg[1]  ( .D(n3626), .CLK(clk), .Q(decoded_imm_j[1]), .QN(n8016) );
  DFFX1_RVT \decoded_imm_j_reg[2]  ( .D(n3625), .CLK(clk), .Q(decoded_imm_j[2]), .QN(n8017) );
  DFFX1_RVT \decoded_imm_j_reg[3]  ( .D(n3624), .CLK(clk), .Q(decoded_imm_j[3]), .QN(n7975) );
  DFFX1_RVT \decoded_imm_j_reg[4]  ( .D(n3623), .CLK(clk), .Q(decoded_imm_j[4]), .QN(n8014) );
  DFFX1_RVT \decoded_imm_j_reg[5]  ( .D(n3622), .CLK(clk), .Q(decoded_imm_j[5]) );
  DFFX1_RVT \decoded_imm_j_reg[6]  ( .D(n3621), .CLK(clk), .Q(decoded_imm_j[6]) );
  DFFX1_RVT \decoded_imm_j_reg[7]  ( .D(n3620), .CLK(clk), .Q(decoded_imm_j[7]) );
  DFFX1_RVT \decoded_imm_j_reg[8]  ( .D(n3619), .CLK(clk), .Q(decoded_imm_j[8]) );
  DFFX1_RVT \decoded_imm_j_reg[9]  ( .D(n3618), .CLK(clk), .Q(decoded_imm_j[9]) );
  DFFX1_RVT \decoded_imm_j_reg[10]  ( .D(n3617), .CLK(clk), .Q(
        decoded_imm_j[10]) );
  DFFX1_RVT instr_fence_reg ( .D(n3743), .CLK(clk), .Q(instr_fence) );
  DFFX1_RVT instr_rdinstrh_reg ( .D(n3690), .CLK(clk), .Q(instr_rdinstrh), 
        .QN(n8037) );
  DFFX1_RVT instr_rdinstr_reg ( .D(n3689), .CLK(clk), .Q(instr_rdinstr) );
  DFFX1_RVT instr_rdcycleh_reg ( .D(n3688), .CLK(clk), .Q(instr_rdcycleh), 
        .QN(n8034) );
  DFFX1_RVT instr_rdcycle_reg ( .D(n3687), .CLK(clk), .Q(instr_rdcycle), .QN(
        n7983) );
  DFFX1_RVT is_beq_bne_blt_bge_bltu_bgeu_reg ( .D(n3742), .CLK(clk), .Q(
        is_beq_bne_blt_bge_bltu_bgeu), .QN(n8018) );
  DFFX1_RVT instr_beq_reg ( .D(n3765), .CLK(clk), .Q(instr_beq) );
  DFFX1_RVT instr_blt_reg ( .D(n3763), .CLK(clk), .Q(instr_blt) );
  DFFX1_RVT instr_bne_reg ( .D(n3764), .CLK(clk), .Q(instr_bne), .QN(n8050) );
  DFFX1_RVT instr_bge_reg ( .D(n3762), .CLK(clk), .Q(instr_bge), .QN(n8051) );
  DFFX1_RVT instr_bltu_reg ( .D(n3761), .CLK(clk), .Q(instr_bltu) );
  DFFX1_RVT instr_bgeu_reg ( .D(n3760), .CLK(clk), .Q(instr_bgeu), .QN(n8048)
         );
  DFFX1_RVT instr_jalr_reg ( .D(n3692), .CLK(clk), .Q(instr_jalr), .QN(n7969)
         );
  DFFX1_RVT mem_do_prefetch_reg ( .D(n3707), .CLK(clk), .Q(mem_do_prefetch), 
        .QN(n4534) );
  DFFX1_RVT is_lb_lh_lw_lbu_lhu_reg ( .D(n3684), .CLK(clk), .Q(
        is_lb_lh_lw_lbu_lhu), .QN(n7984) );
  DFFX1_RVT instr_lb_reg ( .D(n3683), .CLK(clk), .Q(instr_lb) );
  DFFX1_RVT instr_lh_reg ( .D(n3682), .CLK(clk), .Q(instr_lh) );
  DFFX1_RVT instr_lw_reg ( .D(n3681), .CLK(clk), .Q(instr_lw) );
  DFFX1_RVT instr_lbu_reg ( .D(n3680), .CLK(clk), .Q(instr_lbu) );
  DFFX1_RVT instr_lhu_reg ( .D(n3679), .CLK(clk), .Q(instr_lhu) );
  DFFX1_RVT is_lbu_lhu_lw_reg ( .D(N286), .CLK(clk), .Q(is_lbu_lhu_lw) );
  DFFX1_RVT is_sb_sh_sw_reg ( .D(n3678), .CLK(clk), .Q(is_sb_sh_sw), .QN(n8047) );
  DFFX1_RVT instr_sb_reg ( .D(n3677), .CLK(clk), .Q(instr_sb), .QN(n8066) );
  DFFX1_RVT instr_sh_reg ( .D(n3676), .CLK(clk), .Q(instr_sh) );
  DFFX1_RVT instr_sw_reg ( .D(n3675), .CLK(clk), .Q(instr_sw) );
  DFFX1_RVT instr_lui_reg ( .D(n3694), .CLK(clk), .Q(instr_lui), .QN(n8038) );
  DFFX1_RVT instr_auipc_reg ( .D(n3693), .CLK(clk), .Q(instr_auipc) );
  DFFX1_RVT is_lui_auipc_jal_reg ( .D(N282), .CLK(clk), .Q(is_lui_auipc_jal)
         );
  DFFX1_RVT is_alu_reg_imm_reg ( .D(n3634), .CLK(clk), .Q(is_alu_reg_imm), 
        .QN(n8022) );
  DFFX1_RVT instr_addi_reg ( .D(n3759), .CLK(clk), .Q(instr_addi) );
  DFFX1_RVT instr_slti_reg ( .D(n3758), .CLK(clk), .Q(instr_slti) );
  DFFX1_RVT instr_sltiu_reg ( .D(n3757), .CLK(clk), .Q(instr_sltiu) );
  DFFX1_RVT instr_xori_reg ( .D(n3756), .CLK(clk), .Q(instr_xori) );
  DFFX1_RVT instr_ori_reg ( .D(n3755), .CLK(clk), .Q(instr_ori) );
  DFFX1_RVT instr_andi_reg ( .D(n3754), .CLK(clk), .Q(instr_andi) );
  DFFX1_RVT instr_slli_reg ( .D(n3633), .CLK(clk), .Q(instr_slli) );
  DFFX1_RVT instr_srli_reg ( .D(n3632), .CLK(clk), .Q(instr_srli) );
  DFFX1_RVT instr_srai_reg ( .D(n3631), .CLK(clk), .Q(instr_srai) );
  DFFX1_RVT is_slli_srli_srai_reg ( .D(n3630), .CLK(clk), .Q(is_slli_srli_srai) );
  DFFX1_RVT is_jalr_addi_slti_sltiu_xori_ori_andi_reg ( .D(n3629), .CLK(clk), 
        .Q(is_jalr_addi_slti_sltiu_xori_ori_andi) );
  DFFX1_RVT is_alu_reg_reg_reg ( .D(n3628), .CLK(clk), .Q(is_alu_reg_reg) );
  DFFX1_RVT instr_sra_reg ( .D(n3746), .CLK(clk), .Q(instr_sra) );
  DFFX1_RVT instr_sll_reg ( .D(n3751), .CLK(clk), .Q(instr_sll) );
  DFFX1_RVT instr_srl_reg ( .D(n3747), .CLK(clk), .Q(instr_srl) );
  DFFX1_RVT instr_add_reg ( .D(n3753), .CLK(clk), .Q(instr_add) );
  DFFX1_RVT is_lui_auipc_jal_jalr_addi_add_sub_reg ( .D(N375), .CLK(clk), .Q(
        is_lui_auipc_jal_jalr_addi_add_sub), .QN(n7976) );
  DFFX1_RVT instr_slt_reg ( .D(n3750), .CLK(clk), .Q(instr_slt) );
  DFFX1_RVT is_slti_blt_slt_reg ( .D(N284), .CLK(clk), .Q(is_slti_blt_slt), 
        .QN(n8052) );
  DFFX1_RVT instr_xor_reg ( .D(n3748), .CLK(clk), .Q(instr_xor) );
  DFFX1_RVT instr_or_reg ( .D(n3745), .CLK(clk), .Q(instr_or) );
  DFFX1_RVT instr_sltu_reg ( .D(n3749), .CLK(clk), .Q(instr_sltu) );
  DFFX1_RVT is_compare_reg ( .D(N379), .CLK(clk), .Q(is_compare), .QN(n8043)
         );
  DFFX1_RVT is_sltiu_bltu_sltu_reg ( .D(N285), .CLK(clk), .Q(
        is_sltiu_bltu_sltu) );
  DFFX1_RVT instr_and_reg ( .D(n3744), .CLK(clk), .Q(instr_and) );
  DFFX1_RVT \cpu_state_reg[0]  ( .D(n3672), .CLK(clk), .Q(cpu_state[0]), .QN(
        n4642) );
  DFFX1_RVT \cpu_state_reg[1]  ( .D(n3671), .CLK(clk), .Q(cpu_state[1]), .QN(
        n4641) );
  DFFX1_RVT \cpu_state_reg[2]  ( .D(n3670), .CLK(clk), .Q(cpu_state[2]), .QN(
        n8010) );
  DFFX1_RVT latched_is_lb_reg ( .D(n3898), .CLK(clk), .Q(latched_is_lb) );
  DFFX1_RVT latched_is_lh_reg ( .D(n3897), .CLK(clk), .Q(latched_is_lh) );
  DFFX1_RVT latched_is_lu_reg ( .D(n3896), .CLK(clk), .Q(latched_is_lu), .QN(
        n8049) );
  DFFX1_RVT mem_instr_reg ( .D(n3706), .CLK(clk), .Q(mem_instr) );
  DFFX1_RVT \mem_wordsize_reg[0]  ( .D(n3674), .CLK(clk), .Q(mem_wordsize[0]), 
        .QN(n7971) );
  DFFX1_RVT \mem_wordsize_reg[1]  ( .D(n3673), .CLK(clk), .Q(mem_wordsize[1]), 
        .QN(n8070) );
  DFFX1_RVT decoder_pseudo_trigger_reg ( .D(N2107), .CLK(clk), .Q(
        decoder_pseudo_trigger) );
  DFFX1_RVT \decoded_imm_reg[0]  ( .D(n3741), .CLK(clk), .Q(decoded_imm[0]), 
        .QN(net16308) );
  DFFX1_RVT \decoded_imm_reg[1]  ( .D(n3606), .CLK(clk), .Q(decoded_imm[1]) );
  DFFX1_RVT \decoded_imm_reg[2]  ( .D(n3605), .CLK(clk), .Q(decoded_imm[2]) );
  DFFX1_RVT \decoded_imm_reg[3]  ( .D(n3604), .CLK(clk), .Q(decoded_imm[3]), 
        .QN(net26760) );
  DFFX1_RVT \decoded_imm_reg[4]  ( .D(n3603), .CLK(clk), .Q(decoded_imm[4]) );
  DFFX1_RVT \decoded_imm_reg[5]  ( .D(n3602), .CLK(clk), .Q(decoded_imm[5]) );
  DFFX1_RVT \decoded_imm_reg[6]  ( .D(n3601), .CLK(clk), .Q(decoded_imm[6]) );
  DFFX1_RVT \decoded_imm_reg[7]  ( .D(n3600), .CLK(clk), .Q(decoded_imm[7]) );
  DFFX1_RVT \decoded_imm_reg[8]  ( .D(n3599), .CLK(clk), .Q(decoded_imm[8]) );
  DFFX1_RVT \decoded_imm_reg[9]  ( .D(n3598), .CLK(clk), .Q(decoded_imm[9]) );
  DFFX1_RVT \decoded_imm_reg[10]  ( .D(n3597), .CLK(clk), .Q(decoded_imm[10])
         );
  DFFX1_RVT \decoded_imm_reg[11]  ( .D(n3596), .CLK(clk), .Q(decoded_imm[11])
         );
  DFFX1_RVT \decoded_imm_reg[12]  ( .D(n3595), .CLK(clk), .Q(decoded_imm[12])
         );
  DFFX1_RVT \decoded_imm_reg[13]  ( .D(n3594), .CLK(clk), .Q(decoded_imm[13])
         );
  DFFX1_RVT \decoded_imm_reg[14]  ( .D(n3593), .CLK(clk), .Q(decoded_imm[14])
         );
  DFFX1_RVT \decoded_imm_reg[15]  ( .D(n3592), .CLK(clk), .Q(decoded_imm[15])
         );
  DFFX1_RVT \decoded_imm_reg[16]  ( .D(n3591), .CLK(clk), .Q(decoded_imm[16])
         );
  DFFX1_RVT \decoded_imm_reg[17]  ( .D(n3590), .CLK(clk), .Q(decoded_imm[17])
         );
  DFFX1_RVT \decoded_imm_reg[18]  ( .D(n3589), .CLK(clk), .Q(decoded_imm[18])
         );
  DFFX1_RVT \decoded_imm_reg[19]  ( .D(n3588), .CLK(clk), .Q(decoded_imm[19])
         );
  DFFX1_RVT \decoded_imm_reg[20]  ( .D(n3587), .CLK(clk), .Q(decoded_imm[20])
         );
  DFFX1_RVT \decoded_imm_reg[21]  ( .D(n3586), .CLK(clk), .Q(decoded_imm[21])
         );
  DFFX1_RVT \decoded_imm_reg[22]  ( .D(n3585), .CLK(clk), .Q(decoded_imm[22])
         );
  DFFX1_RVT \decoded_imm_reg[23]  ( .D(n3584), .CLK(clk), .Q(decoded_imm[23])
         );
  DFFX1_RVT \decoded_imm_reg[24]  ( .D(n3583), .CLK(clk), .Q(decoded_imm[24])
         );
  DFFX1_RVT \decoded_imm_reg[25]  ( .D(n3582), .CLK(clk), .Q(decoded_imm[25])
         );
  DFFX1_RVT \decoded_imm_reg[26]  ( .D(n3581), .CLK(clk), .Q(decoded_imm[26])
         );
  DFFX1_RVT \decoded_imm_reg[27]  ( .D(n3580), .CLK(clk), .Q(decoded_imm[27])
         );
  DFFX1_RVT \decoded_imm_reg[28]  ( .D(n3579), .CLK(clk), .Q(decoded_imm[28])
         );
  DFFX1_RVT \decoded_imm_reg[29]  ( .D(n3578), .CLK(clk), .Q(decoded_imm[29])
         );
  DFFX1_RVT latched_stalu_reg ( .D(n3895), .CLK(clk), .Q(latched_stalu), .QN(
        n8009) );
  DFFX1_RVT latched_store_reg ( .D(n3894), .CLK(clk), .Q(latched_store), .QN(
        n4798) );
  DFFX1_RVT \latched_rd_reg[0]  ( .D(n3571), .CLK(clk), .Q(latched_rd[0]), 
        .QN(n8020) );
  DFFX1_RVT \latched_rd_reg[1]  ( .D(n3570), .CLK(clk), .Q(latched_rd[1]), 
        .QN(n8011) );
  DFFX1_RVT \latched_rd_reg[2]  ( .D(n3569), .CLK(clk), .Q(latched_rd[2]), 
        .QN(n7981) );
  DFFX1_RVT \cpuregs_reg[7][30]  ( .D(n2796), .CLK(clk), .Q(\cpuregs[7][30] )
         );
  DFFX1_RVT \cpuregs_reg[7][4]  ( .D(n2770), .CLK(clk), .Q(\cpuregs[7][4] ) );
  DFFX1_RVT \cpuregs_reg[6][30]  ( .D(n2764), .CLK(clk), .Q(\cpuregs[6][30] )
         );
  DFFX1_RVT \cpuregs_reg[6][4]  ( .D(n2738), .CLK(clk), .Q(\cpuregs[6][4] ) );
  DFFX1_RVT \cpuregs_reg[5][30]  ( .D(n2732), .CLK(clk), .Q(\cpuregs[5][30] )
         );
  DFFX1_RVT \cpuregs_reg[5][4]  ( .D(n2706), .CLK(clk), .Q(\cpuregs[5][4] ) );
  DFFX1_RVT \cpuregs_reg[4][30]  ( .D(n2700), .CLK(clk), .Q(\cpuregs[4][30] )
         );
  DFFX1_RVT \cpuregs_reg[4][4]  ( .D(n2674), .CLK(clk), .Q(\cpuregs[4][4] ) );
  DFFX1_RVT \cpuregs_reg[3][30]  ( .D(n2668), .CLK(clk), .Q(\cpuregs[3][30] )
         );
  DFFX1_RVT \cpuregs_reg[3][4]  ( .D(n2642), .CLK(clk), .Q(\cpuregs[3][4] ) );
  DFFX1_RVT \cpuregs_reg[2][30]  ( .D(n2636), .CLK(clk), .Q(\cpuregs[2][30] )
         );
  DFFX1_RVT \cpuregs_reg[2][4]  ( .D(n2610), .CLK(clk), .Q(\cpuregs[2][4] ) );
  DFFX1_RVT \latched_rd_reg[3]  ( .D(n3568), .CLK(clk), .Q(latched_rd[3]), 
        .QN(n8012) );
  DFFX1_RVT \latched_rd_reg[4]  ( .D(n3567), .CLK(clk), .Q(latched_rd[4]), 
        .QN(n8015) );
  DFFX1_RVT \cpuregs_reg[31][30]  ( .D(n3564), .CLK(clk), .Q(\cpuregs[31][30] ) );
  DFFX1_RVT \cpuregs_reg[31][4]  ( .D(n3538), .CLK(clk), .Q(\cpuregs[31][4] )
         );
  DFFX1_RVT \cpuregs_reg[30][30]  ( .D(n3532), .CLK(clk), .Q(\cpuregs[30][30] ) );
  DFFX1_RVT \cpuregs_reg[30][4]  ( .D(n3506), .CLK(clk), .Q(\cpuregs[30][4] )
         );
  DFFX1_RVT \cpuregs_reg[29][30]  ( .D(n3500), .CLK(clk), .Q(\cpuregs[29][30] ) );
  DFFX1_RVT \cpuregs_reg[29][4]  ( .D(n3474), .CLK(clk), .Q(\cpuregs[29][4] )
         );
  DFFX1_RVT \cpuregs_reg[28][30]  ( .D(n3468), .CLK(clk), .Q(\cpuregs[28][30] ) );
  DFFX1_RVT \cpuregs_reg[28][4]  ( .D(n3442), .CLK(clk), .Q(\cpuregs[28][4] )
         );
  DFFX1_RVT \cpuregs_reg[27][30]  ( .D(n3436), .CLK(clk), .Q(\cpuregs[27][30] ) );
  DFFX1_RVT \cpuregs_reg[27][4]  ( .D(n3410), .CLK(clk), .Q(\cpuregs[27][4] )
         );
  DFFX1_RVT \cpuregs_reg[26][30]  ( .D(n3404), .CLK(clk), .Q(\cpuregs[26][30] ) );
  DFFX1_RVT \cpuregs_reg[26][4]  ( .D(n3378), .CLK(clk), .Q(\cpuregs[26][4] )
         );
  DFFX1_RVT \cpuregs_reg[25][30]  ( .D(n3372), .CLK(clk), .Q(\cpuregs[25][30] ) );
  DFFX1_RVT \cpuregs_reg[25][4]  ( .D(n3346), .CLK(clk), .Q(\cpuregs[25][4] )
         );
  DFFX1_RVT \cpuregs_reg[24][30]  ( .D(n3340), .CLK(clk), .Q(\cpuregs[24][30] ) );
  DFFX1_RVT \cpuregs_reg[24][4]  ( .D(n3314), .CLK(clk), .Q(\cpuregs[24][4] )
         );
  DFFX1_RVT \cpuregs_reg[23][30]  ( .D(n3308), .CLK(clk), .Q(\cpuregs[23][30] ) );
  DFFX1_RVT \cpuregs_reg[23][4]  ( .D(n3282), .CLK(clk), .Q(\cpuregs[23][4] )
         );
  DFFX1_RVT \cpuregs_reg[22][30]  ( .D(n3276), .CLK(clk), .Q(\cpuregs[22][30] ) );
  DFFX1_RVT \cpuregs_reg[22][4]  ( .D(n3250), .CLK(clk), .Q(\cpuregs[22][4] )
         );
  DFFX1_RVT \cpuregs_reg[21][30]  ( .D(n3244), .CLK(clk), .Q(\cpuregs[21][30] ) );
  DFFX1_RVT \cpuregs_reg[21][4]  ( .D(n3218), .CLK(clk), .Q(\cpuregs[21][4] )
         );
  DFFX1_RVT \cpuregs_reg[20][30]  ( .D(n3212), .CLK(clk), .Q(\cpuregs[20][30] ) );
  DFFX1_RVT \cpuregs_reg[20][4]  ( .D(n3186), .CLK(clk), .Q(\cpuregs[20][4] )
         );
  DFFX1_RVT \cpuregs_reg[19][30]  ( .D(n3180), .CLK(clk), .Q(\cpuregs[19][30] ) );
  DFFX1_RVT \cpuregs_reg[19][4]  ( .D(n3154), .CLK(clk), .Q(\cpuregs[19][4] )
         );
  DFFX1_RVT \cpuregs_reg[18][30]  ( .D(n3148), .CLK(clk), .Q(\cpuregs[18][30] ) );
  DFFX1_RVT \cpuregs_reg[18][4]  ( .D(n3122), .CLK(clk), .Q(\cpuregs[18][4] )
         );
  DFFX1_RVT \cpuregs_reg[17][30]  ( .D(n3116), .CLK(clk), .Q(\cpuregs[17][30] ) );
  DFFX1_RVT \cpuregs_reg[17][4]  ( .D(n3090), .CLK(clk), .Q(\cpuregs[17][4] )
         );
  DFFX1_RVT \cpuregs_reg[16][30]  ( .D(n3084), .CLK(clk), .Q(\cpuregs[16][30] ) );
  DFFX1_RVT \cpuregs_reg[16][4]  ( .D(n3058), .CLK(clk), .Q(\cpuregs[16][4] )
         );
  DFFX1_RVT \cpuregs_reg[15][30]  ( .D(n3052), .CLK(clk), .Q(\cpuregs[15][30] ) );
  DFFX1_RVT \cpuregs_reg[15][4]  ( .D(n3026), .CLK(clk), .Q(\cpuregs[15][4] )
         );
  DFFX1_RVT \cpuregs_reg[14][30]  ( .D(n3020), .CLK(clk), .Q(\cpuregs[14][30] ) );
  DFFX1_RVT \cpuregs_reg[14][4]  ( .D(n2994), .CLK(clk), .Q(\cpuregs[14][4] )
         );
  DFFX1_RVT \cpuregs_reg[13][30]  ( .D(n2988), .CLK(clk), .Q(\cpuregs[13][30] ) );
  DFFX1_RVT \cpuregs_reg[13][4]  ( .D(n2962), .CLK(clk), .Q(\cpuregs[13][4] )
         );
  DFFX1_RVT \cpuregs_reg[12][30]  ( .D(n2956), .CLK(clk), .Q(\cpuregs[12][30] ) );
  DFFX1_RVT \cpuregs_reg[12][4]  ( .D(n2930), .CLK(clk), .Q(\cpuregs[12][4] )
         );
  DFFX1_RVT \cpuregs_reg[11][30]  ( .D(n2924), .CLK(clk), .Q(\cpuregs[11][30] ) );
  DFFX1_RVT \cpuregs_reg[11][4]  ( .D(n2898), .CLK(clk), .Q(\cpuregs[11][4] )
         );
  DFFX1_RVT \cpuregs_reg[10][30]  ( .D(n2892), .CLK(clk), .Q(\cpuregs[10][30] ) );
  DFFX1_RVT \cpuregs_reg[10][4]  ( .D(n2866), .CLK(clk), .Q(\cpuregs[10][4] )
         );
  DFFX1_RVT \cpuregs_reg[9][30]  ( .D(n2860), .CLK(clk), .Q(\cpuregs[9][30] )
         );
  DFFX1_RVT \cpuregs_reg[9][4]  ( .D(n2834), .CLK(clk), .Q(\cpuregs[9][4] ) );
  DFFX1_RVT \cpuregs_reg[8][0]  ( .D(n2830), .CLK(clk), .Q(\cpuregs[8][0] ) );
  DFFX1_RVT \reg_op1_reg[0]  ( .D(n3740), .CLK(clk), .Q(n8094), .QN(net16449)
         );
  DFFX1_RVT \reg_out_reg[7]  ( .D(eco_reg_out_d[7]), .CLK(clk), .Q(reg_out[7]) );
  DFFX1_RVT \reg_out_reg[8]  ( .D(eco_reg_out_d[8]), .CLK(clk), .Q(reg_out[8]) );
  DFFX1_RVT \reg_out_reg[9]  ( .D(eco_reg_out_d[9]), .CLK(clk), .Q(reg_out[9]) );
  DFFX1_RVT \reg_out_reg[10]  ( .D(eco_reg_out_d[10]), .CLK(clk), .Q(reg_out[10]) );
  DFFX1_RVT \reg_out_reg[11]  ( .D(eco_reg_out_d[11]), .CLK(clk), .Q(reg_out[11]) );
  DFFX1_RVT \reg_out_reg[12]  ( .D(eco_reg_out_d[12]), .CLK(clk), .Q(reg_out[12]) );
  DFFX1_RVT \reg_out_reg[13]  ( .D(eco_reg_out_d[13]), .CLK(clk), .Q(reg_out[13]) );
  DFFX1_RVT \reg_out_reg[14]  ( .D(eco_reg_out_d[14]), .CLK(clk), .Q(reg_out[14]) );
  DFFX1_RVT \reg_out_reg[15]  ( .D(eco_reg_out_d[15]), .CLK(clk), .Q(reg_out[15]) );
  DFFX1_RVT \reg_out_reg[16]  ( .D(eco_reg_out_d[16]), .CLK(clk), .Q(reg_out[16]) );
  DFFX1_RVT \reg_out_reg[17]  ( .D(eco_reg_out_d[17]), .CLK(clk), .Q(reg_out[17]) );
  DFFX1_RVT \reg_out_reg[18]  ( .D(eco_reg_out_d[18]), .CLK(clk), .Q(reg_out[18]) );
  DFFX1_RVT \reg_out_reg[19]  ( .D(eco_reg_out_d[19]), .CLK(clk), .Q(reg_out[19]) );
  DFFX1_RVT \reg_out_reg[20]  ( .D(eco_reg_out_d[20]), .CLK(clk), .Q(reg_out[20]) );
  DFFX1_RVT \reg_out_reg[21]  ( .D(eco_reg_out_d[21]), .CLK(clk), .Q(reg_out[21]) );
  DFFX1_RVT \reg_out_reg[22]  ( .D(eco_reg_out_d[22]), .CLK(clk), .Q(reg_out[22]) );
  DFFX1_RVT \reg_out_reg[23]  ( .D(eco_reg_out_d[23]), .CLK(clk), .Q(reg_out[23]) );
  DFFX1_RVT \reg_out_reg[24]  ( .D(eco_reg_out_d[24]), .CLK(clk), .Q(reg_out[24]) );
  DFFX1_RVT \reg_out_reg[25]  ( .D(eco_reg_out_d[25]), .CLK(clk), .Q(reg_out[25]) );
  DFFX1_RVT \reg_out_reg[26]  ( .D(eco_reg_out_d[26]), .CLK(clk), .Q(reg_out[26]) );
  DFFX1_RVT \reg_out_reg[27]  ( .D(eco_reg_out_d[27]), .CLK(clk), .Q(reg_out[27]) );
  DFFX1_RVT \reg_out_reg[28]  ( .D(eco_reg_out_d[28]), .CLK(clk), .Q(reg_out[28]) );
  DFFX1_RVT \reg_out_reg[29]  ( .D(eco_reg_out_d[29]), .CLK(clk), .Q(reg_out[29]) );
  DFFX1_RVT \reg_out_reg[30]  ( .D(eco_reg_out_d[30]), .CLK(clk), .Q(reg_out[30]) );
  DFFX1_RVT \reg_next_pc_reg[30]  ( .D(n3799), .CLK(clk), .Q(reg_next_pc[30])
         );
  DFFX1_RVT \reg_pc_reg[30]  ( .D(n3767), .CLK(clk), .Q(reg_pc[30]) );
  DFFX1_RVT \reg_out_reg[31]  ( .D(eco_reg_out_d[31]), .CLK(clk), .Q(reg_out[31]) );
  DFFX1_RVT \reg_out_reg[6]  ( .D(eco_reg_out_d[6]), .CLK(clk), .Q(reg_out[6]) );
  DFFX1_RVT \reg_out_reg[5]  ( .D(eco_reg_out_d[5]), .CLK(clk), .Q(reg_out[5]) );
  DFFX1_RVT \reg_out_reg[4]  ( .D(eco_reg_out_d[4]), .CLK(clk), .Q(reg_out[4]) );
  DFFX1_RVT \reg_next_pc_reg[4]  ( .D(n3825), .CLK(clk), .Q(reg_next_pc[4]) );
  DFFX1_RVT \reg_pc_reg[4]  ( .D(n3793), .CLK(clk), .Q(reg_pc[4]) );
  DFFX1_RVT \reg_out_reg[1]  ( .D(eco_reg_out_d[1]), .CLK(clk), .Q(reg_out[1]) );
  DFFX1_RVT \reg_out_reg[0]  ( .D(eco_reg_out_d[0]), .CLK(clk), .Q(reg_out[0]) );
  DFFX1_RVT \cpuregs_reg[31][0]  ( .D(n3566), .CLK(clk), .Q(\cpuregs[31][0] )
         );
  DFFX1_RVT \cpuregs_reg[30][0]  ( .D(n3534), .CLK(clk), .Q(\cpuregs[30][0] )
         );
  DFFX1_RVT \cpuregs_reg[29][0]  ( .D(n3502), .CLK(clk), .Q(\cpuregs[29][0] )
         );
  DFFX1_RVT \cpuregs_reg[28][0]  ( .D(n3470), .CLK(clk), .Q(\cpuregs[28][0] )
         );
  DFFX1_RVT \cpuregs_reg[27][0]  ( .D(n3438), .CLK(clk), .Q(\cpuregs[27][0] )
         );
  DFFX1_RVT \cpuregs_reg[26][0]  ( .D(n3406), .CLK(clk), .Q(\cpuregs[26][0] )
         );
  DFFX1_RVT \cpuregs_reg[25][0]  ( .D(n3374), .CLK(clk), .Q(\cpuregs[25][0] )
         );
  DFFX1_RVT \cpuregs_reg[24][0]  ( .D(n3342), .CLK(clk), .Q(\cpuregs[24][0] )
         );
  DFFX1_RVT \cpuregs_reg[23][0]  ( .D(n3310), .CLK(clk), .Q(\cpuregs[23][0] )
         );
  DFFX1_RVT \cpuregs_reg[22][0]  ( .D(n3278), .CLK(clk), .Q(\cpuregs[22][0] )
         );
  DFFX1_RVT \cpuregs_reg[21][0]  ( .D(n3246), .CLK(clk), .Q(\cpuregs[21][0] )
         );
  DFFX1_RVT \cpuregs_reg[20][0]  ( .D(n3214), .CLK(clk), .Q(\cpuregs[20][0] )
         );
  DFFX1_RVT \cpuregs_reg[19][0]  ( .D(n3182), .CLK(clk), .Q(\cpuregs[19][0] )
         );
  DFFX1_RVT \cpuregs_reg[18][0]  ( .D(n3150), .CLK(clk), .Q(\cpuregs[18][0] )
         );
  DFFX1_RVT \cpuregs_reg[17][0]  ( .D(n3118), .CLK(clk), .Q(\cpuregs[17][0] )
         );
  DFFX1_RVT \cpuregs_reg[16][0]  ( .D(n3086), .CLK(clk), .Q(\cpuregs[16][0] )
         );
  DFFX1_RVT \cpuregs_reg[15][0]  ( .D(n3054), .CLK(clk), .Q(\cpuregs[15][0] )
         );
  DFFX1_RVT \cpuregs_reg[14][0]  ( .D(n3022), .CLK(clk), .Q(\cpuregs[14][0] )
         );
  DFFX1_RVT \cpuregs_reg[13][0]  ( .D(n2990), .CLK(clk), .Q(\cpuregs[13][0] )
         );
  DFFX1_RVT \cpuregs_reg[12][0]  ( .D(n2958), .CLK(clk), .Q(\cpuregs[12][0] )
         );
  DFFX1_RVT \cpuregs_reg[11][0]  ( .D(n2926), .CLK(clk), .Q(\cpuregs[11][0] )
         );
  DFFX1_RVT \cpuregs_reg[10][0]  ( .D(n2894), .CLK(clk), .Q(\cpuregs[10][0] )
         );
  DFFX1_RVT \cpuregs_reg[9][0]  ( .D(n2862), .CLK(clk), .Q(\cpuregs[9][0] ) );
  DFFX1_RVT \cpuregs_reg[7][0]  ( .D(n2798), .CLK(clk), .Q(\cpuregs[7][0] ) );
  DFFX1_RVT \cpuregs_reg[6][0]  ( .D(n2766), .CLK(clk), .Q(\cpuregs[6][0] ) );
  DFFX1_RVT \cpuregs_reg[5][0]  ( .D(n2734), .CLK(clk), .Q(\cpuregs[5][0] ) );
  DFFX1_RVT \cpuregs_reg[4][0]  ( .D(n2702), .CLK(clk), .Q(\cpuregs[4][0] ) );
  DFFX1_RVT \cpuregs_reg[3][0]  ( .D(n2670), .CLK(clk), .Q(\cpuregs[3][0] ) );
  DFFX1_RVT \cpuregs_reg[2][0]  ( .D(n2638), .CLK(clk), .Q(\cpuregs[2][0] ) );
  DFFX1_RVT \cpuregs_reg[1][0]  ( .D(n2606), .CLK(clk), .Q(\cpuregs[1][0] ) );
  DFFX1_RVT \reg_sh_reg[0]  ( .D(N1938), .CLK(clk), .Q(N1599), .QN(n8053) );
  DFFX1_RVT \reg_op2_reg[0]  ( .D(n3930), .CLK(clk), .Q(pcpi_rs2[0]), .QN(
        net16329) );
  DFFX1_RVT \alu_out_q_reg[0]  ( .D(alu_out[0]), .CLK(clk), .Q(alu_out_q[0])
         );
  DFFX1_RVT \cpuregs_reg[8][30]  ( .D(n2828), .CLK(clk), .Q(\cpuregs[8][30] )
         );
  DFFX1_RVT \cpuregs_reg[8][4]  ( .D(n2802), .CLK(clk), .Q(\cpuregs[8][4] ) );
  DFFX1_RVT \cpuregs_reg[8][2]  ( .D(n2800), .CLK(clk), .Q(\cpuregs[8][2] ) );
  DFFX1_RVT \reg_op1_reg[2]  ( .D(n3738), .CLK(clk), .Q(n8092), .QN(net16336)
         );
  DFFX1_RVT \reg_out_reg[2]  ( .D(eco_reg_out_d[2]), .CLK(clk), .Q(reg_out[2]) );
  DFFX1_RVT \reg_op1_reg[3]  ( .D(n3737), .CLK(clk), .Q(n8091), .QN(net16367)
         );
  DFFX1_RVT \reg_out_reg[3]  ( .D(eco_reg_out_d[3]), .CLK(clk), .Q(reg_out[3]) );
  DFFX1_RVT \alu_out_q_reg[3]  ( .D(alu_out[3]), .CLK(clk), .Q(alu_out_q[3])
         );
  DFFX1_RVT \reg_next_pc_reg[3]  ( .D(n3826), .CLK(clk), .Q(reg_next_pc[3]) );
  DFFX1_RVT \reg_pc_reg[3]  ( .D(n3794), .CLK(clk), .Q(reg_pc[3]) );
  DFFX1_RVT \cpuregs_reg[31][3]  ( .D(n3537), .CLK(clk), .Q(\cpuregs[31][3] )
         );
  DFFX1_RVT \cpuregs_reg[30][3]  ( .D(n3505), .CLK(clk), .Q(\cpuregs[30][3] )
         );
  DFFX1_RVT \cpuregs_reg[29][3]  ( .D(n3473), .CLK(clk), .Q(\cpuregs[29][3] )
         );
  DFFX1_RVT \cpuregs_reg[28][3]  ( .D(n3441), .CLK(clk), .Q(\cpuregs[28][3] )
         );
  DFFX1_RVT \cpuregs_reg[27][3]  ( .D(n3409), .CLK(clk), .Q(\cpuregs[27][3] )
         );
  DFFX1_RVT \cpuregs_reg[26][3]  ( .D(n3377), .CLK(clk), .Q(\cpuregs[26][3] )
         );
  DFFX1_RVT \cpuregs_reg[25][3]  ( .D(n3345), .CLK(clk), .Q(\cpuregs[25][3] )
         );
  DFFX1_RVT \cpuregs_reg[24][3]  ( .D(n3313), .CLK(clk), .Q(\cpuregs[24][3] )
         );
  DFFX1_RVT \cpuregs_reg[23][3]  ( .D(n3281), .CLK(clk), .Q(\cpuregs[23][3] )
         );
  DFFX1_RVT \cpuregs_reg[22][3]  ( .D(n3249), .CLK(clk), .Q(\cpuregs[22][3] )
         );
  DFFX1_RVT \cpuregs_reg[21][3]  ( .D(n3217), .CLK(clk), .Q(\cpuregs[21][3] )
         );
  DFFX1_RVT \cpuregs_reg[20][3]  ( .D(n3185), .CLK(clk), .Q(\cpuregs[20][3] )
         );
  DFFX1_RVT \cpuregs_reg[19][3]  ( .D(n3153), .CLK(clk), .Q(\cpuregs[19][3] )
         );
  DFFX1_RVT \cpuregs_reg[18][3]  ( .D(n3121), .CLK(clk), .Q(\cpuregs[18][3] )
         );
  DFFX1_RVT \cpuregs_reg[17][3]  ( .D(n3089), .CLK(clk), .Q(\cpuregs[17][3] )
         );
  DFFX1_RVT \cpuregs_reg[16][3]  ( .D(n3057), .CLK(clk), .Q(\cpuregs[16][3] )
         );
  DFFX1_RVT \cpuregs_reg[15][3]  ( .D(n3025), .CLK(clk), .Q(\cpuregs[15][3] )
         );
  DFFX1_RVT \cpuregs_reg[14][3]  ( .D(n2993), .CLK(clk), .Q(\cpuregs[14][3] )
         );
  DFFX1_RVT \cpuregs_reg[13][3]  ( .D(n2961), .CLK(clk), .Q(\cpuregs[13][3] )
         );
  DFFX1_RVT \cpuregs_reg[12][3]  ( .D(n2929), .CLK(clk), .Q(\cpuregs[12][3] )
         );
  DFFX1_RVT \cpuregs_reg[11][3]  ( .D(n2897), .CLK(clk), .Q(\cpuregs[11][3] )
         );
  DFFX1_RVT \cpuregs_reg[10][3]  ( .D(n2865), .CLK(clk), .Q(\cpuregs[10][3] )
         );
  DFFX1_RVT \cpuregs_reg[9][3]  ( .D(n2833), .CLK(clk), .Q(\cpuregs[9][3] ) );
  DFFX1_RVT \cpuregs_reg[8][3]  ( .D(n2801), .CLK(clk), .Q(\cpuregs[8][3] ) );
  DFFX1_RVT \cpuregs_reg[7][3]  ( .D(n2769), .CLK(clk), .Q(\cpuregs[7][3] ) );
  DFFX1_RVT \cpuregs_reg[6][3]  ( .D(n2737), .CLK(clk), .Q(\cpuregs[6][3] ) );
  DFFX1_RVT \cpuregs_reg[5][3]  ( .D(n2705), .CLK(clk), .Q(\cpuregs[5][3] ) );
  DFFX1_RVT \cpuregs_reg[4][3]  ( .D(n2673), .CLK(clk), .Q(\cpuregs[4][3] ) );
  DFFX1_RVT \cpuregs_reg[3][3]  ( .D(n2641), .CLK(clk), .Q(\cpuregs[3][3] ) );
  DFFX1_RVT \cpuregs_reg[2][3]  ( .D(n2609), .CLK(clk), .Q(\cpuregs[2][3] ) );
  DFFX1_RVT \cpuregs_reg[1][3]  ( .D(n2577), .CLK(clk), .Q(\cpuregs[1][3] ) );
  DFFX1_RVT \reg_sh_reg[3]  ( .D(N1941), .CLK(clk), .Q(reg_sh[3]), .QN(n4293)
         );
  DFFX1_RVT \reg_op2_reg[3]  ( .D(n3927), .CLK(clk), .Q(pcpi_rs2[3]), .QN(
        n7987) );
  DFFX1_RVT \alu_out_q_reg[2]  ( .D(alu_out[2]), .CLK(clk), .Q(alu_out_q[2])
         );
  DFFX1_RVT \reg_next_pc_reg[2]  ( .D(n3827), .CLK(clk), .Q(reg_next_pc[2]) );
  DFFX1_RVT \reg_pc_reg[2]  ( .D(n3795), .CLK(clk), .Q(reg_pc[2]), .QN(n8039)
         );
  DFFX1_RVT \cpuregs_reg[31][2]  ( .D(n3536), .CLK(clk), .Q(\cpuregs[31][2] )
         );
  DFFX1_RVT \cpuregs_reg[30][2]  ( .D(n3504), .CLK(clk), .Q(\cpuregs[30][2] )
         );
  DFFX1_RVT \cpuregs_reg[29][2]  ( .D(n3472), .CLK(clk), .Q(\cpuregs[29][2] )
         );
  DFFX1_RVT \cpuregs_reg[28][2]  ( .D(n3440), .CLK(clk), .Q(\cpuregs[28][2] )
         );
  DFFX1_RVT \cpuregs_reg[27][2]  ( .D(n3408), .CLK(clk), .Q(\cpuregs[27][2] )
         );
  DFFX1_RVT \cpuregs_reg[26][2]  ( .D(n3376), .CLK(clk), .Q(\cpuregs[26][2] )
         );
  DFFX1_RVT \cpuregs_reg[25][2]  ( .D(n3344), .CLK(clk), .Q(\cpuregs[25][2] )
         );
  DFFX1_RVT \cpuregs_reg[24][2]  ( .D(n3312), .CLK(clk), .Q(\cpuregs[24][2] )
         );
  DFFX1_RVT \cpuregs_reg[23][2]  ( .D(n3280), .CLK(clk), .Q(\cpuregs[23][2] )
         );
  DFFX1_RVT \cpuregs_reg[22][2]  ( .D(n3248), .CLK(clk), .Q(\cpuregs[22][2] )
         );
  DFFX1_RVT \cpuregs_reg[21][2]  ( .D(n3216), .CLK(clk), .Q(\cpuregs[21][2] )
         );
  DFFX1_RVT \cpuregs_reg[20][2]  ( .D(n3184), .CLK(clk), .Q(\cpuregs[20][2] )
         );
  DFFX1_RVT \cpuregs_reg[19][2]  ( .D(n3152), .CLK(clk), .Q(\cpuregs[19][2] )
         );
  DFFX1_RVT \cpuregs_reg[18][2]  ( .D(n3120), .CLK(clk), .Q(\cpuregs[18][2] )
         );
  DFFX1_RVT \cpuregs_reg[17][2]  ( .D(n3088), .CLK(clk), .Q(\cpuregs[17][2] )
         );
  DFFX1_RVT \cpuregs_reg[16][2]  ( .D(n3056), .CLK(clk), .Q(\cpuregs[16][2] )
         );
  DFFX1_RVT \cpuregs_reg[15][2]  ( .D(n3024), .CLK(clk), .Q(\cpuregs[15][2] )
         );
  DFFX1_RVT \cpuregs_reg[14][2]  ( .D(n2992), .CLK(clk), .Q(\cpuregs[14][2] )
         );
  DFFX1_RVT \cpuregs_reg[13][2]  ( .D(n2960), .CLK(clk), .Q(\cpuregs[13][2] )
         );
  DFFX1_RVT \cpuregs_reg[12][2]  ( .D(n2928), .CLK(clk), .Q(\cpuregs[12][2] )
         );
  DFFX1_RVT \cpuregs_reg[11][2]  ( .D(n2896), .CLK(clk), .Q(\cpuregs[11][2] )
         );
  DFFX1_RVT \cpuregs_reg[10][2]  ( .D(n2864), .CLK(clk), .Q(\cpuregs[10][2] )
         );
  DFFX1_RVT \cpuregs_reg[9][2]  ( .D(n2832), .CLK(clk), .Q(\cpuregs[9][2] ) );
  DFFX1_RVT \cpuregs_reg[7][2]  ( .D(n2768), .CLK(clk), .Q(\cpuregs[7][2] ) );
  DFFX1_RVT \cpuregs_reg[6][2]  ( .D(n2736), .CLK(clk), .Q(\cpuregs[6][2] ) );
  DFFX1_RVT \cpuregs_reg[5][2]  ( .D(n2704), .CLK(clk), .Q(\cpuregs[5][2] ) );
  DFFX1_RVT \cpuregs_reg[4][2]  ( .D(n2672), .CLK(clk), .Q(\cpuregs[4][2] ) );
  DFFX1_RVT \cpuregs_reg[3][2]  ( .D(n2640), .CLK(clk), .Q(\cpuregs[3][2] ) );
  DFFX1_RVT \cpuregs_reg[2][2]  ( .D(n2608), .CLK(clk), .Q(\cpuregs[2][2] ) );
  DFFX1_RVT \cpuregs_reg[1][2]  ( .D(n2576), .CLK(clk), .Q(\cpuregs[1][2] ) );
  DFFX1_RVT \reg_sh_reg[2]  ( .D(N1940), .CLK(clk), .Q(reg_sh[2]), .QN(n4530)
         );
  DFFX1_RVT \reg_op2_reg[2]  ( .D(n3928), .CLK(clk), .Q(pcpi_rs2[2]), .QN(
        n7985) );
  DFFX1_RVT \cpuregs_reg[8][1]  ( .D(n2799), .CLK(clk), .Q(\cpuregs[8][1] ) );
  DFFX1_RVT \reg_sh_reg[1]  ( .D(N1939), .CLK(clk), .Q(N1600) );
  DFFX1_RVT \reg_op2_reg[1]  ( .D(n3929), .CLK(clk), .Q(pcpi_rs2[1]), .QN(
        n8035) );
  DFFX1_RVT \alu_out_q_reg[1]  ( .D(alu_out[1]), .CLK(clk), .Q(alu_out_q[1])
         );
  DFFX1_RVT \reg_next_pc_reg[1]  ( .D(n3828), .CLK(clk), .Q(reg_next_pc[1]) );
  DFFX1_RVT \cpuregs_reg[31][1]  ( .D(n3535), .CLK(clk), .Q(\cpuregs[31][1] )
         );
  DFFX1_RVT \cpuregs_reg[30][1]  ( .D(n3503), .CLK(clk), .Q(\cpuregs[30][1] )
         );
  DFFX1_RVT \cpuregs_reg[29][1]  ( .D(n3471), .CLK(clk), .Q(\cpuregs[29][1] )
         );
  DFFX1_RVT \cpuregs_reg[28][1]  ( .D(n3439), .CLK(clk), .Q(\cpuregs[28][1] )
         );
  DFFX1_RVT \cpuregs_reg[27][1]  ( .D(n3407), .CLK(clk), .Q(\cpuregs[27][1] )
         );
  DFFX1_RVT \cpuregs_reg[26][1]  ( .D(n3375), .CLK(clk), .Q(\cpuregs[26][1] )
         );
  DFFX1_RVT \cpuregs_reg[25][1]  ( .D(n3343), .CLK(clk), .Q(\cpuregs[25][1] )
         );
  DFFX1_RVT \cpuregs_reg[24][1]  ( .D(n3311), .CLK(clk), .Q(\cpuregs[24][1] )
         );
  DFFX1_RVT \cpuregs_reg[23][1]  ( .D(n3279), .CLK(clk), .Q(\cpuregs[23][1] )
         );
  DFFX1_RVT \cpuregs_reg[22][1]  ( .D(n3247), .CLK(clk), .Q(\cpuregs[22][1] )
         );
  DFFX1_RVT \cpuregs_reg[21][1]  ( .D(n3215), .CLK(clk), .Q(\cpuregs[21][1] )
         );
  DFFX1_RVT \cpuregs_reg[20][1]  ( .D(n3183), .CLK(clk), .Q(\cpuregs[20][1] )
         );
  DFFX1_RVT \cpuregs_reg[19][1]  ( .D(n3151), .CLK(clk), .Q(\cpuregs[19][1] )
         );
  DFFX1_RVT \cpuregs_reg[18][1]  ( .D(n3119), .CLK(clk), .Q(\cpuregs[18][1] )
         );
  DFFX1_RVT \cpuregs_reg[17][1]  ( .D(n3087), .CLK(clk), .Q(\cpuregs[17][1] )
         );
  DFFX1_RVT \cpuregs_reg[16][1]  ( .D(n3055), .CLK(clk), .Q(\cpuregs[16][1] )
         );
  DFFX1_RVT \cpuregs_reg[15][1]  ( .D(n3023), .CLK(clk), .Q(\cpuregs[15][1] )
         );
  DFFX1_RVT \cpuregs_reg[14][1]  ( .D(n2991), .CLK(clk), .Q(\cpuregs[14][1] )
         );
  DFFX1_RVT \cpuregs_reg[13][1]  ( .D(n2959), .CLK(clk), .Q(\cpuregs[13][1] )
         );
  DFFX1_RVT \cpuregs_reg[12][1]  ( .D(n2927), .CLK(clk), .Q(\cpuregs[12][1] )
         );
  DFFX1_RVT \cpuregs_reg[11][1]  ( .D(n2895), .CLK(clk), .Q(\cpuregs[11][1] )
         );
  DFFX1_RVT \cpuregs_reg[10][1]  ( .D(n2863), .CLK(clk), .Q(\cpuregs[10][1] )
         );
  DFFX1_RVT \cpuregs_reg[9][1]  ( .D(n2831), .CLK(clk), .Q(\cpuregs[9][1] ) );
  DFFX1_RVT \cpuregs_reg[7][1]  ( .D(n2767), .CLK(clk), .Q(\cpuregs[7][1] ) );
  DFFX1_RVT \cpuregs_reg[6][1]  ( .D(n2735), .CLK(clk), .Q(\cpuregs[6][1] ) );
  DFFX1_RVT \cpuregs_reg[5][1]  ( .D(n2703), .CLK(clk), .Q(\cpuregs[5][1] ) );
  DFFX1_RVT \cpuregs_reg[4][1]  ( .D(n2671), .CLK(clk), .Q(\cpuregs[4][1] ) );
  DFFX1_RVT \cpuregs_reg[3][1]  ( .D(n2639), .CLK(clk), .Q(\cpuregs[3][1] ) );
  DFFX1_RVT \cpuregs_reg[2][1]  ( .D(n2607), .CLK(clk), .Q(\cpuregs[2][1] ) );
  DFFX1_RVT \reg_op2_reg[4]  ( .D(n3926), .CLK(clk), .Q(pcpi_rs2[4]), .QN(
        n7998) );
  DFFX1_RVT \alu_out_q_reg[5]  ( .D(alu_out[5]), .CLK(clk), .Q(alu_out_q[5])
         );
  DFFX1_RVT \reg_next_pc_reg[5]  ( .D(n3824), .CLK(clk), .Q(reg_next_pc[5]) );
  DFFX1_RVT \reg_pc_reg[5]  ( .D(n3792), .CLK(clk), .Q(reg_pc[5]) );
  DFFX1_RVT \cpuregs_reg[31][5]  ( .D(n3539), .CLK(clk), .Q(\cpuregs[31][5] )
         );
  DFFX1_RVT \cpuregs_reg[30][5]  ( .D(n3507), .CLK(clk), .Q(\cpuregs[30][5] )
         );
  DFFX1_RVT \cpuregs_reg[29][5]  ( .D(n3475), .CLK(clk), .Q(\cpuregs[29][5] )
         );
  DFFX1_RVT \cpuregs_reg[28][5]  ( .D(n3443), .CLK(clk), .Q(\cpuregs[28][5] )
         );
  DFFX1_RVT \cpuregs_reg[27][5]  ( .D(n3411), .CLK(clk), .Q(\cpuregs[27][5] )
         );
  DFFX1_RVT \cpuregs_reg[26][5]  ( .D(n3379), .CLK(clk), .Q(\cpuregs[26][5] )
         );
  DFFX1_RVT \cpuregs_reg[25][5]  ( .D(n3347), .CLK(clk), .Q(\cpuregs[25][5] )
         );
  DFFX1_RVT \cpuregs_reg[24][5]  ( .D(n3315), .CLK(clk), .Q(\cpuregs[24][5] )
         );
  DFFX1_RVT \cpuregs_reg[23][5]  ( .D(n3283), .CLK(clk), .Q(\cpuregs[23][5] )
         );
  DFFX1_RVT \cpuregs_reg[22][5]  ( .D(n3251), .CLK(clk), .Q(\cpuregs[22][5] )
         );
  DFFX1_RVT \cpuregs_reg[21][5]  ( .D(n3219), .CLK(clk), .Q(\cpuregs[21][5] )
         );
  DFFX1_RVT \cpuregs_reg[20][5]  ( .D(n3187), .CLK(clk), .Q(\cpuregs[20][5] )
         );
  DFFX1_RVT \cpuregs_reg[19][5]  ( .D(n3155), .CLK(clk), .Q(\cpuregs[19][5] )
         );
  DFFX1_RVT \cpuregs_reg[18][5]  ( .D(n3123), .CLK(clk), .Q(\cpuregs[18][5] )
         );
  DFFX1_RVT \cpuregs_reg[17][5]  ( .D(n3091), .CLK(clk), .Q(\cpuregs[17][5] )
         );
  DFFX1_RVT \cpuregs_reg[16][5]  ( .D(n3059), .CLK(clk), .Q(\cpuregs[16][5] )
         );
  DFFX1_RVT \cpuregs_reg[15][5]  ( .D(n3027), .CLK(clk), .Q(\cpuregs[15][5] )
         );
  DFFX1_RVT \cpuregs_reg[14][5]  ( .D(n2995), .CLK(clk), .Q(\cpuregs[14][5] )
         );
  DFFX1_RVT \cpuregs_reg[13][5]  ( .D(n2963), .CLK(clk), .Q(\cpuregs[13][5] )
         );
  DFFX1_RVT \cpuregs_reg[12][5]  ( .D(n2931), .CLK(clk), .Q(\cpuregs[12][5] )
         );
  DFFX1_RVT \cpuregs_reg[11][5]  ( .D(n2899), .CLK(clk), .Q(\cpuregs[11][5] )
         );
  DFFX1_RVT \cpuregs_reg[10][5]  ( .D(n2867), .CLK(clk), .Q(\cpuregs[10][5] )
         );
  DFFX1_RVT \cpuregs_reg[9][5]  ( .D(n2835), .CLK(clk), .Q(\cpuregs[9][5] ) );
  DFFX1_RVT \cpuregs_reg[8][5]  ( .D(n2803), .CLK(clk), .Q(\cpuregs[8][5] ) );
  DFFX1_RVT \cpuregs_reg[7][5]  ( .D(n2771), .CLK(clk), .Q(\cpuregs[7][5] ) );
  DFFX1_RVT \cpuregs_reg[6][5]  ( .D(n2739), .CLK(clk), .Q(\cpuregs[6][5] ) );
  DFFX1_RVT \cpuregs_reg[5][5]  ( .D(n2707), .CLK(clk), .Q(\cpuregs[5][5] ) );
  DFFX1_RVT \cpuregs_reg[4][5]  ( .D(n2675), .CLK(clk), .Q(\cpuregs[4][5] ) );
  DFFX1_RVT \cpuregs_reg[3][5]  ( .D(n2643), .CLK(clk), .Q(\cpuregs[3][5] ) );
  DFFX1_RVT \cpuregs_reg[2][5]  ( .D(n2611), .CLK(clk), .Q(\cpuregs[2][5] ) );
  DFFX1_RVT \cpuregs_reg[1][5]  ( .D(n2579), .CLK(clk), .Q(\cpuregs[1][5] ) );
  DFFX1_RVT \reg_op2_reg[5]  ( .D(n3925), .CLK(clk), .Q(pcpi_rs2[5]), .QN(
        n8021) );
  DFFX1_RVT \alu_out_q_reg[6]  ( .D(alu_out[6]), .CLK(clk), .Q(alu_out_q[6])
         );
  DFFX1_RVT \reg_next_pc_reg[6]  ( .D(n3823), .CLK(clk), .Q(reg_next_pc[6]) );
  DFFX1_RVT \reg_pc_reg[6]  ( .D(n3791), .CLK(clk), .Q(reg_pc[6]) );
  DFFX1_RVT \cpuregs_reg[31][6]  ( .D(n3540), .CLK(clk), .Q(\cpuregs[31][6] )
         );
  DFFX1_RVT \cpuregs_reg[30][6]  ( .D(n3508), .CLK(clk), .Q(\cpuregs[30][6] )
         );
  DFFX1_RVT \cpuregs_reg[29][6]  ( .D(n3476), .CLK(clk), .Q(\cpuregs[29][6] )
         );
  DFFX1_RVT \cpuregs_reg[28][6]  ( .D(n3444), .CLK(clk), .Q(\cpuregs[28][6] )
         );
  DFFX1_RVT \cpuregs_reg[27][6]  ( .D(n3412), .CLK(clk), .Q(\cpuregs[27][6] )
         );
  DFFX1_RVT \cpuregs_reg[26][6]  ( .D(n3380), .CLK(clk), .Q(\cpuregs[26][6] )
         );
  DFFX1_RVT \cpuregs_reg[25][6]  ( .D(n3348), .CLK(clk), .Q(\cpuregs[25][6] )
         );
  DFFX1_RVT \cpuregs_reg[24][6]  ( .D(n3316), .CLK(clk), .Q(\cpuregs[24][6] )
         );
  DFFX1_RVT \cpuregs_reg[23][6]  ( .D(n3284), .CLK(clk), .Q(\cpuregs[23][6] )
         );
  DFFX1_RVT \cpuregs_reg[22][6]  ( .D(n3252), .CLK(clk), .Q(\cpuregs[22][6] )
         );
  DFFX1_RVT \cpuregs_reg[21][6]  ( .D(n3220), .CLK(clk), .Q(\cpuregs[21][6] )
         );
  DFFX1_RVT \cpuregs_reg[20][6]  ( .D(n3188), .CLK(clk), .Q(\cpuregs[20][6] )
         );
  DFFX1_RVT \cpuregs_reg[19][6]  ( .D(n3156), .CLK(clk), .Q(\cpuregs[19][6] )
         );
  DFFX1_RVT \cpuregs_reg[18][6]  ( .D(n3124), .CLK(clk), .Q(\cpuregs[18][6] )
         );
  DFFX1_RVT \cpuregs_reg[17][6]  ( .D(n3092), .CLK(clk), .Q(\cpuregs[17][6] )
         );
  DFFX1_RVT \cpuregs_reg[16][6]  ( .D(n3060), .CLK(clk), .Q(\cpuregs[16][6] ), 
        .QN(n4340) );
  DFFX1_RVT \cpuregs_reg[15][6]  ( .D(n3028), .CLK(clk), .Q(\cpuregs[15][6] ), 
        .QN(n4341) );
  DFFX1_RVT \cpuregs_reg[14][6]  ( .D(n2996), .CLK(clk), .Q(\cpuregs[14][6] )
         );
  DFFX1_RVT \cpuregs_reg[13][6]  ( .D(n2964), .CLK(clk), .Q(\cpuregs[13][6] )
         );
  DFFX1_RVT \cpuregs_reg[12][6]  ( .D(n2932), .CLK(clk), .Q(\cpuregs[12][6] )
         );
  DFFX1_RVT \cpuregs_reg[11][6]  ( .D(n2900), .CLK(clk), .Q(\cpuregs[11][6] )
         );
  DFFX1_RVT \cpuregs_reg[10][6]  ( .D(n2868), .CLK(clk), .Q(\cpuregs[10][6] )
         );
  DFFX1_RVT \cpuregs_reg[9][6]  ( .D(n2836), .CLK(clk), .Q(\cpuregs[9][6] ) );
  DFFX1_RVT \cpuregs_reg[8][6]  ( .D(n2804), .CLK(clk), .Q(\cpuregs[8][6] ) );
  DFFX1_RVT \cpuregs_reg[7][6]  ( .D(n2772), .CLK(clk), .Q(\cpuregs[7][6] ) );
  DFFX1_RVT \cpuregs_reg[6][6]  ( .D(n2740), .CLK(clk), .Q(\cpuregs[6][6] ) );
  DFFX1_RVT \cpuregs_reg[5][6]  ( .D(n2708), .CLK(clk), .Q(\cpuregs[5][6] ) );
  DFFX1_RVT \cpuregs_reg[4][6]  ( .D(n2676), .CLK(clk), .Q(\cpuregs[4][6] ) );
  DFFX1_RVT \cpuregs_reg[3][6]  ( .D(n2644), .CLK(clk), .Q(\cpuregs[3][6] ) );
  DFFX1_RVT \cpuregs_reg[2][6]  ( .D(n2612), .CLK(clk), .Q(\cpuregs[2][6] ) );
  DFFX1_RVT \cpuregs_reg[1][6]  ( .D(n2580), .CLK(clk), .Q(\cpuregs[1][6] ) );
  DFFX1_RVT \reg_op2_reg[6]  ( .D(n3924), .CLK(clk), .Q(pcpi_rs2[6]), .QN(
        net16468) );
  DFFX1_RVT \alu_out_q_reg[7]  ( .D(alu_out[7]), .CLK(clk), .Q(alu_out_q[7])
         );
  DFFX1_RVT \reg_next_pc_reg[7]  ( .D(n3822), .CLK(clk), .Q(reg_next_pc[7]) );
  DFFX1_RVT \reg_pc_reg[7]  ( .D(n3790), .CLK(clk), .Q(reg_pc[7]) );
  DFFX1_RVT \cpuregs_reg[31][7]  ( .D(n3541), .CLK(clk), .Q(\cpuregs[31][7] )
         );
  DFFX1_RVT \cpuregs_reg[30][7]  ( .D(n3509), .CLK(clk), .Q(\cpuregs[30][7] )
         );
  DFFX1_RVT \cpuregs_reg[29][7]  ( .D(n3477), .CLK(clk), .Q(\cpuregs[29][7] )
         );
  DFFX1_RVT \cpuregs_reg[28][7]  ( .D(n3445), .CLK(clk), .Q(\cpuregs[28][7] )
         );
  DFFX1_RVT \cpuregs_reg[27][7]  ( .D(n3413), .CLK(clk), .Q(\cpuregs[27][7] )
         );
  DFFX1_RVT \cpuregs_reg[26][7]  ( .D(n3381), .CLK(clk), .Q(\cpuregs[26][7] )
         );
  DFFX1_RVT \cpuregs_reg[25][7]  ( .D(n3349), .CLK(clk), .Q(\cpuregs[25][7] )
         );
  DFFX1_RVT \cpuregs_reg[24][7]  ( .D(n3317), .CLK(clk), .Q(\cpuregs[24][7] )
         );
  DFFX1_RVT \cpuregs_reg[23][7]  ( .D(n3285), .CLK(clk), .Q(\cpuregs[23][7] )
         );
  DFFX1_RVT \cpuregs_reg[22][7]  ( .D(n3253), .CLK(clk), .Q(\cpuregs[22][7] )
         );
  DFFX1_RVT \cpuregs_reg[21][7]  ( .D(n3221), .CLK(clk), .Q(\cpuregs[21][7] )
         );
  DFFX1_RVT \cpuregs_reg[20][7]  ( .D(n3189), .CLK(clk), .Q(\cpuregs[20][7] )
         );
  DFFX1_RVT \cpuregs_reg[19][7]  ( .D(n3157), .CLK(clk), .Q(\cpuregs[19][7] )
         );
  DFFX1_RVT \cpuregs_reg[18][7]  ( .D(n3125), .CLK(clk), .Q(\cpuregs[18][7] )
         );
  DFFX1_RVT \cpuregs_reg[17][7]  ( .D(n3093), .CLK(clk), .Q(\cpuregs[17][7] )
         );
  DFFX1_RVT \cpuregs_reg[16][7]  ( .D(n3061), .CLK(clk), .Q(\cpuregs[16][7] )
         );
  DFFX1_RVT \cpuregs_reg[15][7]  ( .D(n3029), .CLK(clk), .Q(\cpuregs[15][7] )
         );
  DFFX1_RVT \cpuregs_reg[14][7]  ( .D(n2997), .CLK(clk), .Q(\cpuregs[14][7] )
         );
  DFFX1_RVT \cpuregs_reg[13][7]  ( .D(n2965), .CLK(clk), .Q(\cpuregs[13][7] )
         );
  DFFX1_RVT \cpuregs_reg[12][7]  ( .D(n2933), .CLK(clk), .Q(\cpuregs[12][7] )
         );
  DFFX1_RVT \cpuregs_reg[11][7]  ( .D(n2901), .CLK(clk), .Q(\cpuregs[11][7] )
         );
  DFFX1_RVT \cpuregs_reg[10][7]  ( .D(n2869), .CLK(clk), .Q(\cpuregs[10][7] )
         );
  DFFX1_RVT \cpuregs_reg[9][7]  ( .D(n2837), .CLK(clk), .Q(\cpuregs[9][7] ) );
  DFFX1_RVT \cpuregs_reg[8][7]  ( .D(n2805), .CLK(clk), .Q(\cpuregs[8][7] ) );
  DFFX1_RVT \cpuregs_reg[7][7]  ( .D(n2773), .CLK(clk), .Q(\cpuregs[7][7] ) );
  DFFX1_RVT \cpuregs_reg[6][7]  ( .D(n2741), .CLK(clk), .Q(\cpuregs[6][7] ) );
  DFFX1_RVT \cpuregs_reg[5][7]  ( .D(n2709), .CLK(clk), .Q(\cpuregs[5][7] ) );
  DFFX1_RVT \cpuregs_reg[4][7]  ( .D(n2677), .CLK(clk), .Q(\cpuregs[4][7] ) );
  DFFX1_RVT \cpuregs_reg[3][7]  ( .D(n2645), .CLK(clk), .Q(\cpuregs[3][7] ) );
  DFFX1_RVT \cpuregs_reg[2][7]  ( .D(n2613), .CLK(clk), .Q(\cpuregs[2][7] ) );
  DFFX1_RVT \cpuregs_reg[1][7]  ( .D(n2581), .CLK(clk), .Q(\cpuregs[1][7] ) );
  DFFX1_RVT \reg_op2_reg[7]  ( .D(n3923), .CLK(clk), .Q(pcpi_rs2[7]), .QN(
        n7986) );
  DFFX1_RVT \alu_out_q_reg[8]  ( .D(alu_out[8]), .CLK(clk), .Q(alu_out_q[8])
         );
  DFFX1_RVT \reg_next_pc_reg[8]  ( .D(n3821), .CLK(clk), .Q(reg_next_pc[8]) );
  DFFX1_RVT \reg_pc_reg[8]  ( .D(n3789), .CLK(clk), .Q(reg_pc[8]) );
  DFFX1_RVT \cpuregs_reg[31][8]  ( .D(n3542), .CLK(clk), .Q(\cpuregs[31][8] )
         );
  DFFX1_RVT \cpuregs_reg[30][8]  ( .D(n3510), .CLK(clk), .Q(\cpuregs[30][8] )
         );
  DFFX1_RVT \cpuregs_reg[29][8]  ( .D(n3478), .CLK(clk), .Q(\cpuregs[29][8] )
         );
  DFFX1_RVT \cpuregs_reg[28][8]  ( .D(n3446), .CLK(clk), .Q(\cpuregs[28][8] )
         );
  DFFX1_RVT \cpuregs_reg[27][8]  ( .D(n3414), .CLK(clk), .Q(\cpuregs[27][8] )
         );
  DFFX1_RVT \cpuregs_reg[26][8]  ( .D(n3382), .CLK(clk), .Q(\cpuregs[26][8] )
         );
  DFFX1_RVT \cpuregs_reg[25][8]  ( .D(n3350), .CLK(clk), .Q(\cpuregs[25][8] )
         );
  DFFX1_RVT \cpuregs_reg[24][8]  ( .D(n3318), .CLK(clk), .Q(\cpuregs[24][8] )
         );
  DFFX1_RVT \cpuregs_reg[23][8]  ( .D(n3286), .CLK(clk), .Q(\cpuregs[23][8] )
         );
  DFFX1_RVT \cpuregs_reg[22][8]  ( .D(n3254), .CLK(clk), .Q(\cpuregs[22][8] )
         );
  DFFX1_RVT \cpuregs_reg[21][8]  ( .D(n3222), .CLK(clk), .Q(\cpuregs[21][8] )
         );
  DFFX1_RVT \cpuregs_reg[20][8]  ( .D(n3190), .CLK(clk), .Q(\cpuregs[20][8] )
         );
  DFFX1_RVT \cpuregs_reg[19][8]  ( .D(n3158), .CLK(clk), .Q(\cpuregs[19][8] )
         );
  DFFX1_RVT \cpuregs_reg[18][8]  ( .D(n3126), .CLK(clk), .Q(\cpuregs[18][8] )
         );
  DFFX1_RVT \cpuregs_reg[17][8]  ( .D(n3094), .CLK(clk), .Q(\cpuregs[17][8] )
         );
  DFFX1_RVT \cpuregs_reg[16][8]  ( .D(n3062), .CLK(clk), .Q(\cpuregs[16][8] )
         );
  DFFX1_RVT \cpuregs_reg[15][8]  ( .D(n3030), .CLK(clk), .Q(\cpuregs[15][8] )
         );
  DFFX1_RVT \cpuregs_reg[14][8]  ( .D(n2998), .CLK(clk), .Q(\cpuregs[14][8] )
         );
  DFFX1_RVT \cpuregs_reg[13][8]  ( .D(n2966), .CLK(clk), .Q(\cpuregs[13][8] )
         );
  DFFX1_RVT \cpuregs_reg[12][8]  ( .D(n2934), .CLK(clk), .Q(\cpuregs[12][8] )
         );
  DFFX1_RVT \cpuregs_reg[11][8]  ( .D(n2902), .CLK(clk), .Q(\cpuregs[11][8] )
         );
  DFFX1_RVT \cpuregs_reg[10][8]  ( .D(n2870), .CLK(clk), .Q(\cpuregs[10][8] )
         );
  DFFX1_RVT \cpuregs_reg[9][8]  ( .D(n2838), .CLK(clk), .Q(\cpuregs[9][8] ) );
  DFFX1_RVT \cpuregs_reg[8][8]  ( .D(n2806), .CLK(clk), .Q(\cpuregs[8][8] ) );
  DFFX1_RVT \cpuregs_reg[7][8]  ( .D(n2774), .CLK(clk), .Q(\cpuregs[7][8] ) );
  DFFX1_RVT \cpuregs_reg[6][8]  ( .D(n2742), .CLK(clk), .Q(\cpuregs[6][8] ) );
  DFFX1_RVT \cpuregs_reg[5][8]  ( .D(n2710), .CLK(clk), .Q(\cpuregs[5][8] ) );
  DFFX1_RVT \cpuregs_reg[4][8]  ( .D(n2678), .CLK(clk), .Q(\cpuregs[4][8] ) );
  DFFX1_RVT \cpuregs_reg[3][8]  ( .D(n2646), .CLK(clk), .Q(\cpuregs[3][8] ) );
  DFFX1_RVT \cpuregs_reg[2][8]  ( .D(n2614), .CLK(clk), .Q(\cpuregs[2][8] ) );
  DFFX1_RVT \cpuregs_reg[1][8]  ( .D(n2582), .CLK(clk), .Q(\cpuregs[1][8] ) );
  DFFX1_RVT \reg_op2_reg[8]  ( .D(n3922), .CLK(clk), .Q(pcpi_rs2[8]), .QN(
        n7992) );
  DFFX1_RVT \alu_out_q_reg[9]  ( .D(alu_out[9]), .CLK(clk), .Q(alu_out_q[9])
         );
  DFFX1_RVT \reg_next_pc_reg[9]  ( .D(n3820), .CLK(clk), .Q(reg_next_pc[9]) );
  DFFX1_RVT \reg_pc_reg[9]  ( .D(n3788), .CLK(clk), .Q(reg_pc[9]) );
  DFFX1_RVT \cpuregs_reg[31][9]  ( .D(n3543), .CLK(clk), .Q(\cpuregs[31][9] )
         );
  DFFX1_RVT \cpuregs_reg[30][9]  ( .D(n3511), .CLK(clk), .Q(\cpuregs[30][9] )
         );
  DFFX1_RVT \cpuregs_reg[29][9]  ( .D(n3479), .CLK(clk), .Q(\cpuregs[29][9] )
         );
  DFFX1_RVT \cpuregs_reg[28][9]  ( .D(n3447), .CLK(clk), .Q(\cpuregs[28][9] )
         );
  DFFX1_RVT \cpuregs_reg[27][9]  ( .D(n3415), .CLK(clk), .Q(\cpuregs[27][9] )
         );
  DFFX1_RVT \cpuregs_reg[26][9]  ( .D(n3383), .CLK(clk), .Q(\cpuregs[26][9] )
         );
  DFFX1_RVT \cpuregs_reg[25][9]  ( .D(n3351), .CLK(clk), .Q(\cpuregs[25][9] )
         );
  DFFX1_RVT \cpuregs_reg[24][9]  ( .D(n3319), .CLK(clk), .Q(\cpuregs[24][9] )
         );
  DFFX1_RVT \cpuregs_reg[23][9]  ( .D(n3287), .CLK(clk), .Q(\cpuregs[23][9] )
         );
  DFFX1_RVT \cpuregs_reg[22][9]  ( .D(n3255), .CLK(clk), .Q(\cpuregs[22][9] )
         );
  DFFX1_RVT \cpuregs_reg[21][9]  ( .D(n3223), .CLK(clk), .Q(\cpuregs[21][9] )
         );
  DFFX1_RVT \cpuregs_reg[20][9]  ( .D(n3191), .CLK(clk), .Q(\cpuregs[20][9] )
         );
  DFFX1_RVT \cpuregs_reg[19][9]  ( .D(n3159), .CLK(clk), .Q(\cpuregs[19][9] )
         );
  DFFX1_RVT \cpuregs_reg[18][9]  ( .D(n3127), .CLK(clk), .Q(\cpuregs[18][9] )
         );
  DFFX1_RVT \cpuregs_reg[17][9]  ( .D(n3095), .CLK(clk), .Q(\cpuregs[17][9] )
         );
  DFFX1_RVT \cpuregs_reg[16][9]  ( .D(n3063), .CLK(clk), .Q(\cpuregs[16][9] )
         );
  DFFX1_RVT \cpuregs_reg[15][9]  ( .D(n3031), .CLK(clk), .Q(\cpuregs[15][9] )
         );
  DFFX1_RVT \cpuregs_reg[14][9]  ( .D(n2999), .CLK(clk), .Q(\cpuregs[14][9] )
         );
  DFFX1_RVT \cpuregs_reg[13][9]  ( .D(n2967), .CLK(clk), .Q(\cpuregs[13][9] )
         );
  DFFX1_RVT \cpuregs_reg[12][9]  ( .D(n2935), .CLK(clk), .Q(\cpuregs[12][9] )
         );
  DFFX1_RVT \cpuregs_reg[11][9]  ( .D(n2903), .CLK(clk), .Q(\cpuregs[11][9] )
         );
  DFFX1_RVT \cpuregs_reg[10][9]  ( .D(n2871), .CLK(clk), .Q(\cpuregs[10][9] )
         );
  DFFX1_RVT \cpuregs_reg[9][9]  ( .D(n2839), .CLK(clk), .Q(\cpuregs[9][9] ) );
  DFFX1_RVT \cpuregs_reg[8][9]  ( .D(n2807), .CLK(clk), .Q(\cpuregs[8][9] ) );
  DFFX1_RVT \cpuregs_reg[7][9]  ( .D(n2775), .CLK(clk), .Q(\cpuregs[7][9] ) );
  DFFX1_RVT \cpuregs_reg[6][9]  ( .D(n2743), .CLK(clk), .Q(\cpuregs[6][9] ) );
  DFFX1_RVT \cpuregs_reg[5][9]  ( .D(n2711), .CLK(clk), .Q(\cpuregs[5][9] ) );
  DFFX1_RVT \cpuregs_reg[4][9]  ( .D(n2679), .CLK(clk), .Q(\cpuregs[4][9] ) );
  DFFX1_RVT \cpuregs_reg[3][9]  ( .D(n2647), .CLK(clk), .Q(\cpuregs[3][9] ) );
  DFFX1_RVT \cpuregs_reg[2][9]  ( .D(n2615), .CLK(clk), .Q(\cpuregs[2][9] ) );
  DFFX1_RVT \cpuregs_reg[1][9]  ( .D(n2583), .CLK(clk), .Q(\cpuregs[1][9] ) );
  DFFX1_RVT \reg_op2_reg[9]  ( .D(n3921), .CLK(clk), .Q(pcpi_rs2[9]), .QN(
        n8029) );
  DFFX1_RVT \alu_out_q_reg[10]  ( .D(alu_out[10]), .CLK(clk), .Q(alu_out_q[10]) );
  DFFX1_RVT \reg_next_pc_reg[10]  ( .D(n3819), .CLK(clk), .Q(reg_next_pc[10])
         );
  DFFX1_RVT \reg_pc_reg[10]  ( .D(n3787), .CLK(clk), .Q(reg_pc[10]) );
  DFFX1_RVT \cpuregs_reg[31][10]  ( .D(n3544), .CLK(clk), .Q(\cpuregs[31][10] ) );
  DFFX1_RVT \cpuregs_reg[30][10]  ( .D(n3512), .CLK(clk), .Q(\cpuregs[30][10] ) );
  DFFX1_RVT \cpuregs_reg[29][10]  ( .D(n3480), .CLK(clk), .Q(\cpuregs[29][10] ) );
  DFFX1_RVT \cpuregs_reg[28][10]  ( .D(n3448), .CLK(clk), .Q(\cpuregs[28][10] ) );
  DFFX1_RVT \cpuregs_reg[27][10]  ( .D(n3416), .CLK(clk), .Q(\cpuregs[27][10] ) );
  DFFX1_RVT \cpuregs_reg[26][10]  ( .D(n3384), .CLK(clk), .Q(\cpuregs[26][10] ) );
  DFFX1_RVT \cpuregs_reg[25][10]  ( .D(n3352), .CLK(clk), .Q(\cpuregs[25][10] ) );
  DFFX1_RVT \cpuregs_reg[24][10]  ( .D(n3320), .CLK(clk), .Q(\cpuregs[24][10] ) );
  DFFX1_RVT \cpuregs_reg[23][10]  ( .D(n3288), .CLK(clk), .Q(\cpuregs[23][10] ) );
  DFFX1_RVT \cpuregs_reg[22][10]  ( .D(n3256), .CLK(clk), .Q(\cpuregs[22][10] ) );
  DFFX1_RVT \cpuregs_reg[21][10]  ( .D(n3224), .CLK(clk), .Q(\cpuregs[21][10] ) );
  DFFX1_RVT \cpuregs_reg[20][10]  ( .D(n3192), .CLK(clk), .Q(\cpuregs[20][10] ) );
  DFFX1_RVT \cpuregs_reg[19][10]  ( .D(n3160), .CLK(clk), .Q(\cpuregs[19][10] ) );
  DFFX1_RVT \cpuregs_reg[18][10]  ( .D(n3128), .CLK(clk), .Q(\cpuregs[18][10] ) );
  DFFX1_RVT \cpuregs_reg[17][10]  ( .D(n3096), .CLK(clk), .Q(\cpuregs[17][10] ) );
  DFFX1_RVT \cpuregs_reg[16][10]  ( .D(n3064), .CLK(clk), .Q(\cpuregs[16][10] ) );
  DFFX1_RVT \cpuregs_reg[15][10]  ( .D(n3032), .CLK(clk), .Q(\cpuregs[15][10] ) );
  DFFX1_RVT \cpuregs_reg[14][10]  ( .D(n3000), .CLK(clk), .Q(\cpuregs[14][10] ) );
  DFFX1_RVT \cpuregs_reg[13][10]  ( .D(n2968), .CLK(clk), .Q(\cpuregs[13][10] ) );
  DFFX1_RVT \cpuregs_reg[12][10]  ( .D(n2936), .CLK(clk), .Q(\cpuregs[12][10] ) );
  DFFX1_RVT \cpuregs_reg[11][10]  ( .D(n2904), .CLK(clk), .Q(\cpuregs[11][10] ) );
  DFFX1_RVT \cpuregs_reg[10][10]  ( .D(n2872), .CLK(clk), .Q(\cpuregs[10][10] ) );
  DFFX1_RVT \cpuregs_reg[9][10]  ( .D(n2840), .CLK(clk), .Q(\cpuregs[9][10] )
         );
  DFFX1_RVT \cpuregs_reg[8][10]  ( .D(n2808), .CLK(clk), .Q(\cpuregs[8][10] )
         );
  DFFX1_RVT \cpuregs_reg[7][10]  ( .D(n2776), .CLK(clk), .Q(\cpuregs[7][10] )
         );
  DFFX1_RVT \cpuregs_reg[6][10]  ( .D(n2744), .CLK(clk), .Q(\cpuregs[6][10] )
         );
  DFFX1_RVT \cpuregs_reg[5][10]  ( .D(n2712), .CLK(clk), .Q(\cpuregs[5][10] )
         );
  DFFX1_RVT \cpuregs_reg[4][10]  ( .D(n2680), .CLK(clk), .Q(\cpuregs[4][10] )
         );
  DFFX1_RVT \cpuregs_reg[3][10]  ( .D(n2648), .CLK(clk), .Q(\cpuregs[3][10] )
         );
  DFFX1_RVT \cpuregs_reg[2][10]  ( .D(n2616), .CLK(clk), .Q(\cpuregs[2][10] )
         );
  DFFX1_RVT \cpuregs_reg[1][10]  ( .D(n2584), .CLK(clk), .Q(\cpuregs[1][10] )
         );
  DFFX1_RVT \reg_op2_reg[10]  ( .D(n3920), .CLK(clk), .Q(pcpi_rs2[10]), .QN(
        n7991) );
  DFFX1_RVT \alu_out_q_reg[11]  ( .D(alu_out[11]), .CLK(clk), .Q(alu_out_q[11]) );
  DFFX1_RVT \reg_next_pc_reg[11]  ( .D(n3818), .CLK(clk), .Q(reg_next_pc[11])
         );
  DFFX1_RVT \reg_pc_reg[11]  ( .D(n3786), .CLK(clk), .Q(reg_pc[11]) );
  DFFX1_RVT \cpuregs_reg[31][11]  ( .D(n3545), .CLK(clk), .Q(\cpuregs[31][11] ) );
  DFFX1_RVT \cpuregs_reg[30][11]  ( .D(n3513), .CLK(clk), .Q(\cpuregs[30][11] ) );
  DFFX1_RVT \cpuregs_reg[29][11]  ( .D(n3481), .CLK(clk), .Q(\cpuregs[29][11] ) );
  DFFX1_RVT \cpuregs_reg[28][11]  ( .D(n3449), .CLK(clk), .Q(\cpuregs[28][11] ) );
  DFFX1_RVT \cpuregs_reg[27][11]  ( .D(n3417), .CLK(clk), .Q(\cpuregs[27][11] ) );
  DFFX1_RVT \cpuregs_reg[26][11]  ( .D(n3385), .CLK(clk), .Q(\cpuregs[26][11] ) );
  DFFX1_RVT \cpuregs_reg[25][11]  ( .D(n3353), .CLK(clk), .Q(\cpuregs[25][11] ) );
  DFFX1_RVT \cpuregs_reg[24][11]  ( .D(n3321), .CLK(clk), .Q(\cpuregs[24][11] ) );
  DFFX1_RVT \cpuregs_reg[23][11]  ( .D(n3289), .CLK(clk), .Q(\cpuregs[23][11] ) );
  DFFX1_RVT \cpuregs_reg[22][11]  ( .D(n3257), .CLK(clk), .Q(\cpuregs[22][11] ) );
  DFFX1_RVT \cpuregs_reg[21][11]  ( .D(n3225), .CLK(clk), .Q(\cpuregs[21][11] ) );
  DFFX1_RVT \cpuregs_reg[20][11]  ( .D(n3193), .CLK(clk), .Q(\cpuregs[20][11] ) );
  DFFX1_RVT \cpuregs_reg[19][11]  ( .D(n3161), .CLK(clk), .Q(\cpuregs[19][11] ) );
  DFFX1_RVT \cpuregs_reg[18][11]  ( .D(n3129), .CLK(clk), .Q(\cpuregs[18][11] ) );
  DFFX1_RVT \cpuregs_reg[17][11]  ( .D(n3097), .CLK(clk), .Q(\cpuregs[17][11] ) );
  DFFX1_RVT \cpuregs_reg[16][11]  ( .D(n3065), .CLK(clk), .Q(\cpuregs[16][11] ) );
  DFFX1_RVT \cpuregs_reg[15][11]  ( .D(n3033), .CLK(clk), .Q(\cpuregs[15][11] ) );
  DFFX1_RVT \cpuregs_reg[14][11]  ( .D(n3001), .CLK(clk), .Q(\cpuregs[14][11] ) );
  DFFX1_RVT \cpuregs_reg[13][11]  ( .D(n2969), .CLK(clk), .Q(\cpuregs[13][11] ) );
  DFFX1_RVT \cpuregs_reg[12][11]  ( .D(n2937), .CLK(clk), .Q(\cpuregs[12][11] ) );
  DFFX1_RVT \cpuregs_reg[11][11]  ( .D(n2905), .CLK(clk), .Q(\cpuregs[11][11] ) );
  DFFX1_RVT \cpuregs_reg[10][11]  ( .D(n2873), .CLK(clk), .Q(\cpuregs[10][11] ) );
  DFFX1_RVT \cpuregs_reg[9][11]  ( .D(n2841), .CLK(clk), .Q(\cpuregs[9][11] )
         );
  DFFX1_RVT \cpuregs_reg[8][11]  ( .D(n2809), .CLK(clk), .Q(\cpuregs[8][11] )
         );
  DFFX1_RVT \cpuregs_reg[7][11]  ( .D(n2777), .CLK(clk), .Q(\cpuregs[7][11] )
         );
  DFFX1_RVT \cpuregs_reg[6][11]  ( .D(n2745), .CLK(clk), .Q(\cpuregs[6][11] )
         );
  DFFX1_RVT \cpuregs_reg[5][11]  ( .D(n2713), .CLK(clk), .Q(\cpuregs[5][11] )
         );
  DFFX1_RVT \cpuregs_reg[4][11]  ( .D(n2681), .CLK(clk), .Q(\cpuregs[4][11] )
         );
  DFFX1_RVT \cpuregs_reg[3][11]  ( .D(n2649), .CLK(clk), .Q(\cpuregs[3][11] )
         );
  DFFX1_RVT \cpuregs_reg[2][11]  ( .D(n2617), .CLK(clk), .Q(\cpuregs[2][11] )
         );
  DFFX1_RVT \cpuregs_reg[1][11]  ( .D(n2585), .CLK(clk), .Q(\cpuregs[1][11] )
         );
  DFFX1_RVT \reg_op2_reg[11]  ( .D(n3919), .CLK(clk), .Q(pcpi_rs2[11]), .QN(
        n7972) );
  DFFX1_RVT \alu_out_q_reg[12]  ( .D(alu_out[12]), .CLK(clk), .Q(alu_out_q[12]) );
  DFFX1_RVT \reg_next_pc_reg[12]  ( .D(n3817), .CLK(clk), .Q(reg_next_pc[12])
         );
  DFFX1_RVT \reg_pc_reg[12]  ( .D(n3785), .CLK(clk), .Q(reg_pc[12]) );
  DFFX1_RVT \cpuregs_reg[31][12]  ( .D(n3546), .CLK(clk), .Q(\cpuregs[31][12] ) );
  DFFX1_RVT \cpuregs_reg[30][12]  ( .D(n3514), .CLK(clk), .Q(\cpuregs[30][12] ) );
  DFFX1_RVT \cpuregs_reg[29][12]  ( .D(n3482), .CLK(clk), .Q(\cpuregs[29][12] ) );
  DFFX1_RVT \cpuregs_reg[28][12]  ( .D(n3450), .CLK(clk), .Q(\cpuregs[28][12] ) );
  DFFX1_RVT \cpuregs_reg[27][12]  ( .D(n3418), .CLK(clk), .Q(\cpuregs[27][12] ) );
  DFFX1_RVT \cpuregs_reg[26][12]  ( .D(n3386), .CLK(clk), .Q(\cpuregs[26][12] ) );
  DFFX1_RVT \cpuregs_reg[25][12]  ( .D(n3354), .CLK(clk), .Q(\cpuregs[25][12] ) );
  DFFX1_RVT \cpuregs_reg[24][12]  ( .D(n3322), .CLK(clk), .Q(\cpuregs[24][12] ) );
  DFFX1_RVT \cpuregs_reg[23][12]  ( .D(n3290), .CLK(clk), .Q(\cpuregs[23][12] ) );
  DFFX1_RVT \cpuregs_reg[22][12]  ( .D(n3258), .CLK(clk), .Q(\cpuregs[22][12] ) );
  DFFX1_RVT \cpuregs_reg[21][12]  ( .D(n3226), .CLK(clk), .Q(\cpuregs[21][12] ) );
  DFFX1_RVT \cpuregs_reg[20][12]  ( .D(n3194), .CLK(clk), .Q(\cpuregs[20][12] ) );
  DFFX1_RVT \cpuregs_reg[19][12]  ( .D(n3162), .CLK(clk), .Q(\cpuregs[19][12] ) );
  DFFX1_RVT \cpuregs_reg[18][12]  ( .D(n3130), .CLK(clk), .Q(\cpuregs[18][12] ) );
  DFFX1_RVT \cpuregs_reg[17][12]  ( .D(n3098), .CLK(clk), .Q(\cpuregs[17][12] ) );
  DFFX1_RVT \cpuregs_reg[16][12]  ( .D(n3066), .CLK(clk), .Q(\cpuregs[16][12] ) );
  DFFX1_RVT \cpuregs_reg[15][12]  ( .D(n3034), .CLK(clk), .Q(\cpuregs[15][12] ) );
  DFFX1_RVT \cpuregs_reg[14][12]  ( .D(n3002), .CLK(clk), .Q(\cpuregs[14][12] ) );
  DFFX1_RVT \cpuregs_reg[13][12]  ( .D(n2970), .CLK(clk), .Q(\cpuregs[13][12] ) );
  DFFX1_RVT \cpuregs_reg[12][12]  ( .D(n2938), .CLK(clk), .Q(\cpuregs[12][12] ) );
  DFFX1_RVT \cpuregs_reg[11][12]  ( .D(n2906), .CLK(clk), .Q(\cpuregs[11][12] ) );
  DFFX1_RVT \cpuregs_reg[10][12]  ( .D(n2874), .CLK(clk), .Q(\cpuregs[10][12] ) );
  DFFX1_RVT \cpuregs_reg[9][12]  ( .D(n2842), .CLK(clk), .Q(\cpuregs[9][12] )
         );
  DFFX1_RVT \cpuregs_reg[8][12]  ( .D(n2810), .CLK(clk), .Q(\cpuregs[8][12] )
         );
  DFFX1_RVT \cpuregs_reg[7][12]  ( .D(n2778), .CLK(clk), .Q(\cpuregs[7][12] )
         );
  DFFX1_RVT \cpuregs_reg[6][12]  ( .D(n2746), .CLK(clk), .Q(\cpuregs[6][12] )
         );
  DFFX1_RVT \cpuregs_reg[5][12]  ( .D(n2714), .CLK(clk), .Q(\cpuregs[5][12] )
         );
  DFFX1_RVT \cpuregs_reg[4][12]  ( .D(n2682), .CLK(clk), .Q(\cpuregs[4][12] )
         );
  DFFX1_RVT \cpuregs_reg[3][12]  ( .D(n2650), .CLK(clk), .Q(\cpuregs[3][12] )
         );
  DFFX1_RVT \cpuregs_reg[2][12]  ( .D(n2618), .CLK(clk), .Q(\cpuregs[2][12] )
         );
  DFFX1_RVT \cpuregs_reg[1][12]  ( .D(n2586), .CLK(clk), .Q(\cpuregs[1][12] )
         );
  DFFX1_RVT \reg_op2_reg[12]  ( .D(n3918), .CLK(clk), .Q(pcpi_rs2[12]), .QN(
        n8001) );
  DFFX1_RVT \alu_out_q_reg[13]  ( .D(alu_out[13]), .CLK(clk), .Q(alu_out_q[13]) );
  DFFX1_RVT \reg_next_pc_reg[13]  ( .D(n3816), .CLK(clk), .Q(reg_next_pc[13])
         );
  DFFX1_RVT \reg_pc_reg[13]  ( .D(n3784), .CLK(clk), .Q(reg_pc[13]) );
  DFFX1_RVT \cpuregs_reg[31][13]  ( .D(n3547), .CLK(clk), .Q(\cpuregs[31][13] ) );
  DFFX1_RVT \cpuregs_reg[30][13]  ( .D(n3515), .CLK(clk), .Q(\cpuregs[30][13] ) );
  DFFX1_RVT \cpuregs_reg[29][13]  ( .D(n3483), .CLK(clk), .Q(\cpuregs[29][13] ) );
  DFFX1_RVT \cpuregs_reg[28][13]  ( .D(n3451), .CLK(clk), .Q(\cpuregs[28][13] ) );
  DFFX1_RVT \cpuregs_reg[27][13]  ( .D(n3419), .CLK(clk), .Q(\cpuregs[27][13] ) );
  DFFX1_RVT \cpuregs_reg[26][13]  ( .D(n3387), .CLK(clk), .Q(\cpuregs[26][13] ) );
  DFFX1_RVT \cpuregs_reg[25][13]  ( .D(n3355), .CLK(clk), .Q(\cpuregs[25][13] ) );
  DFFX1_RVT \cpuregs_reg[24][13]  ( .D(n3323), .CLK(clk), .Q(\cpuregs[24][13] ) );
  DFFX1_RVT \cpuregs_reg[23][13]  ( .D(n3291), .CLK(clk), .Q(\cpuregs[23][13] ) );
  DFFX1_RVT \cpuregs_reg[22][13]  ( .D(n3259), .CLK(clk), .Q(\cpuregs[22][13] ) );
  DFFX1_RVT \cpuregs_reg[21][13]  ( .D(n3227), .CLK(clk), .Q(\cpuregs[21][13] ) );
  DFFX1_RVT \cpuregs_reg[20][13]  ( .D(n3195), .CLK(clk), .Q(\cpuregs[20][13] ) );
  DFFX1_RVT \cpuregs_reg[19][13]  ( .D(n3163), .CLK(clk), .Q(\cpuregs[19][13] ) );
  DFFX1_RVT \cpuregs_reg[18][13]  ( .D(n3131), .CLK(clk), .Q(\cpuregs[18][13] ) );
  DFFX1_RVT \cpuregs_reg[17][13]  ( .D(n3099), .CLK(clk), .Q(\cpuregs[17][13] ) );
  DFFX1_RVT \cpuregs_reg[16][13]  ( .D(n3067), .CLK(clk), .Q(\cpuregs[16][13] ) );
  DFFX1_RVT \cpuregs_reg[15][13]  ( .D(n3035), .CLK(clk), .Q(\cpuregs[15][13] ), .QN(n4318) );
  DFFX1_RVT \cpuregs_reg[14][13]  ( .D(n3003), .CLK(clk), .Q(\cpuregs[14][13] ) );
  DFFX1_RVT \cpuregs_reg[13][13]  ( .D(n2971), .CLK(clk), .Q(\cpuregs[13][13] ) );
  DFFX1_RVT \cpuregs_reg[12][13]  ( .D(n2939), .CLK(clk), .Q(\cpuregs[12][13] ) );
  DFFX1_RVT \cpuregs_reg[11][13]  ( .D(n2907), .CLK(clk), .Q(\cpuregs[11][13] ) );
  DFFX1_RVT \cpuregs_reg[10][13]  ( .D(n2875), .CLK(clk), .Q(\cpuregs[10][13] ) );
  DFFX1_RVT \cpuregs_reg[9][13]  ( .D(n2843), .CLK(clk), .Q(\cpuregs[9][13] )
         );
  DFFX1_RVT \cpuregs_reg[8][13]  ( .D(n2811), .CLK(clk), .Q(\cpuregs[8][13] )
         );
  DFFX1_RVT \cpuregs_reg[7][13]  ( .D(n2779), .CLK(clk), .Q(\cpuregs[7][13] )
         );
  DFFX1_RVT \cpuregs_reg[6][13]  ( .D(n2747), .CLK(clk), .Q(\cpuregs[6][13] )
         );
  DFFX1_RVT \cpuregs_reg[5][13]  ( .D(n2715), .CLK(clk), .Q(\cpuregs[5][13] ), 
        .QN(n4319) );
  DFFX1_RVT \cpuregs_reg[4][13]  ( .D(n2683), .CLK(clk), .Q(\cpuregs[4][13] )
         );
  DFFX1_RVT \cpuregs_reg[3][13]  ( .D(n2651), .CLK(clk), .Q(\cpuregs[3][13] )
         );
  DFFX1_RVT \cpuregs_reg[2][13]  ( .D(n2619), .CLK(clk), .Q(\cpuregs[2][13] )
         );
  DFFX1_RVT \cpuregs_reg[1][13]  ( .D(n2587), .CLK(clk), .Q(\cpuregs[1][13] )
         );
  DFFX1_RVT \reg_op2_reg[13]  ( .D(n3917), .CLK(clk), .Q(pcpi_rs2[13]), .QN(
        n7989) );
  DFFX1_RVT \alu_out_q_reg[14]  ( .D(alu_out[14]), .CLK(clk), .Q(alu_out_q[14]) );
  DFFX1_RVT \reg_next_pc_reg[14]  ( .D(n3815), .CLK(clk), .Q(reg_next_pc[14])
         );
  DFFX1_RVT \reg_pc_reg[14]  ( .D(n3783), .CLK(clk), .Q(reg_pc[14]) );
  DFFX1_RVT \cpuregs_reg[31][14]  ( .D(n3548), .CLK(clk), .Q(\cpuregs[31][14] ) );
  DFFX1_RVT \cpuregs_reg[30][14]  ( .D(n3516), .CLK(clk), .Q(\cpuregs[30][14] ) );
  DFFX1_RVT \cpuregs_reg[29][14]  ( .D(n3484), .CLK(clk), .Q(\cpuregs[29][14] ) );
  DFFX1_RVT \cpuregs_reg[28][14]  ( .D(n3452), .CLK(clk), .Q(\cpuregs[28][14] ) );
  DFFX1_RVT \cpuregs_reg[27][14]  ( .D(n3420), .CLK(clk), .Q(\cpuregs[27][14] ) );
  DFFX1_RVT \cpuregs_reg[26][14]  ( .D(n3388), .CLK(clk), .Q(\cpuregs[26][14] ) );
  DFFX1_RVT \cpuregs_reg[25][14]  ( .D(n3356), .CLK(clk), .Q(\cpuregs[25][14] ) );
  DFFX1_RVT \cpuregs_reg[24][14]  ( .D(n3324), .CLK(clk), .Q(\cpuregs[24][14] ) );
  DFFX1_RVT \cpuregs_reg[23][14]  ( .D(n3292), .CLK(clk), .Q(\cpuregs[23][14] ) );
  DFFX1_RVT \cpuregs_reg[22][14]  ( .D(n3260), .CLK(clk), .Q(\cpuregs[22][14] ) );
  DFFX1_RVT \cpuregs_reg[21][14]  ( .D(n3228), .CLK(clk), .Q(\cpuregs[21][14] ) );
  DFFX1_RVT \cpuregs_reg[20][14]  ( .D(n3196), .CLK(clk), .Q(\cpuregs[20][14] ) );
  DFFX1_RVT \cpuregs_reg[19][14]  ( .D(n3164), .CLK(clk), .Q(\cpuregs[19][14] ) );
  DFFX1_RVT \cpuregs_reg[18][14]  ( .D(n3132), .CLK(clk), .Q(\cpuregs[18][14] ) );
  DFFX1_RVT \cpuregs_reg[17][14]  ( .D(n3100), .CLK(clk), .Q(\cpuregs[17][14] ) );
  DFFX1_RVT \cpuregs_reg[16][14]  ( .D(n3068), .CLK(clk), .Q(\cpuregs[16][14] ) );
  DFFX1_RVT \cpuregs_reg[15][14]  ( .D(n3036), .CLK(clk), .Q(\cpuregs[15][14] ) );
  DFFX1_RVT \cpuregs_reg[14][14]  ( .D(n3004), .CLK(clk), .Q(\cpuregs[14][14] ) );
  DFFX1_RVT \cpuregs_reg[13][14]  ( .D(n2972), .CLK(clk), .Q(\cpuregs[13][14] ) );
  DFFX1_RVT \cpuregs_reg[12][14]  ( .D(n2940), .CLK(clk), .Q(\cpuregs[12][14] ) );
  DFFX1_RVT \cpuregs_reg[11][14]  ( .D(n2908), .CLK(clk), .Q(\cpuregs[11][14] ) );
  DFFX1_RVT \cpuregs_reg[10][14]  ( .D(n2876), .CLK(clk), .Q(\cpuregs[10][14] ) );
  DFFX1_RVT \cpuregs_reg[9][14]  ( .D(n2844), .CLK(clk), .Q(\cpuregs[9][14] )
         );
  DFFX1_RVT \cpuregs_reg[8][14]  ( .D(n2812), .CLK(clk), .Q(\cpuregs[8][14] )
         );
  DFFX1_RVT \cpuregs_reg[7][14]  ( .D(n2780), .CLK(clk), .Q(\cpuregs[7][14] )
         );
  DFFX1_RVT \cpuregs_reg[6][14]  ( .D(n2748), .CLK(clk), .Q(\cpuregs[6][14] )
         );
  DFFX1_RVT \cpuregs_reg[5][14]  ( .D(n2716), .CLK(clk), .Q(\cpuregs[5][14] )
         );
  DFFX1_RVT \cpuregs_reg[4][14]  ( .D(n2684), .CLK(clk), .Q(\cpuregs[4][14] )
         );
  DFFX1_RVT \cpuregs_reg[3][14]  ( .D(n2652), .CLK(clk), .Q(\cpuregs[3][14] )
         );
  DFFX1_RVT \cpuregs_reg[2][14]  ( .D(n2620), .CLK(clk), .Q(\cpuregs[2][14] )
         );
  DFFX1_RVT \cpuregs_reg[1][14]  ( .D(n2588), .CLK(clk), .Q(\cpuregs[1][14] )
         );
  DFFX1_RVT \reg_op2_reg[14]  ( .D(n3916), .CLK(clk), .Q(pcpi_rs2[14]), .QN(
        n7997) );
  DFFX1_RVT \alu_out_q_reg[15]  ( .D(alu_out[15]), .CLK(clk), .Q(alu_out_q[15]) );
  DFFX1_RVT \reg_next_pc_reg[15]  ( .D(n3814), .CLK(clk), .Q(reg_next_pc[15])
         );
  DFFX1_RVT \reg_pc_reg[15]  ( .D(n3782), .CLK(clk), .Q(reg_pc[15]) );
  DFFX1_RVT \cpuregs_reg[31][15]  ( .D(n3549), .CLK(clk), .Q(\cpuregs[31][15] ) );
  DFFX1_RVT \cpuregs_reg[30][15]  ( .D(n3517), .CLK(clk), .Q(\cpuregs[30][15] ) );
  DFFX1_RVT \cpuregs_reg[29][15]  ( .D(n3485), .CLK(clk), .Q(\cpuregs[29][15] ) );
  DFFX1_RVT \cpuregs_reg[28][15]  ( .D(n3453), .CLK(clk), .Q(\cpuregs[28][15] ) );
  DFFX1_RVT \cpuregs_reg[27][15]  ( .D(n3421), .CLK(clk), .Q(\cpuregs[27][15] ) );
  DFFX1_RVT \cpuregs_reg[26][15]  ( .D(n3389), .CLK(clk), .Q(\cpuregs[26][15] ) );
  DFFX1_RVT \cpuregs_reg[25][15]  ( .D(n3357), .CLK(clk), .Q(\cpuregs[25][15] ) );
  DFFX1_RVT \cpuregs_reg[24][15]  ( .D(n3325), .CLK(clk), .Q(\cpuregs[24][15] ) );
  DFFX1_RVT \cpuregs_reg[23][15]  ( .D(n3293), .CLK(clk), .Q(\cpuregs[23][15] ) );
  DFFX1_RVT \cpuregs_reg[22][15]  ( .D(n3261), .CLK(clk), .Q(\cpuregs[22][15] ) );
  DFFX1_RVT \cpuregs_reg[21][15]  ( .D(n3229), .CLK(clk), .Q(\cpuregs[21][15] ) );
  DFFX1_RVT \cpuregs_reg[20][15]  ( .D(n3197), .CLK(clk), .Q(\cpuregs[20][15] ) );
  DFFX1_RVT \cpuregs_reg[19][15]  ( .D(n3165), .CLK(clk), .Q(\cpuregs[19][15] ) );
  DFFX1_RVT \cpuregs_reg[18][15]  ( .D(n3133), .CLK(clk), .Q(\cpuregs[18][15] ) );
  DFFX1_RVT \cpuregs_reg[17][15]  ( .D(n3101), .CLK(clk), .Q(\cpuregs[17][15] ) );
  DFFX1_RVT \cpuregs_reg[16][15]  ( .D(n3069), .CLK(clk), .Q(\cpuregs[16][15] ) );
  DFFX1_RVT \cpuregs_reg[15][15]  ( .D(n3037), .CLK(clk), .Q(\cpuregs[15][15] ) );
  DFFX1_RVT \cpuregs_reg[14][15]  ( .D(n3005), .CLK(clk), .Q(\cpuregs[14][15] ) );
  DFFX1_RVT \cpuregs_reg[13][15]  ( .D(n2973), .CLK(clk), .Q(\cpuregs[13][15] ) );
  DFFX1_RVT \cpuregs_reg[12][15]  ( .D(n2941), .CLK(clk), .Q(\cpuregs[12][15] ) );
  DFFX1_RVT \cpuregs_reg[11][15]  ( .D(n2909), .CLK(clk), .Q(\cpuregs[11][15] ) );
  DFFX1_RVT \cpuregs_reg[10][15]  ( .D(n2877), .CLK(clk), .Q(\cpuregs[10][15] ) );
  DFFX1_RVT \cpuregs_reg[9][15]  ( .D(n2845), .CLK(clk), .Q(\cpuregs[9][15] )
         );
  DFFX1_RVT \cpuregs_reg[8][15]  ( .D(n2813), .CLK(clk), .Q(\cpuregs[8][15] )
         );
  DFFX1_RVT \cpuregs_reg[7][15]  ( .D(n2781), .CLK(clk), .Q(\cpuregs[7][15] )
         );
  DFFX1_RVT \cpuregs_reg[6][15]  ( .D(n2749), .CLK(clk), .Q(\cpuregs[6][15] )
         );
  DFFX1_RVT \cpuregs_reg[5][15]  ( .D(n2717), .CLK(clk), .Q(\cpuregs[5][15] )
         );
  DFFX1_RVT \cpuregs_reg[4][15]  ( .D(n2685), .CLK(clk), .Q(\cpuregs[4][15] )
         );
  DFFX1_RVT \cpuregs_reg[3][15]  ( .D(n2653), .CLK(clk), .Q(\cpuregs[3][15] )
         );
  DFFX1_RVT \cpuregs_reg[2][15]  ( .D(n2621), .CLK(clk), .Q(\cpuregs[2][15] )
         );
  DFFX1_RVT \cpuregs_reg[1][15]  ( .D(n2589), .CLK(clk), .Q(\cpuregs[1][15] )
         );
  DFFX1_RVT \reg_op2_reg[15]  ( .D(n3915), .CLK(clk), .Q(pcpi_rs2[15]), .QN(
        n8033) );
  DFFX1_RVT \alu_out_q_reg[16]  ( .D(alu_out[16]), .CLK(clk), .Q(alu_out_q[16]) );
  DFFX1_RVT \reg_next_pc_reg[16]  ( .D(n3813), .CLK(clk), .Q(reg_next_pc[16])
         );
  DFFX1_RVT \reg_pc_reg[16]  ( .D(n3781), .CLK(clk), .Q(reg_pc[16]) );
  DFFX1_RVT \cpuregs_reg[31][16]  ( .D(n3550), .CLK(clk), .Q(\cpuregs[31][16] ) );
  DFFX1_RVT \cpuregs_reg[30][16]  ( .D(n3518), .CLK(clk), .Q(\cpuregs[30][16] ) );
  DFFX1_RVT \cpuregs_reg[29][16]  ( .D(n3486), .CLK(clk), .Q(\cpuregs[29][16] ) );
  DFFX1_RVT \cpuregs_reg[28][16]  ( .D(n3454), .CLK(clk), .Q(\cpuregs[28][16] ) );
  DFFX1_RVT \cpuregs_reg[27][16]  ( .D(n3422), .CLK(clk), .Q(\cpuregs[27][16] ) );
  DFFX1_RVT \cpuregs_reg[26][16]  ( .D(n3390), .CLK(clk), .Q(\cpuregs[26][16] ) );
  DFFX1_RVT \cpuregs_reg[25][16]  ( .D(n3358), .CLK(clk), .Q(\cpuregs[25][16] ) );
  DFFX1_RVT \cpuregs_reg[24][16]  ( .D(n3326), .CLK(clk), .Q(\cpuregs[24][16] ) );
  DFFX1_RVT \cpuregs_reg[23][16]  ( .D(n3294), .CLK(clk), .Q(\cpuregs[23][16] ) );
  DFFX1_RVT \cpuregs_reg[22][16]  ( .D(n3262), .CLK(clk), .Q(\cpuregs[22][16] ) );
  DFFX1_RVT \cpuregs_reg[21][16]  ( .D(n3230), .CLK(clk), .Q(\cpuregs[21][16] ) );
  DFFX1_RVT \cpuregs_reg[20][16]  ( .D(n3198), .CLK(clk), .Q(\cpuregs[20][16] ) );
  DFFX1_RVT \cpuregs_reg[19][16]  ( .D(n3166), .CLK(clk), .Q(\cpuregs[19][16] ) );
  DFFX1_RVT \cpuregs_reg[18][16]  ( .D(n3134), .CLK(clk), .Q(\cpuregs[18][16] ) );
  DFFX1_RVT \cpuregs_reg[17][16]  ( .D(n3102), .CLK(clk), .Q(\cpuregs[17][16] ) );
  DFFX1_RVT \cpuregs_reg[16][16]  ( .D(n3070), .CLK(clk), .Q(\cpuregs[16][16] ) );
  DFFX1_RVT \cpuregs_reg[15][16]  ( .D(n3038), .CLK(clk), .Q(\cpuregs[15][16] ) );
  DFFX1_RVT \cpuregs_reg[14][16]  ( .D(n3006), .CLK(clk), .Q(\cpuregs[14][16] ) );
  DFFX1_RVT \cpuregs_reg[13][16]  ( .D(n2974), .CLK(clk), .Q(\cpuregs[13][16] ) );
  DFFX1_RVT \cpuregs_reg[12][16]  ( .D(n2942), .CLK(clk), .Q(\cpuregs[12][16] ) );
  DFFX1_RVT \cpuregs_reg[11][16]  ( .D(n2910), .CLK(clk), .Q(\cpuregs[11][16] ) );
  DFFX1_RVT \cpuregs_reg[10][16]  ( .D(n2878), .CLK(clk), .Q(\cpuregs[10][16] ) );
  DFFX1_RVT \cpuregs_reg[9][16]  ( .D(n2846), .CLK(clk), .Q(\cpuregs[9][16] )
         );
  DFFX1_RVT \cpuregs_reg[8][16]  ( .D(n2814), .CLK(clk), .Q(\cpuregs[8][16] )
         );
  DFFX1_RVT \cpuregs_reg[7][16]  ( .D(n2782), .CLK(clk), .Q(\cpuregs[7][16] )
         );
  DFFX1_RVT \cpuregs_reg[6][16]  ( .D(n2750), .CLK(clk), .Q(\cpuregs[6][16] )
         );
  DFFX1_RVT \cpuregs_reg[5][16]  ( .D(n2718), .CLK(clk), .Q(\cpuregs[5][16] )
         );
  DFFX1_RVT \cpuregs_reg[4][16]  ( .D(n2686), .CLK(clk), .Q(\cpuregs[4][16] )
         );
  DFFX1_RVT \cpuregs_reg[3][16]  ( .D(n2654), .CLK(clk), .Q(\cpuregs[3][16] )
         );
  DFFX1_RVT \cpuregs_reg[2][16]  ( .D(n2622), .CLK(clk), .Q(\cpuregs[2][16] )
         );
  DFFX1_RVT \cpuregs_reg[1][16]  ( .D(n2590), .CLK(clk), .Q(\cpuregs[1][16] )
         );
  DFFX1_RVT \reg_op2_reg[16]  ( .D(n3914), .CLK(clk), .Q(pcpi_rs2[16]), .QN(
        n7993) );
  DFFX1_RVT \alu_out_q_reg[17]  ( .D(alu_out[17]), .CLK(clk), .Q(alu_out_q[17]) );
  DFFX1_RVT \reg_next_pc_reg[17]  ( .D(n3812), .CLK(clk), .Q(reg_next_pc[17])
         );
  DFFX1_RVT \reg_pc_reg[17]  ( .D(n3780), .CLK(clk), .Q(reg_pc[17]) );
  DFFX1_RVT \cpuregs_reg[31][17]  ( .D(n3551), .CLK(clk), .Q(\cpuregs[31][17] ) );
  DFFX1_RVT \cpuregs_reg[30][17]  ( .D(n3519), .CLK(clk), .Q(\cpuregs[30][17] ) );
  DFFX1_RVT \cpuregs_reg[29][17]  ( .D(n3487), .CLK(clk), .Q(\cpuregs[29][17] ) );
  DFFX1_RVT \cpuregs_reg[28][17]  ( .D(n3455), .CLK(clk), .Q(\cpuregs[28][17] ) );
  DFFX1_RVT \cpuregs_reg[27][17]  ( .D(n3423), .CLK(clk), .Q(\cpuregs[27][17] ) );
  DFFX1_RVT \cpuregs_reg[26][17]  ( .D(n3391), .CLK(clk), .Q(\cpuregs[26][17] ) );
  DFFX1_RVT \cpuregs_reg[25][17]  ( .D(n3359), .CLK(clk), .Q(\cpuregs[25][17] ) );
  DFFX1_RVT \cpuregs_reg[24][17]  ( .D(n3327), .CLK(clk), .Q(\cpuregs[24][17] ) );
  DFFX1_RVT \cpuregs_reg[23][17]  ( .D(n3295), .CLK(clk), .Q(\cpuregs[23][17] ) );
  DFFX1_RVT \cpuregs_reg[22][17]  ( .D(n3263), .CLK(clk), .Q(\cpuregs[22][17] ) );
  DFFX1_RVT \cpuregs_reg[21][17]  ( .D(n3231), .CLK(clk), .Q(\cpuregs[21][17] ) );
  DFFX1_RVT \cpuregs_reg[20][17]  ( .D(n3199), .CLK(clk), .Q(\cpuregs[20][17] ) );
  DFFX1_RVT \cpuregs_reg[19][17]  ( .D(n3167), .CLK(clk), .Q(\cpuregs[19][17] ) );
  DFFX1_RVT \cpuregs_reg[18][17]  ( .D(n3135), .CLK(clk), .Q(\cpuregs[18][17] ) );
  DFFX1_RVT \cpuregs_reg[17][17]  ( .D(n3103), .CLK(clk), .Q(\cpuregs[17][17] ) );
  DFFX1_RVT \cpuregs_reg[16][17]  ( .D(n3071), .CLK(clk), .Q(\cpuregs[16][17] ) );
  DFFX1_RVT \cpuregs_reg[15][17]  ( .D(n3039), .CLK(clk), .Q(\cpuregs[15][17] ) );
  DFFX1_RVT \cpuregs_reg[14][17]  ( .D(n3007), .CLK(clk), .Q(\cpuregs[14][17] ) );
  DFFX1_RVT \cpuregs_reg[13][17]  ( .D(n2975), .CLK(clk), .Q(\cpuregs[13][17] ) );
  DFFX1_RVT \cpuregs_reg[12][17]  ( .D(n2943), .CLK(clk), .Q(\cpuregs[12][17] ) );
  DFFX1_RVT \cpuregs_reg[11][17]  ( .D(n2911), .CLK(clk), .Q(\cpuregs[11][17] ) );
  DFFX1_RVT \cpuregs_reg[10][17]  ( .D(n2879), .CLK(clk), .Q(\cpuregs[10][17] ) );
  DFFX1_RVT \cpuregs_reg[9][17]  ( .D(n2847), .CLK(clk), .Q(\cpuregs[9][17] )
         );
  DFFX1_RVT \cpuregs_reg[8][17]  ( .D(n2815), .CLK(clk), .Q(\cpuregs[8][17] )
         );
  DFFX1_RVT \cpuregs_reg[7][17]  ( .D(n2783), .CLK(clk), .Q(\cpuregs[7][17] )
         );
  DFFX1_RVT \cpuregs_reg[6][17]  ( .D(n2751), .CLK(clk), .Q(\cpuregs[6][17] )
         );
  DFFX1_RVT \cpuregs_reg[5][17]  ( .D(n2719), .CLK(clk), .Q(\cpuregs[5][17] )
         );
  DFFX1_RVT \cpuregs_reg[4][17]  ( .D(n2687), .CLK(clk), .Q(\cpuregs[4][17] )
         );
  DFFX1_RVT \cpuregs_reg[3][17]  ( .D(n2655), .CLK(clk), .Q(\cpuregs[3][17] )
         );
  DFFX1_RVT \cpuregs_reg[2][17]  ( .D(n2623), .CLK(clk), .Q(\cpuregs[2][17] )
         );
  DFFX1_RVT \cpuregs_reg[1][17]  ( .D(n2591), .CLK(clk), .Q(\cpuregs[1][17] )
         );
  DFFX1_RVT \reg_op2_reg[17]  ( .D(n3913), .CLK(clk), .Q(pcpi_rs2[17]), .QN(
        n8028) );
  DFFX1_RVT \alu_out_q_reg[18]  ( .D(alu_out[18]), .CLK(clk), .Q(alu_out_q[18]) );
  DFFX1_RVT \reg_next_pc_reg[18]  ( .D(n3811), .CLK(clk), .Q(reg_next_pc[18])
         );
  DFFX1_RVT \reg_pc_reg[18]  ( .D(n3779), .CLK(clk), .Q(reg_pc[18]) );
  DFFX1_RVT \cpuregs_reg[31][18]  ( .D(n3552), .CLK(clk), .Q(\cpuregs[31][18] ) );
  DFFX1_RVT \cpuregs_reg[30][18]  ( .D(n3520), .CLK(clk), .Q(\cpuregs[30][18] ) );
  DFFX1_RVT \cpuregs_reg[29][18]  ( .D(n3488), .CLK(clk), .Q(\cpuregs[29][18] ) );
  DFFX1_RVT \cpuregs_reg[28][18]  ( .D(n3456), .CLK(clk), .Q(\cpuregs[28][18] ) );
  DFFX1_RVT \cpuregs_reg[27][18]  ( .D(n3424), .CLK(clk), .Q(\cpuregs[27][18] ) );
  DFFX1_RVT \cpuregs_reg[26][18]  ( .D(n3392), .CLK(clk), .Q(\cpuregs[26][18] ) );
  DFFX1_RVT \cpuregs_reg[25][18]  ( .D(n3360), .CLK(clk), .Q(\cpuregs[25][18] ) );
  DFFX1_RVT \cpuregs_reg[24][18]  ( .D(n3328), .CLK(clk), .Q(\cpuregs[24][18] ) );
  DFFX1_RVT \cpuregs_reg[23][18]  ( .D(n3296), .CLK(clk), .Q(\cpuregs[23][18] ) );
  DFFX1_RVT \cpuregs_reg[22][18]  ( .D(n3264), .CLK(clk), .Q(\cpuregs[22][18] ) );
  DFFX1_RVT \cpuregs_reg[21][18]  ( .D(n3232), .CLK(clk), .Q(\cpuregs[21][18] ) );
  DFFX1_RVT \cpuregs_reg[20][18]  ( .D(n3200), .CLK(clk), .Q(\cpuregs[20][18] ) );
  DFFX1_RVT \cpuregs_reg[19][18]  ( .D(n3168), .CLK(clk), .Q(\cpuregs[19][18] ) );
  DFFX1_RVT \cpuregs_reg[18][18]  ( .D(n3136), .CLK(clk), .Q(\cpuregs[18][18] ) );
  DFFX1_RVT \cpuregs_reg[17][18]  ( .D(n3104), .CLK(clk), .Q(\cpuregs[17][18] ) );
  DFFX1_RVT \cpuregs_reg[16][18]  ( .D(n3072), .CLK(clk), .Q(\cpuregs[16][18] ) );
  DFFX1_RVT \cpuregs_reg[15][18]  ( .D(n3040), .CLK(clk), .Q(\cpuregs[15][18] ) );
  DFFX1_RVT \cpuregs_reg[14][18]  ( .D(n3008), .CLK(clk), .Q(\cpuregs[14][18] ) );
  DFFX1_RVT \cpuregs_reg[13][18]  ( .D(n2976), .CLK(clk), .Q(\cpuregs[13][18] ) );
  DFFX1_RVT \cpuregs_reg[12][18]  ( .D(n2944), .CLK(clk), .Q(\cpuregs[12][18] ) );
  DFFX1_RVT \cpuregs_reg[11][18]  ( .D(n2912), .CLK(clk), .Q(\cpuregs[11][18] ) );
  DFFX1_RVT \cpuregs_reg[10][18]  ( .D(n2880), .CLK(clk), .Q(\cpuregs[10][18] ) );
  DFFX1_RVT \cpuregs_reg[9][18]  ( .D(n2848), .CLK(clk), .Q(\cpuregs[9][18] )
         );
  DFFX1_RVT \cpuregs_reg[8][18]  ( .D(n2816), .CLK(clk), .Q(\cpuregs[8][18] )
         );
  DFFX1_RVT \cpuregs_reg[7][18]  ( .D(n2784), .CLK(clk), .Q(\cpuregs[7][18] )
         );
  DFFX1_RVT \cpuregs_reg[6][18]  ( .D(n2752), .CLK(clk), .Q(\cpuregs[6][18] )
         );
  DFFX1_RVT \cpuregs_reg[5][18]  ( .D(n2720), .CLK(clk), .Q(\cpuregs[5][18] )
         );
  DFFX1_RVT \cpuregs_reg[4][18]  ( .D(n2688), .CLK(clk), .Q(\cpuregs[4][18] )
         );
  DFFX1_RVT \cpuregs_reg[3][18]  ( .D(n2656), .CLK(clk), .Q(\cpuregs[3][18] )
         );
  DFFX1_RVT \cpuregs_reg[2][18]  ( .D(n2624), .CLK(clk), .Q(\cpuregs[2][18] )
         );
  DFFX1_RVT \cpuregs_reg[1][18]  ( .D(n2592), .CLK(clk), .Q(\cpuregs[1][18] )
         );
  DFFX1_RVT \reg_op2_reg[18]  ( .D(n3912), .CLK(clk), .Q(pcpi_rs2[18]), .QN(
        n7990) );
  DFFX1_RVT \alu_out_q_reg[19]  ( .D(alu_out[19]), .CLK(clk), .Q(alu_out_q[19]) );
  DFFX1_RVT \reg_next_pc_reg[19]  ( .D(n3810), .CLK(clk), .Q(reg_next_pc[19])
         );
  DFFX1_RVT \reg_pc_reg[19]  ( .D(n3778), .CLK(clk), .Q(reg_pc[19]) );
  DFFX1_RVT \cpuregs_reg[31][19]  ( .D(n3553), .CLK(clk), .Q(\cpuregs[31][19] ) );
  DFFX1_RVT \cpuregs_reg[30][19]  ( .D(n3521), .CLK(clk), .Q(\cpuregs[30][19] ) );
  DFFX1_RVT \cpuregs_reg[29][19]  ( .D(n3489), .CLK(clk), .Q(\cpuregs[29][19] ) );
  DFFX1_RVT \cpuregs_reg[28][19]  ( .D(n3457), .CLK(clk), .Q(\cpuregs[28][19] ) );
  DFFX1_RVT \cpuregs_reg[27][19]  ( .D(n3425), .CLK(clk), .Q(\cpuregs[27][19] ) );
  DFFX1_RVT \cpuregs_reg[26][19]  ( .D(n3393), .CLK(clk), .Q(\cpuregs[26][19] ) );
  DFFX1_RVT \cpuregs_reg[25][19]  ( .D(n3361), .CLK(clk), .Q(\cpuregs[25][19] ) );
  DFFX1_RVT \cpuregs_reg[24][19]  ( .D(n3329), .CLK(clk), .Q(\cpuregs[24][19] ) );
  DFFX1_RVT \cpuregs_reg[23][19]  ( .D(n3297), .CLK(clk), .Q(\cpuregs[23][19] ) );
  DFFX1_RVT \cpuregs_reg[22][19]  ( .D(n3265), .CLK(clk), .Q(\cpuregs[22][19] ) );
  DFFX1_RVT \cpuregs_reg[21][19]  ( .D(n3233), .CLK(clk), .Q(\cpuregs[21][19] ) );
  DFFX1_RVT \cpuregs_reg[20][19]  ( .D(n3201), .CLK(clk), .Q(\cpuregs[20][19] ) );
  DFFX1_RVT \cpuregs_reg[19][19]  ( .D(n3169), .CLK(clk), .Q(\cpuregs[19][19] ) );
  DFFX1_RVT \cpuregs_reg[18][19]  ( .D(n3137), .CLK(clk), .Q(\cpuregs[18][19] ) );
  DFFX1_RVT \cpuregs_reg[17][19]  ( .D(n3105), .CLK(clk), .Q(\cpuregs[17][19] ) );
  DFFX1_RVT \cpuregs_reg[16][19]  ( .D(n3073), .CLK(clk), .Q(\cpuregs[16][19] ) );
  DFFX1_RVT \cpuregs_reg[15][19]  ( .D(n3041), .CLK(clk), .Q(\cpuregs[15][19] ) );
  DFFX1_RVT \cpuregs_reg[14][19]  ( .D(n3009), .CLK(clk), .Q(\cpuregs[14][19] ) );
  DFFX1_RVT \cpuregs_reg[13][19]  ( .D(n2977), .CLK(clk), .Q(\cpuregs[13][19] ) );
  DFFX1_RVT \cpuregs_reg[12][19]  ( .D(n2945), .CLK(clk), .Q(\cpuregs[12][19] ) );
  DFFX1_RVT \cpuregs_reg[11][19]  ( .D(n2913), .CLK(clk), .Q(\cpuregs[11][19] ) );
  DFFX1_RVT \cpuregs_reg[10][19]  ( .D(n2881), .CLK(clk), .Q(\cpuregs[10][19] ) );
  DFFX1_RVT \cpuregs_reg[9][19]  ( .D(n2849), .CLK(clk), .Q(\cpuregs[9][19] )
         );
  DFFX1_RVT \cpuregs_reg[8][19]  ( .D(n2817), .CLK(clk), .Q(\cpuregs[8][19] )
         );
  DFFX1_RVT \cpuregs_reg[7][19]  ( .D(n2785), .CLK(clk), .Q(\cpuregs[7][19] )
         );
  DFFX1_RVT \cpuregs_reg[6][19]  ( .D(n2753), .CLK(clk), .Q(\cpuregs[6][19] )
         );
  DFFX1_RVT \cpuregs_reg[5][19]  ( .D(n2721), .CLK(clk), .Q(\cpuregs[5][19] )
         );
  DFFX1_RVT \cpuregs_reg[4][19]  ( .D(n2689), .CLK(clk), .Q(\cpuregs[4][19] )
         );
  DFFX1_RVT \cpuregs_reg[3][19]  ( .D(n2657), .CLK(clk), .Q(\cpuregs[3][19] )
         );
  DFFX1_RVT \cpuregs_reg[2][19]  ( .D(n2625), .CLK(clk), .Q(\cpuregs[2][19] )
         );
  DFFX1_RVT \cpuregs_reg[1][19]  ( .D(n2593), .CLK(clk), .Q(\cpuregs[1][19] )
         );
  DFFX1_RVT \reg_op2_reg[19]  ( .D(n3911), .CLK(clk), .Q(pcpi_rs2[19]), .QN(
        n8026) );
  DFFX1_RVT \alu_out_q_reg[20]  ( .D(alu_out[20]), .CLK(clk), .Q(alu_out_q[20]) );
  DFFX1_RVT \reg_next_pc_reg[20]  ( .D(n3809), .CLK(clk), .Q(reg_next_pc[20])
         );
  DFFX1_RVT \reg_pc_reg[20]  ( .D(n3777), .CLK(clk), .Q(reg_pc[20]) );
  DFFX1_RVT \cpuregs_reg[31][20]  ( .D(n3554), .CLK(clk), .Q(\cpuregs[31][20] ) );
  DFFX1_RVT \cpuregs_reg[30][20]  ( .D(n3522), .CLK(clk), .Q(\cpuregs[30][20] ), .QN(n4299) );
  DFFX1_RVT \cpuregs_reg[29][20]  ( .D(n3490), .CLK(clk), .Q(\cpuregs[29][20] ) );
  DFFX1_RVT \cpuregs_reg[28][20]  ( .D(n3458), .CLK(clk), .Q(\cpuregs[28][20] ) );
  DFFX1_RVT \cpuregs_reg[27][20]  ( .D(n3426), .CLK(clk), .Q(\cpuregs[27][20] ) );
  DFFX1_RVT \cpuregs_reg[26][20]  ( .D(n3394), .CLK(clk), .Q(\cpuregs[26][20] ) );
  DFFX1_RVT \cpuregs_reg[25][20]  ( .D(n3362), .CLK(clk), .Q(\cpuregs[25][20] ) );
  DFFX1_RVT \cpuregs_reg[24][20]  ( .D(n3330), .CLK(clk), .Q(\cpuregs[24][20] ) );
  DFFX1_RVT \cpuregs_reg[23][20]  ( .D(n3298), .CLK(clk), .Q(\cpuregs[23][20] ) );
  DFFX1_RVT \cpuregs_reg[22][20]  ( .D(n3266), .CLK(clk), .Q(\cpuregs[22][20] ) );
  DFFX1_RVT \cpuregs_reg[21][20]  ( .D(n3234), .CLK(clk), .Q(\cpuregs[21][20] ) );
  DFFX1_RVT \cpuregs_reg[20][20]  ( .D(n3202), .CLK(clk), .Q(\cpuregs[20][20] ) );
  DFFX1_RVT \cpuregs_reg[19][20]  ( .D(n3170), .CLK(clk), .Q(\cpuregs[19][20] ) );
  DFFX1_RVT \cpuregs_reg[18][20]  ( .D(n3138), .CLK(clk), .Q(\cpuregs[18][20] ) );
  DFFX1_RVT \cpuregs_reg[17][20]  ( .D(n3106), .CLK(clk), .Q(\cpuregs[17][20] ) );
  DFFX1_RVT \cpuregs_reg[16][20]  ( .D(n3074), .CLK(clk), .Q(\cpuregs[16][20] ) );
  DFFX1_RVT \cpuregs_reg[15][20]  ( .D(n3042), .CLK(clk), .Q(\cpuregs[15][20] ), .QN(n4298) );
  DFFX1_RVT \cpuregs_reg[14][20]  ( .D(n3010), .CLK(clk), .Q(\cpuregs[14][20] ) );
  DFFX1_RVT \cpuregs_reg[13][20]  ( .D(n2978), .CLK(clk), .Q(\cpuregs[13][20] ) );
  DFFX1_RVT \cpuregs_reg[12][20]  ( .D(n2946), .CLK(clk), .Q(\cpuregs[12][20] ) );
  DFFX1_RVT \cpuregs_reg[11][20]  ( .D(n2914), .CLK(clk), .Q(\cpuregs[11][20] ) );
  DFFX1_RVT \cpuregs_reg[10][20]  ( .D(n2882), .CLK(clk), .Q(\cpuregs[10][20] ) );
  DFFX1_RVT \cpuregs_reg[9][20]  ( .D(n2850), .CLK(clk), .Q(\cpuregs[9][20] )
         );
  DFFX1_RVT \cpuregs_reg[8][20]  ( .D(n2818), .CLK(clk), .Q(\cpuregs[8][20] )
         );
  DFFX1_RVT \cpuregs_reg[7][20]  ( .D(n2786), .CLK(clk), .Q(\cpuregs[7][20] )
         );
  DFFX1_RVT \cpuregs_reg[6][20]  ( .D(n2754), .CLK(clk), .Q(\cpuregs[6][20] )
         );
  DFFX1_RVT \cpuregs_reg[5][20]  ( .D(n2722), .CLK(clk), .Q(\cpuregs[5][20] )
         );
  DFFX1_RVT \cpuregs_reg[4][20]  ( .D(n2690), .CLK(clk), .Q(\cpuregs[4][20] )
         );
  DFFX1_RVT \cpuregs_reg[3][20]  ( .D(n2658), .CLK(clk), .Q(\cpuregs[3][20] )
         );
  DFFX1_RVT \cpuregs_reg[2][20]  ( .D(n2626), .CLK(clk), .Q(\cpuregs[2][20] )
         );
  DFFX1_RVT \cpuregs_reg[1][20]  ( .D(n2594), .CLK(clk), .Q(\cpuregs[1][20] )
         );
  DFFX1_RVT \reg_op2_reg[20]  ( .D(n3910), .CLK(clk), .Q(pcpi_rs2[20]), .QN(
        n7996) );
  DFFX1_RVT \alu_out_q_reg[21]  ( .D(alu_out[21]), .CLK(clk), .Q(alu_out_q[21]) );
  DFFX1_RVT \reg_next_pc_reg[21]  ( .D(n3808), .CLK(clk), .Q(reg_next_pc[21])
         );
  DFFX1_RVT \reg_pc_reg[21]  ( .D(n3776), .CLK(clk), .Q(reg_pc[21]) );
  DFFX1_RVT \cpuregs_reg[31][21]  ( .D(n3555), .CLK(clk), .Q(\cpuregs[31][21] ) );
  DFFX1_RVT \cpuregs_reg[30][21]  ( .D(n3523), .CLK(clk), .Q(\cpuregs[30][21] ) );
  DFFX1_RVT \cpuregs_reg[29][21]  ( .D(n3491), .CLK(clk), .Q(\cpuregs[29][21] ) );
  DFFX1_RVT \cpuregs_reg[28][21]  ( .D(n3459), .CLK(clk), .Q(\cpuregs[28][21] ) );
  DFFX1_RVT \cpuregs_reg[27][21]  ( .D(n3427), .CLK(clk), .Q(\cpuregs[27][21] ) );
  DFFX1_RVT \cpuregs_reg[26][21]  ( .D(n3395), .CLK(clk), .Q(\cpuregs[26][21] ) );
  DFFX1_RVT \cpuregs_reg[25][21]  ( .D(n3363), .CLK(clk), .Q(\cpuregs[25][21] ) );
  DFFX1_RVT \cpuregs_reg[24][21]  ( .D(n3331), .CLK(clk), .Q(\cpuregs[24][21] ) );
  DFFX1_RVT \cpuregs_reg[23][21]  ( .D(n3299), .CLK(clk), .Q(\cpuregs[23][21] ) );
  DFFX1_RVT \cpuregs_reg[22][21]  ( .D(n3267), .CLK(clk), .Q(\cpuregs[22][21] ) );
  DFFX1_RVT \cpuregs_reg[21][21]  ( .D(n3235), .CLK(clk), .Q(\cpuregs[21][21] ) );
  DFFX1_RVT \cpuregs_reg[20][21]  ( .D(n3203), .CLK(clk), .Q(\cpuregs[20][21] ) );
  DFFX1_RVT \cpuregs_reg[19][21]  ( .D(n3171), .CLK(clk), .Q(\cpuregs[19][21] ) );
  DFFX1_RVT \cpuregs_reg[18][21]  ( .D(n3139), .CLK(clk), .Q(\cpuregs[18][21] ) );
  DFFX1_RVT \cpuregs_reg[17][21]  ( .D(n3107), .CLK(clk), .Q(\cpuregs[17][21] ) );
  DFFX1_RVT \cpuregs_reg[16][21]  ( .D(n3075), .CLK(clk), .Q(\cpuregs[16][21] ) );
  DFFX1_RVT \cpuregs_reg[15][21]  ( .D(n3043), .CLK(clk), .Q(\cpuregs[15][21] ) );
  DFFX1_RVT \cpuregs_reg[14][21]  ( .D(n3011), .CLK(clk), .Q(\cpuregs[14][21] ) );
  DFFX1_RVT \cpuregs_reg[13][21]  ( .D(n2979), .CLK(clk), .Q(\cpuregs[13][21] ) );
  DFFX1_RVT \cpuregs_reg[12][21]  ( .D(n2947), .CLK(clk), .Q(\cpuregs[12][21] ) );
  DFFX1_RVT \cpuregs_reg[11][21]  ( .D(n2915), .CLK(clk), .Q(\cpuregs[11][21] ) );
  DFFX1_RVT \cpuregs_reg[10][21]  ( .D(n2883), .CLK(clk), .Q(\cpuregs[10][21] ) );
  DFFX1_RVT \cpuregs_reg[9][21]  ( .D(n2851), .CLK(clk), .Q(\cpuregs[9][21] )
         );
  DFFX1_RVT \cpuregs_reg[8][21]  ( .D(n2819), .CLK(clk), .Q(\cpuregs[8][21] )
         );
  DFFX1_RVT \cpuregs_reg[7][21]  ( .D(n2787), .CLK(clk), .Q(\cpuregs[7][21] )
         );
  DFFX1_RVT \cpuregs_reg[6][21]  ( .D(n2755), .CLK(clk), .Q(\cpuregs[6][21] )
         );
  DFFX1_RVT \cpuregs_reg[5][21]  ( .D(n2723), .CLK(clk), .Q(\cpuregs[5][21] )
         );
  DFFX1_RVT \cpuregs_reg[4][21]  ( .D(n2691), .CLK(clk), .Q(\cpuregs[4][21] )
         );
  DFFX1_RVT \cpuregs_reg[3][21]  ( .D(n2659), .CLK(clk), .Q(\cpuregs[3][21] )
         );
  DFFX1_RVT \cpuregs_reg[2][21]  ( .D(n2627), .CLK(clk), .Q(\cpuregs[2][21] )
         );
  DFFX1_RVT \cpuregs_reg[1][21]  ( .D(n2595), .CLK(clk), .Q(\cpuregs[1][21] )
         );
  DFFX1_RVT \reg_op2_reg[21]  ( .D(n3909), .CLK(clk), .Q(pcpi_rs2[21]), .QN(
        n8027) );
  DFFX1_RVT \alu_out_q_reg[22]  ( .D(alu_out[22]), .CLK(clk), .Q(alu_out_q[22]) );
  DFFX1_RVT \reg_next_pc_reg[22]  ( .D(n3807), .CLK(clk), .Q(reg_next_pc[22])
         );
  DFFX1_RVT \reg_pc_reg[22]  ( .D(n3775), .CLK(clk), .Q(reg_pc[22]) );
  DFFX1_RVT \cpuregs_reg[31][22]  ( .D(n3556), .CLK(clk), .Q(\cpuregs[31][22] ) );
  DFFX1_RVT \cpuregs_reg[30][22]  ( .D(n3524), .CLK(clk), .Q(\cpuregs[30][22] ) );
  DFFX1_RVT \cpuregs_reg[29][22]  ( .D(n3492), .CLK(clk), .Q(\cpuregs[29][22] ) );
  DFFX1_RVT \cpuregs_reg[28][22]  ( .D(n3460), .CLK(clk), .Q(\cpuregs[28][22] ) );
  DFFX1_RVT \cpuregs_reg[27][22]  ( .D(n3428), .CLK(clk), .Q(\cpuregs[27][22] ), .QN(n4308) );
  DFFX1_RVT \cpuregs_reg[26][22]  ( .D(n3396), .CLK(clk), .Q(\cpuregs[26][22] ) );
  DFFX1_RVT \cpuregs_reg[25][22]  ( .D(n3364), .CLK(clk), .Q(\cpuregs[25][22] ) );
  DFFX1_RVT \cpuregs_reg[24][22]  ( .D(n3332), .CLK(clk), .Q(\cpuregs[24][22] ) );
  DFFX1_RVT \cpuregs_reg[23][22]  ( .D(n3300), .CLK(clk), .Q(\cpuregs[23][22] ) );
  DFFX1_RVT \cpuregs_reg[22][22]  ( .D(n3268), .CLK(clk), .Q(\cpuregs[22][22] ) );
  DFFX1_RVT \cpuregs_reg[21][22]  ( .D(n3236), .CLK(clk), .Q(\cpuregs[21][22] ) );
  DFFX1_RVT \cpuregs_reg[20][22]  ( .D(n3204), .CLK(clk), .Q(\cpuregs[20][22] ) );
  DFFX1_RVT \cpuregs_reg[19][22]  ( .D(n3172), .CLK(clk), .Q(\cpuregs[19][22] ) );
  DFFX1_RVT \cpuregs_reg[18][22]  ( .D(n3140), .CLK(clk), .Q(\cpuregs[18][22] ) );
  DFFX1_RVT \cpuregs_reg[17][22]  ( .D(n3108), .CLK(clk), .Q(\cpuregs[17][22] ) );
  DFFX1_RVT \cpuregs_reg[16][22]  ( .D(n3076), .CLK(clk), .Q(\cpuregs[16][22] ) );
  DFFX1_RVT \cpuregs_reg[15][22]  ( .D(n3044), .CLK(clk), .Q(\cpuregs[15][22] ), .QN(n4309) );
  DFFX1_RVT \cpuregs_reg[14][22]  ( .D(n3012), .CLK(clk), .Q(\cpuregs[14][22] ) );
  DFFX1_RVT \cpuregs_reg[13][22]  ( .D(n2980), .CLK(clk), .Q(\cpuregs[13][22] ) );
  DFFX1_RVT \cpuregs_reg[12][22]  ( .D(n2948), .CLK(clk), .Q(\cpuregs[12][22] ) );
  DFFX1_RVT \cpuregs_reg[11][22]  ( .D(n2916), .CLK(clk), .Q(\cpuregs[11][22] ) );
  DFFX1_RVT \cpuregs_reg[10][22]  ( .D(n2884), .CLK(clk), .Q(\cpuregs[10][22] ) );
  DFFX1_RVT \cpuregs_reg[9][22]  ( .D(n2852), .CLK(clk), .Q(\cpuregs[9][22] )
         );
  DFFX1_RVT \cpuregs_reg[8][22]  ( .D(n2820), .CLK(clk), .Q(\cpuregs[8][22] )
         );
  DFFX1_RVT \cpuregs_reg[7][22]  ( .D(n2788), .CLK(clk), .Q(\cpuregs[7][22] )
         );
  DFFX1_RVT \cpuregs_reg[6][22]  ( .D(n2756), .CLK(clk), .Q(\cpuregs[6][22] )
         );
  DFFX1_RVT \cpuregs_reg[5][22]  ( .D(n2724), .CLK(clk), .Q(\cpuregs[5][22] )
         );
  DFFX1_RVT \cpuregs_reg[4][22]  ( .D(n2692), .CLK(clk), .Q(\cpuregs[4][22] )
         );
  DFFX1_RVT \cpuregs_reg[3][22]  ( .D(n2660), .CLK(clk), .Q(\cpuregs[3][22] )
         );
  DFFX1_RVT \cpuregs_reg[2][22]  ( .D(n2628), .CLK(clk), .Q(\cpuregs[2][22] )
         );
  DFFX1_RVT \cpuregs_reg[1][22]  ( .D(n2596), .CLK(clk), .Q(\cpuregs[1][22] )
         );
  DFFX1_RVT \reg_op2_reg[22]  ( .D(n3908), .CLK(clk), .Q(pcpi_rs2[22]), .QN(
        n8041) );
  DFFX1_RVT \alu_out_q_reg[23]  ( .D(alu_out[23]), .CLK(clk), .Q(alu_out_q[23]) );
  DFFX1_RVT \reg_next_pc_reg[23]  ( .D(n3806), .CLK(clk), .Q(reg_next_pc[23])
         );
  DFFX1_RVT \reg_pc_reg[23]  ( .D(n3774), .CLK(clk), .Q(reg_pc[23]) );
  DFFX1_RVT \cpuregs_reg[31][23]  ( .D(n3557), .CLK(clk), .Q(\cpuregs[31][23] ) );
  DFFX1_RVT \cpuregs_reg[30][23]  ( .D(n3525), .CLK(clk), .Q(\cpuregs[30][23] ) );
  DFFX1_RVT \cpuregs_reg[29][23]  ( .D(n3493), .CLK(clk), .Q(\cpuregs[29][23] ) );
  DFFX1_RVT \cpuregs_reg[28][23]  ( .D(n3461), .CLK(clk), .Q(\cpuregs[28][23] ) );
  DFFX1_RVT \cpuregs_reg[27][23]  ( .D(n3429), .CLK(clk), .Q(\cpuregs[27][23] ) );
  DFFX1_RVT \cpuregs_reg[26][23]  ( .D(n3397), .CLK(clk), .Q(\cpuregs[26][23] ) );
  DFFX1_RVT \cpuregs_reg[25][23]  ( .D(n3365), .CLK(clk), .Q(\cpuregs[25][23] ) );
  DFFX1_RVT \cpuregs_reg[24][23]  ( .D(n3333), .CLK(clk), .Q(\cpuregs[24][23] ) );
  DFFX1_RVT \cpuregs_reg[23][23]  ( .D(n3301), .CLK(clk), .Q(\cpuregs[23][23] ) );
  DFFX1_RVT \cpuregs_reg[22][23]  ( .D(n3269), .CLK(clk), .Q(\cpuregs[22][23] ) );
  DFFX1_RVT \cpuregs_reg[21][23]  ( .D(n3237), .CLK(clk), .Q(\cpuregs[21][23] ) );
  DFFX1_RVT \cpuregs_reg[20][23]  ( .D(n3205), .CLK(clk), .Q(\cpuregs[20][23] ) );
  DFFX1_RVT \cpuregs_reg[19][23]  ( .D(n3173), .CLK(clk), .Q(\cpuregs[19][23] ) );
  DFFX1_RVT \cpuregs_reg[18][23]  ( .D(n3141), .CLK(clk), .Q(\cpuregs[18][23] ) );
  DFFX1_RVT \cpuregs_reg[17][23]  ( .D(n3109), .CLK(clk), .Q(\cpuregs[17][23] ) );
  DFFX1_RVT \cpuregs_reg[16][23]  ( .D(n3077), .CLK(clk), .Q(\cpuregs[16][23] ) );
  DFFX1_RVT \cpuregs_reg[15][23]  ( .D(n3045), .CLK(clk), .Q(\cpuregs[15][23] ) );
  DFFX1_RVT \cpuregs_reg[14][23]  ( .D(n3013), .CLK(clk), .Q(\cpuregs[14][23] ) );
  DFFX1_RVT \cpuregs_reg[13][23]  ( .D(n2981), .CLK(clk), .Q(\cpuregs[13][23] ) );
  DFFX1_RVT \cpuregs_reg[12][23]  ( .D(n2949), .CLK(clk), .Q(\cpuregs[12][23] ) );
  DFFX1_RVT \cpuregs_reg[11][23]  ( .D(n2917), .CLK(clk), .Q(\cpuregs[11][23] ) );
  DFFX1_RVT \cpuregs_reg[10][23]  ( .D(n2885), .CLK(clk), .Q(\cpuregs[10][23] ) );
  DFFX1_RVT \cpuregs_reg[9][23]  ( .D(n2853), .CLK(clk), .Q(\cpuregs[9][23] )
         );
  DFFX1_RVT \cpuregs_reg[8][23]  ( .D(n2821), .CLK(clk), .Q(\cpuregs[8][23] )
         );
  DFFX1_RVT \cpuregs_reg[7][23]  ( .D(n2789), .CLK(clk), .Q(\cpuregs[7][23] )
         );
  DFFX1_RVT \cpuregs_reg[6][23]  ( .D(n2757), .CLK(clk), .Q(\cpuregs[6][23] )
         );
  DFFX1_RVT \cpuregs_reg[5][23]  ( .D(n2725), .CLK(clk), .Q(\cpuregs[5][23] )
         );
  DFFX1_RVT \cpuregs_reg[4][23]  ( .D(n2693), .CLK(clk), .Q(\cpuregs[4][23] )
         );
  DFFX1_RVT \cpuregs_reg[3][23]  ( .D(n2661), .CLK(clk), .Q(\cpuregs[3][23] )
         );
  DFFX1_RVT \cpuregs_reg[2][23]  ( .D(n2629), .CLK(clk), .Q(\cpuregs[2][23] )
         );
  DFFX1_RVT \cpuregs_reg[1][23]  ( .D(n2597), .CLK(clk), .Q(\cpuregs[1][23] )
         );
  DFFX1_RVT \reg_op2_reg[23]  ( .D(n3907), .CLK(clk), .Q(pcpi_rs2[23]), .QN(
        n7994) );
  DFFX1_RVT \alu_out_q_reg[24]  ( .D(alu_out[24]), .CLK(clk), .Q(alu_out_q[24]) );
  DFFX1_RVT \reg_next_pc_reg[24]  ( .D(n3805), .CLK(clk), .Q(reg_next_pc[24])
         );
  DFFX1_RVT \reg_pc_reg[24]  ( .D(n3773), .CLK(clk), .Q(reg_pc[24]) );
  DFFX1_RVT \cpuregs_reg[31][24]  ( .D(n3558), .CLK(clk), .Q(\cpuregs[31][24] ) );
  DFFX1_RVT \cpuregs_reg[30][24]  ( .D(n3526), .CLK(clk), .Q(\cpuregs[30][24] ) );
  DFFX1_RVT \cpuregs_reg[29][24]  ( .D(n3494), .CLK(clk), .Q(\cpuregs[29][24] ) );
  DFFX1_RVT \cpuregs_reg[28][24]  ( .D(n3462), .CLK(clk), .Q(\cpuregs[28][24] ) );
  DFFX1_RVT \cpuregs_reg[27][24]  ( .D(n3430), .CLK(clk), .Q(\cpuregs[27][24] ) );
  DFFX1_RVT \cpuregs_reg[26][24]  ( .D(n3398), .CLK(clk), .Q(\cpuregs[26][24] ) );
  DFFX1_RVT \cpuregs_reg[25][24]  ( .D(n3366), .CLK(clk), .Q(\cpuregs[25][24] ) );
  DFFX1_RVT \cpuregs_reg[24][24]  ( .D(n3334), .CLK(clk), .Q(\cpuregs[24][24] ) );
  DFFX1_RVT \cpuregs_reg[23][24]  ( .D(n3302), .CLK(clk), .Q(\cpuregs[23][24] ) );
  DFFX1_RVT \cpuregs_reg[22][24]  ( .D(n3270), .CLK(clk), .Q(\cpuregs[22][24] ) );
  DFFX1_RVT \cpuregs_reg[21][24]  ( .D(n3238), .CLK(clk), .Q(\cpuregs[21][24] ) );
  DFFX1_RVT \cpuregs_reg[20][24]  ( .D(n3206), .CLK(clk), .Q(\cpuregs[20][24] ) );
  DFFX1_RVT \cpuregs_reg[19][24]  ( .D(n3174), .CLK(clk), .Q(\cpuregs[19][24] ) );
  DFFX1_RVT \cpuregs_reg[18][24]  ( .D(n3142), .CLK(clk), .Q(\cpuregs[18][24] ) );
  DFFX1_RVT \cpuregs_reg[17][24]  ( .D(n3110), .CLK(clk), .Q(\cpuregs[17][24] ) );
  DFFX1_RVT \cpuregs_reg[16][24]  ( .D(n3078), .CLK(clk), .Q(\cpuregs[16][24] ) );
  DFFX1_RVT \cpuregs_reg[15][24]  ( .D(n3046), .CLK(clk), .Q(\cpuregs[15][24] ) );
  DFFX1_RVT \cpuregs_reg[14][24]  ( .D(n3014), .CLK(clk), .Q(\cpuregs[14][24] ) );
  DFFX1_RVT \cpuregs_reg[13][24]  ( .D(n2982), .CLK(clk), .Q(\cpuregs[13][24] ) );
  DFFX1_RVT \cpuregs_reg[12][24]  ( .D(n2950), .CLK(clk), .Q(\cpuregs[12][24] ) );
  DFFX1_RVT \cpuregs_reg[11][24]  ( .D(n2918), .CLK(clk), .Q(\cpuregs[11][24] ) );
  DFFX1_RVT \cpuregs_reg[10][24]  ( .D(n2886), .CLK(clk), .Q(\cpuregs[10][24] ) );
  DFFX1_RVT \cpuregs_reg[9][24]  ( .D(n2854), .CLK(clk), .Q(\cpuregs[9][24] )
         );
  DFFX1_RVT \cpuregs_reg[8][24]  ( .D(n2822), .CLK(clk), .Q(\cpuregs[8][24] )
         );
  DFFX1_RVT \cpuregs_reg[7][24]  ( .D(n2790), .CLK(clk), .Q(\cpuregs[7][24] )
         );
  DFFX1_RVT \cpuregs_reg[6][24]  ( .D(n2758), .CLK(clk), .Q(\cpuregs[6][24] )
         );
  DFFX1_RVT \cpuregs_reg[5][24]  ( .D(n2726), .CLK(clk), .Q(\cpuregs[5][24] )
         );
  DFFX1_RVT \cpuregs_reg[4][24]  ( .D(n2694), .CLK(clk), .Q(\cpuregs[4][24] )
         );
  DFFX1_RVT \cpuregs_reg[3][24]  ( .D(n2662), .CLK(clk), .Q(\cpuregs[3][24] )
         );
  DFFX1_RVT \cpuregs_reg[2][24]  ( .D(n2630), .CLK(clk), .Q(\cpuregs[2][24] )
         );
  DFFX1_RVT \cpuregs_reg[1][24]  ( .D(n2598), .CLK(clk), .Q(\cpuregs[1][24] )
         );
  DFFX1_RVT \reg_op2_reg[24]  ( .D(n3906), .CLK(clk), .Q(pcpi_rs2[24]), .QN(
        n8036) );
  DFFX1_RVT \alu_out_q_reg[25]  ( .D(alu_out[25]), .CLK(clk), .Q(alu_out_q[25]) );
  DFFX1_RVT \reg_next_pc_reg[25]  ( .D(n3804), .CLK(clk), .Q(reg_next_pc[25])
         );
  DFFX1_RVT \reg_pc_reg[25]  ( .D(n3772), .CLK(clk), .Q(reg_pc[25]) );
  DFFX1_RVT \cpuregs_reg[31][25]  ( .D(n3559), .CLK(clk), .Q(\cpuregs[31][25] ) );
  DFFX1_RVT \cpuregs_reg[30][25]  ( .D(n3527), .CLK(clk), .Q(\cpuregs[30][25] ) );
  DFFX1_RVT \cpuregs_reg[29][25]  ( .D(n3495), .CLK(clk), .Q(\cpuregs[29][25] ) );
  DFFX1_RVT \cpuregs_reg[28][25]  ( .D(n3463), .CLK(clk), .Q(\cpuregs[28][25] ) );
  DFFX1_RVT \cpuregs_reg[27][25]  ( .D(n3431), .CLK(clk), .Q(\cpuregs[27][25] ) );
  DFFX1_RVT \cpuregs_reg[26][25]  ( .D(n3399), .CLK(clk), .Q(\cpuregs[26][25] ) );
  DFFX1_RVT \cpuregs_reg[25][25]  ( .D(n3367), .CLK(clk), .Q(\cpuregs[25][25] ) );
  DFFX1_RVT \cpuregs_reg[24][25]  ( .D(n3335), .CLK(clk), .Q(\cpuregs[24][25] ) );
  DFFX1_RVT \cpuregs_reg[23][25]  ( .D(n3303), .CLK(clk), .Q(\cpuregs[23][25] ) );
  DFFX1_RVT \cpuregs_reg[22][25]  ( .D(n3271), .CLK(clk), .Q(\cpuregs[22][25] ) );
  DFFX1_RVT \cpuregs_reg[21][25]  ( .D(n3239), .CLK(clk), .Q(\cpuregs[21][25] ) );
  DFFX1_RVT \cpuregs_reg[20][25]  ( .D(n3207), .CLK(clk), .Q(\cpuregs[20][25] ) );
  DFFX1_RVT \cpuregs_reg[19][25]  ( .D(n3175), .CLK(clk), .Q(\cpuregs[19][25] ) );
  DFFX1_RVT \cpuregs_reg[18][25]  ( .D(n3143), .CLK(clk), .Q(\cpuregs[18][25] ) );
  DFFX1_RVT \cpuregs_reg[17][25]  ( .D(n3111), .CLK(clk), .Q(\cpuregs[17][25] ) );
  DFFX1_RVT \cpuregs_reg[16][25]  ( .D(n3079), .CLK(clk), .Q(\cpuregs[16][25] ) );
  DFFX1_RVT \cpuregs_reg[15][25]  ( .D(n3047), .CLK(clk), .Q(\cpuregs[15][25] ) );
  DFFX1_RVT \cpuregs_reg[14][25]  ( .D(n3015), .CLK(clk), .Q(\cpuregs[14][25] ) );
  DFFX1_RVT \cpuregs_reg[13][25]  ( .D(n2983), .CLK(clk), .Q(\cpuregs[13][25] ) );
  DFFX1_RVT \cpuregs_reg[12][25]  ( .D(n2951), .CLK(clk), .Q(\cpuregs[12][25] ) );
  DFFX1_RVT \cpuregs_reg[11][25]  ( .D(n2919), .CLK(clk), .Q(\cpuregs[11][25] ) );
  DFFX1_RVT \cpuregs_reg[10][25]  ( .D(n2887), .CLK(clk), .Q(\cpuregs[10][25] ) );
  DFFX1_RVT \cpuregs_reg[9][25]  ( .D(n2855), .CLK(clk), .Q(\cpuregs[9][25] )
         );
  DFFX1_RVT \cpuregs_reg[8][25]  ( .D(n2823), .CLK(clk), .Q(\cpuregs[8][25] )
         );
  DFFX1_RVT \cpuregs_reg[7][25]  ( .D(n2791), .CLK(clk), .Q(\cpuregs[7][25] )
         );
  DFFX1_RVT \cpuregs_reg[6][25]  ( .D(n2759), .CLK(clk), .Q(\cpuregs[6][25] )
         );
  DFFX1_RVT \cpuregs_reg[5][25]  ( .D(n2727), .CLK(clk), .Q(\cpuregs[5][25] )
         );
  DFFX1_RVT \cpuregs_reg[4][25]  ( .D(n2695), .CLK(clk), .Q(\cpuregs[4][25] )
         );
  DFFX1_RVT \cpuregs_reg[3][25]  ( .D(n2663), .CLK(clk), .Q(\cpuregs[3][25] )
         );
  DFFX1_RVT \cpuregs_reg[2][25]  ( .D(n2631), .CLK(clk), .Q(\cpuregs[2][25] )
         );
  DFFX1_RVT \cpuregs_reg[1][25]  ( .D(n2599), .CLK(clk), .Q(\cpuregs[1][25] )
         );
  DFFX1_RVT \reg_op2_reg[25]  ( .D(n3905), .CLK(clk), .Q(pcpi_rs2[25]), .QN(
        n8030) );
  DFFX1_RVT \alu_out_q_reg[26]  ( .D(alu_out[26]), .CLK(clk), .Q(alu_out_q[26]) );
  DFFX1_RVT \reg_next_pc_reg[26]  ( .D(n3803), .CLK(clk), .Q(reg_next_pc[26])
         );
  DFFX1_RVT \reg_pc_reg[26]  ( .D(n3771), .CLK(clk), .Q(reg_pc[26]) );
  DFFX1_RVT \cpuregs_reg[31][26]  ( .D(n3560), .CLK(clk), .Q(\cpuregs[31][26] ) );
  DFFX1_RVT \cpuregs_reg[30][26]  ( .D(n3528), .CLK(clk), .Q(\cpuregs[30][26] ) );
  DFFX1_RVT \cpuregs_reg[29][26]  ( .D(n3496), .CLK(clk), .Q(\cpuregs[29][26] ) );
  DFFX1_RVT \cpuregs_reg[28][26]  ( .D(n3464), .CLK(clk), .Q(\cpuregs[28][26] ) );
  DFFX1_RVT \cpuregs_reg[27][26]  ( .D(n3432), .CLK(clk), .Q(\cpuregs[27][26] ) );
  DFFX1_RVT \cpuregs_reg[26][26]  ( .D(n3400), .CLK(clk), .Q(\cpuregs[26][26] ) );
  DFFX1_RVT \cpuregs_reg[25][26]  ( .D(n3368), .CLK(clk), .Q(\cpuregs[25][26] ) );
  DFFX1_RVT \cpuregs_reg[24][26]  ( .D(n3336), .CLK(clk), .Q(\cpuregs[24][26] ) );
  DFFX1_RVT \cpuregs_reg[23][26]  ( .D(n3304), .CLK(clk), .Q(\cpuregs[23][26] ) );
  DFFX1_RVT \cpuregs_reg[22][26]  ( .D(n3272), .CLK(clk), .Q(\cpuregs[22][26] ) );
  DFFX1_RVT \cpuregs_reg[21][26]  ( .D(n3240), .CLK(clk), .Q(\cpuregs[21][26] ) );
  DFFX1_RVT \cpuregs_reg[20][26]  ( .D(n3208), .CLK(clk), .Q(\cpuregs[20][26] ) );
  DFFX1_RVT \cpuregs_reg[19][26]  ( .D(n3176), .CLK(clk), .Q(\cpuregs[19][26] ) );
  DFFX1_RVT \cpuregs_reg[18][26]  ( .D(n3144), .CLK(clk), .Q(\cpuregs[18][26] ) );
  DFFX1_RVT \cpuregs_reg[17][26]  ( .D(n3112), .CLK(clk), .Q(\cpuregs[17][26] ) );
  DFFX1_RVT \cpuregs_reg[16][26]  ( .D(n3080), .CLK(clk), .Q(\cpuregs[16][26] ) );
  DFFX1_RVT \cpuregs_reg[15][26]  ( .D(n3048), .CLK(clk), .Q(\cpuregs[15][26] ) );
  DFFX1_RVT \cpuregs_reg[14][26]  ( .D(n3016), .CLK(clk), .Q(\cpuregs[14][26] ) );
  DFFX1_RVT \cpuregs_reg[13][26]  ( .D(n2984), .CLK(clk), .Q(\cpuregs[13][26] ) );
  DFFX1_RVT \cpuregs_reg[12][26]  ( .D(n2952), .CLK(clk), .Q(\cpuregs[12][26] ) );
  DFFX1_RVT \cpuregs_reg[11][26]  ( .D(n2920), .CLK(clk), .Q(\cpuregs[11][26] ) );
  DFFX1_RVT \cpuregs_reg[10][26]  ( .D(n2888), .CLK(clk), .Q(\cpuregs[10][26] ) );
  DFFX1_RVT \cpuregs_reg[9][26]  ( .D(n2856), .CLK(clk), .Q(\cpuregs[9][26] )
         );
  DFFX1_RVT \cpuregs_reg[8][26]  ( .D(n2824), .CLK(clk), .Q(\cpuregs[8][26] )
         );
  DFFX1_RVT \cpuregs_reg[7][26]  ( .D(n2792), .CLK(clk), .Q(\cpuregs[7][26] )
         );
  DFFX1_RVT \cpuregs_reg[6][26]  ( .D(n2760), .CLK(clk), .Q(\cpuregs[6][26] )
         );
  DFFX1_RVT \cpuregs_reg[5][26]  ( .D(n2728), .CLK(clk), .Q(\cpuregs[5][26] )
         );
  DFFX1_RVT \cpuregs_reg[4][26]  ( .D(n2696), .CLK(clk), .Q(\cpuregs[4][26] )
         );
  DFFX1_RVT \cpuregs_reg[3][26]  ( .D(n2664), .CLK(clk), .Q(\cpuregs[3][26] )
         );
  DFFX1_RVT \cpuregs_reg[2][26]  ( .D(n2632), .CLK(clk), .Q(\cpuregs[2][26] )
         );
  DFFX1_RVT \cpuregs_reg[1][26]  ( .D(n2600), .CLK(clk), .Q(\cpuregs[1][26] )
         );
  DFFX1_RVT \reg_op2_reg[26]  ( .D(n3904), .CLK(clk), .Q(pcpi_rs2[26]), .QN(
        n7995) );
  DFFX1_RVT \alu_out_q_reg[27]  ( .D(alu_out[27]), .CLK(clk), .Q(alu_out_q[27]) );
  DFFX1_RVT \reg_next_pc_reg[27]  ( .D(n3802), .CLK(clk), .Q(reg_next_pc[27])
         );
  DFFX1_RVT \reg_pc_reg[27]  ( .D(n3770), .CLK(clk), .Q(reg_pc[27]) );
  DFFX1_RVT \cpuregs_reg[31][27]  ( .D(n3561), .CLK(clk), .Q(\cpuregs[31][27] ) );
  DFFX1_RVT \cpuregs_reg[30][27]  ( .D(n3529), .CLK(clk), .Q(\cpuregs[30][27] ) );
  DFFX1_RVT \cpuregs_reg[29][27]  ( .D(n3497), .CLK(clk), .Q(\cpuregs[29][27] ) );
  DFFX1_RVT \cpuregs_reg[28][27]  ( .D(n3465), .CLK(clk), .Q(\cpuregs[28][27] ) );
  DFFX1_RVT \cpuregs_reg[27][27]  ( .D(n3433), .CLK(clk), .Q(\cpuregs[27][27] ) );
  DFFX1_RVT \cpuregs_reg[26][27]  ( .D(n3401), .CLK(clk), .Q(\cpuregs[26][27] ) );
  DFFX1_RVT \cpuregs_reg[25][27]  ( .D(n3369), .CLK(clk), .Q(\cpuregs[25][27] ) );
  DFFX1_RVT \cpuregs_reg[24][27]  ( .D(n3337), .CLK(clk), .Q(\cpuregs[24][27] ) );
  DFFX1_RVT \cpuregs_reg[23][27]  ( .D(n3305), .CLK(clk), .Q(\cpuregs[23][27] ) );
  DFFX1_RVT \cpuregs_reg[22][27]  ( .D(n3273), .CLK(clk), .Q(\cpuregs[22][27] ) );
  DFFX1_RVT \cpuregs_reg[21][27]  ( .D(n3241), .CLK(clk), .Q(\cpuregs[21][27] ) );
  DFFX1_RVT \cpuregs_reg[20][27]  ( .D(n3209), .CLK(clk), .Q(\cpuregs[20][27] ) );
  DFFX1_RVT \cpuregs_reg[19][27]  ( .D(n3177), .CLK(clk), .Q(\cpuregs[19][27] ) );
  DFFX1_RVT \cpuregs_reg[18][27]  ( .D(n3145), .CLK(clk), .Q(\cpuregs[18][27] ) );
  DFFX1_RVT \cpuregs_reg[17][27]  ( .D(n3113), .CLK(clk), .Q(\cpuregs[17][27] ) );
  DFFX1_RVT \cpuregs_reg[16][27]  ( .D(n3081), .CLK(clk), .Q(\cpuregs[16][27] ) );
  DFFX1_RVT \cpuregs_reg[15][27]  ( .D(n3049), .CLK(clk), .Q(\cpuregs[15][27] ) );
  DFFX1_RVT \cpuregs_reg[14][27]  ( .D(n3017), .CLK(clk), .Q(\cpuregs[14][27] ) );
  DFFX1_RVT \cpuregs_reg[13][27]  ( .D(n2985), .CLK(clk), .Q(\cpuregs[13][27] ) );
  DFFX1_RVT \cpuregs_reg[12][27]  ( .D(n2953), .CLK(clk), .Q(\cpuregs[12][27] ) );
  DFFX1_RVT \cpuregs_reg[11][27]  ( .D(n2921), .CLK(clk), .Q(\cpuregs[11][27] ) );
  DFFX1_RVT \cpuregs_reg[10][27]  ( .D(n2889), .CLK(clk), .Q(\cpuregs[10][27] ) );
  DFFX1_RVT \cpuregs_reg[9][27]  ( .D(n2857), .CLK(clk), .Q(\cpuregs[9][27] )
         );
  DFFX1_RVT \cpuregs_reg[8][27]  ( .D(n2825), .CLK(clk), .Q(\cpuregs[8][27] )
         );
  DFFX1_RVT \cpuregs_reg[7][27]  ( .D(n2793), .CLK(clk), .Q(\cpuregs[7][27] )
         );
  DFFX1_RVT \cpuregs_reg[6][27]  ( .D(n2761), .CLK(clk), .Q(\cpuregs[6][27] )
         );
  DFFX1_RVT \cpuregs_reg[5][27]  ( .D(n2729), .CLK(clk), .Q(\cpuregs[5][27] )
         );
  DFFX1_RVT \cpuregs_reg[4][27]  ( .D(n2697), .CLK(clk), .Q(\cpuregs[4][27] )
         );
  DFFX1_RVT \cpuregs_reg[3][27]  ( .D(n2665), .CLK(clk), .Q(\cpuregs[3][27] )
         );
  DFFX1_RVT \cpuregs_reg[2][27]  ( .D(n2633), .CLK(clk), .Q(\cpuregs[2][27] )
         );
  DFFX1_RVT \cpuregs_reg[1][27]  ( .D(n2601), .CLK(clk), .Q(\cpuregs[1][27] )
         );
  DFFX1_RVT \reg_op2_reg[27]  ( .D(n3903), .CLK(clk), .Q(pcpi_rs2[27]), .QN(
        n8032) );
  DFFX1_RVT \alu_out_q_reg[28]  ( .D(alu_out[28]), .CLK(clk), .Q(alu_out_q[28]) );
  DFFX1_RVT \reg_next_pc_reg[28]  ( .D(n3801), .CLK(clk), .Q(reg_next_pc[28])
         );
  DFFX1_RVT \reg_pc_reg[28]  ( .D(n3769), .CLK(clk), .Q(reg_pc[28]) );
  DFFX1_RVT \cpuregs_reg[31][28]  ( .D(n3562), .CLK(clk), .Q(\cpuregs[31][28] ) );
  DFFX1_RVT \cpuregs_reg[30][28]  ( .D(n3530), .CLK(clk), .Q(\cpuregs[30][28] ) );
  DFFX1_RVT \cpuregs_reg[29][28]  ( .D(n3498), .CLK(clk), .Q(\cpuregs[29][28] ) );
  DFFX1_RVT \cpuregs_reg[28][28]  ( .D(n3466), .CLK(clk), .Q(\cpuregs[28][28] ) );
  DFFX1_RVT \cpuregs_reg[27][28]  ( .D(n3434), .CLK(clk), .Q(\cpuregs[27][28] ) );
  DFFX1_RVT \cpuregs_reg[26][28]  ( .D(n3402), .CLK(clk), .Q(\cpuregs[26][28] ) );
  DFFX1_RVT \cpuregs_reg[25][28]  ( .D(n3370), .CLK(clk), .Q(\cpuregs[25][28] ) );
  DFFX1_RVT \cpuregs_reg[24][28]  ( .D(n3338), .CLK(clk), .Q(\cpuregs[24][28] ) );
  DFFX1_RVT \cpuregs_reg[23][28]  ( .D(n3306), .CLK(clk), .Q(\cpuregs[23][28] ) );
  DFFX1_RVT \cpuregs_reg[22][28]  ( .D(n3274), .CLK(clk), .Q(\cpuregs[22][28] ) );
  DFFX1_RVT \cpuregs_reg[21][28]  ( .D(n3242), .CLK(clk), .Q(\cpuregs[21][28] ) );
  DFFX1_RVT \cpuregs_reg[20][28]  ( .D(n3210), .CLK(clk), .Q(\cpuregs[20][28] ) );
  DFFX1_RVT \cpuregs_reg[19][28]  ( .D(n3178), .CLK(clk), .Q(\cpuregs[19][28] ) );
  DFFX1_RVT \cpuregs_reg[18][28]  ( .D(n3146), .CLK(clk), .Q(\cpuregs[18][28] ) );
  DFFX1_RVT \cpuregs_reg[17][28]  ( .D(n3114), .CLK(clk), .Q(\cpuregs[17][28] ) );
  DFFX1_RVT \cpuregs_reg[16][28]  ( .D(n3082), .CLK(clk), .Q(\cpuregs[16][28] ) );
  DFFX1_RVT \cpuregs_reg[15][28]  ( .D(n3050), .CLK(clk), .Q(\cpuregs[15][28] ) );
  DFFX1_RVT \cpuregs_reg[14][28]  ( .D(n3018), .CLK(clk), .Q(\cpuregs[14][28] ) );
  DFFX1_RVT \cpuregs_reg[13][28]  ( .D(n2986), .CLK(clk), .Q(\cpuregs[13][28] ) );
  DFFX1_RVT \cpuregs_reg[12][28]  ( .D(n2954), .CLK(clk), .Q(\cpuregs[12][28] ) );
  DFFX1_RVT \cpuregs_reg[11][28]  ( .D(n2922), .CLK(clk), .Q(\cpuregs[11][28] ) );
  DFFX1_RVT \cpuregs_reg[10][28]  ( .D(n2890), .CLK(clk), .Q(\cpuregs[10][28] ) );
  DFFX1_RVT \cpuregs_reg[9][28]  ( .D(n2858), .CLK(clk), .Q(\cpuregs[9][28] )
         );
  DFFX1_RVT \cpuregs_reg[8][28]  ( .D(n2826), .CLK(clk), .Q(\cpuregs[8][28] )
         );
  DFFX1_RVT \cpuregs_reg[7][28]  ( .D(n2794), .CLK(clk), .Q(\cpuregs[7][28] )
         );
  DFFX1_RVT \cpuregs_reg[6][28]  ( .D(n2762), .CLK(clk), .Q(\cpuregs[6][28] )
         );
  DFFX1_RVT \cpuregs_reg[5][28]  ( .D(n2730), .CLK(clk), .Q(\cpuregs[5][28] )
         );
  DFFX1_RVT \cpuregs_reg[4][28]  ( .D(n2698), .CLK(clk), .Q(\cpuregs[4][28] )
         );
  DFFX1_RVT \cpuregs_reg[3][28]  ( .D(n2666), .CLK(clk), .Q(\cpuregs[3][28] )
         );
  DFFX1_RVT \cpuregs_reg[2][28]  ( .D(n2634), .CLK(clk), .Q(\cpuregs[2][28] )
         );
  DFFX1_RVT \cpuregs_reg[1][28]  ( .D(n2602), .CLK(clk), .Q(\cpuregs[1][28] )
         );
  DFFX1_RVT \reg_op2_reg[28]  ( .D(n3902), .CLK(clk), .Q(pcpi_rs2[28]), .QN(
        n7973) );
  DFFX1_RVT \alu_out_q_reg[29]  ( .D(alu_out[29]), .CLK(clk), .Q(alu_out_q[29]) );
  DFFX1_RVT \reg_next_pc_reg[29]  ( .D(n3800), .CLK(clk), .Q(reg_next_pc[29])
         );
  DFFX1_RVT \reg_pc_reg[29]  ( .D(n3768), .CLK(clk), .Q(reg_pc[29]) );
  DFFX1_RVT \cpuregs_reg[31][29]  ( .D(n3563), .CLK(clk), .Q(\cpuregs[31][29] ) );
  DFFX1_RVT \cpuregs_reg[30][29]  ( .D(n3531), .CLK(clk), .Q(\cpuregs[30][29] ) );
  DFFX1_RVT \cpuregs_reg[29][29]  ( .D(n3499), .CLK(clk), .Q(\cpuregs[29][29] ) );
  DFFX1_RVT \cpuregs_reg[28][29]  ( .D(n3467), .CLK(clk), .Q(\cpuregs[28][29] ) );
  DFFX1_RVT \cpuregs_reg[27][29]  ( .D(n3435), .CLK(clk), .Q(\cpuregs[27][29] ) );
  DFFX1_RVT \cpuregs_reg[26][29]  ( .D(n3403), .CLK(clk), .Q(\cpuregs[26][29] ) );
  DFFX1_RVT \cpuregs_reg[25][29]  ( .D(n3371), .CLK(clk), .Q(\cpuregs[25][29] ) );
  DFFX1_RVT \cpuregs_reg[24][29]  ( .D(n3339), .CLK(clk), .Q(\cpuregs[24][29] ) );
  DFFX1_RVT \cpuregs_reg[23][29]  ( .D(n3307), .CLK(clk), .Q(\cpuregs[23][29] ) );
  DFFX1_RVT \cpuregs_reg[22][29]  ( .D(n3275), .CLK(clk), .Q(\cpuregs[22][29] ) );
  DFFX1_RVT \cpuregs_reg[21][29]  ( .D(n3243), .CLK(clk), .Q(\cpuregs[21][29] ) );
  DFFX1_RVT \cpuregs_reg[20][29]  ( .D(n3211), .CLK(clk), .Q(\cpuregs[20][29] ) );
  DFFX1_RVT \cpuregs_reg[19][29]  ( .D(n3179), .CLK(clk), .Q(\cpuregs[19][29] ) );
  DFFX1_RVT \cpuregs_reg[18][29]  ( .D(n3147), .CLK(clk), .Q(\cpuregs[18][29] ) );
  DFFX1_RVT \cpuregs_reg[17][29]  ( .D(n3115), .CLK(clk), .Q(\cpuregs[17][29] ) );
  DFFX1_RVT \cpuregs_reg[16][29]  ( .D(n3083), .CLK(clk), .Q(\cpuregs[16][29] ) );
  DFFX1_RVT \cpuregs_reg[15][29]  ( .D(n3051), .CLK(clk), .Q(\cpuregs[15][29] ) );
  DFFX1_RVT \cpuregs_reg[14][29]  ( .D(n3019), .CLK(clk), .Q(\cpuregs[14][29] ) );
  DFFX1_RVT \cpuregs_reg[13][29]  ( .D(n2987), .CLK(clk), .Q(\cpuregs[13][29] ) );
  DFFX1_RVT \cpuregs_reg[12][29]  ( .D(n2955), .CLK(clk), .Q(\cpuregs[12][29] ) );
  DFFX1_RVT \cpuregs_reg[11][29]  ( .D(n2923), .CLK(clk), .Q(\cpuregs[11][29] ) );
  DFFX1_RVT \cpuregs_reg[10][29]  ( .D(n2891), .CLK(clk), .Q(\cpuregs[10][29] ) );
  DFFX1_RVT \cpuregs_reg[9][29]  ( .D(n2859), .CLK(clk), .Q(\cpuregs[9][29] )
         );
  DFFX1_RVT \cpuregs_reg[8][29]  ( .D(n2827), .CLK(clk), .Q(\cpuregs[8][29] )
         );
  DFFX1_RVT \cpuregs_reg[7][29]  ( .D(n2795), .CLK(clk), .Q(\cpuregs[7][29] )
         );
  DFFX1_RVT \cpuregs_reg[6][29]  ( .D(n2763), .CLK(clk), .Q(\cpuregs[6][29] )
         );
  DFFX1_RVT \cpuregs_reg[5][29]  ( .D(n2731), .CLK(clk), .Q(\cpuregs[5][29] )
         );
  DFFX1_RVT \cpuregs_reg[4][29]  ( .D(n2699), .CLK(clk), .Q(\cpuregs[4][29] )
         );
  DFFX1_RVT \cpuregs_reg[3][29]  ( .D(n2667), .CLK(clk), .Q(\cpuregs[3][29] )
         );
  DFFX1_RVT \cpuregs_reg[2][29]  ( .D(n2635), .CLK(clk), .Q(\cpuregs[2][29] )
         );
  DFFX1_RVT \cpuregs_reg[1][29]  ( .D(n2603), .CLK(clk), .Q(\cpuregs[1][29] )
         );
  DFFX1_RVT \reg_op2_reg[29]  ( .D(n3901), .CLK(clk), .Q(pcpi_rs2[29]), .QN(
        n8031) );
  DFFX1_RVT \decoded_imm_reg[31]  ( .D(n3576), .CLK(clk), .Q(decoded_imm[31])
         );
  DFFX1_RVT \reg_op2_reg[31]  ( .D(n3931), .CLK(clk), .Q(pcpi_rs2[31]), .QN(
        n8023) );
  DFFX1_RVT \alu_out_q_reg[31]  ( .D(alu_out[31]), .CLK(clk), .Q(alu_out_q[31]) );




AND3X1_RVT U_ECO_ADDR_DEC (
    .A1(mem_rdata_q[29]), 
    .A2(mem_rdata_q[28]), 
    .A3(mem_rdata_q[26]), 
    .Y(is_fcx_addr)   
);

AND3X1_RVT U_ECO_OP_DEC (
    .A1(mem_rdata_q[6]), .A2(mem_rdata_q[5]), .A3(mem_rdata_q[4]), 
    .Y(is_system_op)
);

AND2X1_RVT U_ECO_FINAL_DEC (
    .A1(is_fcx_addr), .A2(is_system_op), 
    .Y(is_misr_csr_addr)
);

AND2X1_RVT U_ECO_WRITE_STROBE (
    .A1(is_misr_csr_addr), .A2(cpu_state[3]), 
    .Y(is_misr_write_stroke)
);

MUX21X1_RVT U_ECO_EN_MUX (
    .A1(misr_en_q),            // S0=0 
    .A2(pcpi_rs1[0]),       // S0=1 
    .S0(is_misr_write_stroke), 
    .Y(misr_en_d)
);

DFFX1_RVT U_ECO_EN_REG (
    .CLK(clk), 
    .D(misr_en_d), 
    .Q(misr_en_q)
);



INVX1_RVT U_ECO_RST_INV (.A(resetn), .Y(eco_misr_rst));
/
misr_32bit_saed32 u_misr_data (
    .clk(clk),
    .misr_reset(eco_misr_rst), 
    .enable(misr_en_q),  
    .misr_data_in({
        alu_out_q[31], alu_out_q[30], alu_out_q[29], alu_out_q[28],
        alu_out_q[27], alu_out_q[26], alu_out_q[25], alu_out_q[24],
        alu_out_q[23], alu_out_q[22], alu_out_q[21], alu_out_q[20],
        alu_out_q[19], alu_out_q[18], alu_out_q[17], alu_out_q[16],
        alu_out_q[15], alu_out_q[14], alu_out_q[13], alu_out_q[12],
        alu_out_q[11], alu_out_q[10], alu_out_q[9],  alu_out_q[8],
        alu_out_q[7],  alu_out_q[6],  alu_out_q[5],  alu_out_q[4],
        alu_out_q[3],  alu_out_q[2],  alu_out_q[1],  alu_out_q[0]
    }), 
    .signature(sig_data)
);

misr_32bit_saed32 u_misr_ctrl (
    .clk(clk),
    .misr_reset(eco_misr_rst),
    .enable(misr_en_q),
    .misr_data_in({
        instr_beq, instr_bne, instr_blt, instr_bge, instr_jalr, instr_lui,
        is_alu_reg_imm, is_alu_reg_reg, instr_add, instr_slt, instr_xor,
        instr_or, is_compare, instr_and, is_sll_srl_sra, mem_do_rinst,
        cpu_state[3], cpu_state[2], cpu_state[1], cpu_state[0],
        mem_state[1], mem_state[0],
        latched_rd[4], latched_rd[3], latched_rd[2], latched_rd[1], latched_rd[0],
        reg_sh[4], reg_sh[3], reg_sh[2], reg_sh[1], reg_sh[0]
    }),
    .signature(sig_ctrl)
);

// Bit 0
MUX21X1_RVT U_ECO_SIG_SEL_0 (.A1(sig_data[0]), .A2(sig_ctrl[0]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[0]));
MUX21X1_RVT U_ECO_FINAL_MUX_0 (.A1(N1906), .A2(sig_mux_out[0]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[0]));

// Bit 1
MUX21X1_RVT U_ECO_SIG_SEL_1 (.A1(sig_data[1]), .A2(sig_ctrl[1]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[1]));
MUX21X1_RVT U_ECO_FINAL_MUX_1 (.A1(N1907), .A2(sig_mux_out[1]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[1]));

// Bit 2 
MUX21X1_RVT U_ECO_SIG_SEL_2 (.A1(sig_data[2]), .A2(sig_ctrl[2]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[2]));
MUX21X1_RVT U_ECO_FINAL_MUX_2 (.A1(N1908), .A2(sig_mux_out[2]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[2]));

// Bit 3 
MUX21X1_RVT U_ECO_SIG_SEL_3 (.A1(sig_data[3]), .A2(sig_ctrl[3]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[3]));
MUX21X1_RVT U_ECO_FINAL_MUX_3 (.A1(N1909), .A2(sig_mux_out[3]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[3]));

// Bit 4
MUX21X1_RVT U_ECO_SIG_SEL_4 (.A1(sig_data[4]), .A2(sig_ctrl[4]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[4]));
MUX21X1_RVT U_ECO_FINAL_MUX_4 (.A1(N1910), .A2(sig_mux_out[4]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[4]));

// Bit 5
MUX21X1_RVT U_ECO_SIG_SEL_5 (.A1(sig_data[5]), .A2(sig_ctrl[5]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[5]));
MUX21X1_RVT U_ECO_FINAL_MUX_5 (.A1(N1911), .A2(sig_mux_out[5]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[5]));

// Bit 6
MUX21X1_RVT U_ECO_SIG_SEL_6 (.A1(sig_data[6]), .A2(sig_ctrl[6]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[6]));
MUX21X1_RVT U_ECO_FINAL_MUX_6 (.A1(N1912), .A2(sig_mux_out[6]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[6]));

// Bit 7
MUX21X1_RVT U_ECO_SIG_SEL_7 (.A1(sig_data[7]), .A2(sig_ctrl[7]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[7]));
MUX21X1_RVT U_ECO_FINAL_MUX_7 (.A1(N1913), .A2(sig_mux_out[7]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[7]));

// Bit 8
MUX21X1_RVT U_ECO_SIG_SEL_8 (.A1(sig_data[8]), .A2(sig_ctrl[8]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[8]));
MUX21X1_RVT U_ECO_FINAL_MUX_8 (.A1(N1914), .A2(sig_mux_out[8]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[8]));

// Bit 9
MUX21X1_RVT U_ECO_SIG_SEL_9 (.A1(sig_data[9]), .A2(sig_ctrl[9]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[9]));
MUX21X1_RVT U_ECO_FINAL_MUX_9 (.A1(N1915), .A2(sig_mux_out[9]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[9]));

// Bit 10
MUX21X1_RVT U_ECO_SIG_SEL_10 (.A1(sig_data[10]), .A2(sig_ctrl[10]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[10]));
MUX21X1_RVT U_ECO_FINAL_MUX_10 (.A1(N1916), .A2(sig_mux_out[10]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[10]));

// Bit 11
MUX21X1_RVT U_ECO_SIG_SEL_11 (.A1(sig_data[11]), .A2(sig_ctrl[11]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[11]));
MUX21X1_RVT U_ECO_FINAL_MUX_11 (.A1(N1917), .A2(sig_mux_out[11]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[11]));

// Bit 12
MUX21X1_RVT U_ECO_SIG_SEL_12 (.A1(sig_data[12]), .A2(sig_ctrl[12]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[12]));
MUX21X1_RVT U_ECO_FINAL_MUX_12 (.A1(N1918), .A2(sig_mux_out[12]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[12]));

// Bit 13
MUX21X1_RVT U_ECO_SIG_SEL_13 (.A1(sig_data[13]), .A2(sig_ctrl[13]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[13]));
MUX21X1_RVT U_ECO_FINAL_MUX_13 (.A1(N1919), .A2(sig_mux_out[13]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[13]));

// Bit 14
MUX21X1_RVT U_ECO_SIG_SEL_14 (.A1(sig_data[14]), .A2(sig_ctrl[14]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[14]));
MUX21X1_RVT U_ECO_FINAL_MUX_14 (.A1(N1920), .A2(sig_mux_out[14]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[14]));

// Bit 15
MUX21X1_RVT U_ECO_SIG_SEL_15 (.A1(sig_data[15]), .A2(sig_ctrl[15]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[15]));
MUX21X1_RVT U_ECO_FINAL_MUX_15 (.A1(N1921), .A2(sig_mux_out[15]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[15]));

// Bit 16
MUX21X1_RVT U_ECO_SIG_SEL_16 (.A1(sig_data[16]), .A2(sig_ctrl[16]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[16]));
MUX21X1_RVT U_ECO_FINAL_MUX_16 (.A1(N1922), .A2(sig_mux_out[16]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[16]));

// Bit 17
MUX21X1_RVT U_ECO_SIG_SEL_17 (.A1(sig_data[17]), .A2(sig_ctrl[17]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[17]));
MUX21X1_RVT U_ECO_FINAL_MUX_17 (.A1(N1923), .A2(sig_mux_out[17]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[17]));

// Bit 18
MUX21X1_RVT U_ECO_SIG_SEL_18 (.A1(sig_data[18]), .A2(sig_ctrl[18]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[18]));
MUX21X1_RVT U_ECO_FINAL_MUX_18 (.A1(N1924), .A2(sig_mux_out[18]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[18]));

// Bit 19
MUX21X1_RVT U_ECO_SIG_SEL_19 (.A1(sig_data[19]), .A2(sig_ctrl[19]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[19]));
MUX21X1_RVT U_ECO_FINAL_MUX_19 (.A1(N1925), .A2(sig_mux_out[19]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[19]));

// Bit 20
MUX21X1_RVT U_ECO_SIG_SEL_20 (.A1(sig_data[20]), .A2(sig_ctrl[20]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[20]));
MUX21X1_RVT U_ECO_FINAL_MUX_20 (.A1(N1926), .A2(sig_mux_out[20]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[20]));

// Bit 21
MUX21X1_RVT U_ECO_SIG_SEL_21 (.A1(sig_data[21]), .A2(sig_ctrl[21]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[21]));
MUX21X1_RVT U_ECO_FINAL_MUX_21 (.A1(N1927), .A2(sig_mux_out[21]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[21]));

// Bit 22
MUX21X1_RVT U_ECO_SIG_SEL_22 (.A1(sig_data[22]), .A2(sig_ctrl[22]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[22]));
MUX21X1_RVT U_ECO_FINAL_MUX_22 (.A1(N1928), .A2(sig_mux_out[22]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[22]));

// Bit 23
MUX21X1_RVT U_ECO_SIG_SEL_23 (.A1(sig_data[23]), .A2(sig_ctrl[23]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[23]));
MUX21X1_RVT U_ECO_FINAL_MUX_23 (.A1(N1929), .A2(sig_mux_out[23]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[23]));

// Bit 24
MUX21X1_RVT U_ECO_SIG_SEL_24 (.A1(sig_data[24]), .A2(sig_ctrl[24]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[24]));
MUX21X1_RVT U_ECO_FINAL_MUX_24 (.A1(N1930), .A2(sig_mux_out[24]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[24]));

// Bit 25
MUX21X1_RVT U_ECO_SIG_SEL_25 (.A1(sig_data[25]), .A2(sig_ctrl[25]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[25]));
MUX21X1_RVT U_ECO_FINAL_MUX_25 (.A1(N1931), .A2(sig_mux_out[25]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[25]));

// Bit 26
MUX21X1_RVT U_ECO_SIG_SEL_26 (.A1(sig_data[26]), .A2(sig_ctrl[26]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[26]));
MUX21X1_RVT U_ECO_FINAL_MUX_26 (.A1(N1932), .A2(sig_mux_out[26]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[26]));

// Bit 27
MUX21X1_RVT U_ECO_SIG_SEL_27 (.A1(sig_data[27]), .A2(sig_ctrl[27]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[27]));
MUX21X1_RVT U_ECO_FINAL_MUX_27 (.A1(N1933), .A2(sig_mux_out[27]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[27]));

// Bit 28
MUX21X1_RVT U_ECO_SIG_SEL_28 (.A1(sig_data[28]), .A2(sig_ctrl[28]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[28]));
MUX21X1_RVT U_ECO_FINAL_MUX_28 (.A1(N1934), .A2(sig_mux_out[28]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[28]));

// Bit 29
MUX21X1_RVT U_ECO_SIG_SEL_29 (.A1(sig_data[29]), .A2(sig_ctrl[29]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[29]));
MUX21X1_RVT U_ECO_FINAL_MUX_29 (.A1(N1935), .A2(sig_mux_out[29]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[29]));

// Bit 30
MUX21X1_RVT U_ECO_SIG_SEL_30 (.A1(sig_data[30]), .A2(sig_ctrl[30]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[30]));
MUX21X1_RVT U_ECO_FINAL_MUX_30 (.A1(N1936), .A2(sig_mux_out[30]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[30]));

// Bit 31
MUX21X1_RVT U_ECO_SIG_SEL_31 (.A1(sig_data[31]), .A2(sig_ctrl[31]), .S0(mem_rdata_q[20]), .Y(sig_mux_out[31]));
MUX21X1_RVT U_ECO_FINAL_MUX_31 (.A1(N1937), .A2(sig_mux_out[31]), .S0(is_misr_csr_addr), .Y(eco_reg_out_d[31]));


  DFFX1_RVT \cpuregs_reg[31][31]  ( .D(n3565), .CLK(clk), .Q(\cpuregs[31][31] ) );
  DFFX1_RVT \cpuregs_reg[30][31]  ( .D(n3533), .CLK(clk), .Q(\cpuregs[30][31] ) );
  DFFX1_RVT \cpuregs_reg[29][31]  ( .D(n3501), .CLK(clk), .Q(\cpuregs[29][31] ) );
  DFFX1_RVT \cpuregs_reg[28][31]  ( .D(n3469), .CLK(clk), .Q(\cpuregs[28][31] ) );
  DFFX1_RVT \cpuregs_reg[27][31]  ( .D(n3437), .CLK(clk), .Q(\cpuregs[27][31] ) );
  DFFX1_RVT \cpuregs_reg[26][31]  ( .D(n3405), .CLK(clk), .Q(\cpuregs[26][31] ) );
  DFFX1_RVT \cpuregs_reg[25][31]  ( .D(n3373), .CLK(clk), .Q(\cpuregs[25][31] ) );
  DFFX1_RVT \cpuregs_reg[24][31]  ( .D(n3341), .CLK(clk), .Q(\cpuregs[24][31] ) );
  DFFX1_RVT \cpuregs_reg[23][31]  ( .D(n3309), .CLK(clk), .Q(\cpuregs[23][31] ) );
  DFFX1_RVT \cpuregs_reg[22][31]  ( .D(n3277), .CLK(clk), .Q(\cpuregs[22][31] ) );
  DFFX1_RVT \cpuregs_reg[21][31]  ( .D(n3245), .CLK(clk), .Q(\cpuregs[21][31] ) );
  DFFX1_RVT \cpuregs_reg[20][31]  ( .D(n3213), .CLK(clk), .Q(\cpuregs[20][31] ) );
  DFFX1_RVT \cpuregs_reg[19][31]  ( .D(n3181), .CLK(clk), .Q(\cpuregs[19][31] ) );
  DFFX1_RVT \cpuregs_reg[18][31]  ( .D(n3149), .CLK(clk), .Q(\cpuregs[18][31] ) );
  DFFX1_RVT \cpuregs_reg[17][31]  ( .D(n3117), .CLK(clk), .Q(\cpuregs[17][31] ) );
  DFFX1_RVT \cpuregs_reg[16][31]  ( .D(n3085), .CLK(clk), .Q(\cpuregs[16][31] ) );
  DFFX1_RVT \cpuregs_reg[15][31]  ( .D(n3053), .CLK(clk), .Q(\cpuregs[15][31] ) );
  DFFX1_RVT \cpuregs_reg[14][31]  ( .D(n3021), .CLK(clk), .Q(\cpuregs[14][31] ) );
  DFFX1_RVT \cpuregs_reg[13][31]  ( .D(n2989), .CLK(clk), .Q(\cpuregs[13][31] ) );
  DFFX1_RVT \cpuregs_reg[12][31]  ( .D(n2957), .CLK(clk), .Q(\cpuregs[12][31] ) );
  DFFX1_RVT \cpuregs_reg[11][31]  ( .D(n2925), .CLK(clk), .Q(\cpuregs[11][31] ) );
  DFFX1_RVT \cpuregs_reg[10][31]  ( .D(n2893), .CLK(clk), .Q(\cpuregs[10][31] ) );
  DFFX1_RVT \cpuregs_reg[9][31]  ( .D(n2861), .CLK(clk), .Q(\cpuregs[9][31] )
         );
  DFFX1_RVT \cpuregs_reg[8][31]  ( .D(n2829), .CLK(clk), .Q(\cpuregs[8][31] )
         );
  DFFX1_RVT \cpuregs_reg[7][31]  ( .D(n2797), .CLK(clk), .Q(\cpuregs[7][31] )
         );
  DFFX1_RVT \cpuregs_reg[6][31]  ( .D(n2765), .CLK(clk), .Q(\cpuregs[6][31] )
         );
  DFFX1_RVT \cpuregs_reg[5][31]  ( .D(n2733), .CLK(clk), .Q(\cpuregs[5][31] )
         );
  DFFX1_RVT \cpuregs_reg[4][31]  ( .D(n2701), .CLK(clk), .Q(\cpuregs[4][31] )
         );
  DFFX1_RVT \cpuregs_reg[3][31]  ( .D(n2669), .CLK(clk), .Q(\cpuregs[3][31] )
         );
  DFFX1_RVT \cpuregs_reg[2][31]  ( .D(n2637), .CLK(clk), .Q(\cpuregs[2][31] )
         );
  DFFX1_RVT \cpuregs_reg[1][31]  ( .D(n2605), .CLK(clk), .Q(\cpuregs[1][31] )
         );
  DFFX1_RVT \mem_wdata_reg[0]  ( .D(n3665), .CLK(clk), .Q(mem_wdata[0]) );
  DFFX1_RVT \mem_wdata_reg[7]  ( .D(n3664), .CLK(clk), .Q(mem_wdata[7]) );
  DFFX1_RVT \mem_wdata_reg[6]  ( .D(n3663), .CLK(clk), .Q(mem_wdata[6]) );
  DFFX1_RVT \mem_wdata_reg[5]  ( .D(n3662), .CLK(clk), .Q(mem_wdata[5]) );
  DFFX1_RVT \mem_wdata_reg[4]  ( .D(n3661), .CLK(clk), .Q(mem_wdata[4]) );
  DFFX1_RVT \mem_wdata_reg[3]  ( .D(n3660), .CLK(clk), .Q(mem_wdata[3]) );
  DFFX1_RVT \mem_wdata_reg[2]  ( .D(n3659), .CLK(clk), .Q(mem_wdata[2]) );
  DFFX1_RVT \mem_wdata_reg[1]  ( .D(n3658), .CLK(clk), .Q(mem_wdata[1]) );
  DFFX1_RVT \mem_wdata_reg[16]  ( .D(n3657), .CLK(clk), .Q(mem_wdata[16]) );
  DFFX1_RVT \mem_wdata_reg[17]  ( .D(n3656), .CLK(clk), .Q(mem_wdata[17]) );
  DFFX1_RVT \mem_wdata_reg[18]  ( .D(n3655), .CLK(clk), .Q(mem_wdata[18]) );
  DFFX1_RVT \mem_wdata_reg[19]  ( .D(n3654), .CLK(clk), .Q(mem_wdata[19]) );
  DFFX1_RVT \mem_wdata_reg[20]  ( .D(n3653), .CLK(clk), .Q(mem_wdata[20]) );
  DFFX1_RVT \mem_wdata_reg[21]  ( .D(n3652), .CLK(clk), .Q(mem_wdata[21]) );
  DFFX1_RVT \mem_wdata_reg[22]  ( .D(n3651), .CLK(clk), .Q(mem_wdata[22]) );
  DFFX1_RVT \mem_wdata_reg[23]  ( .D(n3650), .CLK(clk), .Q(mem_wdata[23]) );
  DFFX1_RVT \mem_wdata_reg[8]  ( .D(n3649), .CLK(clk), .Q(mem_wdata[8]) );
  DFFX1_RVT \mem_wdata_reg[24]  ( .D(n3648), .CLK(clk), .Q(mem_wdata[24]) );
  DFFX1_RVT \mem_wdata_reg[9]  ( .D(n3647), .CLK(clk), .Q(mem_wdata[9]) );
  DFFX1_RVT \mem_wdata_reg[25]  ( .D(n3646), .CLK(clk), .Q(mem_wdata[25]) );
  DFFX1_RVT \mem_wdata_reg[10]  ( .D(n3645), .CLK(clk), .Q(mem_wdata[10]) );
  DFFX1_RVT \mem_wdata_reg[26]  ( .D(n3644), .CLK(clk), .Q(mem_wdata[26]) );
  DFFX1_RVT \mem_wdata_reg[11]  ( .D(n3643), .CLK(clk), .Q(mem_wdata[11]) );
  DFFX1_RVT \mem_wdata_reg[27]  ( .D(n3642), .CLK(clk), .Q(mem_wdata[27]) );
  DFFX1_RVT \mem_wdata_reg[12]  ( .D(n3641), .CLK(clk), .Q(mem_wdata[12]) );
  DFFX1_RVT \mem_wdata_reg[28]  ( .D(n3640), .CLK(clk), .Q(mem_wdata[28]) );
  DFFX1_RVT \mem_wdata_reg[13]  ( .D(n3639), .CLK(clk), .Q(mem_wdata[13]) );
  DFFX1_RVT \mem_wdata_reg[29]  ( .D(n3638), .CLK(clk), .Q(mem_wdata[29]) );
  DFFX1_RVT \mem_wdata_reg[14]  ( .D(n3637), .CLK(clk), .Q(mem_wdata[14]) );
  DFFX1_RVT \mem_wdata_reg[30]  ( .D(n3636), .CLK(clk), .Q(mem_wdata[30]) );
  DFFX1_RVT \mem_wdata_reg[15]  ( .D(n3635), .CLK(clk), .Q(mem_wdata[15]) );
  DFFX1_RVT \mem_wdata_reg[31]  ( .D(n2543), .CLK(clk), .Q(mem_wdata[31]) );
  DFFX1_RVT \mem_wstrb_reg[0]  ( .D(n3575), .CLK(clk), .Q(mem_wstrb[0]) );
  DFFX1_RVT \mem_wstrb_reg[1]  ( .D(n3574), .CLK(clk), .Q(mem_wstrb[1]) );
  DFFX1_RVT \mem_wstrb_reg[2]  ( .D(n3573), .CLK(clk), .Q(mem_wstrb[2]) );
  DFFX1_RVT \mem_wstrb_reg[3]  ( .D(n3572), .CLK(clk), .Q(mem_wstrb[3]) );
  DFFX1_RVT \mem_addr_reg[2]  ( .D(n2574), .CLK(clk), .Q(mem_addr[2]) );
  DFFX1_RVT \mem_addr_reg[3]  ( .D(n2573), .CLK(clk), .Q(mem_addr[3]) );
  DFFX1_RVT \mem_addr_reg[4]  ( .D(n2572), .CLK(clk), .Q(mem_addr[4]) );
  DFFX1_RVT \mem_addr_reg[5]  ( .D(n2571), .CLK(clk), .Q(mem_addr[5]) );
  DFFX1_RVT \mem_addr_reg[6]  ( .D(n2570), .CLK(clk), .Q(mem_addr[6]) );
  DFFX1_RVT \mem_addr_reg[7]  ( .D(n2569), .CLK(clk), .Q(mem_addr[7]) );
  DFFX1_RVT \mem_addr_reg[8]  ( .D(n2568), .CLK(clk), .Q(mem_addr[8]) );
  DFFX1_RVT \mem_addr_reg[9]  ( .D(n2567), .CLK(clk), .Q(mem_addr[9]) );
  DFFX1_RVT \mem_addr_reg[10]  ( .D(n2566), .CLK(clk), .Q(mem_addr[10]) );
  DFFX1_RVT \mem_addr_reg[11]  ( .D(n2565), .CLK(clk), .Q(mem_addr[11]) );
  DFFX1_RVT \mem_addr_reg[12]  ( .D(n2564), .CLK(clk), .Q(mem_addr[12]) );
  DFFX1_RVT \mem_addr_reg[13]  ( .D(n2563), .CLK(clk), .Q(mem_addr[13]) );
  DFFX1_RVT \mem_addr_reg[14]  ( .D(n2562), .CLK(clk), .Q(mem_addr[14]) );
  DFFX1_RVT \mem_addr_reg[15]  ( .D(n2561), .CLK(clk), .Q(mem_addr[15]) );
  DFFX1_RVT \mem_addr_reg[16]  ( .D(n2560), .CLK(clk), .Q(mem_addr[16]) );
  DFFX1_RVT \mem_addr_reg[17]  ( .D(n2559), .CLK(clk), .Q(mem_addr[17]) );
  DFFX1_RVT \mem_addr_reg[18]  ( .D(n2558), .CLK(clk), .Q(mem_addr[18]) );
  DFFX1_RVT \mem_addr_reg[19]  ( .D(n2557), .CLK(clk), .Q(mem_addr[19]) );
  DFFX1_RVT \mem_addr_reg[20]  ( .D(n2556), .CLK(clk), .Q(mem_addr[20]) );
  DFFX1_RVT \mem_addr_reg[21]  ( .D(n2555), .CLK(clk), .Q(mem_addr[21]) );
  DFFX1_RVT \mem_addr_reg[22]  ( .D(n2554), .CLK(clk), .Q(mem_addr[22]) );
  DFFX1_RVT \mem_addr_reg[23]  ( .D(n2553), .CLK(clk), .Q(mem_addr[23]) );
  DFFX1_RVT \mem_addr_reg[24]  ( .D(n2552), .CLK(clk), .Q(mem_addr[24]) );
  DFFX1_RVT \mem_addr_reg[25]  ( .D(n2551), .CLK(clk), .Q(mem_addr[25]) );
  DFFX1_RVT \mem_addr_reg[26]  ( .D(n2550), .CLK(clk), .Q(mem_addr[26]) );
  DFFX1_RVT \mem_addr_reg[27]  ( .D(n2549), .CLK(clk), .Q(mem_addr[27]) );
  DFFX1_RVT \mem_addr_reg[28]  ( .D(n2548), .CLK(clk), .Q(mem_addr[28]) );
  DFFX1_RVT \mem_addr_reg[29]  ( .D(n2547), .CLK(clk), .Q(mem_addr[29]) );
  DFFX1_RVT \mem_addr_reg[30]  ( .D(n2546), .CLK(clk), .Q(mem_addr[30]) );
  DFFX1_RVT \mem_addr_reg[31]  ( .D(n2545), .CLK(clk), .Q(mem_addr[31]) );
  DFFX1_RVT \mem_rdata_q_reg[1]  ( .D(n2542), .CLK(clk), .Q(mem_rdata_q[1]) );
  DFFX1_RVT \mem_rdata_q_reg[2]  ( .D(n2541), .CLK(clk), .Q(mem_rdata_q[2]) );
  DFFX1_RVT \mem_rdata_q_reg[3]  ( .D(n2540), .CLK(clk), .Q(mem_rdata_q[3]) );
  DFFX1_RVT \mem_rdata_q_reg[4]  ( .D(n2539), .CLK(clk), .Q(mem_rdata_q[4]), 
        .QN(n8069) );
  DFFX1_RVT \mem_rdata_q_reg[5]  ( .D(n2538), .CLK(clk), .Q(mem_rdata_q[5]), 
        .QN(n8065) );
  DFFX1_RVT \mem_rdata_q_reg[6]  ( .D(n2537), .CLK(clk), .Q(mem_rdata_q[6]), 
        .QN(n8004) );
  DFFX1_RVT \mem_rdata_q_reg[7]  ( .D(n2536), .CLK(clk), .Q(mem_rdata_q[7]) );
  DFFX1_RVT \mem_rdata_q_reg[8]  ( .D(n2535), .CLK(clk), .Q(mem_rdata_q[8]) );
  DFFX1_RVT \mem_rdata_q_reg[9]  ( .D(n2534), .CLK(clk), .Q(mem_rdata_q[9]) );
  DFFX1_RVT \mem_rdata_q_reg[10]  ( .D(n2533), .CLK(clk), .Q(mem_rdata_q[10])
         );
  DFFX1_RVT \mem_rdata_q_reg[11]  ( .D(n2532), .CLK(clk), .Q(mem_rdata_q[11])
         );
  DFFX1_RVT \mem_rdata_q_reg[12]  ( .D(n2531), .CLK(clk), .Q(mem_rdata_q[12]), 
        .QN(n8045) );
  DFFX1_RVT \mem_rdata_q_reg[13]  ( .D(n2530), .CLK(clk), .Q(mem_rdata_q[13]), 
        .QN(n7999) );
  DFFX1_RVT \mem_rdata_q_reg[14]  ( .D(n2529), .CLK(clk), .Q(mem_rdata_q[14]), 
        .QN(n7970) );
  DFFX1_RVT \mem_rdata_q_reg[15]  ( .D(n2528), .CLK(clk), .Q(mem_rdata_q[15])
         );
  DFFX1_RVT \mem_rdata_q_reg[16]  ( .D(n2527), .CLK(clk), .Q(mem_rdata_q[16])
         );
  DFFX1_RVT \mem_rdata_q_reg[17]  ( .D(n2526), .CLK(clk), .Q(mem_rdata_q[17])
         );
  DFFX1_RVT \mem_rdata_q_reg[18]  ( .D(n2525), .CLK(clk), .Q(mem_rdata_q[18])
         );
  DFFX1_RVT \mem_rdata_q_reg[19]  ( .D(n2524), .CLK(clk), .Q(mem_rdata_q[19])
         );
  DFFX1_RVT \mem_rdata_q_reg[20]  ( .D(n2523), .CLK(clk), .Q(mem_rdata_q[20]), 
        .QN(net16302) );
  DFFX1_RVT \mem_rdata_q_reg[21]  ( .D(n2522), .CLK(clk), .Q(mem_rdata_q[21]), 
        .QN(n8061) );
  DFFX1_RVT \mem_rdata_q_reg[22]  ( .D(n2521), .CLK(clk), .Q(mem_rdata_q[22])
         );
  DFFX1_RVT \mem_rdata_q_reg[23]  ( .D(n2520), .CLK(clk), .Q(mem_rdata_q[23])
         );
  DFFX1_RVT \mem_rdata_q_reg[24]  ( .D(n2519), .CLK(clk), .Q(mem_rdata_q[24])
         );
  DFFX1_RVT \mem_rdata_q_reg[25]  ( .D(n2518), .CLK(clk), .Q(mem_rdata_q[25])
         );
  DFFX1_RVT \mem_rdata_q_reg[26]  ( .D(n2517), .CLK(clk), .Q(mem_rdata_q[26])
         );
  DFFX1_RVT \mem_rdata_q_reg[27]  ( .D(n2516), .CLK(clk), .Q(mem_rdata_q[27]), 
        .QN(n8000) );
  DFFX1_RVT \mem_rdata_q_reg[28]  ( .D(n2515), .CLK(clk), .Q(mem_rdata_q[28])
         );
  DFFX1_RVT \mem_rdata_q_reg[29]  ( .D(n2514), .CLK(clk), .Q(mem_rdata_q[29])
         );
  DFFX1_RVT \mem_rdata_q_reg[30]  ( .D(n2513), .CLK(clk), .Q(mem_rdata_q[30]), 
        .QN(n8044) );
  DFFX1_RVT \mem_rdata_q_reg[31]  ( .D(n2512), .CLK(clk), .Q(mem_rdata_q[31]), 
        .QN(n8046) );
  DFFX1_RVT \mem_rdata_q_reg[0]  ( .D(n2511), .CLK(clk), .Q(mem_rdata_q[0]) );
  LATCHX1_RVT \mem_rdata_word_reg[8]  ( .CLK(n4005), .D(n3978), .Q(
        mem_rdata_word[8]) );
  LATCHX1_RVT \mem_rdata_word_reg[9]  ( .CLK(n8071), .D(n3977), .Q(
        mem_rdata_word[9]) );
  LATCHX1_RVT \mem_rdata_word_reg[10]  ( .CLK(n4006), .D(n3976), .Q(
        mem_rdata_word[10]) );
  LATCHX1_RVT \mem_rdata_word_reg[11]  ( .CLK(n8071), .D(n3975), .Q(
        mem_rdata_word[11]) );
  LATCHX1_RVT \mem_rdata_word_reg[12]  ( .CLK(n4005), .D(n3974), .Q(
        mem_rdata_word[12]) );
  LATCHX1_RVT \mem_rdata_word_reg[13]  ( .CLK(n8071), .D(n3973), .Q(
        mem_rdata_word[13]) );
  LATCHX1_RVT \mem_rdata_word_reg[14]  ( .CLK(n4006), .D(n3972), .Q(
        mem_rdata_word[14]) );
  LATCHX1_RVT \mem_rdata_word_reg[15]  ( .CLK(n8071), .D(n3971), .Q(
        mem_rdata_word[15]) );
  LATCHX1_RVT \mem_la_wstrb_reg[0]  ( .CLK(n8071), .D(n3959), .Q(
        mem_la_wstrb[0]) );
  LATCHX1_RVT \mem_rdata_word_reg[16]  ( .CLK(n8071), .D(N216), .Q(
        mem_rdata_word[16]) );
  LATCHX1_RVT \mem_rdata_word_reg[17]  ( .CLK(n8071), .D(N217), .Q(
        mem_rdata_word[17]) );
  LATCHX1_RVT \mem_rdata_word_reg[18]  ( .CLK(n8071), .D(N218), .Q(
        mem_rdata_word[18]) );
  LATCHX1_RVT \mem_rdata_word_reg[19]  ( .CLK(n8071), .D(N219), .Q(
        mem_rdata_word[19]) );
  LATCHX1_RVT \mem_rdata_word_reg[20]  ( .CLK(n8071), .D(N220), .Q(
        mem_rdata_word[20]) );
  LATCHX1_RVT \mem_rdata_word_reg[21]  ( .CLK(n8071), .D(N221), .Q(
        mem_rdata_word[21]) );
  LATCHX1_RVT \mem_rdata_word_reg[22]  ( .CLK(n8071), .D(N222), .Q(
        mem_rdata_word[22]) );
  LATCHX1_RVT \mem_rdata_word_reg[23]  ( .CLK(n8071), .D(N223), .Q(
        mem_rdata_word[23]) );
  LATCHX1_RVT \mem_rdata_word_reg[24]  ( .CLK(n8071), .D(N224), .Q(
        mem_rdata_word[24]) );
  LATCHX1_RVT \mem_rdata_word_reg[25]  ( .CLK(n8071), .D(N225), .Q(
        mem_rdata_word[25]) );
  LATCHX1_RVT \mem_rdata_word_reg[26]  ( .CLK(n8071), .D(N226), .Q(
        mem_rdata_word[26]) );
  LATCHX1_RVT \mem_rdata_word_reg[27]  ( .CLK(n4006), .D(N227), .Q(
        mem_rdata_word[27]) );
  LATCHX1_RVT \mem_rdata_word_reg[28]  ( .CLK(n8071), .D(N228), .Q(
        mem_rdata_word[28]) );
  LATCHX1_RVT \mem_rdata_word_reg[29]  ( .CLK(n8071), .D(N229), .Q(
        mem_rdata_word[29]) );
  LATCHX1_RVT \mem_rdata_word_reg[30]  ( .CLK(n4005), .D(N230), .Q(
        mem_rdata_word[30]) );
  LATCHX1_RVT \mem_rdata_word_reg[31]  ( .CLK(n8071), .D(N231), .Q(
        mem_rdata_word[31]) );
  LATCHX1_RVT \mem_la_wstrb_reg[3]  ( .CLK(n8071), .D(n3962), .Q(
        mem_la_wstrb[3]) );
  LATCHX1_RVT \mem_la_wstrb_reg[1]  ( .CLK(n4006), .D(n3960), .Q(
        mem_la_wstrb[1]) );
  LATCHX1_RVT \mem_rdata_word_reg[7]  ( .CLK(n8071), .D(n3970), .Q(
        mem_rdata_word[7]) );
  LATCHX1_RVT \mem_rdata_word_reg[6]  ( .CLK(n8071), .D(n3969), .Q(
        mem_rdata_word[6]) );
  LATCHX1_RVT \mem_rdata_word_reg[5]  ( .CLK(n4004), .D(n3968), .Q(
        mem_rdata_word[5]) );
  LATCHX1_RVT \mem_rdata_word_reg[4]  ( .CLK(n8071), .D(n3967), .Q(
        mem_rdata_word[4]) );
  LATCHX1_RVT \mem_rdata_word_reg[3]  ( .CLK(n8071), .D(n3966), .Q(
        mem_rdata_word[3]) );
  LATCHX1_RVT \mem_rdata_word_reg[2]  ( .CLK(n4005), .D(n3965), .Q(
        mem_rdata_word[2]) );
  LATCHX1_RVT \mem_rdata_word_reg[1]  ( .CLK(n8071), .D(n3964), .Q(
        mem_rdata_word[1]) );
  LATCHX1_RVT \mem_rdata_word_reg[0]  ( .CLK(n8071), .D(n3963), .Q(
        mem_rdata_word[0]) );
  LATCHX1_RVT \mem_la_wstrb_reg[2]  ( .CLK(n8071), .D(n3961), .Q(
        mem_la_wstrb[2]) );
  LATCHX1_RVT \mem_la_wdata_reg[3]  ( .CLK(n8071), .D(pcpi_rs2[3]), .Q(
        mem_la_wdata[3]) );
  LATCHX1_RVT \mem_la_wdata_reg[2]  ( .CLK(n4004), .D(pcpi_rs2[2]), .Q(
        mem_la_wdata[2]) );
  LATCHX1_RVT \mem_la_wdata_reg[8]  ( .CLK(n8071), .D(n3958), .Q(
        mem_la_wdata[8]) );
  LATCHX1_RVT \mem_la_wdata_reg[9]  ( .CLK(n4005), .D(n3957), .Q(
        mem_la_wdata[9]) );
  LATCHX1_RVT \mem_la_wdata_reg[10]  ( .CLK(n4004), .D(n3956), .Q(
        mem_la_wdata[10]) );
  LATCHX1_RVT \mem_la_wdata_reg[11]  ( .CLK(n8071), .D(n3955), .Q(
        mem_la_wdata[11]) );
  LATCHX1_RVT \mem_la_wdata_reg[12]  ( .CLK(n4006), .D(n3954), .Q(
        mem_la_wdata[12]) );
  LATCHX1_RVT \mem_la_wdata_reg[13]  ( .CLK(n8071), .D(n3953), .Q(
        mem_la_wdata[13]) );
  LATCHX1_RVT \mem_la_wdata_reg[14]  ( .CLK(n4004), .D(n3952), .Q(
        mem_la_wdata[14]) );
  LATCHX1_RVT \mem_la_wdata_reg[30]  ( .CLK(n4005), .D(n3936), .Q(
        mem_la_wdata[30]) );
  LATCHX1_RVT \mem_la_wdata_reg[15]  ( .CLK(n8071), .D(n3951), .Q(
        mem_la_wdata[15]) );
  LATCHX1_RVT \mem_la_wdata_reg[16]  ( .CLK(n8071), .D(n3950), .Q(
        mem_la_wdata[16]) );
  LATCHX1_RVT \mem_la_wdata_reg[17]  ( .CLK(n8071), .D(n3949), .Q(
        mem_la_wdata[17]) );
  LATCHX1_RVT \mem_la_wdata_reg[18]  ( .CLK(n4004), .D(n3948), .Q(
        mem_la_wdata[18]) );
  LATCHX1_RVT \mem_la_wdata_reg[19]  ( .CLK(n4006), .D(n3947), .Q(
        mem_la_wdata[19]) );
  LATCHX1_RVT \mem_la_wdata_reg[20]  ( .CLK(n4004), .D(n3946), .Q(
        mem_la_wdata[20]) );
  LATCHX1_RVT \mem_la_wdata_reg[21]  ( .CLK(n4005), .D(n3945), .Q(
        mem_la_wdata[21]) );
  LATCHX1_RVT \mem_la_wdata_reg[22]  ( .CLK(n4004), .D(n3944), .Q(
        mem_la_wdata[22]) );
  LATCHX1_RVT \mem_la_wdata_reg[23]  ( .CLK(n4006), .D(n3943), .Q(
        mem_la_wdata[23]) );
  LATCHX1_RVT \mem_la_wdata_reg[24]  ( .CLK(n4004), .D(n3942), .Q(
        mem_la_wdata[24]) );
  LATCHX1_RVT \mem_la_wdata_reg[25]  ( .CLK(n4005), .D(n3941), .Q(
        mem_la_wdata[25]) );
  LATCHX1_RVT \mem_la_wdata_reg[26]  ( .CLK(n4004), .D(n3940), .Q(
        mem_la_wdata[26]) );
  LATCHX1_RVT \mem_la_wdata_reg[27]  ( .CLK(n8071), .D(n3939), .Q(
        mem_la_wdata[27]) );
  LATCHX1_RVT \mem_la_wdata_reg[28]  ( .CLK(n4006), .D(n3938), .Q(
        mem_la_wdata[28]) );
  LATCHX1_RVT \mem_la_wdata_reg[29]  ( .CLK(n4004), .D(n3937), .Q(
        mem_la_wdata[29]) );
  LATCHX1_RVT \mem_la_wdata_reg[31]  ( .CLK(n4005), .D(n3935), .Q(
        mem_la_wdata[31]) );
  LATCHX1_RVT \mem_la_wdata_reg[6]  ( .CLK(n8071), .D(pcpi_rs2[6]), .Q(
        mem_la_wdata[6]) );
  LATCHX1_RVT \mem_la_wdata_reg[4]  ( .CLK(n8071), .D(pcpi_rs2[4]), .Q(
        mem_la_wdata[4]) );
  LATCHX1_RVT \mem_la_wdata_reg[1]  ( .CLK(n8071), .D(pcpi_rs2[1]), .Q(
        mem_la_wdata[1]) );
  LATCHX1_RVT \mem_la_wdata_reg[5]  ( .CLK(n4005), .D(pcpi_rs2[5]), .Q(
        mem_la_wdata[5]) );
  LATCHX1_RVT \mem_la_wdata_reg[7]  ( .CLK(n4006), .D(pcpi_rs2[7]), .Q(
        mem_la_wdata[7]) );
  DFFX1_RVT \reg_pc_reg[1]  ( .D(n3796), .CLK(clk), .Q(reg_pc[1]), .QN(n8040)
         );
  DFFX1_RVT instr_jal_reg ( .D(n3691), .CLK(clk), .Q(instr_jal), .QN(n8042) );
  DFFX1_RVT \decoded_imm_j_reg[19]  ( .D(n3608), .CLK(clk), .Q(
        decoded_imm_j[19]), .QN(n7968) );
  DFFX1_RVT \reg_op1_reg[7]  ( .D(n3733), .CLK(clk), .Q(n8087), .QN(net16363)
         );
  DFFX1_RVT \reg_op1_reg[6]  ( .D(n3734), .CLK(clk), .Q(n8088), .QN(net16359)
         );
  LATCHX1_RVT \mem_la_wdata_reg[0]  ( .CLK(n8071), .D(pcpi_rs2[0]), .Q(
        mem_la_wdata[0]) );
  DFFX1_RVT mem_do_rdata_reg ( .D(n3700), .CLK(clk), .Q(mem_do_rdata), .QN(
        n8008) );
  DFFX1_RVT instr_sub_reg ( .D(n3752), .CLK(clk), .Q(instr_sub), .QN(n8025) );
  DFFX1_RVT mem_do_wdata_reg ( .D(n3701), .CLK(clk), .Q(mem_do_wdata), .QN(
        n7977) );
  DFFX1_RVT decoder_trigger_reg ( .D(N2106), .CLK(clk), .Q(decoder_trigger), 
        .QN(n8005) );
  DFFX1_RVT \reg_op1_reg[5]  ( .D(n3735), .CLK(clk), .Q(n8089), .QN(net16448)
         );
  DFFX1_RVT \reg_op1_reg[13]  ( .D(n3727), .CLK(clk), .Q(n8081), .QN(net16341)
         );
  DFFX1_RVT \reg_op1_reg[14]  ( .D(n3726), .CLK(clk), .Q(n8080), .QN(net16348)
         );
  DFFX1_RVT \cpu_state_reg[6]  ( .D(n3667), .CLK(clk), .Q(cpu_state[6]), .QN(
        n8006) );
  DFFX1_RVT \reg_op1_reg[23]  ( .D(n3717), .CLK(clk), .Q(n8074), .QN(net16360)
         );
  DFFX1_RVT \cpu_state_reg[7]  ( .D(n3666), .CLK(clk), .Q(cpu_state[7]), .QN(
        n8007) );
  DFFX1_RVT \cpu_state_reg[5]  ( .D(n3668), .CLK(clk), .Q(cpu_state[5]), .QN(
        n7974) );
  DFFX1_RVT latched_branch_reg ( .D(n3932), .CLK(clk), .Q(latched_branch), 
        .QN(n7988) );
  DFFX1_RVT \reg_op1_reg[15]  ( .D(n3725), .CLK(clk), .Q(n8079), .QN(net16327)
         );
  DFFX1_RVT \reg_op1_reg[27]  ( .D(n3713), .CLK(clk), .Q(pcpi_rs1[27]), .QN(
        net16338) );
  AO222X1_RVT U4206 ( .A1(pcpi_rs2[29]), .A2(net29439), .A3(net23989), .A4(
        decoded_imm[29]), .A5(n7361), .A6(net30423), .Y(n3901) );
  AO21X1_RVT U4207 ( .A1(n3988), .A2(net30422), .A3(n3987), .Y(n3911) );
  AO21X1_RVT U4208 ( .A1(n3985), .A2(net30422), .A3(n3984), .Y(n3912) );
  NAND3X0_RVT U4209 ( .A1(n7203), .A2(n6343), .A3(n6342), .Y(N1939) );
  XOR3X1_RVT U4210 ( .A1(n7575), .A2(n8078), .A3(n7576), .Y(n7577) );
  XOR3X1_RVT U4211 ( .A1(n7548), .A2(n8075), .A3(n7549), .Y(n7550) );
  AND3X1_RVT U4212 ( .A1(resetn), .A2(is_beq_bne_blt_bge_bltu_bgeu), .A3(n6142), .Y(n6143) );
  NBUFFX2_RVT U4213 ( .A(n6355), .Y(n4683) );
  XOR3X1_RVT U4214 ( .A1(pcpi_rs1[31]), .A2(decoded_imm[31]), .A3(net24608), 
        .Y(n4128) );
  AND3X1_RVT U4215 ( .A1(resetn), .A2(is_beq_bne_blt_bge_bltu_bgeu), .A3(n6197), .Y(n6141) );
  XOR3X1_RVT U4216 ( .A1(reg_pc[31]), .A2(decoded_imm[31]), .A3(n6813), .Y(
        n6821) );
  XOR2X1_RVT U4217 ( .A1(n5132), .A2(n5131), .Y(n5142) );
  AND3X1_RVT U4218 ( .A1(resetn), .A2(n4266), .A3(n6186), .Y(n6196) );
  AO22X1_RVT U4219 ( .A1(pcpi_rs2[19]), .A2(net29438), .A3(net23989), .A4(
        decoded_imm[19]), .Y(n3987) );
  AO22X1_RVT U4220 ( .A1(pcpi_rs2[18]), .A2(net27439), .A3(net30048), .A4(
        decoded_imm[18]), .Y(n3984) );
  NBUFFX2_RVT U4221 ( .A(n6360), .Y(n4761) );
  NBUFFX2_RVT U4222 ( .A(n6360), .Y(n4762) );
  NBUFFX2_RVT U4223 ( .A(n6522), .Y(n4758) );
  NBUFFX2_RVT U4224 ( .A(n6522), .Y(n4757) );
  NBUFFX2_RVT U4225 ( .A(n6068), .Y(n4784) );
  NBUFFX2_RVT U4226 ( .A(n6522), .Y(n4759) );
  NBUFFX2_RVT U4227 ( .A(n6355), .Y(n4684) );
  NBUFFX2_RVT U4228 ( .A(n6223), .Y(n4735) );
  NBUFFX2_RVT U4229 ( .A(n6348), .Y(n4687) );
  NBUFFX2_RVT U4230 ( .A(n6348), .Y(n4685) );
  NBUFFX2_RVT U4231 ( .A(n6348), .Y(n4686) );
  AND2X1_RVT U4232 ( .A1(n5871), .A2(resetn), .Y(n5863) );
  AND2X1_RVT U4233 ( .A1(n5862), .A2(resetn), .Y(n5855) );
  NBUFFX2_RVT U4234 ( .A(n6299), .Y(n4618) );
  NBUFFX2_RVT U4235 ( .A(n6299), .Y(n4619) );
  NBUFFX2_RVT U4236 ( .A(n6042), .Y(n4627) );
  NBUFFX2_RVT U4237 ( .A(n6042), .Y(n4628) );
  NBUFFX2_RVT U4238 ( .A(n6298), .Y(n4616) );
  NBUFFX2_RVT U4239 ( .A(n5524), .Y(n4621) );
  NBUFFX2_RVT U4240 ( .A(n5524), .Y(n4622) );
  NBUFFX2_RVT U4241 ( .A(n6042), .Y(n4629) );
  NBUFFX2_RVT U4242 ( .A(n6299), .Y(n4620) );
  NBUFFX2_RVT U4243 ( .A(n6041), .Y(n4626) );
  NBUFFX2_RVT U4244 ( .A(n6168), .Y(n4782) );
  NBUFFX2_RVT U4245 ( .A(n5524), .Y(n4623) );
  NOR2X0_RVT U4246 ( .A1(net29419), .A2(n7826), .Y(n4536) );
  INVX1_RVT U4247 ( .A(n7891), .Y(n4323) );
  XNOR2X1_RVT U4248 ( .A1(n6949), .A2(n4252), .Y(n6950) );
  AO22X1_RVT U4249 ( .A1(net30560), .A2(pcpi_rs1[10]), .A3(net30609), .A4(
        pcpi_rs1[15]), .Y(n5784) );
  HADDX1_RVT U4250 ( .A0(reg_pc[5]), .B0(n7724), .SO(n7725) );
  HADDX1_RVT U4251 ( .A0(reg_pc[9]), .B0(n7741), .SO(n7744) );
  NBUFFX2_RVT U4252 ( .A(is_lui_auipc_jal_jalr_addi_add_sub), .Y(n4528) );
  INVX1_RVT U4253 ( .A(n6360), .Y(n6522) );
  INVX1_RVT U4254 ( .A(net16337), .Y(pcpi_rs1[8]) );
  NBUFFX2_RVT U4255 ( .A(n6526), .Y(n4085) );
  INVX0_RVT U4256 ( .A(n7603), .Y(n4244) );
  NBUFFX2_RVT U4257 ( .A(n4035), .Y(n4038) );
  INVX1_RVT U4258 ( .A(n6310), .Y(n6312) );
  XOR3X1_RVT U4259 ( .A1(reg_pc[7]), .A2(decoded_imm[7]), .A3(net25657), .Y(
        n5722) );
  XOR2X1_RVT U4260 ( .A1(decoded_imm[5]), .A2(n7723), .Y(n7724) );
  NOR3X0_RVT U4261 ( .A1(n6051), .A2(decoder_pseudo_trigger), .A3(n6050), .Y(
        n6128) );
  AND2X1_RVT U4262 ( .A1(n4803), .A2(n4266), .Y(n7944) );
  HADDX1_RVT U4263 ( .A0(decoded_imm[13]), .B0(n7763), .SO(n7764) );
  HADDX1_RVT U4264 ( .A0(decoded_imm[9]), .B0(n7740), .SO(n7741) );
  NBUFFX2_RVT U4265 ( .A(n6711), .Y(n4035) );
  AND3X1_RVT U4266 ( .A1(resetn), .A2(n4266), .A3(n6144), .Y(n6194) );
  NAND4X0_RVT U4267 ( .A1(n6365), .A2(n7981), .A3(n8011), .A4(n4021), .Y(n6416) );
  NAND4X0_RVT U4268 ( .A1(n6140), .A2(n7981), .A3(n8011), .A4(n4021), .Y(n6168) );
  NAND3X0_RVT U4269 ( .A1(n6309), .A2(n6365), .A3(n8020), .Y(n6351) );
  NAND3X0_RVT U4270 ( .A1(n6365), .A2(n6302), .A3(n8020), .Y(n6349) );
  NAND3X0_RVT U4271 ( .A1(n6302), .A2(n6140), .A3(n8020), .Y(n6153) );
  INVX1_RVT U4272 ( .A(net16341), .Y(pcpi_rs1[13]) );
  INVX1_RVT U4273 ( .A(n7733), .Y(n7775) );
  INVX1_RVT U4274 ( .A(n6288), .Y(n6557) );
  AND2X1_RVT U4275 ( .A1(n6855), .A2(n4838), .Y(n4275) );
  AND2X1_RVT U4276 ( .A1(n4312), .A2(n4829), .Y(n4286) );
  INVX1_RVT U4277 ( .A(n6468), .Y(n4491) );
  INVX1_RVT U4278 ( .A(n7429), .Y(n4454) );
  XOR3X1_RVT U4279 ( .A1(pcpi_rs1[22]), .A2(decoded_imm[22]), .A3(n3992), .Y(
        net26360) );
  AO222X1_RVT U4280 ( .A1(resetn), .A2(n7893), .A3(resetn), .A4(trap), .A5(
        resetn), .A6(n7892), .Y(n7896) );
  INVX1_RVT U4281 ( .A(net16466), .Y(net30596) );
  NAND2X0_RVT U4282 ( .A1(n6309), .A2(n6359), .Y(n5524) );
  OR2X1_RVT U4283 ( .A1(pcpi_rs1[29]), .A2(n7505), .Y(n3981) );
  NAND2X1_RVT U4284 ( .A1(n6359), .A2(n6302), .Y(n6299) );
  NAND2X1_RVT U4285 ( .A1(n6302), .A2(n6059), .Y(n6042) );
  NAND2X1_RVT U4286 ( .A1(n6359), .A2(n6300), .Y(n6298) );
  NAND2X1_RVT U4287 ( .A1(n6300), .A2(n6059), .Y(n6041) );
  INVX1_RVT U4288 ( .A(net16317), .Y(net30668) );
  INVX1_RVT U4289 ( .A(net16336), .Y(net30713) );
  NBUFFX2_RVT U4290 ( .A(n4320), .Y(n4184) );
  AND2X1_RVT U4291 ( .A1(latched_rd[2]), .A2(latched_rd[1]), .Y(n6309) );
  XOR3X1_RVT U4292 ( .A1(pcpi_rs1[26]), .A2(decoded_imm[26]), .A3(n3993), .Y(
        net24133) );
  INVX1_RVT U4293 ( .A(net16367), .Y(net30659) );
  INVX1_RVT U4294 ( .A(net16363), .Y(net30656) );
  INVX1_RVT U4295 ( .A(net16359), .Y(net30702) );
  NBUFFX2_RVT U4296 ( .A(n6508), .Y(n4370) );
  NBUFFX2_RVT U4297 ( .A(n6508), .Y(n4372) );
  AND2X1_RVT U4298 ( .A1(n7979), .A2(n8016), .Y(n6855) );
  XOR3X1_RVT U4299 ( .A1(pcpi_rs1[24]), .A2(decoded_imm[24]), .A3(net26246), 
        .Y(net26245) );
  OR2X1_RVT U4300 ( .A1(n5707), .A2(decoded_imm[28]), .Y(n5709) );
  INVX1_RVT U4301 ( .A(n4972), .Y(n4514) );
  INVX1_RVT U4302 ( .A(n6649), .Y(n4391) );
  AND2X1_RVT U4303 ( .A1(n4972), .A2(latched_is_lu), .Y(n6573) );
  NBUFFX2_RVT U4304 ( .A(n6735), .Y(n4424) );
  NBUFFX2_RVT U4305 ( .A(n4007), .Y(n4267) );
  AND2X1_RVT U4306 ( .A1(n4893), .A2(n4328), .Y(n4327) );
  AND2X1_RVT U4307 ( .A1(n5237), .A2(n4814), .Y(n4294) );
  NBUFFX2_RVT U4308 ( .A(n4007), .Y(n4266) );
  AND3X1_RVT U4309 ( .A1(decoded_imm_j[3]), .A2(decoded_imm_j[4]), .A3(
        decoded_imm_j[2]), .Y(n7229) );
  AND3X1_RVT U4310 ( .A1(decoded_imm_j[3]), .A2(n8017), .A3(n8014), .Y(n7226)
         );
  AND2X1_RVT U4311 ( .A1(n5237), .A2(n4814), .Y(n4806) );
  NBUFFX2_RVT U4312 ( .A(n6735), .Y(n4422) );
  NAND2X0_RVT U4313 ( .A1(n4328), .A2(n4881), .Y(n6591) );
  AND3X1_RVT U4314 ( .A1(decoded_imm_j[17]), .A2(n7968), .A3(n7978), .Y(n4886)
         );
  OR2X1_RVT U4315 ( .A1(n8075), .A2(n7548), .Y(n3982) );
  INVX1_RVT U4316 ( .A(n7555), .Y(n4238) );
  NBUFFX2_RVT U4317 ( .A(n8074), .Y(pcpi_rs1[23]) );
  INVX1_RVT U4318 ( .A(net16330), .Y(pcpi_rs1[4]) );
  INVX1_RVT U4319 ( .A(net13612), .Y(pcpi_rs1[9]) );
  OR2X1_RVT U4320 ( .A1(n8078), .A2(n7575), .Y(n3983) );
  INVX1_RVT U4321 ( .A(net16448), .Y(net30690) );
  NBUFFX2_RVT U4322 ( .A(n8079), .Y(pcpi_rs1[15]) );
  INVX1_RVT U4323 ( .A(n7844), .Y(n7845) );
  OR2X1_RVT U4324 ( .A1(n5922), .A2(n7838), .Y(n7844) );
  NBUFFX2_RVT U4325 ( .A(n8082), .Y(pcpi_rs1[12]) );
  NBUFFX2_RVT U4326 ( .A(n8084), .Y(pcpi_rs1[10]) );
  HADDX1_RVT U4327 ( .A0(reg_pc[9]), .B0(n6499), .C1(n6156), .SO(n6500) );
  HADDX1_RVT U4328 ( .A0(reg_pc[7]), .B0(n6511), .C1(n6497), .SO(n6512) );
  HADDX1_RVT U4329 ( .A0(reg_pc[6]), .B0(n6030), .C1(n6511), .SO(n6031) );
  HADDX1_RVT U4330 ( .A0(reg_pc[4]), .B0(n6493), .C1(n6154), .SO(n6494) );
  HADDX1_RVT U4331 ( .A0(reg_pc[3]), .B0(reg_pc[2]), .C1(n6493), .SO(n6505) );
  HADDX1_RVT U4332 ( .A0(decoded_imm[0]), .B0(n8094), .C1(net25787), .SO(
        net25637) );
  OR2X1_RVT U4333 ( .A1(n7823), .A2(n8005), .Y(n7826) );
  XOR3X2_RVT U4334 ( .A1(n7505), .A2(pcpi_rs1[29]), .A3(n7506), .Y(n7507) );
  AO22X1_RVT U4335 ( .A1(n7505), .A2(pcpi_rs1[29]), .A3(n7506), .A4(n3981), 
        .Y(n7497) );
  AO22X1_RVT U4336 ( .A1(n7548), .A2(n8075), .A3(n7549), .A4(n3982), .Y(n7540)
         );
  AO22X1_RVT U4337 ( .A1(n7575), .A2(n8078), .A3(n7576), .A4(n3983), .Y(n6243)
         );
  NAND4X0_RVT U4338 ( .A1(n7073), .A2(n7074), .A3(n7075), .A4(n7072), .Y(n3985) );
  NAND4X0_RVT U4339 ( .A1(n7337), .A2(n7335), .A3(n7336), .A4(n7334), .Y(n3988) );
  NOR4X1_RVT U4340 ( .A1(n3989), .A2(n7286), .A3(n7284), .A4(n7285), .Y(n7293)
         );
  AO22X1_RVT U4341 ( .A1(n7474), .A2(\cpuregs[8][26] ), .A3(n4445), .A4(
        \cpuregs[23][26] ), .Y(n3989) );
  INVX1_RVT U4342 ( .A(n7439), .Y(n4476) );
  INVX1_RVT U4343 ( .A(n7426), .Y(n4462) );
  AND2X1_RVT U4344 ( .A1(n7253), .A2(n6340), .Y(n3990) );
  AND2X1_RVT U4345 ( .A1(n4833), .A2(n4830), .Y(n3991) );
  AND2X1_RVT U4346 ( .A1(n4312), .A2(n7226), .Y(n7474) );
  AND2X1_RVT U4347 ( .A1(n4312), .A2(n7226), .Y(n4274) );
  NBUFFX2_RVT U4348 ( .A(net26361), .Y(n3992) );
  NBUFFX2_RVT U4349 ( .A(net24135), .Y(n3993) );
  NAND2X0_RVT U4350 ( .A1(decoded_imm[21]), .A2(reg_pc[21]), .Y(n3994) );
  NAND2X0_RVT U4351 ( .A1(n5525), .A2(decoded_imm[21]), .Y(n3995) );
  NAND2X0_RVT U4352 ( .A1(n5525), .A2(reg_pc[21]), .Y(n3996) );
  NAND3X0_RVT U4353 ( .A1(n3994), .A2(n3995), .A3(n3996), .Y(n6568) );
  NAND2X0_RVT U4354 ( .A1(n7708), .A2(decoded_imm[3]), .Y(n3997) );
  NAND2X0_RVT U4355 ( .A1(decoded_imm[3]), .A2(reg_pc[3]), .Y(n3998) );
  NAND2X0_RVT U4356 ( .A1(n7708), .A2(reg_pc[3]), .Y(n3999) );
  NAND3X0_RVT U4357 ( .A1(n3997), .A2(n3998), .A3(n3999), .Y(n7714) );
  NAND2X0_RVT U4358 ( .A1(n7714), .A2(decoded_imm[4]), .Y(n4000) );
  NAND2X0_RVT U4359 ( .A1(decoded_imm[4]), .A2(reg_pc[4]), .Y(n4001) );
  NAND2X0_RVT U4360 ( .A1(n7714), .A2(reg_pc[4]), .Y(n4002) );
  NAND3X0_RVT U4361 ( .A1(n4000), .A2(n4001), .A3(n4002), .Y(n7723) );
  INVX1_RVT U4362 ( .A(n4813), .Y(n4003) );
  INVX1_RVT U4363 ( .A(n4003), .Y(n4004) );
  INVX1_RVT U4364 ( .A(n4003), .Y(n4005) );
  INVX1_RVT U4365 ( .A(n4003), .Y(n4006) );
  INVX1_RVT U4366 ( .A(n6649), .Y(n4390) );
  NAND2X0_RVT U4367 ( .A1(n4328), .A2(n4887), .Y(n6658) );
  NAND2X0_RVT U4368 ( .A1(n4328), .A2(n4879), .Y(n6751) );
  NBUFFX2_RVT U4369 ( .A(n6735), .Y(n4423) );
  AND2X1_RVT U4370 ( .A1(n4312), .A2(n4829), .Y(n7473) );
  INVX1_RVT U4371 ( .A(n7440), .Y(n4472) );
  AND2X1_RVT U4372 ( .A1(n7979), .A2(n8016), .Y(n4312) );
  INVX1_RVT U4373 ( .A(n4971), .Y(n4155) );
  XOR2X1_RVT U4374 ( .A1(n5130), .A2(pcpi_rs1[31]), .Y(n5131) );
  INVX1_RVT U4375 ( .A(n7555), .Y(n4237) );
  HADDX1_RVT U4376 ( .A0(reg_pc[15]), .B0(n6165), .C1(n6163), .SO(n6166) );
  HADDX1_RVT U4377 ( .A0(reg_pc[13]), .B0(n6503), .C1(n6517), .SO(n6504) );
  HADDX1_RVT U4378 ( .A0(reg_pc[11]), .B0(n6151), .C1(n6039), .SO(n6152) );
  HADDX1_RVT U4379 ( .A0(reg_pc[10]), .B0(n6156), .C1(n6151), .SO(n6157) );
  HADDX1_RVT U4380 ( .A0(reg_pc[8]), .B0(n6497), .C1(n6499), .SO(n6498) );
  HADDX1_RVT U4381 ( .A0(reg_pc[5]), .B0(n6154), .C1(n6030), .SO(n6155) );
  AND2X1_RVT U4382 ( .A1(n5237), .A2(n4814), .Y(n4321) );
  INVX1_RVT U4383 ( .A(n4514), .Y(n4538) );
  NAND2X0_RVT U4384 ( .A1(n7733), .A2(n4973), .Y(n7797) );
  AND2X1_RVT U4385 ( .A1(n4861), .A2(n4640), .Y(n4031) );
  AND2X1_RVT U4386 ( .A1(mem_rdata_q[31]), .A2(net22659), .Y(n6098) );
  INVX1_RVT U4387 ( .A(n7826), .Y(n7888) );
  NBUFFX2_RVT U4388 ( .A(n6508), .Y(n4371) );
  INVX1_RVT U4389 ( .A(net25875), .Y(net24129) );
  NOR2X0_RVT U4390 ( .A1(n4798), .A2(n7988), .Y(n4219) );
  NAND2X0_RVT U4391 ( .A1(n6287), .A2(n4529), .Y(n6293) );
  NAND2X0_RVT U4392 ( .A1(n6270), .A2(n4528), .Y(n6275) );
  NBUFFX2_RVT U4393 ( .A(n6526), .Y(n4554) );
  NAND2X0_RVT U4394 ( .A1(n6378), .A2(n4528), .Y(n6383) );
  MUX21X1_RVT U4395 ( .A1(alu_out_q[15]), .A2(n6939), .S0(n4800), .Y(n7870) );
  MUX21X1_RVT U4396 ( .A1(alu_out_q[11]), .A2(n6936), .S0(n4800), .Y(n7866) );
  MUX21X1_RVT U4397 ( .A1(alu_out_q[8]), .A2(n6933), .S0(n4800), .Y(n7863) );
  NBUFFX2_RVT U4398 ( .A(n6168), .Y(n4781) );
  NBUFFX2_RVT U4399 ( .A(n6298), .Y(n4617) );
  NBUFFX2_RVT U4400 ( .A(n6171), .Y(n4747) );
  NBUFFX2_RVT U4401 ( .A(n6041), .Y(n4625) );
  NBUFFX2_RVT U4402 ( .A(n6168), .Y(n4780) );
  NBUFFX2_RVT U4403 ( .A(n6041), .Y(n4624) );
  NBUFFX2_RVT U4404 ( .A(n6360), .Y(n4760) );
  NBUFFX2_RVT U4405 ( .A(n6298), .Y(n4615) );
  NBUFFX2_RVT U4406 ( .A(n6224), .Y(n4741) );
  NBUFFX2_RVT U4407 ( .A(n6173), .Y(n4753) );
  OR2X1_RVT U4408 ( .A1(n6130), .A2(net22738), .Y(net22659) );
  INVX1_RVT U4409 ( .A(n6456), .Y(n6354) );
  AND2X1_RVT U4410 ( .A1(n5892), .A2(count_cycle[15]), .Y(n5898) );
  MUX21X1_RVT U4411 ( .A1(reg_next_pc[6]), .A2(reg_out[6]), .S0(n4219), .Y(
        n6930) );
  MUX21X1_RVT U4412 ( .A1(reg_next_pc[11]), .A2(reg_out[11]), .S0(n4229), .Y(
        n6936) );
  INVX1_RVT U4413 ( .A(n7891), .Y(n6209) );
  AO22X1_RVT U4414 ( .A1(resetn), .A2(n7904), .A3(mem_do_wdata), .A4(n7920), 
        .Y(n3701) );
  AO222X1_RVT U4415 ( .A1(pcpi_rs2[31]), .A2(net29439), .A3(net30049), .A4(
        decoded_imm[31]), .A5(n6992), .A6(net30423), .Y(n3931) );
  AO222X1_RVT U4416 ( .A1(pcpi_rs2[24]), .A2(net29439), .A3(net23989), .A4(
        decoded_imm[24]), .A5(n7013), .A6(net30424), .Y(n3906) );
  AO222X1_RVT U4417 ( .A1(pcpi_rs2[23]), .A2(net29438), .A3(net30049), .A4(
        decoded_imm[23]), .A5(n7409), .A6(net30424), .Y(n3907) );
  AO222X1_RVT U4418 ( .A1(n7544), .A2(n7543), .A3(n6412), .A4(n7542), .A5(
        n4528), .A6(n7541), .Y(alu_out[23]) );
  AO222X1_RVT U4419 ( .A1(n7553), .A2(n7552), .A3(n4246), .A4(n7551), .A5(
        n4529), .A6(n7550), .Y(alu_out[22]) );
  AO222X1_RVT U4420 ( .A1(pcpi_rs2[20]), .A2(net29439), .A3(net30049), .A4(
        decoded_imm[20]), .A5(n6864), .A6(net30423), .Y(n3910) );
  AO222X1_RVT U4421 ( .A1(n7565), .A2(n7564), .A3(n6412), .A4(n7563), .A5(
        n4529), .A6(n7562), .Y(alu_out[20]) );
  AO222X1_RVT U4422 ( .A1(n7205), .A2(resetn), .A3(net27439), .A4(pcpi_rs2[4]), 
        .A5(net30048), .A6(decoded_imm[4]), .Y(n3926) );
  AO222X1_RVT U4423 ( .A1(n7254), .A2(resetn), .A3(net29439), .A4(pcpi_rs2[2]), 
        .A5(net30049), .A6(n4121), .Y(n3928) );
  AO222X1_RVT U4424 ( .A1(n7675), .A2(n7674), .A3(n6412), .A4(n7673), .A5(
        n4528), .A6(n7672), .Y(alu_out[2]) );
  AO222X1_RVT U4425 ( .A1(net23636), .A2(resetn), .A3(net27439), .A4(
        pcpi_rs2[0]), .A5(net23989), .A6(decoded_imm[0]), .Y(n3930) );
  AND3X1_RVT U4426 ( .A1(resetn), .A2(n7852), .A3(n7851), .Y(n3858) );
  AO222X1_RVT U4427 ( .A1(pcpi_rs2[30]), .A2(net29438), .A3(net30049), .A4(
        decoded_imm[30]), .A5(n6971), .A6(net30424), .Y(n3900) );
  INVX1_RVT U4428 ( .A(net16449), .Y(pcpi_rs1[0]) );
  NBUFFX2_RVT U4429 ( .A(n8078), .Y(pcpi_rs1[17]) );
  NBUFFX2_RVT U4430 ( .A(n4035), .Y(n4036) );
  NBUFFX2_RVT U4431 ( .A(n4036), .Y(n4039) );
  INVX1_RVT U4432 ( .A(n6115), .Y(n4249) );
  INVX1_RVT U4433 ( .A(n6115), .Y(n4248) );
  OR4X1_RVT U4434 ( .A1(n4225), .A2(n4226), .A3(n4227), .A4(n4228), .Y(n5817)
         );
  NBUFFX2_RVT U4435 ( .A(n6592), .Y(n4427) );
  NBUFFX2_RVT U4436 ( .A(n6592), .Y(n4428) );
  INVX1_RVT U4437 ( .A(n4543), .Y(n4807) );
  NBUFFX2_RVT U4438 ( .A(n7952), .Y(n4592) );
  NBUFFX2_RVT U4439 ( .A(n7952), .Y(n4102) );
  NBUFFX2_RVT U4440 ( .A(n7952), .Y(n4593) );
  NOR2X0_RVT U4441 ( .A1(n8005), .A2(decoder_pseudo_trigger), .Y(n4007) );
  OR2X1_RVT U4442 ( .A1(n8005), .A2(decoder_pseudo_trigger), .Y(net27467) );
  NBUFFX2_RVT U4443 ( .A(n7951), .Y(n4598) );
  NBUFFX2_RVT U4444 ( .A(n7951), .Y(n4599) );
  NBUFFX2_RVT U4445 ( .A(n7951), .Y(n4600) );
  NBUFFX2_RVT U4446 ( .A(n6524), .Y(n4568) );
  NBUFFX2_RVT U4447 ( .A(n7962), .Y(n4080) );
  NBUFFX2_RVT U4448 ( .A(n6526), .Y(n4553) );
  NBUFFX2_RVT U4449 ( .A(n6526), .Y(n4551) );
  NBUFFX2_RVT U4450 ( .A(n6526), .Y(n4552) );
  NBUFFX2_RVT U4451 ( .A(n6523), .Y(n4591) );
  NBUFFX2_RVT U4452 ( .A(n6523), .Y(n4589) );
  NBUFFX2_RVT U4453 ( .A(n6523), .Y(n4590) );
  NBUFFX2_RVT U4454 ( .A(n4109), .Y(n4585) );
  NBUFFX2_RVT U4455 ( .A(n4092), .Y(n4009) );
  NBUFFX2_RVT U4456 ( .A(n7955), .Y(n4101) );
  NBUFFX2_RVT U4457 ( .A(n6709), .Y(n4100) );
  NBUFFX2_RVT U4458 ( .A(n4100), .Y(n4594) );
  NBUFFX2_RVT U4459 ( .A(n4100), .Y(n4084) );
  NBUFFX2_RVT U4460 ( .A(n4099), .Y(n4083) );
  NBUFFX2_RVT U4461 ( .A(n6713), .Y(n4595) );
  NBUFFX2_RVT U4462 ( .A(n6713), .Y(n4099) );
  NBUFFX2_RVT U4463 ( .A(n6713), .Y(n4596) );
  NBUFFX2_RVT U4464 ( .A(n7956), .Y(n4561) );
  NBUFFX2_RVT U4465 ( .A(n4103), .Y(n4562) );
  NBUFFX2_RVT U4466 ( .A(n4103), .Y(n4087) );
  NBUFFX2_RVT U4467 ( .A(n7956), .Y(n4103) );
  INVX1_RVT U4468 ( .A(n7941), .Y(n7940) );
  NBUFFX2_RVT U4469 ( .A(n7940), .Y(n4612) );
  NBUFFX2_RVT U4470 ( .A(n7940), .Y(n4611) );
  NBUFFX2_RVT U4471 ( .A(n7941), .Y(n4614) );
  NBUFFX2_RVT U4472 ( .A(n7941), .Y(n4613) );
  OR2X1_RVT U4473 ( .A1(mem_do_rinst), .A2(mem_do_prefetch), .Y(n7891) );
  INVX1_RVT U4474 ( .A(n4219), .Y(n4632) );
  INVX1_RVT U4475 ( .A(n4219), .Y(n4220) );
  NBUFFX2_RVT U4476 ( .A(n6318), .Y(n4681) );
  NBUFFX2_RVT U4477 ( .A(n6318), .Y(n4679) );
  INVX1_RVT U4478 ( .A(n6267), .Y(n6318) );
  NBUFFX2_RVT U4479 ( .A(n6318), .Y(n4680) );
  INVX1_RVT U4480 ( .A(n6266), .Y(n6317) );
  NBUFFX2_RVT U4481 ( .A(n6317), .Y(n4677) );
  NBUFFX2_RVT U4482 ( .A(n6317), .Y(n4676) );
  NBUFFX2_RVT U4483 ( .A(n6317), .Y(n4678) );
  NBUFFX2_RVT U4484 ( .A(n6068), .Y(n4786) );
  NBUFFX2_RVT U4485 ( .A(n6043), .Y(n4787) );
  XOR3X2_RVT U4486 ( .A1(reg_pc[8]), .A2(decoded_imm[8]), .A3(n7732), .Y(n7736) );
  AND2X1_RVT U4487 ( .A1(n5824), .A2(count_cycle[6]), .Y(n5827) );
  INVX1_RVT U4488 ( .A(n5824), .Y(n5822) );
  OA21X1_RVT U4489 ( .A1(n5824), .A2(count_cycle[6]), .A3(n5826), .Y(N924) );
  AO22X1_RVT U4490 ( .A1(n8080), .A2(n7997), .A3(pcpi_rs1[15]), .A4(n8033), 
        .Y(n5441) );
  OA22X1_RVT U4491 ( .A1(n8033), .A2(pcpi_rs1[15]), .A3(n5439), .A4(
        pcpi_rs1[14]), .Y(n5440) );
  INVX1_RVT U4492 ( .A(n4516), .Y(n4519) );
  INVX1_RVT U4493 ( .A(n4516), .Y(n4518) );
  INVX1_RVT U4494 ( .A(n4516), .Y(n4517) );
  INVX1_RVT U4495 ( .A(latched_branch), .Y(n4516) );
  NBUFFX2_RVT U4496 ( .A(n6224), .Y(n4739) );
  INVX1_RVT U4497 ( .A(n6715), .Y(n6224) );
  NBUFFX2_RVT U4498 ( .A(n6223), .Y(n4733) );
  INVX1_RVT U4499 ( .A(n6716), .Y(n6223) );
  NBUFFX2_RVT U4500 ( .A(n6173), .Y(n4752) );
  INVX1_RVT U4501 ( .A(n6174), .Y(n6173) );
  NBUFFX2_RVT U4502 ( .A(n6171), .Y(n4746) );
  INVX1_RVT U4503 ( .A(n6176), .Y(n6171) );
  INVX1_RVT U4504 ( .A(n7852), .Y(n5842) );
  XOR3X2_RVT U4505 ( .A1(reg_pc[30]), .A2(decoded_imm[30]), .A3(n6812), .Y(
        n4981) );
  NBUFFX2_RVT U4506 ( .A(n4114), .Y(n4008) );
  NBUFFX2_RVT U4507 ( .A(n7963), .Y(n4114) );
  NBUFFX2_RVT U4508 ( .A(n4109), .Y(n4092) );
  XOR3X2_RVT U4509 ( .A1(reg_pc[12]), .A2(decoded_imm[12]), .A3(n6527), .Y(
        n6535) );
  OR2X1_RVT U4510 ( .A1(n5726), .A2(decoded_imm[15]), .Y(n5727) );
  AO222X1_RVT U4511 ( .A1(reg_pc[12]), .A2(decoded_imm[12]), .A3(n6527), .A4(
        reg_pc[12]), .A5(n6527), .A6(decoded_imm[12]), .Y(n7763) );
  NBUFFX2_RVT U4512 ( .A(n8080), .Y(pcpi_rs1[14]) );
  XOR3X2_RVT U4513 ( .A1(decoded_imm[22]), .A2(reg_pc[22]), .A3(n6568), .Y(
        n6571) );
  NBUFFX2_RVT U4514 ( .A(n7953), .Y(n4560) );
  NBUFFX2_RVT U4515 ( .A(n7953), .Y(n4559) );
  NBUFFX2_RVT U4516 ( .A(n7953), .Y(n4558) );
  NBUFFX2_RVT U4517 ( .A(n6710), .Y(n4011) );
  NBUFFX2_RVT U4518 ( .A(n6710), .Y(n4012) );
  NBUFFX2_RVT U4519 ( .A(n4012), .Y(n4013) );
  INVX1_RVT U4520 ( .A(n5871), .Y(n5873) );
  AO222X1_RVT U4521 ( .A1(n3990), .A2(resetn), .A3(net29439), .A4(pcpi_rs2[1]), 
        .A5(net30048), .A6(decoded_imm[1]), .Y(n3929) );
  XNOR2X1_RVT U4522 ( .A1(reg_pc[1]), .A2(decoded_imm[1]), .Y(n7695) );
  NBUFFX2_RVT U4523 ( .A(n6173), .Y(n4751) );
  NBUFFX2_RVT U4524 ( .A(n6171), .Y(n4745) );
  NBUFFX2_RVT U4525 ( .A(n6224), .Y(n4740) );
  NBUFFX2_RVT U4526 ( .A(n6223), .Y(n4734) );
  XOR3X2_RVT U4527 ( .A1(decoded_imm[21]), .A2(reg_pc[21]), .A3(n5525), .Y(
        n5529) );
  INVX1_RVT U4528 ( .A(n7954), .Y(n4547) );
  OA21X1_RVT U4529 ( .A1(n5928), .A2(count_cycle[20]), .A3(n5930), .Y(N938) );
  INVX0_RVT U4530 ( .A(n5928), .Y(n5920) );
  AND2X1_RVT U4531 ( .A1(n6012), .A2(count_cycle[26]), .Y(n6019) );
  OA21X1_RVT U4532 ( .A1(count_cycle[26]), .A2(n6012), .A3(n6011), .Y(N944) );
  XOR3X2_RVT U4533 ( .A1(decoded_imm[20]), .A2(reg_pc[20]), .A3(n7793), .Y(
        n7800) );
  AO222X1_RVT U4534 ( .A1(decoded_imm[20]), .A2(reg_pc[20]), .A3(n7793), .A4(
        decoded_imm[20]), .A5(n7793), .A6(reg_pc[20]), .Y(n5525) );
  NBUFFX2_RVT U4535 ( .A(n6367), .Y(n4014) );
  NBUFFX2_RVT U4536 ( .A(n4014), .Y(n4015) );
  NBUFFX2_RVT U4537 ( .A(n4015), .Y(n4016) );
  NBUFFX2_RVT U4538 ( .A(n4015), .Y(n4017) );
  AO222X1_RVT U4539 ( .A1(latched_branch), .A2(n6166), .A3(n4370), .A4(
        reg_out[15]), .A5(alu_out_q[15]), .A6(n4097), .Y(n6367) );
  NBUFFX2_RVT U4540 ( .A(n8076), .Y(pcpi_rs1[19]) );
  XOR3X2_RVT U4541 ( .A1(decoded_imm[19]), .A2(reg_pc[19]), .A3(n7785), .Y(
        n7792) );
  AO222X1_RVT U4542 ( .A1(decoded_imm[19]), .A2(reg_pc[19]), .A3(n7785), .A4(
        decoded_imm[19]), .A5(n7785), .A6(reg_pc[19]), .Y(n7793) );
  NBUFFX2_RVT U4543 ( .A(n8073), .Y(pcpi_rs1[24]) );
  NBUFFX2_RVT U4544 ( .A(n6525), .Y(n4572) );
  NBUFFX2_RVT U4545 ( .A(n6525), .Y(n4571) );
  NBUFFX2_RVT U4546 ( .A(n6525), .Y(n4570) );
  NBUFFX2_RVT U4547 ( .A(n7910), .Y(n4020) );
  NAND4X0_RVT U4548 ( .A1(cpu_state[3]), .A2(n4971), .A3(n7688), .A4(n4638), 
        .Y(n7910) );
  XOR3X2_RVT U4549 ( .A1(decoded_imm[18]), .A2(reg_pc[18]), .A3(n7780), .Y(
        n7784) );
  AO222X1_RVT U4550 ( .A1(decoded_imm[18]), .A2(reg_pc[18]), .A3(n7780), .A4(
        decoded_imm[18]), .A5(n7780), .A6(reg_pc[18]), .Y(n7785) );
  NBUFFX2_RVT U4551 ( .A(n8020), .Y(n4021) );
  INVX1_RVT U4552 ( .A(n4676), .Y(n4022) );
  INVX1_RVT U4553 ( .A(n4677), .Y(n4023) );
  INVX1_RVT U4554 ( .A(n4678), .Y(n4024) );
  INVX1_RVT U4555 ( .A(n6266), .Y(n4025) );
  INVX1_RVT U4556 ( .A(n4028), .Y(n4026) );
  INVX1_RVT U4557 ( .A(n4679), .Y(n4027) );
  NBUFFX2_RVT U4558 ( .A(n4681), .Y(n4028) );
  INVX1_RVT U4559 ( .A(n4028), .Y(n4029) );
  INVX1_RVT U4560 ( .A(n4680), .Y(n4030) );
  XOR3X2_RVT U4561 ( .A1(decoded_imm[17]), .A2(reg_pc[17]), .A3(n6572), .Y(
        n6580) );
  AO222X1_RVT U4562 ( .A1(decoded_imm[17]), .A2(reg_pc[17]), .A3(n6572), .A4(
        decoded_imm[17]), .A5(n6572), .A6(reg_pc[17]), .Y(n7780) );
  NBUFFX2_RVT U4563 ( .A(n4533), .Y(n4634) );
  INVX1_RVT U4564 ( .A(n4241), .Y(n4535) );
  INVX1_RVT U4565 ( .A(n4533), .Y(n4241) );
  XOR3X2_RVT U4566 ( .A1(decoded_imm[16]), .A2(reg_pc[16]), .A3(n5143), .Y(
        n5145) );
  AO222X1_RVT U4567 ( .A1(decoded_imm[16]), .A2(reg_pc[16]), .A3(n5143), .A4(
        decoded_imm[16]), .A5(reg_pc[16]), .A6(n5143), .Y(n6572) );
  AO222X1_RVT U4568 ( .A1(n5726), .A2(decoded_imm[15]), .A3(decoded_imm[15]), 
        .A4(reg_pc[15]), .A5(n5726), .A6(reg_pc[15]), .Y(n5143) );
  NBUFFX2_RVT U4569 ( .A(n7950), .Y(n4603) );
  NBUFFX2_RVT U4570 ( .A(n7950), .Y(n4601) );
  NBUFFX2_RVT U4571 ( .A(n7950), .Y(n4602) );
  NBUFFX2_RVT U4572 ( .A(n8077), .Y(n4032) );
  NBUFFX2_RVT U4573 ( .A(n8077), .Y(pcpi_rs1[18]) );
  INVX1_RVT U4574 ( .A(n4242), .Y(n4853) );
  INVX1_RVT U4575 ( .A(n4785), .Y(n4034) );
  NBUFFX2_RVT U4576 ( .A(n6068), .Y(n4785) );
  NBUFFX2_RVT U4577 ( .A(n4035), .Y(n4037) );
  NBUFFX2_RVT U4578 ( .A(n4036), .Y(n4040) );
  NBUFFX2_RVT U4579 ( .A(n4037), .Y(n4041) );
  NBUFFX2_RVT U4580 ( .A(n4037), .Y(n4042) );
  NBUFFX2_RVT U4581 ( .A(n4038), .Y(n4043) );
  NBUFFX2_RVT U4582 ( .A(n4038), .Y(n4044) );
  AO222X1_RVT U4583 ( .A1(n4519), .A2(n6518), .A3(n4372), .A4(reg_out[14]), 
        .A5(alu_out_q[14]), .A6(n6063), .Y(n6711) );
  NBUFFX2_RVT U4584 ( .A(n7955), .Y(n4086) );
  NBUFFX2_RVT U4585 ( .A(n7955), .Y(n4569) );
  NBUFFX2_RVT U4586 ( .A(n7966), .Y(n4607) );
  NBUFFX2_RVT U4587 ( .A(n7966), .Y(n4608) );
  NBUFFX2_RVT U4588 ( .A(n7966), .Y(n4606) );
  NBUFFX2_RVT U4589 ( .A(n7965), .Y(n4576) );
  NBUFFX2_RVT U4590 ( .A(n7965), .Y(n4577) );
  NBUFFX2_RVT U4591 ( .A(n7964), .Y(n4575) );
  NBUFFX2_RVT U4592 ( .A(n7964), .Y(n4574) );
  NBUFFX2_RVT U4593 ( .A(n7964), .Y(n4573) );
  NBUFFX2_RVT U4594 ( .A(n7960), .Y(n4556) );
  NBUFFX2_RVT U4595 ( .A(n7960), .Y(n4557) );
  NBUFFX2_RVT U4596 ( .A(n7960), .Y(n4555) );
  XOR3X2_RVT U4597 ( .A1(decoded_imm[4]), .A2(reg_pc[4]), .A3(n7714), .Y(n7715) );
  NBUFFX2_RVT U4598 ( .A(n6310), .Y(n4650) );
  NAND4X1_RVT U4599 ( .A1(n6308), .A2(n6301), .A3(n8020), .A4(n8015), .Y(n6310) );
  INVX1_RVT U4600 ( .A(n5862), .Y(n5864) );
  NBUFFX2_RVT U4601 ( .A(n6712), .Y(n4045) );
  NBUFFX2_RVT U4602 ( .A(n6712), .Y(n4046) );
  NBUFFX2_RVT U4603 ( .A(n6712), .Y(n4047) );
  NBUFFX2_RVT U4604 ( .A(n8072), .Y(pcpi_rs1[26]) );
  XOR3X2_RVT U4605 ( .A1(decoded_imm[3]), .A2(reg_pc[3]), .A3(n7708), .Y(n7709) );
  NBUFFX2_RVT U4606 ( .A(n7957), .Y(n4049) );
  NBUFFX2_RVT U4607 ( .A(n4049), .Y(n4050) );
  NBUFFX2_RVT U4608 ( .A(n4049), .Y(n4051) );
  AO222X1_RVT U4609 ( .A1(latched_branch), .A2(n6504), .A3(n4370), .A4(
        reg_out[13]), .A5(alu_out_q[13]), .A6(n6063), .Y(n7957) );
  INVX1_RVT U4610 ( .A(n6178), .Y(n6169) );
  NAND4X1_RVT U4611 ( .A1(n6302), .A2(n6127), .A3(n4021), .A4(n8015), .Y(n6178) );
  NBUFFX2_RVT U4612 ( .A(n7963), .Y(n4550) );
  INVX1_RVT U4613 ( .A(n5854), .Y(n5856) );
  INVX0_RVT U4614 ( .A(n5883), .Y(n5875) );
  NOR2X0_RVT U4615 ( .A1(n4636), .A2(n4637), .Y(n4635) );
  NOR2X0_RVT U4616 ( .A1(n4636), .A2(n4637), .Y(n4543) );
  INVX1_RVT U4617 ( .A(n4807), .Y(n4809) );
  INVX1_RVT U4618 ( .A(n4807), .Y(n4808) );
  INVX1_RVT U4619 ( .A(n4543), .Y(n5521) );
  INVX1_RVT U4620 ( .A(n4635), .Y(n4544) );
  NBUFFX2_RVT U4621 ( .A(n7891), .Y(n4052) );
  NBUFFX2_RVT U4622 ( .A(n7891), .Y(n4053) );
  INVX1_RVT U4623 ( .A(n7891), .Y(n4322) );
  INVX1_RVT U4624 ( .A(n6168), .Y(n6167) );
  NBUFFX2_RVT U4625 ( .A(net27408), .Y(n4054) );
  NBUFFX2_RVT U4626 ( .A(net27408), .Y(n4055) );
  NBUFFX2_RVT U4627 ( .A(net29472), .Y(n4056) );
  NBUFFX2_RVT U4628 ( .A(net29471), .Y(n4057) );
  INVX1_RVT U4629 ( .A(net27408), .Y(net26624) );
  NBUFFX2_RVT U4630 ( .A(net26624), .Y(net29472) );
  INVX1_RVT U4631 ( .A(n6175), .Y(n6172) );
  NAND4X1_RVT U4632 ( .A1(n6309), .A2(n6127), .A3(n8015), .A4(n8020), .Y(n6175) );
  NAND3X0_RVT U4633 ( .A1(n6531), .A2(n6530), .A3(n7733), .Y(n6532) );
  NBUFFX2_RVT U4634 ( .A(n5208), .Y(n4058) );
  NBUFFX2_RVT U4635 ( .A(n5208), .Y(n4059) );
  NBUFFX2_RVT U4636 ( .A(n4058), .Y(n4060) );
  NBUFFX2_RVT U4637 ( .A(n4058), .Y(n4061) );
  NBUFFX2_RVT U4638 ( .A(n4059), .Y(n4062) );
  NBUFFX2_RVT U4639 ( .A(n4059), .Y(n4063) );
  INVX1_RVT U4640 ( .A(n6416), .Y(n6417) );
  INVX1_RVT U4641 ( .A(n7823), .Y(n5833) );
  INVX1_RVT U4642 ( .A(n6314), .Y(n6315) );
  NAND4X1_RVT U4643 ( .A1(n6309), .A2(n6308), .A3(n8015), .A4(n4021), .Y(n6314) );
  NBUFFX2_RVT U4644 ( .A(n7886), .Y(n4064) );
  NBUFFX2_RVT U4645 ( .A(n7886), .Y(n4065) );
  NBUFFX2_RVT U4646 ( .A(n7886), .Y(n4066) );
  NBUFFX2_RVT U4647 ( .A(n7886), .Y(n4067) );
  NBUFFX2_RVT U4648 ( .A(n7886), .Y(n4068) );
  NBUFFX2_RVT U4649 ( .A(n6351), .Y(n4703) );
  NBUFFX2_RVT U4650 ( .A(n6160), .Y(n4772) );
  INVX1_RVT U4651 ( .A(n6160), .Y(n6084) );
  NBUFFX2_RVT U4652 ( .A(n6160), .Y(n4771) );
  NBUFFX2_RVT U4653 ( .A(n6160), .Y(n4770) );
  NBUFFX2_RVT U4654 ( .A(n6350), .Y(n4693) );
  INVX1_RVT U4655 ( .A(n6350), .Y(n6356) );
  NBUFFX2_RVT U4656 ( .A(n6350), .Y(n4691) );
  NBUFFX2_RVT U4657 ( .A(n6350), .Y(n4692) );
  INVX0_RVT U4658 ( .A(n5892), .Y(n5884) );
  NBUFFX2_RVT U4659 ( .A(n6311), .Y(n4670) );
  INVX1_RVT U4660 ( .A(n6311), .Y(n6313) );
  NAND4X1_RVT U4661 ( .A1(n8015), .A2(n6302), .A3(n4021), .A4(n6308), .Y(n6311) );
  INVX0_RVT U4662 ( .A(n8025), .Y(n4069) );
  NBUFFX2_RVT U4663 ( .A(n6306), .Y(n4658) );
  INVX1_RVT U4664 ( .A(n6306), .Y(n6307) );
  NAND4X1_RVT U4665 ( .A1(n6308), .A2(n6300), .A3(n4021), .A4(n8015), .Y(n6306) );
  NBUFFX2_RVT U4666 ( .A(n6177), .Y(n4723) );
  INVX1_RVT U4667 ( .A(n6177), .Y(n6170) );
  NAND4X1_RVT U4668 ( .A1(n6300), .A2(n6127), .A3(n4021), .A4(n8015), .Y(n6177) );
  NOR2X0_RVT U4669 ( .A1(n4798), .A2(n7988), .Y(n4070) );
  INVX1_RVT U4670 ( .A(n4220), .Y(n4188) );
  INVX1_RVT U4671 ( .A(n4220), .Y(n4631) );
  INVX1_RVT U4672 ( .A(n4219), .Y(n4797) );
  OA21X1_RVT U4673 ( .A1(count_instr[51]), .A2(n5978), .A3(n5977), .Y(n3842)
         );
  OA21X1_RVT U4674 ( .A1(count_instr[50]), .A2(n5959), .A3(n5958), .Y(n3843)
         );
  OA21X1_RVT U4675 ( .A1(count_instr[49]), .A2(n5945), .A3(n5944), .Y(n3844)
         );
  INVX1_RVT U4676 ( .A(n6016), .Y(n6018) );
  OA21X1_RVT U4677 ( .A1(count_instr[48]), .A2(n5936), .A3(n5935), .Y(n3845)
         );
  INVX1_RVT U4678 ( .A(n6839), .Y(n6837) );
  INVX1_RVT U4679 ( .A(n6836), .Y(n6834) );
  INVX1_RVT U4680 ( .A(n6007), .Y(n6009) );
  OA21X1_RVT U4681 ( .A1(count_instr[47]), .A2(n5927), .A3(n5926), .Y(n3846)
         );
  INVX1_RVT U4682 ( .A(n4208), .Y(n6827) );
  INVX1_RVT U4683 ( .A(n5991), .Y(n5993) );
  XOR3X2_RVT U4684 ( .A1(pcpi_rs1[29]), .A2(decoded_imm[29]), .A3(net25873), 
        .Y(net26109) );
  OA21X1_RVT U4685 ( .A1(count_instr[46]), .A2(n5918), .A3(n5917), .Y(n3847)
         );
  INVX1_RVT U4686 ( .A(n5982), .Y(n5984) );
  INVX1_RVT U4687 ( .A(n6808), .Y(n6806) );
  INVX1_RVT U4688 ( .A(n6805), .Y(n6803) );
  NBUFFX2_RVT U4689 ( .A(n7949), .Y(n4604) );
  NBUFFX2_RVT U4690 ( .A(n7949), .Y(n4605) );
  NBUFFX2_RVT U4691 ( .A(n7949), .Y(n4082) );
  INVX1_RVT U4692 ( .A(n6791), .Y(n6789) );
  INVX1_RVT U4693 ( .A(n6802), .Y(n6792) );
  INVX1_RVT U4694 ( .A(n6788), .Y(n6786) );
  OAI21X1_RVT U4695 ( .A1(n4957), .A2(net26526), .A3(n4056), .Y(n4958) );
  OA21X1_RVT U4696 ( .A1(count_instr[45]), .A2(n5912), .A3(n5911), .Y(n3848)
         );
  INVX1_RVT U4697 ( .A(n6782), .Y(n6780) );
  INVX1_RVT U4698 ( .A(n5967), .Y(n5969) );
  XOR2X1_RVT U4699 ( .A1(n5684), .A2(reg_pc[25]), .Y(n5688) );
  OAI21X1_RVT U4700 ( .A1(n4929), .A2(net26558), .A3(net29471), .Y(n4930) );
  INVX1_RVT U4701 ( .A(n6779), .Y(n6717) );
  OA21X1_RVT U4702 ( .A1(count_instr[44]), .A2(n5906), .A3(n5905), .Y(n3849)
         );
  INVX1_RVT U4703 ( .A(n5946), .Y(n5948) );
  OA21X1_RVT U4704 ( .A1(count_instr[43]), .A2(n5897), .A3(n5896), .Y(n3850)
         );
  INVX1_RVT U4705 ( .A(n7840), .Y(n7841) );
  AO222X1_RVT U4706 ( .A1(n4517), .A2(n5523), .A3(n4371), .A4(reg_out[25]), 
        .A5(alu_out_q[25]), .A6(n4549), .Y(n6713) );
  INVX1_RVT U4707 ( .A(n5940), .Y(n5942) );
  INVX1_RVT U4708 ( .A(n6519), .Y(n6491) );
  OA21X1_RVT U4709 ( .A1(count_instr[42]), .A2(n5891), .A3(n5890), .Y(n3851)
         );
  INVX1_RVT U4710 ( .A(n6490), .Y(n6374) );
  INVX1_RVT U4711 ( .A(n6373), .Y(n6345) );
  INVX1_RVT U4712 ( .A(n6536), .Y(n6520) );
  INVX1_RVT U4713 ( .A(n5998), .Y(n6000) );
  INVX1_RVT U4714 ( .A(n5931), .Y(n5933) );
  AO222X1_RVT U4715 ( .A1(n4517), .A2(n6083), .A3(n4371), .A4(reg_out[22]), 
        .A5(alu_out_q[22]), .A6(n4098), .Y(n6526) );
  INVX1_RVT U4716 ( .A(n6344), .Y(n6304) );
  OA21X1_RVT U4717 ( .A1(count_instr[41]), .A2(n5882), .A3(n5881), .Y(n3852)
         );
  INVX1_RVT U4718 ( .A(n5963), .Y(n5966) );
  INVX1_RVT U4719 ( .A(n5960), .Y(n5962) );
  INVX1_RVT U4720 ( .A(n7842), .Y(n7843) );
  INVX1_RVT U4721 ( .A(n5979), .Y(n5981) );
  INVX1_RVT U4722 ( .A(n6001), .Y(n5975) );
  OA21X1_RVT U4723 ( .A1(n5903), .A2(count_instr[11]), .A3(n5902), .Y(n3882)
         );
  INVX1_RVT U4724 ( .A(n6276), .Y(n6219) );
  INVX1_RVT U4725 ( .A(n7838), .Y(n7839) );
  OA22X1_RVT U4726 ( .A1(n4020), .A2(n5730), .A3(n4241), .A4(net16327), .Y(
        n5733) );
  OA21X1_RVT U4727 ( .A1(count_instr[40]), .A2(n5873), .A3(n5872), .Y(n3853)
         );
  AO222X1_RVT U4728 ( .A1(n4517), .A2(n6502), .A3(n4371), .A4(reg_out[19]), 
        .A5(alu_out_q[19]), .A6(n4098), .Y(n7956) );
  INVX1_RVT U4729 ( .A(n6221), .Y(n6180) );
  OA21X1_RVT U4730 ( .A1(n5888), .A2(count_instr[10]), .A3(n5887), .Y(n3883)
         );
  INVX1_RVT U4731 ( .A(n5880), .Y(n5882) );
  AO222X1_RVT U4732 ( .A1(n4517), .A2(n6162), .A3(n4371), .A4(reg_out[17]), 
        .A5(alu_out_q[17]), .A6(n4098), .Y(n6523) );
  INVX1_RVT U4733 ( .A(n6104), .Y(n6079) );
  OA21X1_RVT U4734 ( .A1(count_instr[39]), .A2(n5864), .A3(n5863), .Y(n3854)
         );
  NBUFFX2_RVT U4735 ( .A(n6524), .Y(n4566) );
  INVX1_RVT U4736 ( .A(n5901), .Y(n5903) );
  NBUFFX2_RVT U4737 ( .A(n6524), .Y(n4567) );
  INVX1_RVT U4738 ( .A(n6047), .Y(n6020) );
  INVX1_RVT U4739 ( .A(n6078), .Y(n6061) );
  INVX1_RVT U4740 ( .A(n6060), .Y(n6048) );
  INVX1_RVT U4741 ( .A(n5994), .Y(n5986) );
  OA21X1_RVT U4742 ( .A1(n5949), .A2(count_cycle[22]), .A3(n5951), .Y(N940) );
  OA21X1_RVT U4743 ( .A1(n5879), .A2(count_instr[9]), .A3(n5878), .Y(n3884) );
  MUX21X1_RVT U4744 ( .A1(net30668), .A2(n5366), .S0(n4057), .Y(n3729) );
  INVX1_RVT U4745 ( .A(n6019), .Y(n6010) );
  INVX1_RVT U4746 ( .A(n5985), .Y(n5971) );
  NBUFFX2_RVT U4747 ( .A(n4646), .Y(n4108) );
  NBUFFX2_RVT U4748 ( .A(n4646), .Y(n4091) );
  NBUFFX2_RVT U4749 ( .A(n4789), .Y(n4071) );
  NBUFFX2_RVT U4750 ( .A(n4790), .Y(n4072) );
  NBUFFX2_RVT U4751 ( .A(n4732), .Y(n4073) );
  NBUFFX2_RVT U4752 ( .A(n4731), .Y(n4074) );
  OA21X1_RVT U4753 ( .A1(count_instr[38]), .A2(n5856), .A3(n5855), .Y(n3855)
         );
  NBUFFX2_RVT U4754 ( .A(n6462), .Y(n4075) );
  NBUFFX2_RVT U4755 ( .A(n4730), .Y(n4076) );
  INVX1_RVT U4756 ( .A(n5886), .Y(n5888) );
  NBUFFX2_RVT U4757 ( .A(n6158), .Y(n4527) );
  INVX1_RVT U4758 ( .A(n5949), .Y(n5938) );
  NBUFFX2_RVT U4759 ( .A(n6316), .Y(n4673) );
  NBUFFX2_RVT U4760 ( .A(n6316), .Y(n4672) );
  NBUFFX2_RVT U4761 ( .A(n4646), .Y(n4077) );
  NBUFFX2_RVT U4762 ( .A(n6316), .Y(n4674) );
  INVX1_RVT U4763 ( .A(n5515), .Y(n5517) );
  NBUFFX2_RVT U4764 ( .A(n6158), .Y(n4526) );
  AOI22X1_RVT U4765 ( .A1(n4524), .A2(n7938), .A3(n7937), .A4(n4638), .Y(n3666) );
  NBUFFX8_RVT U4766 ( .A(n6355), .Y(n4682) );
  NBUFFX2_RVT U4767 ( .A(n6358), .Y(n4702) );
  OA21X1_RVT U4768 ( .A1(n5870), .A2(count_instr[8]), .A3(n5869), .Y(n3885) );
  NBUFFX2_RVT U4769 ( .A(n6158), .Y(n4525) );
  INVX1_RVT U4770 ( .A(n5937), .Y(n5929) );
  OA22X1_RVT U4771 ( .A1(n8053), .A2(net30554), .A3(n7979), .A4(n7801), .Y(
        n6489) );
  INVX1_RVT U4772 ( .A(n5877), .Y(n5879) );
  OA21X1_RVT U4773 ( .A1(count_instr[37]), .A2(n5848), .A3(n5847), .Y(n3856)
         );
  NBUFFX2_RVT U4774 ( .A(n7958), .Y(n4588) );
  NBUFFX2_RVT U4775 ( .A(n6349), .Y(n4699) );
  NBUFFX2_RVT U4776 ( .A(n7958), .Y(n4587) );
  INVX0_RVT U4777 ( .A(n6617), .Y(n6675) );
  OA22X1_RVT U4778 ( .A1(reg_sh[2]), .A2(net30554), .A3(n7801), .A4(n8017), 
        .Y(n7803) );
  NBUFFX2_RVT U4779 ( .A(n7958), .Y(n4586) );
  OA21X1_RVT U4780 ( .A1(count_cycle[17]), .A2(n5907), .A3(n5909), .Y(N935) );
  OA21X1_RVT U4781 ( .A1(n5913), .A2(count_cycle[18]), .A3(n5915), .Y(N936) );
  NBUFFX2_RVT U4782 ( .A(n6349), .Y(n4697) );
  INVX1_RVT U4783 ( .A(n7801), .Y(n7684) );
  INVX1_RVT U4784 ( .A(n4513), .Y(n7937) );
  INVX1_RVT U4785 ( .A(n6351), .Y(n6358) );
  NBUFFX2_RVT U4786 ( .A(n6351), .Y(n4705) );
  INVX4_RVT U4787 ( .A(n6348), .Y(n6355) );
  NBUFFX2_RVT U4788 ( .A(n6225), .Y(n4675) );
  OAI21X1_RVT U4789 ( .A1(n4903), .A2(net26587), .A3(n4056), .Y(n4904) );
  NBUFFX2_RVT U4790 ( .A(n6174), .Y(n4755) );
  NBUFFX2_RVT U4791 ( .A(n6716), .Y(n4738) );
  AO222X1_RVT U4792 ( .A1(pcpi_rs2[5]), .A2(net29438), .A3(net23989), .A4(
        decoded_imm[5]), .A5(n7202), .A6(net30423), .Y(n3925) );
  NBUFFX2_RVT U4793 ( .A(n7959), .Y(n4109) );
  NBUFFX2_RVT U4794 ( .A(n6176), .Y(n4749) );
  NBUFFX2_RVT U4795 ( .A(n6716), .Y(n4737) );
  NBUFFX2_RVT U4796 ( .A(n6715), .Y(n4744) );
  NBUFFX2_RVT U4797 ( .A(n6715), .Y(n4743) );
  INVX1_RVT U4798 ( .A(n7802), .Y(n7254) );
  OAI21X1_RVT U4799 ( .A1(n7920), .A2(n7921), .A3(n7919), .Y(n4513) );
  AO222X1_RVT U4800 ( .A1(pcpi_rs2[22]), .A2(net29438), .A3(net30049), .A4(
        decoded_imm[22]), .A5(n7275), .A6(net30423), .Y(n3908) );
  INVX1_RVT U4801 ( .A(n7204), .Y(n7205) );
  INVX1_RVT U4802 ( .A(net23637), .Y(net23636) );
  NBUFFX2_RVT U4803 ( .A(n6174), .Y(n4754) );
  NBUFFX2_RVT U4804 ( .A(n6174), .Y(n4756) );
  OA21X1_RVT U4805 ( .A1(n5861), .A2(count_instr[7]), .A3(n5860), .Y(n3886) );
  NBUFFX2_RVT U4806 ( .A(n6716), .Y(n4736) );
  AO222X1_RVT U4807 ( .A1(n4519), .A2(n6040), .A3(n4371), .A4(reg_out[12]), 
        .A5(n4548), .A6(alu_out_q[12]), .Y(n7958) );
  NBUFFX2_RVT U4808 ( .A(n6176), .Y(n4750) );
  NBUFFX2_RVT U4809 ( .A(n6176), .Y(n4748) );
  AO21X1_RVT U4810 ( .A1(reg_pc[3]), .A2(net30310), .A3(n5581), .Y(n5604) );
  NBUFFX2_RVT U4811 ( .A(n6715), .Y(n4742) );
  AND2X1_RVT U4812 ( .A1(n5928), .A2(count_cycle[20]), .Y(n5937) );
  INVX1_RVT U4813 ( .A(n7909), .Y(n7907) );
  NBUFFX2_RVT U4814 ( .A(n4110), .Y(n4584) );
  MUX21X1_RVT U4815 ( .A1(mem_wordsize[0]), .A2(n5241), .S0(n7909), .Y(n3674)
         );
  XOR3X2_RVT U4816 ( .A1(decoded_imm[10]), .A2(reg_pc[10]), .A3(n7748), .Y(
        n7749) );
  INVX1_RVT U4817 ( .A(n5102), .Y(n6776) );
  AO21X1_RVT U4818 ( .A1(n7930), .A2(n8055), .A3(n7929), .Y(n7931) );
  OA21X1_RVT U4819 ( .A1(count_instr[36]), .A2(n5842), .A3(n5841), .Y(n3857)
         );
  OR2X1_RVT U4820 ( .A1(n4165), .A2(n7797), .Y(n4164) );
  INVX1_RVT U4821 ( .A(net23329), .Y(net30423) );
  INVX1_RVT U4822 ( .A(net23329), .Y(net30424) );
  INVX1_RVT U4823 ( .A(n5868), .Y(n5870) );
  OR2X1_RVT U4824 ( .A1(n4171), .A2(n7797), .Y(n4170) );
  INVX1_RVT U4825 ( .A(net23329), .Y(net30422) );
  AO222X1_RVT U4826 ( .A1(n4517), .A2(n6152), .A3(n4370), .A4(reg_out[11]), 
        .A5(alu_out_q[11]), .A6(n4097), .Y(n7959) );
  OR2X1_RVT U4827 ( .A1(n4162), .A2(n7797), .Y(n4161) );
  OR2X1_RVT U4828 ( .A1(n4168), .A2(n7797), .Y(n4167) );
  INVX1_RVT U4829 ( .A(n5919), .Y(n5914) );
  OA21X1_RVT U4830 ( .A1(n5892), .A2(count_cycle[15]), .A3(n5894), .Y(N933) );
  INVX1_RVT U4831 ( .A(n5913), .Y(n5908) );
  AO22X1_RVT U4832 ( .A1(count_instr[41]), .A2(n4310), .A3(n4634), .A4(
        pcpi_rs1[9]), .Y(n7742) );
  AO22X1_RVT U4833 ( .A1(n8083), .A2(net30389), .A3(n8088), .A4(net24129), .Y(
        n5172) );
  INVX1_RVT U4834 ( .A(net30307), .Y(net30309) );
  INVX1_RVT U4835 ( .A(net30307), .Y(net30310) );
  AO22X1_RVT U4836 ( .A1(net30690), .A2(net30389), .A3(net25786), .A4(net23007), .Y(net25784) );
  AO22X1_RVT U4837 ( .A1(reg_pc[17]), .A2(n4068), .A3(n4093), .A4(n7872), .Y(
        n3780) );
  AOI22X1_RVT U4838 ( .A1(net30389), .A2(pcpi_rs1[17]), .A3(net30609), .A4(
        pcpi_rs1[14]), .Y(n5049) );
  AO22X1_RVT U4839 ( .A1(pcpi_rs1[10]), .A2(net30390), .A3(net26389), .A4(
        net29607), .Y(net26388) );
  INVX1_RVT U4840 ( .A(n7525), .Y(n4354) );
  INVX1_RVT U4841 ( .A(n5846), .Y(n5848) );
  OA21X1_RVT U4842 ( .A1(n5853), .A2(count_instr[5]), .A3(n5852), .Y(n3888) );
  INVX1_RVT U4843 ( .A(n7525), .Y(n4353) );
  INVX1_RVT U4844 ( .A(n7525), .Y(n4355) );
  AO22X1_RVT U4845 ( .A1(n8087), .A2(net30389), .A3(net25815), .A4(net23007), 
        .Y(net25813) );
  NBUFFX2_RVT U4846 ( .A(n7961), .Y(n4110) );
  NBUFFX2_RVT U4847 ( .A(n7961), .Y(n4583) );
  NBUFFX2_RVT U4848 ( .A(n4111), .Y(n4582) );
  INVX1_RVT U4849 ( .A(n5907), .Y(n5899) );
  AO22X1_RVT U4850 ( .A1(net30702), .A2(net30389), .A3(net25844), .A4(net23007), .Y(net25842) );
  OA21X1_RVT U4851 ( .A1(n5883), .A2(count_cycle[14]), .A3(n5885), .Y(N932) );
  NBUFFX2_RVT U4852 ( .A(net23989), .Y(net30048) );
  NBUFFX2_RVT U4853 ( .A(net23989), .Y(net30049) );
  AO222X1_RVT U4854 ( .A1(n4518), .A2(n6157), .A3(n4372), .A4(reg_out[10]), 
        .A5(alu_out_q[10]), .A6(n4098), .Y(n7960) );
  OR2X1_RVT U4855 ( .A1(n4055), .A2(n5530), .Y(n5102) );
  AND2X1_RVT U4856 ( .A1(n7925), .A2(n8047), .Y(n7930) );
  INVX0_RVT U4857 ( .A(net23989), .Y(net26650) );
  AND2X1_RVT U4858 ( .A1(n5898), .A2(count_cycle[16]), .Y(n5907) );
  INVX1_RVT U4859 ( .A(n7901), .Y(n7903) );
  INVX1_RVT U4860 ( .A(n7703), .Y(n7788) );
  OA22X1_RVT U4861 ( .A1(n8054), .A2(n7703), .A3(n4020), .A4(n7702), .Y(n7705)
         );
  INVX1_RVT U4862 ( .A(n7703), .Y(n4310) );
  INVX1_RVT U4863 ( .A(n6455), .Y(n6459) );
  INVX1_RVT U4864 ( .A(n5898), .Y(n5893) );
  NBUFFX2_RVT U4865 ( .A(n6714), .Y(n4581) );
  INVX1_RVT U4866 ( .A(n4870), .Y(n7927) );
  AO222X1_RVT U4867 ( .A1(n4518), .A2(n6500), .A3(n4370), .A4(reg_out[9]), 
        .A5(n6063), .A6(alu_out_q[9]), .Y(n7961) );
  AO22X1_RVT U4868 ( .A1(reg_pc[15]), .A2(n4064), .A3(n4811), .A4(n7870), .Y(
        n3782) );
  INVX1_RVT U4869 ( .A(n7703), .Y(n4311) );
  OA21X1_RVT U4870 ( .A1(n5874), .A2(count_cycle[13]), .A3(n5876), .Y(N931) );
  INVX1_RVT U4871 ( .A(net24496), .Y(net30307) );
  INVX1_RVT U4872 ( .A(n7916), .Y(n7889) );
  OA21X1_RVT U4873 ( .A1(n5865), .A2(count_cycle[12]), .A3(n5867), .Y(N930) );
  NBUFFX2_RVT U4874 ( .A(n4095), .Y(n4081) );
  INVX1_RVT U4875 ( .A(net24545), .Y(net30390) );
  NBUFFX2_RVT U4876 ( .A(n4112), .Y(n4093) );
  OA21X1_RVT U4877 ( .A1(n5857), .A2(count_cycle[11]), .A3(n5859), .Y(N929) );
  INVX1_RVT U4878 ( .A(net24545), .Y(net30391) );
  OA21X1_RVT U4879 ( .A1(count_cycle[10]), .A2(n5849), .A3(n5851), .Y(N928) );
  OA21X1_RVT U4880 ( .A1(n5843), .A2(count_cycle[9]), .A3(n5845), .Y(N927) );
  OR2X1_RVT U4881 ( .A1(n4324), .A2(net27439), .Y(n7938) );
  INVX1_RVT U4882 ( .A(n7836), .Y(n7837) );
  INVX1_RVT U4883 ( .A(n7815), .Y(n7905) );
  NBUFFX2_RVT U4884 ( .A(n7962), .Y(n4111) );
  INVX1_RVT U4885 ( .A(net24545), .Y(net30389) );
  AND2X1_RVT U4886 ( .A1(n4972), .A2(mem_rdata_word[7]), .Y(n5720) );
  AO22X1_RVT U4887 ( .A1(n4335), .A2(\cpuregs[25][10] ), .A3(n4409), .A4(
        \cpuregs[12][10] ), .Y(n5217) );
  AO22X1_RVT U4888 ( .A1(net22738), .A2(mem_rdata_q[23]), .A3(mem_rdata_q[10]), 
        .A4(n6130), .Y(n6036) );
  AO222X1_RVT U4889 ( .A1(n4517), .A2(n6498), .A3(n4371), .A4(reg_out[8]), 
        .A5(n6063), .A6(alu_out_q[8]), .Y(n7962) );
  INVX1_RVT U4890 ( .A(net22739), .Y(net22737) );
  AO22X1_RVT U4891 ( .A1(net22738), .A2(mem_rdata_q[21]), .A3(mem_rdata_q[8]), 
        .A4(n6130), .Y(n6121) );
  AO22X1_RVT U4892 ( .A1(n4066), .A2(reg_pc[13]), .A3(n7855), .A4(n7868), .Y(
        n3784) );
  AO22X1_RVT U4893 ( .A1(net22738), .A2(mem_rdata_q[22]), .A3(mem_rdata_q[9]), 
        .A4(n6130), .Y(n6038) );
  AO22X1_RVT U4894 ( .A1(n4335), .A2(\cpuregs[25][17] ), .A3(n4409), .A4(
        \cpuregs[12][17] ), .Y(n5107) );
  AO22X1_RVT U4895 ( .A1(n4336), .A2(\cpuregs[19][6] ), .A3(n4402), .A4(
        \cpuregs[14][6] ), .Y(n5055) );
  INVX0_RVT U4896 ( .A(n4356), .Y(n4313) );
  NOR2X0_RVT U4897 ( .A1(n6529), .A2(n4515), .Y(n7771) );
  AO22X1_RVT U4898 ( .A1(n8088), .A2(net24198), .A3(pcpi_rs1[9]), .A4(net24129), .Y(n5227) );
  INVX1_RVT U4899 ( .A(n7814), .Y(n5236) );
  AND3X1_RVT U4900 ( .A1(n7888), .A2(n7832), .A3(count_instr[4]), .Y(n5853) );
  OA21X1_RVT U4901 ( .A1(net22708), .A2(mem_do_prefetch), .A3(n7911), .Y(n7921) );
  AO22X1_RVT U4902 ( .A1(n8081), .A2(net24198), .A3(pcpi_rs1[16]), .A4(
        net24129), .Y(n5124) );
  AO21X1_RVT U4903 ( .A1(net25183), .A2(net22739), .A3(n8046), .Y(n6134) );
  INVX0_RVT U4904 ( .A(net24034), .Y(net26648) );
  AO22X1_RVT U4905 ( .A1(count_cycle[43]), .A2(n4259), .A3(count_instr[11]), 
        .A4(n4351), .Y(n7760) );
  OA21X1_RVT U4906 ( .A1(count_cycle[8]), .A2(n5830), .A3(n5832), .Y(N926) );
  OA21X1_RVT U4907 ( .A1(n5827), .A2(count_cycle[7]), .A3(n5829), .Y(N925) );
  OA22X1_RVT U4908 ( .A1(n8068), .A2(n7696), .A3(n4020), .A4(n7695), .Y(n7699)
         );
  NBUFFX2_RVT U4909 ( .A(n6714), .Y(n4095) );
  AO22X1_RVT U4910 ( .A1(net22738), .A2(mem_rdata_q[24]), .A3(mem_rdata_q[11]), 
        .A4(n6130), .Y(n6132) );
  AO22X1_RVT U4911 ( .A1(n4405), .A2(\cpuregs[29][13] ), .A3(n4402), .A4(
        \cpuregs[14][13] ), .Y(n5042) );
  AO22X1_RVT U4912 ( .A1(count_cycle[5]), .A2(n4356), .A3(count_instr[5]), 
        .A4(n4351), .Y(n7721) );
  AO22X1_RVT U4913 ( .A1(n4335), .A2(\cpuregs[25][12] ), .A3(n4416), .A4(
        \cpuregs[28][12] ), .Y(n6695) );
  NBUFFX2_RVT U4914 ( .A(n6761), .Y(n4426) );
  INVX1_RVT U4915 ( .A(n6692), .Y(n4410) );
  INVX1_RVT U4916 ( .A(n7846), .Y(n7848) );
  INVX1_RVT U4917 ( .A(net30554), .Y(net30386) );
  INVX1_RVT U4918 ( .A(n6585), .Y(n4404) );
  OA22X1_RVT U4919 ( .A1(n8003), .A2(n6528), .A3(n4241), .A4(net16303), .Y(
        n6531) );
  OA22X1_RVT U4920 ( .A1(net16372), .A2(n5530), .A3(net16540), .A4(net25875), 
        .Y(n5553) );
  NBUFFX2_RVT U4921 ( .A(n6366), .Y(n4579) );
  NBUFFX2_RVT U4922 ( .A(n7762), .Y(n4356) );
  NBUFFX2_RVT U4923 ( .A(n4113), .Y(n4094) );
  INVX1_RVT U4924 ( .A(n6528), .Y(n4352) );
  NBUFFX2_RVT U4925 ( .A(n6366), .Y(n4580) );
  INVX1_RVT U4926 ( .A(n6528), .Y(n4351) );
  NBUFFX2_RVT U4927 ( .A(n7762), .Y(n4357) );
  INVX1_RVT U4928 ( .A(net30598), .Y(net30608) );
  INVX1_RVT U4929 ( .A(n6585), .Y(n4402) );
  AND2X1_RVT U4930 ( .A1(resetn), .A2(n5833), .Y(n7855) );
  AO22X1_RVT U4931 ( .A1(n4333), .A2(\cpuregs[25][15] ), .A3(n4346), .A4(
        \cpuregs[20][15] ), .Y(n4991) );
  OR2X1_RVT U4932 ( .A1(n4325), .A2(n7820), .Y(n7821) );
  AO22X1_RVT U4933 ( .A1(n4334), .A2(\cpuregs[25][13] ), .A3(n4347), .A4(
        \cpuregs[20][13] ), .Y(n5031) );
  AO22X1_RVT U4934 ( .A1(n4335), .A2(\cpuregs[25][16] ), .A3(n4365), .A4(
        \cpuregs[8][16] ), .Y(n5663) );
  INVX1_RVT U4935 ( .A(n6692), .Y(n4408) );
  XNOR2X1_RVT U4936 ( .A1(n7887), .A2(n4237), .Y(n4252) );
  AO222X1_RVT U4937 ( .A1(n4632), .A2(reg_next_pc[12]), .A3(n4254), .A4(
        alu_out_q[12]), .A5(reg_out[12]), .A6(n4195), .Y(n7867) );
  AO222X1_RVT U4938 ( .A1(n4632), .A2(reg_next_pc[16]), .A3(n4254), .A4(
        alu_out_q[16]), .A5(reg_out[16]), .A6(n4195), .Y(n7871) );
  INVX1_RVT U4939 ( .A(net25875), .Y(net30625) );
  AO222X1_RVT U4940 ( .A1(n4797), .A2(reg_next_pc[19]), .A3(n4254), .A4(
        alu_out_q[19]), .A5(reg_out[19]), .A6(n4195), .Y(n7874) );
  INVX1_RVT U4941 ( .A(n6680), .Y(n4433) );
  INVX1_RVT U4942 ( .A(net23007), .Y(net22708) );
  INVX1_RVT U4943 ( .A(n6692), .Y(n4409) );
  NOR2X0_RVT U4944 ( .A1(net29419), .A2(n7826), .Y(n4537) );
  NOR2X0_RVT U4945 ( .A1(net29419), .A2(n7826), .Y(n7640) );
  NBUFFX2_RVT U4946 ( .A(n6761), .Y(n4425) );
  INVX1_RVT U4947 ( .A(n6680), .Y(n4431) );
  AO22X1_RVT U4948 ( .A1(n4388), .A2(\cpuregs[23][17] ), .A3(n4383), .A4(
        \cpuregs[16][17] ), .Y(n5114) );
  NBUFFX2_RVT U4949 ( .A(n6573), .Y(n4175) );
  INVX1_RVT U4950 ( .A(n6585), .Y(n4403) );
  INVX1_RVT U4951 ( .A(n5013), .Y(n4407) );
  NBUFFX2_RVT U4952 ( .A(n6211), .Y(n4793) );
  INVX1_RVT U4953 ( .A(n5849), .Y(n5844) );
  INVX1_RVT U4954 ( .A(n6680), .Y(n4432) );
  INVX1_RVT U4955 ( .A(n5857), .Y(n5850) );
  INVX1_RVT U4956 ( .A(n5013), .Y(n4406) );
  AO22X1_RVT U4957 ( .A1(n4337), .A2(\cpuregs[19][8] ), .A3(n4384), .A4(
        \cpuregs[16][8] ), .Y(n6651) );
  INVX1_RVT U4958 ( .A(net30598), .Y(net30609) );
  AO22X1_RVT U4959 ( .A1(n4333), .A2(\cpuregs[25][11] ), .A3(n6581), .A4(
        \cpuregs[6][11] ), .Y(n5349) );
  INVX1_RVT U4960 ( .A(n5874), .Y(n5866) );
  AO222X1_RVT U4961 ( .A1(n4519), .A2(n6512), .A3(n4372), .A4(reg_out[7]), 
        .A5(alu_out_q[7]), .A6(n6063), .Y(n6714) );
  AO22X1_RVT U4962 ( .A1(n4369), .A2(\cpuregs[5][3] ), .A3(n4384), .A4(
        \cpuregs[16][3] ), .Y(n5592) );
  INVX1_RVT U4963 ( .A(n5865), .Y(n5858) );
  NBUFFX2_RVT U4964 ( .A(n6366), .Y(n4578) );
  INVX1_RVT U4965 ( .A(n5013), .Y(n4405) );
  INVX1_RVT U4966 ( .A(n7696), .Y(n4259) );
  NBUFFX2_RVT U4967 ( .A(n6211), .Y(n4792) );
  NBUFFX2_RVT U4968 ( .A(n6211), .Y(n4794) );
  INVX1_RVT U4969 ( .A(n6528), .Y(n5718) );
  NBUFFX2_RVT U4970 ( .A(n7965), .Y(n4115) );
  NBUFFX2_RVT U4971 ( .A(n6456), .Y(n4539) );
  NBUFFX2_RVT U4972 ( .A(n6222), .Y(n4796) );
  NBUFFX2_RVT U4973 ( .A(n4791), .Y(n4795) );
  INVX1_RVT U4974 ( .A(n5830), .Y(n5828) );
  OAI22X1_RVT U4975 ( .A1(n6687), .A2(n4340), .A3(n4341), .A4(n4343), .Y(n4342) );
  NAND2X0_RVT U4976 ( .A1(n7933), .A2(n4531), .Y(net29607) );
  INVX1_RVT U4977 ( .A(n6720), .Y(n4411) );
  INVX1_RVT U4978 ( .A(n6756), .Y(n4451) );
  AND2X1_RVT U4979 ( .A1(n4199), .A2(n4200), .Y(n5857) );
  NBUFFX2_RVT U4980 ( .A(n6456), .Y(n4540) );
  INVX1_RVT U4981 ( .A(n5665), .Y(n4368) );
  NBUFFX2_RVT U4982 ( .A(n6456), .Y(n4541) );
  INVX1_RVT U4983 ( .A(n4806), .Y(n4325) );
  AO22X1_RVT U4984 ( .A1(n4373), .A2(\cpuregs[1][6] ), .A3(n4415), .A4(
        \cpuregs[28][6] ), .Y(n5062) );
  INVX1_RVT U4985 ( .A(n5843), .Y(n5831) );
  INVX1_RVT U4986 ( .A(n6591), .Y(n4337) );
  AO22X1_RVT U4987 ( .A1(n6645), .A2(\cpuregs[27][15] ), .A3(n4366), .A4(
        \cpuregs[8][15] ), .Y(n4983) );
  NBUFFX2_RVT U4988 ( .A(n5745), .Y(n4360) );
  INVX1_RVT U4989 ( .A(n6720), .Y(n4412) );
  INVX1_RVT U4990 ( .A(n6681), .Y(n4347) );
  INVX1_RVT U4991 ( .A(n6687), .Y(n4382) );
  AND2X1_RVT U4992 ( .A1(n4879), .A2(n4414), .Y(n4349) );
  AO222X1_RVT U4993 ( .A1(n4518), .A2(n6031), .A3(n4371), .A4(reg_out[6]), 
        .A5(alu_out_q[6]), .A6(n4098), .Y(n6366) );
  AND3X1_RVT U4994 ( .A1(n4294), .A2(instr_rdcycleh), .A3(n7983), .Y(n4258) );
  NBUFFX2_RVT U4995 ( .A(n7967), .Y(n4609) );
  NBUFFX2_RVT U4996 ( .A(n6412), .Y(n4246) );
  INVX1_RVT U4997 ( .A(n6658), .Y(n4388) );
  NBUFFX2_RVT U4998 ( .A(n7967), .Y(n4113) );
  INVX1_RVT U4999 ( .A(n6756), .Y(n4450) );
  OAI22X1_RVT U5000 ( .A1(n4343), .A2(n4298), .A3(n4943), .A4(n4299), .Y(n4297) );
  NBUFFX2_RVT U5001 ( .A(n5745), .Y(n4359) );
  INVX1_RVT U5002 ( .A(n5665), .Y(n4369) );
  INVX1_RVT U5003 ( .A(n4339), .Y(n4333) );
  INVX1_RVT U5004 ( .A(n6658), .Y(n4387) );
  INVX1_RVT U5005 ( .A(n6687), .Y(n4383) );
  NAND2X0_RVT U5006 ( .A1(n7933), .A2(n4531), .Y(net29606) );
  INVX1_RVT U5007 ( .A(n6681), .Y(n4348) );
  INVX1_RVT U5008 ( .A(n7917), .Y(n7817) );
  NBUFFX2_RVT U5009 ( .A(n5745), .Y(n4358) );
  INVX1_RVT U5010 ( .A(n6649), .Y(n4389) );
  MUX21X1_RVT U5011 ( .A1(alu_out_q[18]), .A2(n6940), .S0(n4801), .Y(n7873) );
  INVX1_RVT U5012 ( .A(n2539), .Y(n6363) );
  MUX21X1_RVT U5013 ( .A1(alu_out_q[24]), .A2(n6943), .S0(n4801), .Y(n7879) );
  INVX1_RVT U5014 ( .A(n6591), .Y(n4336) );
  INVX1_RVT U5015 ( .A(n7954), .Y(n4397) );
  INVX1_RVT U5016 ( .A(n7954), .Y(n4398) );
  INVX1_RVT U5017 ( .A(n6591), .Y(n4338) );
  INVX1_RVT U5018 ( .A(n2541), .Y(n6361) );
  MUX21X1_RVT U5019 ( .A1(alu_out_q[13]), .A2(n6937), .S0(n4801), .Y(n7868) );
  AND2X1_RVT U5020 ( .A1(n4199), .A2(n4136), .Y(n5865) );
  INVX1_RVT U5021 ( .A(n2538), .Y(n6371) );
  INVX1_RVT U5022 ( .A(n4943), .Y(n4420) );
  INVX1_RVT U5023 ( .A(n2537), .Y(n6369) );
  INVX1_RVT U5024 ( .A(n2540), .Y(n6370) );
  AO22X1_RVT U5025 ( .A1(decoded_imm[3]), .A2(net30496), .A3(decoded_imm_j[3]), 
        .A4(net30578), .Y(n6035) );
  AO22X1_RVT U5026 ( .A1(n4121), .A2(net30497), .A3(decoded_imm_j[2]), .A4(
        net30578), .Y(n6037) );
  MUX21X1_RVT U5027 ( .A1(alu_out_q[6]), .A2(n6930), .S0(n4801), .Y(n7861) );
  NAND2X0_RVT U5028 ( .A1(n7933), .A2(n4531), .Y(net23007) );
  INVX1_RVT U5029 ( .A(n4339), .Y(n4335) );
  AND2X1_RVT U5030 ( .A1(n4879), .A2(n4414), .Y(n4350) );
  AO22X1_RVT U5031 ( .A1(n4361), .A2(\cpuregs[11][15] ), .A3(n4434), .A4(
        \cpuregs[10][15] ), .Y(n4995) );
  AND2X1_RVT U5032 ( .A1(n4199), .A2(n4135), .Y(n5874) );
  INVX1_RVT U5033 ( .A(n4943), .Y(n4419) );
  INVX1_RVT U5034 ( .A(n6756), .Y(n4449) );
  MUX21X1_RVT U5035 ( .A1(alu_out_q[9]), .A2(n6934), .S0(n4801), .Y(n7864) );
  INVX1_RVT U5036 ( .A(n6720), .Y(n4413) );
  MUX21X1_RVT U5037 ( .A1(alu_out_q[7]), .A2(n6931), .S0(n4799), .Y(n7862) );
  OAI22X1_RVT U5038 ( .A1(n4343), .A2(n4318), .A3(n5665), .A4(n4319), .Y(n4317) );
  INVX1_RVT U5039 ( .A(n6681), .Y(n4346) );
  INVX0_RVT U5040 ( .A(n6687), .Y(n4384) );
  INVX1_RVT U5041 ( .A(n5665), .Y(n4367) );
  INVX1_RVT U5042 ( .A(n6658), .Y(n4386) );
  INVX1_RVT U5043 ( .A(net25183), .Y(net22738) );
  INVX1_RVT U5044 ( .A(n4943), .Y(n4421) );
  INVX1_RVT U5045 ( .A(n4339), .Y(n4334) );
  OR2X1_RVT U5046 ( .A1(n4291), .A2(n4241), .Y(net30554) );
  AND2X1_RVT U5047 ( .A1(n4266), .A2(n6187), .Y(n6142) );
  AO22X1_RVT U5048 ( .A1(\cpuregs[21][29] ), .A2(n4447), .A3(\cpuregs[17][29] ), .A4(n4493), .Y(n7347) );
  INVX1_RVT U5049 ( .A(n6676), .Y(n4365) );
  INVX1_RVT U5050 ( .A(n6676), .Y(n4364) );
  NBUFFX2_RVT U5051 ( .A(n6420), .Y(n4247) );
  INVX1_RVT U5052 ( .A(n4343), .Y(n4272) );
  INVX1_RVT U5053 ( .A(n5750), .Y(n4416) );
  INVX1_RVT U5054 ( .A(n5821), .Y(n5819) );
  AO222X1_RVT U5055 ( .A1(n8039), .A2(n4519), .A3(n4370), .A4(reg_out[2]), 
        .A5(alu_out_q[2]), .A6(n4098), .Y(n7966) );
  AO222X1_RVT U5056 ( .A1(n4519), .A2(n6494), .A3(n4370), .A4(reg_out[4]), 
        .A5(alu_out_q[4]), .A6(n4098), .Y(n7964) );
  AO21X1_RVT U5057 ( .A1(\cpuregs[16][4] ), .A2(n7227), .A3(n6433), .Y(n6450)
         );
  NBUFFX2_RVT U5058 ( .A(n5052), .Y(n4392) );
  AND2X1_RVT U5059 ( .A1(n4197), .A2(n4198), .Y(n5843) );
  AO21X1_RVT U5060 ( .A1(\cpuregs[28][1] ), .A2(n7229), .A3(n6321), .Y(n6338)
         );
  INVX1_RVT U5061 ( .A(n5750), .Y(n4417) );
  AO222X1_RVT U5062 ( .A1(n4518), .A2(n6505), .A3(n4372), .A4(reg_out[3]), 
        .A5(alu_out_q[3]), .A6(n4549), .Y(n7965) );
  INVX1_RVT U5063 ( .A(n7648), .Y(n7652) );
  AO22X1_RVT U5064 ( .A1(\cpuregs[6][6] ), .A2(n4459), .A3(\cpuregs[30][6] ), 
        .A4(n4502), .Y(n7219) );
  INVX1_RVT U5065 ( .A(n5827), .Y(n5825) );
  NBUFFX2_RVT U5066 ( .A(n6557), .Y(n4245) );
  INVX1_RVT U5067 ( .A(n6586), .Y(n4374) );
  INVX1_RVT U5068 ( .A(n6751), .Y(n4363) );
  NBUFFX2_RVT U5069 ( .A(n6726), .Y(n4442) );
  AND2X2_RVT U5070 ( .A1(n4971), .A2(n4153), .Y(n4320) );
  AO21X1_RVT U5071 ( .A1(\cpuregs[20][2] ), .A2(n7233), .A3(n7232), .Y(n7250)
         );
  INVX1_RVT U5072 ( .A(n6420), .Y(n6412) );
  AO222X1_RVT U5073 ( .A1(reg_pc[1]), .A2(n4519), .A3(n4548), .A4(alu_out_q[1]), .A5(n4371), .A6(reg_out[1]), .Y(n7967) );
  INVX1_RVT U5074 ( .A(n5292), .Y(n4855) );
  NBUFFX2_RVT U5075 ( .A(n6686), .Y(n4435) );
  AO22X1_RVT U5076 ( .A1(\cpuregs[5][31] ), .A2(n4478), .A3(\cpuregs[19][31] ), 
        .A4(n4499), .Y(n6984) );
  AND2X1_RVT U5077 ( .A1(instr_jal), .A2(n4266), .Y(net30578) );
  NBUFFX2_RVT U5078 ( .A(n6192), .Y(n4276) );
  INVX1_RVT U5079 ( .A(n6751), .Y(n4362) );
  AO222X1_RVT U5080 ( .A1(n4519), .A2(n6155), .A3(n4372), .A4(reg_out[5]), 
        .A5(alu_out_q[5]), .A6(n4097), .Y(n7963) );
  NOR2X0_RVT U5081 ( .A1(n4250), .A2(n4251), .Y(net24198) );
  INVX1_RVT U5082 ( .A(n6586), .Y(n4373) );
  NBUFFX2_RVT U5083 ( .A(n6726), .Y(n4440) );
  AO222X1_RVT U5084 ( .A1(n8093), .A2(n8035), .A3(net16466), .A4(pcpi_rs2[1]), 
        .A5(n7648), .A6(n7654), .Y(n5412) );
  NBUFFX2_RVT U5085 ( .A(n5052), .Y(n4394) );
  INVX0_RVT U5086 ( .A(n4343), .Y(n4271) );
  NBUFFX2_RVT U5087 ( .A(n6686), .Y(n4436) );
  INVX1_RVT U5088 ( .A(n6751), .Y(n4361) );
  INVX1_RVT U5089 ( .A(n7641), .Y(n7642) );
  NOR2X0_RVT U5090 ( .A1(n5954), .A2(n4266), .Y(N375) );
  INVX1_RVT U5091 ( .A(n7621), .Y(n7625) );
  NBUFFX2_RVT U5092 ( .A(n6726), .Y(n4441) );
  AO22X1_RVT U5093 ( .A1(n6645), .A2(\cpuregs[27][9] ), .A3(n4486), .A4(
        \cpuregs[24][9] ), .Y(n4894) );
  INVX1_RVT U5094 ( .A(n6676), .Y(n4366) );
  INVX1_RVT U5095 ( .A(n4343), .Y(n4273) );
  INVX1_RVT U5096 ( .A(n5750), .Y(n4415) );
  AO21X1_RVT U5097 ( .A1(n7233), .A2(\cpuregs[20][0] ), .A3(n6467), .Y(n6485)
         );
  AND2X1_RVT U5098 ( .A1(n7900), .A2(n7977), .Y(n7899) );
  NOR2X0_RVT U5099 ( .A1(n4250), .A2(n4251), .Y(net30560) );
  INVX1_RVT U5100 ( .A(n6557), .Y(n4196) );
  NBUFFX2_RVT U5101 ( .A(n5052), .Y(n4393) );
  NBUFFX2_RVT U5102 ( .A(n6686), .Y(n4434) );
  OR2X1_RVT U5103 ( .A1(n4020), .A2(net16308), .Y(n7691) );
  INVX1_RVT U5104 ( .A(n6586), .Y(n4375) );
  AO21X1_RVT U5105 ( .A1(\cpuregs[12][3] ), .A2(n4829), .A3(n4841), .Y(n4842)
         );
  NBUFFX2_RVT U5106 ( .A(n7452), .Y(n4459) );
  INVX1_RVT U5107 ( .A(n7386), .Y(n4512) );
  NBUFFX2_RVT U5108 ( .A(n6128), .Y(n4240) );
  OR4X1_RVT U5109 ( .A1(mem_rdata[13]), .A2(mem_rdata[14]), .A3(mem_rdata[12]), 
        .A4(n4544), .Y(n4645) );
  NBUFFX2_RVT U5110 ( .A(n7468), .Y(n4464) );
  INVX1_RVT U5111 ( .A(n7370), .Y(n4456) );
  INVX1_RVT U5112 ( .A(n6468), .Y(n4489) );
  INVX1_RVT U5113 ( .A(n7420), .Y(n4508) );
  INVX1_RVT U5114 ( .A(n7457), .Y(n4498) );
  INVX1_RVT U5115 ( .A(n7421), .Y(n4497) );
  INVX1_RVT U5116 ( .A(n7485), .Y(n4289) );
  XOR2X1_RVT U5117 ( .A1(instr_sub), .A2(pcpi_rs2[3]), .Y(n7660) );
  INVX1_RVT U5118 ( .A(net26087), .Y(n4214) );
  INVX1_RVT U5119 ( .A(n7440), .Y(n4471) );
  INVX1_RVT U5120 ( .A(n7439), .Y(n4475) );
  INVX1_RVT U5121 ( .A(n7457), .Y(n4499) );
  INVX1_RVT U5122 ( .A(n7427), .Y(n4504) );
  NBUFFX2_RVT U5123 ( .A(n7479), .Y(n4478) );
  INVX1_RVT U5124 ( .A(n6747), .Y(n4486) );
  INVX1_RVT U5125 ( .A(n7445), .Y(n4484) );
  NBUFFX2_RVT U5126 ( .A(n7452), .Y(n4460) );
  INVX1_RVT U5127 ( .A(n7605), .Y(n7609) );
  NBUFFX2_RVT U5128 ( .A(n7479), .Y(n4477) );
  INVX1_RVT U5129 ( .A(n7410), .Y(n4502) );
  NBUFFX2_RVT U5130 ( .A(n7452), .Y(n4458) );
  INVX1_RVT U5131 ( .A(n7429), .Y(n4453) );
  INVX1_RVT U5132 ( .A(n6550), .Y(n6551) );
  INVX1_RVT U5133 ( .A(n6468), .Y(n4490) );
  INVX1_RVT U5134 ( .A(n7659), .Y(n7663) );
  INVX1_RVT U5135 ( .A(n7386), .Y(n4511) );
  NBUFFX2_RVT U5136 ( .A(n7387), .Y(n4448) );
  INVX1_RVT U5137 ( .A(N282), .Y(n6033) );
  INVX1_RVT U5138 ( .A(n7429), .Y(n4452) );
  INVX1_RVT U5139 ( .A(n7343), .Y(n4439) );
  INVX1_RVT U5140 ( .A(n6747), .Y(n4487) );
  INVX1_RVT U5141 ( .A(n7352), .Y(n4465) );
  INVX1_RVT U5142 ( .A(n7343), .Y(n4437) );
  INVX1_RVT U5143 ( .A(n7415), .Y(n4470) );
  INVX1_RVT U5144 ( .A(n7669), .Y(n7673) );
  INVX1_RVT U5145 ( .A(n7933), .Y(n5234) );
  INVX1_RVT U5146 ( .A(n7547), .Y(n7551) );
  AO22X1_RVT U5147 ( .A1(n7830), .A2(n8063), .A3(n7829), .A4(count_instr[3]), 
        .Y(n7831) );
  INVX1_RVT U5148 ( .A(n7352), .Y(n4467) );
  INVX1_RVT U5149 ( .A(n7485), .Y(n4287) );
  XOR2X1_RVT U5150 ( .A1(n4069), .A2(pcpi_rs2[18]), .Y(n6242) );
  NBUFFX8_RVT U5151 ( .A(n7603), .Y(n7658) );
  INVX1_RVT U5152 ( .A(n7439), .Y(n4474) );
  INVX1_RVT U5153 ( .A(n7484), .Y(n4277) );
  INVX1_RVT U5154 ( .A(n7370), .Y(n4455) );
  INVX1_RVT U5155 ( .A(n7415), .Y(n4469) );
  INVX1_RVT U5156 ( .A(n7388), .Y(n4284) );
  XOR2X1_RVT U5157 ( .A1(n4610), .A2(pcpi_rs2[30]), .Y(n7496) );
  INVX1_RVT U5158 ( .A(n7410), .Y(n4503) );
  NBUFFX2_RVT U5159 ( .A(n7387), .Y(n4446) );
  INVX1_RVT U5160 ( .A(n7446), .Y(n4482) );
  INVX1_RVT U5161 ( .A(n6645), .Y(n4307) );
  INVX1_RVT U5162 ( .A(n7352), .Y(n4466) );
  INVX1_RVT U5163 ( .A(n7428), .Y(n4494) );
  INVX1_RVT U5164 ( .A(n7427), .Y(n4506) );
  INVX1_RVT U5165 ( .A(n7371), .Y(n4282) );
  XOR2X1_RVT U5166 ( .A1(n4610), .A2(pcpi_rs2[29]), .Y(n7505) );
  INVX1_RVT U5167 ( .A(n7447), .Y(n4445) );
  OA22X1_RVT U5168 ( .A1(n7986), .A2(n8087), .A3(n5458), .A4(n8088), .Y(n5459)
         );
  INVX1_RVT U5169 ( .A(n7447), .Y(n4444) );
  XOR2X1_RVT U5170 ( .A1(n4610), .A2(pcpi_rs2[27]), .Y(n7516) );
  INVX1_RVT U5171 ( .A(n7420), .Y(n4509) );
  XOR2X1_RVT U5172 ( .A1(n4610), .A2(pcpi_rs2[28]), .Y(n6400) );
  INVX1_RVT U5173 ( .A(n7574), .Y(n7578) );
  INVX1_RVT U5174 ( .A(n4220), .Y(n4630) );
  INVX1_RVT U5175 ( .A(n7388), .Y(n4283) );
  INVX1_RVT U5176 ( .A(n6747), .Y(n4488) );
  INVX1_RVT U5177 ( .A(n7538), .Y(n7542) );
  INVX1_RVT U5178 ( .A(n7446), .Y(n4480) );
  OAI21X1_RVT U5179 ( .A1(pcpi_rs2[16]), .A2(net16357), .A3(n5463), .Y(n5464)
         );
  INVX1_RVT U5180 ( .A(n7343), .Y(n4438) );
  XOR2X1_RVT U5181 ( .A1(n4610), .A2(pcpi_rs2[31]), .Y(n5130) );
  INVX1_RVT U5182 ( .A(n7428), .Y(n4492) );
  INVX0_RVT U5183 ( .A(n4220), .Y(n4229) );
  INVX1_RVT U5184 ( .A(n7427), .Y(n4505) );
  INVX1_RVT U5185 ( .A(n7410), .Y(n4501) );
  INVX1_RVT U5186 ( .A(n7371), .Y(n4280) );
  INVX1_RVT U5187 ( .A(n7415), .Y(n4468) );
  INVX1_RVT U5188 ( .A(n7445), .Y(n4485) );
  INVX1_RVT U5189 ( .A(n7428), .Y(n4493) );
  INVX1_RVT U5190 ( .A(n7421), .Y(n4496) );
  NBUFFX2_RVT U5191 ( .A(n7479), .Y(n4479) );
  INVX1_RVT U5192 ( .A(n7445), .Y(n4483) );
  INVX1_RVT U5193 ( .A(n7370), .Y(n4457) );
  INVX1_RVT U5194 ( .A(n7457), .Y(n4500) );
  INVX1_RVT U5195 ( .A(n7386), .Y(n4510) );
  INVX1_RVT U5196 ( .A(n7426), .Y(n4463) );
  XOR2X1_RVT U5197 ( .A1(n4209), .A2(pcpi_rs2[8]), .Y(n6384) );
  NBUFFX2_RVT U5198 ( .A(n7387), .Y(n4447) );
  INVX1_RVT U5199 ( .A(n7484), .Y(n4279) );
  OA22X1_RVT U5200 ( .A1(n8091), .A2(n7987), .A3(n8092), .A4(n5449), .Y(n5454)
         );
  INVX1_RVT U5201 ( .A(n7890), .Y(n7900) );
  INVX1_RVT U5202 ( .A(n7426), .Y(n4461) );
  INVX1_RVT U5203 ( .A(n7371), .Y(n4281) );
  INVX1_RVT U5204 ( .A(n7388), .Y(n4285) );
  INVX1_RVT U5205 ( .A(n7440), .Y(n4473) );
  OR2X1_RVT U5206 ( .A1(n4116), .A2(n4291), .Y(n4251) );
  INVX1_RVT U5207 ( .A(n7421), .Y(n4495) );
  INVX1_RVT U5208 ( .A(n7485), .Y(n4288) );
  INVX1_RVT U5209 ( .A(n7447), .Y(n4443) );
  INVX1_RVT U5210 ( .A(n7446), .Y(n4481) );
  INVX1_RVT U5211 ( .A(n7420), .Y(n4507) );
  INVX1_RVT U5212 ( .A(n7484), .Y(n4278) );
  XNOR2X1_RVT U5213 ( .A1(pcpi_rs2[12]), .A2(pcpi_rs1[12]), .Y(n7605) );
  AO22X1_RVT U5214 ( .A1(\cpuregs[20][1] ), .A2(n7233), .A3(\cpuregs[12][1] ), 
        .A4(n4829), .Y(n6319) );
  INVX1_RVT U5215 ( .A(n7559), .Y(n7563) );
  AND2X2_RVT U5216 ( .A1(n6855), .A2(n4838), .Y(n7467) );
  INVX1_RVT U5217 ( .A(n5814), .Y(n5812) );
  NBUFFX2_RVT U5218 ( .A(net27467), .Y(net30495) );
  AND3X1_RVT U5219 ( .A1(n5135), .A2(n8043), .A3(n7976), .Y(n5137) );
  AND2X1_RVT U5220 ( .A1(n4893), .A2(n4328), .Y(n6645) );
  INVX0_RVT U5221 ( .A(n5134), .Y(n5138) );
  INVX1_RVT U5222 ( .A(n7587), .Y(n7591) );
  INVX1_RVT U5223 ( .A(n7495), .Y(n7499) );
  AO22X1_RVT U5224 ( .A1(\cpuregs[24][3] ), .A2(n7228), .A3(\cpuregs[4][3] ), 
        .A4(n4838), .Y(n4839) );
  INVX1_RVT U5225 ( .A(n6430), .Y(n4644) );
  INVX1_RVT U5226 ( .A(n7968), .Y(n4399) );
  NBUFFX2_RVT U5227 ( .A(n4006), .Y(n8071) );
  INVX1_RVT U5228 ( .A(n5441), .Y(n5435) );
  INVX1_RVT U5229 ( .A(n6543), .Y(n6544) );
  INVX1_RVT U5230 ( .A(n5817), .Y(n5818) );
  AO22X1_RVT U5231 ( .A1(n7229), .A2(\cpuregs[28][0] ), .A3(n7228), .A4(
        \cpuregs[24][0] ), .Y(n6486) );
  INVX1_RVT U5232 ( .A(n7942), .Y(n6187) );
  INVX1_RVT U5233 ( .A(n5483), .Y(n5414) );
  AND2X1_RVT U5234 ( .A1(latched_stalu), .A2(n4516), .Y(n6063) );
  AO22X1_RVT U5235 ( .A1(n7227), .A2(\cpuregs[16][0] ), .A3(n4838), .A4(
        \cpuregs[4][0] ), .Y(n6465) );
  INVX1_RVT U5236 ( .A(n5813), .Y(n5816) );
  INVX1_RVT U5237 ( .A(n5239), .Y(n4817) );
  INVX1_RVT U5238 ( .A(n6558), .Y(n6559) );
  INVX1_RVT U5239 ( .A(n7682), .Y(n7683) );
  OR2X1_RVT U5240 ( .A1(n7912), .A2(mem_wordsize[1]), .Y(n7913) );
  INVX1_RVT U5241 ( .A(n7529), .Y(n7533) );
  INVX1_RVT U5242 ( .A(n5421), .Y(n4181) );
  NBUFFX2_RVT U5243 ( .A(net27467), .Y(net30496) );
  AND2X1_RVT U5244 ( .A1(latched_stalu), .A2(n4516), .Y(n4548) );
  INVX1_RVT U5245 ( .A(n7504), .Y(n7508) );
  INVX1_RVT U5246 ( .A(n4869), .Y(n4116) );
  INVX1_RVT U5247 ( .A(n7829), .Y(n7830) );
  NBUFFX2_RVT U5248 ( .A(net27467), .Y(net30497) );
  AND2X1_RVT U5249 ( .A1(latched_stalu), .A2(n4516), .Y(n4549) );
  INVX1_RVT U5250 ( .A(n5498), .Y(n5489) );
  AND2X1_RVT U5251 ( .A1(n4893), .A2(n4328), .Y(n4326) );
  NBUFFX2_RVT U5252 ( .A(net27467), .Y(net30494) );
  INVX1_RVT U5253 ( .A(n7515), .Y(n7519) );
  INVX1_RVT U5254 ( .A(n7812), .Y(n7813) );
  INVX1_RVT U5255 ( .A(n5791), .Y(n7810) );
  AND2X1_RVT U5256 ( .A1(is_alu_reg_imm), .A2(n7942), .Y(n7943) );
  AND2X1_RVT U5257 ( .A1(net16345), .A2(n7973), .Y(n6404) );
  XOR2X1_RVT U5258 ( .A1(n4610), .A2(pcpi_rs2[19]), .Y(n6250) );
  NBUFFX2_RVT U5259 ( .A(is_lui_auipc_jal_jalr_addi_add_sub), .Y(n4529) );
  AND2X1_RVT U5260 ( .A1(n7981), .A2(n8011), .Y(n6301) );
  NOR2X0_RVT U5261 ( .A1(instr_xor), .A2(instr_xori), .Y(n5135) );
  OR2X1_RVT U5262 ( .A1(instr_or), .A2(instr_ori), .Y(n5134) );
  OR2X1_RVT U5263 ( .A1(decoded_imm[28]), .A2(reg_pc[28]), .Y(n4969) );
  NBUFFX2_RVT U5264 ( .A(decoded_imm[2]), .Y(n4121) );
  XOR2X1_RVT U5265 ( .A1(n4610), .A2(pcpi_rs2[25]), .Y(n6268) );
  AND3X1_RVT U5266 ( .A1(n7975), .A2(n8014), .A3(n8017), .Y(n4830) );
  INVX1_RVT U5267 ( .A(n8042), .Y(n4803) );
  XOR2X1_RVT U5268 ( .A1(n4610), .A2(pcpi_rs2[21]), .Y(n6376) );
  AND2X1_RVT U5269 ( .A1(net16449), .A2(net16329), .Y(n6421) );
  XOR2X1_RVT U5270 ( .A1(n8025), .A2(net16329), .Y(n6423) );
  XOR2X1_RVT U5271 ( .A1(instr_sub), .A2(pcpi_rs2[1]), .Y(n6545) );
  XOR2X1_RVT U5272 ( .A1(instr_sub), .A2(pcpi_rs2[2]), .Y(n7670) );
  INVX1_RVT U5273 ( .A(n8042), .Y(n4812) );
  NOR2X0_RVT U5274 ( .A1(instr_lbu), .A2(instr_lb), .Y(n7906) );
  AND2X1_RVT U5275 ( .A1(net16359), .A2(net16468), .Y(n6411) );
  AND2X1_RVT U5276 ( .A1(is_slli_srli_srai), .A2(n7984), .Y(n7926) );
  OR2X1_RVT U5277 ( .A1(instr_slt), .A2(instr_slti), .Y(n7690) );
  NAND2X0_RVT U5278 ( .A1(n7971), .A2(n8070), .Y(n7812) );
  AND2X1_RVT U5279 ( .A1(latched_rd[1]), .A2(n7981), .Y(n6302) );
  AND2X1_RVT U5280 ( .A1(latched_rd[2]), .A2(n8011), .Y(n6300) );
  NOR3X0_RVT U5281 ( .A1(mem_rdata_q[2]), .A2(mem_rdata_q[3]), .A3(
        mem_rdata_q[15]), .Y(n6024) );
  XOR2X1_RVT U5282 ( .A1(net16449), .A2(pcpi_rs2[0]), .Y(n6422) );
  OR2X1_RVT U5283 ( .A1(instr_sltu), .A2(instr_sltiu), .Y(n7689) );
  NAND2X0_RVT U5284 ( .A1(mem_wordsize[0]), .A2(mem_wordsize[1]), .Y(n4813) );
  INVX1_RVT U5285 ( .A(n8010), .Y(n4639) );
  INVX1_RVT U5286 ( .A(resetn), .Y(net29419) );
  INVX0_RVT U5287 ( .A(mem_ready), .Y(n4636) );
  NBUFFX2_RVT U5288 ( .A(n4085), .Y(n4078) );
  NBUFFX2_RVT U5289 ( .A(n4730), .Y(n4079) );
  INVX1_RVT U5290 ( .A(n4799), .Y(n4253) );
  NAND3X0_RVT U5291 ( .A1(n7688), .A2(n4159), .A3(n8018), .Y(n4154) );
  MUX21X1_RVT U5292 ( .A1(pcpi_rs1[30]), .A2(n4146), .S0(n4056), .Y(n3710) );
  NBUFFX2_RVT U5293 ( .A(n4731), .Y(n4088) );
  NBUFFX2_RVT U5294 ( .A(n6461), .Y(n4089) );
  NBUFFX2_RVT U5295 ( .A(n4790), .Y(n4090) );
  NBUFFX2_RVT U5296 ( .A(n6351), .Y(n4704) );
  AND2X1_RVT U5297 ( .A1(latched_rd[0]), .A2(n6365), .Y(n6359) );
  NAND3X0_RVT U5298 ( .A1(n6365), .A2(n6300), .A3(n4021), .Y(n6350) );
  NAND3X0_RVT U5299 ( .A1(n6300), .A2(n6140), .A3(n8020), .Y(n6159) );
  NAND3X0_RVT U5300 ( .A1(n6309), .A2(n6140), .A3(n4021), .Y(n6160) );
  INVX0_RVT U5301 ( .A(n7856), .Y(n7680) );
  AO22X1_RVT U5302 ( .A1(n8092), .A2(net24129), .A3(pcpi_rs1[4]), .A4(net30608), .Y(n5580) );
  AO222X1_RVT U5303 ( .A1(n4220), .A2(reg_next_pc[4]), .A3(n4253), .A4(
        alu_out_q[4]), .A5(reg_out[4]), .A6(n4194), .Y(n7859) );
  NAND2X0_RVT U5304 ( .A1(net30386), .A2(n4116), .Y(net24545) );
  INVX0_RVT U5305 ( .A(n6928), .Y(n4194) );
  NAND2X0_RVT U5306 ( .A1(net24198), .A2(pcpi_rs1[26]), .Y(n4150) );
  AO22X1_RVT U5307 ( .A1(n4630), .A2(reg_out[23]), .A3(n4797), .A4(
        reg_next_pc[23]), .Y(n6217) );
  NAND2X0_RVT U5308 ( .A1(n4116), .A2(n4532), .Y(net30598) );
  AO22X1_RVT U5309 ( .A1(n4188), .A2(reg_out[17]), .A3(n4632), .A4(
        reg_next_pc[17]), .Y(n6210) );
  NBUFFX2_RVT U5310 ( .A(n6192), .Y(n4096) );
  NAND4X0_RVT U5311 ( .A1(decoded_imm_j[18]), .A2(decoded_imm_j[19]), .A3(
        n8013), .A4(n4889), .Y(n4339) );
  NAND2X0_RVT U5312 ( .A1(n8009), .A2(n4070), .Y(n6928) );
  NBUFFX2_RVT U5313 ( .A(n4549), .Y(n4097) );
  AND4X1_RVT U5314 ( .A1(n5135), .A2(n8043), .A3(n5134), .A4(n7976), .Y(n4243)
         );
  NBUFFX2_RVT U5315 ( .A(n4548), .Y(n4098) );
  OR2X1_RVT U5316 ( .A1(n8072), .A2(decoded_imm[26]), .Y(n4124) );
  INVX0_RVT U5317 ( .A(n7853), .Y(n7854) );
  NAND2X0_RVT U5318 ( .A1(n6842), .A2(count_cycle[62]), .Y(n7804) );
  AND2X1_RVT U5319 ( .A1(n6833), .A2(n4133), .Y(n6839) );
  AND2X1_RVT U5320 ( .A1(n6833), .A2(count_cycle[59]), .Y(n6836) );
  INVX0_RVT U5321 ( .A(n6825), .Y(n6823) );
  AND2X1_RVT U5322 ( .A1(n4205), .A2(n4206), .Y(n6802) );
  AND2X1_RVT U5323 ( .A1(n4205), .A2(n4145), .Y(n6805) );
  AND2X1_RVT U5324 ( .A1(n4205), .A2(n4144), .Y(n6808) );
  AO222X1_RVT U5325 ( .A1(n4518), .A2(n6065), .A3(n4371), .A4(reg_out[26]), 
        .A5(alu_out_q[26]), .A6(n4548), .Y(n4385) );
  OR3X1_RVT U5326 ( .A1(n5099), .A2(n5098), .A3(net26359), .Y(n5100) );
  OR3X1_RVT U5327 ( .A1(n6746), .A2(n6745), .A3(net24197), .Y(n4376) );
  AO22X1_RVT U5328 ( .A1(reg_pc[23]), .A2(decoded_imm[23]), .A3(n6539), .A4(
        n4966), .Y(n6610) );
  AO22X1_RVT U5329 ( .A1(reg_pc[22]), .A2(decoded_imm[22]), .A3(n6568), .A4(
        n4123), .Y(n6539) );
  OR3X1_RVT U5330 ( .A1(n5316), .A2(n5315), .A3(net26114), .Y(n5317) );
  AOI22X1_RVT U5331 ( .A1(pcpi_rs1[21]), .A2(net30609), .A3(net26446), .A4(
        net29606), .Y(net26445) );
  OR3X1_RVT U5332 ( .A1(n5654), .A2(n5653), .A3(net25729), .Y(n5656) );
  AND2X1_RVT U5333 ( .A1(n4232), .A2(n4233), .Y(n6490) );
  AND2X1_RVT U5334 ( .A1(n4232), .A2(n4138), .Y(n6536) );
  AND2X1_RVT U5335 ( .A1(n4232), .A2(n4139), .Y(n6519) );
  OR3X1_RVT U5336 ( .A1(n5680), .A2(n5679), .A3(net25698), .Y(n5682) );
  OR3X1_RVT U5337 ( .A1(n7779), .A2(n7778), .A3(n7777), .Y(N1920) );
  OR3X1_RVT U5338 ( .A1(n5785), .A2(n5784), .A3(net25574), .Y(n5787) );
  AOI22X1_RVT U5339 ( .A1(pcpi_rs1[16]), .A2(net30609), .A3(net26476), .A4(
        net29607), .Y(net26475) );
  OR3X1_RVT U5340 ( .A1(n7770), .A2(n7769), .A3(n7768), .Y(N1919) );
  NBUFFX2_RVT U5341 ( .A(n4788), .Y(n4104) );
  AND2X1_RVT U5342 ( .A1(n4223), .A2(n4141), .Y(n6104) );
  AOI22X1_RVT U5343 ( .A1(pcpi_rs1[9]), .A2(net30560), .A3(net26418), .A4(
        net29606), .Y(net26417) );
  AND2X1_RVT U5344 ( .A1(n4223), .A2(n4224), .Y(n6060) );
  AND2X1_RVT U5345 ( .A1(n4223), .A2(n4142), .Y(n6078) );
  NBUFFX2_RVT U5346 ( .A(n4732), .Y(n4105) );
  NBUFFX2_RVT U5347 ( .A(n6460), .Y(n4106) );
  OR3X1_RVT U5348 ( .A1(n7761), .A2(n7760), .A3(n7759), .Y(N1917) );
  NBUFFX2_RVT U5349 ( .A(n4790), .Y(n4107) );
  OR3X1_RVT U5350 ( .A1(n7754), .A2(n7753), .A3(n7752), .Y(N1916) );
  AO22X1_RVT U5351 ( .A1(pcpi_rs1[31]), .A2(n4055), .A3(n4151), .A4(net29472), 
        .Y(n4129) );
  OR3X1_RVT U5352 ( .A1(net26141), .A2(n5290), .A3(n5289), .Y(n5291) );
  OR3X1_RVT U5353 ( .A1(n5365), .A2(n5364), .A3(net26058), .Y(n5366) );
  OR3X1_RVT U5354 ( .A1(net26169), .A2(n5265), .A3(n5264), .Y(n5266) );
  OR2X1_RVT U5355 ( .A1(net24598), .A2(n4152), .Y(n4151) );
  AND2X1_RVT U5356 ( .A1(n4057), .A2(net23007), .Y(n4130) );
  OR3X1_RVT U5357 ( .A1(n5074), .A2(n5073), .A3(net26388), .Y(n5075) );
  AND2X1_RVT U5358 ( .A1(n4257), .A2(n4256), .Y(n4193) );
  NAND2X0_RVT U5359 ( .A1(n5552), .A2(n4148), .Y(n4147) );
  NBUFFX2_RVT U5360 ( .A(n6349), .Y(n4698) );
  AO21X1_RVT U5361 ( .A1(reg_pc[31]), .A2(net24496), .A3(net30680), .Y(n4152)
         );
  OR3X1_RVT U5362 ( .A1(n7739), .A2(n7738), .A3(n7737), .Y(N1914) );
  OR3X1_RVT U5363 ( .A1(n7747), .A2(n7746), .A3(n7745), .Y(N1915) );
  AND2X1_RVT U5364 ( .A1(latched_rd[4]), .A2(n6308), .Y(n6365) );
  OR2X1_RVT U5365 ( .A1(n4215), .A2(n4212), .Y(net30680) );
  AND2X1_RVT U5366 ( .A1(net25850), .A2(n4149), .Y(n4148) );
  OAI22X1_RVT U5367 ( .A1(n4269), .A2(n7696), .A3(n4270), .A4(n6528), .Y(n4268) );
  NAND2X0_RVT U5368 ( .A1(n7925), .A2(net26648), .Y(net23329) );
  OAI22X1_RVT U5369 ( .A1(n4305), .A2(n4313), .A3(n4306), .A4(n7696), .Y(n4304) );
  AOI21X1_RVT U5370 ( .A1(n7944), .A2(decoded_imm_j[31]), .A3(n6098), .Y(n6115) );
  OAI22X1_RVT U5371 ( .A1(n4332), .A2(n7696), .A3(n8058), .A4(n6528), .Y(n4331) );
  FADDX1_RVT U5372 ( .A(decoded_imm[8]), .B(net24504), .CI(n8086), .CO(
        net26560), .S(net24503) );
  OAI22X1_RVT U5373 ( .A1(n4261), .A2(n4313), .A3(n4262), .A4(n7696), .Y(n4260) );
  OAI22X1_RVT U5374 ( .A1(n4264), .A2(n7696), .A3(n4265), .A4(n6528), .Y(n4263) );
  NAND2X0_RVT U5375 ( .A1(n4112), .A2(n8005), .Y(n7525) );
  AO22X1_RVT U5376 ( .A1(decoded_imm[8]), .A2(reg_pc[8]), .A3(n7732), .A4(
        n4962), .Y(n7740) );
  AND2X1_RVT U5377 ( .A1(n5553), .A2(n4150), .Y(n4149) );
  OR3X1_RVT U5378 ( .A1(n7826), .A2(n7846), .A3(n5840), .Y(n7852) );
  AO22X1_RVT U5379 ( .A1(decoded_imm[7]), .A2(reg_pc[7]), .A3(net25657), .A4(
        n4122), .Y(n7732) );
  OR3X1_RVT U5380 ( .A1(N1600), .A2(N1599), .A3(n5516), .Y(n7918) );
  NBUFFX2_RVT U5381 ( .A(n4810), .Y(n4112) );
  NAND4X0_RVT U5382 ( .A1(n4399), .A2(decoded_imm_j[18]), .A3(
        decoded_imm_j[17]), .A4(n4414), .Y(n5013) );
  AOI22X1_RVT U5383 ( .A1(n4548), .A2(alu_out_q[0]), .A3(n4372), .A4(
        reg_out[0]), .Y(n7954) );
  MUX21X1_RVT U5384 ( .A1(alu_out_q[5]), .A2(n6929), .S0(n4800), .Y(n7860) );
  NAND2X0_RVT U5385 ( .A1(n4414), .A2(n4886), .Y(n5665) );
  OR3X1_RVT U5386 ( .A1(n5447), .A2(n5446), .A3(n5445), .Y(n5469) );
  NAND2X0_RVT U5387 ( .A1(n4880), .A2(n4418), .Y(n6692) );
  NAND2X0_RVT U5388 ( .A1(n4880), .A2(n4888), .Y(n6585) );
  NAND2X0_RVT U5389 ( .A1(n4887), .A2(n4414), .Y(n6756) );
  NAND4X0_RVT U5390 ( .A1(n4399), .A2(decoded_imm_j[18]), .A3(
        decoded_imm_j[17]), .A4(n4888), .Y(n4943) );
  NAND2X0_RVT U5391 ( .A1(n4888), .A2(n4890), .Y(n6649) );
  NAND2X0_RVT U5392 ( .A1(n4889), .A2(n4890), .Y(n6586) );
  AO22X1_RVT U5393 ( .A1(n4188), .A2(reg_out[4]), .A3(n4797), .A4(
        reg_next_pc[4]), .Y(n6206) );
  NAND2X0_RVT U5394 ( .A1(n4880), .A2(n4889), .Y(n6680) );
  NAND2X0_RVT U5395 ( .A1(n4893), .A2(n4888), .Y(n6720) );
  AND2X1_RVT U5396 ( .A1(n4141), .A2(count_cycle[31]), .Y(n4140) );
  AND2X1_RVT U5397 ( .A1(n4135), .A2(count_cycle[13]), .Y(n4134) );
  NAND2X0_RVT U5398 ( .A1(n4887), .A2(n4892), .Y(n6681) );
  AND2X1_RVT U5399 ( .A1(n4138), .A2(count_cycle[42]), .Y(n4137) );
  NAND2X0_RVT U5400 ( .A1(n4881), .A2(n4892), .Y(n6687) );
  OR2X1_RVT U5401 ( .A1(n4155), .A2(n4154), .Y(n7917) );
  AND2X1_RVT U5402 ( .A1(n4144), .A2(count_cycle[54]), .Y(n4143) );
  OR3X1_RVT U5403 ( .A1(trap), .A2(n6207), .A3(net29419), .Y(n7890) );
  AND2X1_RVT U5404 ( .A1(n4861), .A2(n4640), .Y(n4533) );
  AND4X1_RVT U5405 ( .A1(resetn), .A2(cpu_state[7]), .A3(n7688), .A4(n4861), 
        .Y(N2097) );
  NAND4X0_RVT U5406 ( .A1(n4892), .A2(decoded_imm_j[18]), .A3(
        decoded_imm_j[17]), .A4(n4399), .Y(n5750) );
  NAND2X0_RVT U5407 ( .A1(n4879), .A2(n4418), .Y(n6676) );
  AND2X1_RVT U5408 ( .A1(n7688), .A2(n4159), .Y(n4153) );
  AND2X1_RVT U5409 ( .A1(n4136), .A2(count_cycle[12]), .Y(n4135) );
  AND2X1_RVT U5410 ( .A1(n4142), .A2(count_cycle[30]), .Y(n4141) );
  NAND2X0_RVT U5411 ( .A1(n4893), .A2(n4418), .Y(n6747) );
  AND2X1_RVT U5412 ( .A1(n4139), .A2(count_cycle[41]), .Y(n4138) );
  AND2X1_RVT U5413 ( .A1(n4145), .A2(count_cycle[53]), .Y(n4144) );
  AND2X1_RVT U5414 ( .A1(n4206), .A2(count_cycle[52]), .Y(n4145) );
  AND2X1_RVT U5415 ( .A1(n4233), .A2(count_cycle[40]), .Y(n4139) );
  OR3X1_RVT U5416 ( .A1(instr_jal), .A2(instr_auipc), .A3(instr_lui), .Y(N282)
         );
  NAND2X0_RVT U5417 ( .A1(instr_jal), .A2(decoded_imm_j[31]), .Y(n7555) );
  AND2X1_RVT U5418 ( .A1(n4133), .A2(count_cycle[61]), .Y(n4132) );
  AND2X1_RVT U5419 ( .A1(n4200), .A2(count_cycle[11]), .Y(n4136) );
  AND2X1_RVT U5420 ( .A1(n4224), .A2(count_cycle[29]), .Y(n4142) );
  NAND2X0_RVT U5421 ( .A1(n4829), .A2(n4831), .Y(n7429) );
  NAND2X0_RVT U5422 ( .A1(n4830), .A2(n4831), .Y(n7445) );
  NAND2X0_RVT U5423 ( .A1(n6855), .A2(n7228), .Y(n7388) );
  NAND2X0_RVT U5424 ( .A1(n7228), .A2(n4831), .Y(n7446) );
  NAND2X0_RVT U5425 ( .A1(n7229), .A2(n4832), .Y(n7352) );
  NAND2X0_RVT U5426 ( .A1(n7226), .A2(n4833), .Y(n7426) );
  NAND2X0_RVT U5427 ( .A1(n4312), .A2(n7229), .Y(n7371) );
  OR2X1_RVT U5428 ( .A1(pcpi_rs1[22]), .A2(decoded_imm[22]), .Y(n4126) );
  NAND2X0_RVT U5429 ( .A1(n4829), .A2(n4833), .Y(n7440) );
  NAND2X0_RVT U5430 ( .A1(n7229), .A2(n4833), .Y(n7410) );
  NAND2X0_RVT U5431 ( .A1(n7227), .A2(n4833), .Y(n7427) );
  NAND2X0_RVT U5432 ( .A1(n4829), .A2(n4832), .Y(n6468) );
  NAND2X0_RVT U5433 ( .A1(n7229), .A2(n4831), .Y(n7420) );
  NAND2X0_RVT U5434 ( .A1(n7228), .A2(n4833), .Y(n7386) );
  NAND2X0_RVT U5435 ( .A1(n7226), .A2(n4832), .Y(n7439) );
  NAND2X0_RVT U5436 ( .A1(n7227), .A2(n4831), .Y(n7428) );
  NAND2X0_RVT U5437 ( .A1(n6855), .A2(n7227), .Y(n7485) );
  NAND2X0_RVT U5438 ( .A1(n4838), .A2(n4832), .Y(n7343) );
  NAND2X0_RVT U5439 ( .A1(n7226), .A2(n4831), .Y(n7415) );
  NAND2X0_RVT U5440 ( .A1(n7233), .A2(n4833), .Y(n7421) );
  NAND2X0_RVT U5441 ( .A1(n7227), .A2(n4832), .Y(n7457) );
  NAND2X0_RVT U5442 ( .A1(n7233), .A2(n4832), .Y(n7447) );
  NAND2X0_RVT U5443 ( .A1(n7228), .A2(n4832), .Y(n7370) );
  NAND2X0_RVT U5444 ( .A1(n6855), .A2(n7233), .Y(n7484) );
  OR3X1_RVT U5445 ( .A1(instr_bltu), .A2(instr_sltu), .A3(instr_sltiu), .Y(
        N285) );
  AND2X1_RVT U5446 ( .A1(pcpi_rs1[20]), .A2(n7996), .Y(n5420) );
  OR2X1_RVT U5447 ( .A1(decoded_imm[7]), .A2(reg_pc[7]), .Y(n4122) );
  OR3X1_RVT U5448 ( .A1(instr_lhu), .A2(instr_lbu), .A3(instr_lw), .Y(N286) );
  NBUFFX2_RVT U5449 ( .A(n8007), .Y(n4638) );
  OR2X1_RVT U5450 ( .A1(decoded_imm[22]), .A2(reg_pc[22]), .Y(n4123) );
  OR3X1_RVT U5451 ( .A1(instr_sb), .A2(instr_sw), .A3(instr_sh), .Y(n5239) );
  OR3X1_RVT U5452 ( .A1(instr_blt), .A2(instr_slt), .A3(instr_slti), .Y(N284)
         );
  NBUFFX2_RVT U5453 ( .A(n8075), .Y(pcpi_rs1[22]) );
  OR2X1_RVT U5454 ( .A1(pcpi_rs1[29]), .A2(decoded_imm[29]), .Y(n4131) );
  AND2X1_RVT U5455 ( .A1(count_cycle[59]), .A2(count_cycle[60]), .Y(n4133) );
  OR2X1_RVT U5456 ( .A1(n8073), .A2(decoded_imm[24]), .Y(n4125) );
  AO22X1_RVT U5457 ( .A1(n8072), .A2(decoded_imm[26]), .A3(net24135), .A4(
        n4124), .Y(net24547) );
  AO22X1_RVT U5458 ( .A1(n8073), .A2(decoded_imm[24]), .A3(net26246), .A4(
        n4125), .Y(net26110) );
  AO22X1_RVT U5459 ( .A1(pcpi_rs1[22]), .A2(decoded_imm[22]), .A3(n4126), .A4(
        net26361), .Y(net26528) );
  AO21X1_RVT U5460 ( .A1(n4128), .A2(n4130), .A3(n4129), .Y(n3709) );
  AO22X1_RVT U5461 ( .A1(pcpi_rs1[29]), .A2(decoded_imm[29]), .A3(net25873), 
        .A4(n4131), .Y(net24609) );
  AO21X1_RVT U5462 ( .A1(net25872), .A2(net29607), .A3(n4147), .Y(n4146) );
  FADDX1_RVT U5463 ( .A(decoded_imm[13]), .B(net26419), .CI(n8081), .CO(
        net25576), .S(net26418) );
  AND2X1_RVT U5464 ( .A1(n6833), .A2(n4132), .Y(n6842) );
  AND2X1_RVT U5465 ( .A1(n4199), .A2(n4134), .Y(n5883) );
  AND2X1_RVT U5466 ( .A1(n4232), .A2(n4137), .Y(n6565) );
  AND2X1_RVT U5467 ( .A1(n4223), .A2(n4140), .Y(n6145) );
  AND2X1_RVT U5468 ( .A1(n4205), .A2(n4143), .Y(n6822) );
  AND2X1_RVT U5469 ( .A1(n7918), .A2(n4156), .Y(n7919) );
  AND2X1_RVT U5470 ( .A1(n7922), .A2(n4157), .Y(n4156) );
  AND2X1_RVT U5471 ( .A1(n7916), .A2(n4158), .Y(n4157) );
  AND2X1_RVT U5472 ( .A1(n4325), .A2(n7917), .Y(n4158) );
  AND2X1_RVT U5473 ( .A1(n4638), .A2(cpu_state[3]), .Y(n4159) );
  OR2X1_RVT U5474 ( .A1(n4160), .A2(n6541), .Y(N1929) );
  AO21X1_RVT U5475 ( .A1(n6542), .A2(n4316), .A3(n4161), .Y(n4160) );
  AO22X1_RVT U5476 ( .A1(n4356), .A2(count_cycle[23]), .A3(n4310), .A4(
        count_instr[55]), .Y(n4162) );
  OR2X1_RVT U5477 ( .A1(n4163), .A2(n7783), .Y(N1924) );
  AO21X1_RVT U5478 ( .A1(n7784), .A2(n4316), .A3(n4164), .Y(n4163) );
  AO22X1_RVT U5479 ( .A1(n4357), .A2(count_cycle[18]), .A3(n4310), .A4(
        count_instr[50]), .Y(n4165) );
  OR2X1_RVT U5480 ( .A1(n4166), .A2(n6612), .Y(N1930) );
  AO21X1_RVT U5481 ( .A1(n6613), .A2(n4316), .A3(n4167), .Y(n4166) );
  AO22X1_RVT U5482 ( .A1(n4352), .A2(count_instr[24]), .A3(n4311), .A4(
        count_instr[56]), .Y(n4168) );
  OR2X1_RVT U5483 ( .A1(n4169), .A2(n6570), .Y(N1928) );
  AO21X1_RVT U5484 ( .A1(n6571), .A2(n4316), .A3(n4170), .Y(n4169) );
  AO22X1_RVT U5485 ( .A1(n4351), .A2(count_instr[22]), .A3(n7788), .A4(
        count_instr[54]), .Y(n4171) );
  OR2X1_RVT U5486 ( .A1(n4172), .A2(n5528), .Y(N1927) );
  AO21X1_RVT U5487 ( .A1(n5529), .A2(n4316), .A3(n4173), .Y(n4172) );
  OR2X1_RVT U5488 ( .A1(n4174), .A2(n7797), .Y(n4173) );
  AO22X1_RVT U5489 ( .A1(n5718), .A2(count_instr[21]), .A3(n4311), .A4(
        count_instr[53]), .Y(n4174) );
  OR2X1_RVT U5490 ( .A1(n4176), .A2(n7794), .Y(n7795) );
  AO22X1_RVT U5491 ( .A1(n6573), .A2(mem_rdata_word[20]), .A3(n4535), .A4(
        pcpi_rs1[20]), .Y(n4176) );
  AND2X1_RVT U5492 ( .A1(n4862), .A2(n4863), .Y(n4972) );
  AO22X1_RVT U5493 ( .A1(n8041), .A2(pcpi_rs1[22]), .A3(n8074), .A4(n7994), 
        .Y(n5426) );
  OR2X1_RVT U5494 ( .A1(n5426), .A2(n4177), .Y(n5465) );
  OR2X1_RVT U5495 ( .A1(n5426), .A2(n4178), .Y(n5467) );
  OR2X1_RVT U5496 ( .A1(n5420), .A2(n4181), .Y(n4177) );
  OR2X1_RVT U5497 ( .A1(n4179), .A2(n4181), .Y(n4178) );
  OR2X1_RVT U5498 ( .A1(n4180), .A2(n5464), .Y(n4179) );
  OR2X1_RVT U5499 ( .A1(n5420), .A2(n5466), .Y(n4180) );
  AO21X1_RVT U5500 ( .A1(n4183), .A2(n4064), .A3(n4182), .Y(n3932) );
  OA22X1_RVT U5501 ( .A1(n4093), .A2(n7947), .A3(n6463), .A4(n6464), .Y(n4182)
         );
  AND2X1_RVT U5502 ( .A1(latched_branch), .A2(n4020), .Y(n4183) );
  AOI21X1_RVT U5503 ( .A1(n5509), .A2(n4187), .A3(instr_beq), .Y(n4186) );
  AO22X1_RVT U5504 ( .A1(n5510), .A2(n4185), .A3(n4186), .A4(n4184), .Y(n7819)
         );
  AND2X1_RVT U5505 ( .A1(n4320), .A2(instr_beq), .Y(n4185) );
  NAND2X0_RVT U5506 ( .A1(n6418), .A2(n4184), .Y(n7687) );
  AO21X1_RVT U5507 ( .A1(instr_beq), .A2(n5510), .A3(n4186), .Y(n6418) );
  OR2X1_RVT U5508 ( .A1(n8050), .A2(n5510), .Y(n4187) );
  MUX21X1_RVT U5509 ( .A1(alu_out_q[5]), .A2(n6929), .S0(n4800), .Y(n4192) );
  FADDX1_RVT U5510 ( .A(decoded_imm[9]), .B(n8085), .CI(net26560), .CO(
        net26214), .S(net26588) );
  NAND2X0_RVT U5511 ( .A1(n4255), .A2(n4193), .Y(n3798) );
  AO22X1_RVT U5512 ( .A1(reg_pc[5]), .A2(n4067), .A3(n4811), .A4(n4192), .Y(
        n3792) );
  INVX1_RVT U5513 ( .A(n6928), .Y(n4195) );
  AND2X1_RVT U5514 ( .A1(n5824), .A2(count_cycle[6]), .Y(n4197) );
  AND2X1_RVT U5515 ( .A1(count_cycle[8]), .A2(count_cycle[7]), .Y(n4198) );
  AND2X1_RVT U5516 ( .A1(n4197), .A2(n4198), .Y(n4199) );
  AND2X1_RVT U5517 ( .A1(count_cycle[10]), .A2(count_cycle[9]), .Y(n4200) );
  AND2X1_RVT U5518 ( .A1(n5928), .A2(count_cycle[20]), .Y(n4201) );
  AND2X1_RVT U5519 ( .A1(n4201), .A2(n4202), .Y(n5970) );
  AND2X1_RVT U5520 ( .A1(count_cycle[22]), .A2(count_cycle[21]), .Y(n4202) );
  AND2X1_RVT U5521 ( .A1(n6179), .A2(count_cycle[33]), .Y(n4203) );
  AND2X1_RVT U5522 ( .A1(n4203), .A2(n4204), .Y(n6294) );
  AND2X1_RVT U5523 ( .A1(count_cycle[35]), .A2(count_cycle[34]), .Y(n4204) );
  AND2X1_RVT U5524 ( .A1(n6785), .A2(count_cycle[49]), .Y(n4205) );
  AND2X1_RVT U5525 ( .A1(count_cycle[51]), .A2(count_cycle[50]), .Y(n4206) );
  AND2X1_RVT U5526 ( .A1(count_cycle[57]), .A2(count_cycle[56]), .Y(n4207) );
  NAND2X0_RVT U5527 ( .A1(n6825), .A2(count_cycle[56]), .Y(n4208) );
  AND2X1_RVT U5528 ( .A1(n6719), .A2(count_cycle[46]), .Y(n6779) );
  OA21X1_RVT U5529 ( .A1(n6785), .A2(count_cycle[49]), .A3(n6787), .Y(N967) );
  INVX0_RVT U5530 ( .A(n6785), .Y(n6783) );
  AND2X1_RVT U5531 ( .A1(n5970), .A2(count_cycle[23]), .Y(n5985) );
  INVX0_RVT U5532 ( .A(n8025), .Y(n4209) );
  NAND4X0_RVT U5533 ( .A1(n4806), .A2(instr_rdinstr), .A3(n7983), .A4(n8034), 
        .Y(n6528) );
  NAND3X0_RVT U5534 ( .A1(n4806), .A2(n4974), .A3(instr_rdinstrh), .Y(n7703)
         );
  INVX1_RVT U5535 ( .A(n7797), .Y(n6817) );
  AND2X1_RVT U5536 ( .A1(net26624), .A2(net24129), .Y(n4934) );
  AND2X1_RVT U5537 ( .A1(n4888), .A2(n4879), .Y(n6686) );
  AO22X1_RVT U5538 ( .A1(n4419), .A2(\cpuregs[30][13] ), .A3(n4415), .A4(
        \cpuregs[28][13] ), .Y(n5039) );
  AND3X1_RVT U5539 ( .A1(n4399), .A2(decoded_imm_j[17]), .A3(n7978), .Y(n4887)
         );
  AND3X1_RVT U5540 ( .A1(decoded_imm_j[18]), .A2(decoded_imm_j[19]), .A3(n8013), .Y(n4893) );
  AND4X1_RVT U5541 ( .A1(n4891), .A2(n4399), .A3(decoded_imm_j[18]), .A4(
        decoded_imm_j[17]), .Y(n5052) );
  NAND3X0_RVT U5542 ( .A1(n5237), .A2(cpu_state[6]), .A3(n7974), .Y(n7823) );
  OA221X1_RVT U5543 ( .A1(n7923), .A2(n7925), .A3(n7923), .A4(is_sb_sh_sw), 
        .A5(n4806), .Y(n5513) );
  MUX21X1_RVT U5544 ( .A1(reg_next_pc[7]), .A2(reg_out[7]), .S0(n4188), .Y(
        n6931) );
  AND2X1_RVT U5545 ( .A1(n4812), .A2(decoded_imm_j[3]), .Y(n7667) );
  AO22X1_RVT U5546 ( .A1(n4538), .A2(mem_rdata_word[5]), .A3(n4633), .A4(
        net30690), .Y(n7720) );
  AO22X1_RVT U5547 ( .A1(pcpi_rs1[25]), .A2(net24129), .A3(pcpi_rs1[30]), .A4(
        net30391), .Y(n6772) );
  AO21X1_RVT U5548 ( .A1(n5688), .A2(n4320), .A3(n5687), .Y(n5689) );
  AO21X1_RVT U5549 ( .A1(n4316), .A2(n7792), .A3(n7791), .Y(N1925) );
  AO21X1_RVT U5550 ( .A1(n4316), .A2(n6580), .A3(n6579), .Y(N1923) );
  AO22X1_RVT U5551 ( .A1(count_cycle[15]), .A2(n4356), .A3(count_cycle[47]), 
        .A4(n4258), .Y(n5735) );
  AO22X1_RVT U5552 ( .A1(pcpi_rs1[18]), .A2(n4054), .A3(n4934), .A4(
        pcpi_rs1[17]), .Y(n5655) );
  NOR2X0_RVT U5553 ( .A1(net29419), .A2(count_cycle[0]), .Y(N918) );
  AO22X1_RVT U5554 ( .A1(\cpuregs[8][3] ), .A2(n7226), .A3(\cpuregs[16][3] ), 
        .A4(n7227), .Y(n4840) );
  AND3X1_RVT U5555 ( .A1(decoded_imm_j[18]), .A2(n7968), .A3(n8013), .Y(n4879)
         );
  AND2X1_RVT U5556 ( .A1(n4891), .A2(n4890), .Y(n6592) );
  OR2X1_RVT U5557 ( .A1(n4869), .A2(n4805), .Y(net26087) );
  AND2X1_RVT U5558 ( .A1(n4838), .A2(n4831), .Y(n7479) );
  AND2X1_RVT U5559 ( .A1(n4833), .A2(n4830), .Y(n7468) );
  AND2X1_RVT U5560 ( .A1(n4838), .A2(n4833), .Y(n7452) );
  AND2X1_RVT U5561 ( .A1(n7233), .A2(n4831), .Y(n7387) );
  OR2X1_RVT U5562 ( .A1(n4290), .A2(n7696), .Y(n4296) );
  NAND3X0_RVT U5563 ( .A1(n6297), .A2(n7981), .A3(n8011), .Y(n6348) );
  NAND3X0_RVT U5564 ( .A1(n6059), .A2(n7981), .A3(n8011), .Y(n6158) );
  NAND3X0_RVT U5565 ( .A1(n6359), .A2(n7981), .A3(n8011), .Y(n6360) );
  NAND4X0_RVT U5566 ( .A1(latched_rd[0]), .A2(n6302), .A3(n6127), .A4(n8015), 
        .Y(n6715) );
  NAND4X0_RVT U5567 ( .A1(latched_rd[0]), .A2(n6300), .A3(n6127), .A4(n8015), 
        .Y(n6176) );
  NAND4X0_RVT U5568 ( .A1(latched_rd[0]), .A2(n6309), .A3(n6127), .A4(n8015), 
        .Y(n6174) );
  AO21X1_RVT U5569 ( .A1(n7945), .A2(n7977), .A3(n7890), .Y(n6222) );
  AND3X1_RVT U5570 ( .A1(n6354), .A2(n2511), .A3(n2542), .Y(n6368) );
  AND2X1_RVT U5571 ( .A1(n4271), .A2(\cpuregs[15][9] ), .Y(n4874) );
  AND2X1_RVT U5572 ( .A1(n4271), .A2(\cpuregs[15][25] ), .Y(n4938) );
  OR2X1_RVT U5573 ( .A1(instr_slli), .A2(instr_sll), .Y(n4869) );
  NAND4X0_RVT U5574 ( .A1(latched_rd[0]), .A2(n6301), .A3(n6127), .A4(n8015), 
        .Y(n6716) );
  NAND3X0_RVT U5575 ( .A1(resetn), .A2(mem_do_rinst), .A3(n5292), .Y(n6456) );
  FADDX1_RVT U5576 ( .A(decoded_imm[5]), .B(n8089), .CI(net26195), .CO(
        net26390), .S(net26194) );
  AO21X1_RVT U5577 ( .A1(net30608), .A2(net30702), .A3(n5242), .Y(n5265) );
  NBUFFX2_RVT U5578 ( .A(n4385), .Y(n4563) );
  XOR2X1_RVT U5579 ( .A1(n4610), .A2(pcpi_rs2[20]), .Y(n7560) );
  AND2X1_RVT U5580 ( .A1(n4812), .A2(decoded_imm_j[18]), .Y(n7572) );
  XOR2X1_RVT U5581 ( .A1(n4209), .A2(pcpi_rs2[12]), .Y(n7606) );
  AND3X1_RVT U5582 ( .A1(resetn), .A2(n4321), .A3(n7929), .Y(net23989) );
  AO22X1_RVT U5583 ( .A1(n8093), .A2(net24129), .A3(net30659), .A4(net30608), 
        .Y(n5554) );
  NAND3X0_RVT U5584 ( .A1(is_slli_srli_srai), .A2(n4063), .A3(n7984), .Y(n7801) );
  AND2X1_RVT U5585 ( .A1(n4803), .A2(decoded_imm_j[4]), .Y(n7656) );
  AO22X1_RVT U5586 ( .A1(count_cycle[11]), .A2(n4356), .A3(n4320), .A4(n7756), 
        .Y(n7757) );
  INVX1_RVT U5587 ( .A(n6158), .Y(n4646) );
  AND4X1_RVT U5588 ( .A1(resetn), .A2(n7822), .A3(n7821), .A4(n4020), .Y(n7934) );
  AND3X1_RVT U5589 ( .A1(n7848), .A2(count_instr[33]), .A3(n7640), .Y(n7850)
         );
  OR2X1_RVT U5590 ( .A1(reg_sh[3]), .A2(reg_sh[2]), .Y(n7682) );
  AO22X1_RVT U5591 ( .A1(net30390), .A2(pcpi_rs1[25]), .A3(pcpi_rs1[22]), .A4(
        net30609), .Y(n6745) );
  AO22X1_RVT U5592 ( .A1(pcpi_rs1[26]), .A2(net30625), .A3(pcpi_rs1[28]), .A4(
        net30608), .Y(n6639) );
  NAND3X0_RVT U5593 ( .A1(n4214), .A2(pcpi_rs1[31]), .A3(net30386), .Y(
        net25850) );
  AND4X1_RVT U5594 ( .A1(is_lui_auipc_jal), .A2(n4806), .A3(n4379), .A4(n8038), 
        .Y(net24496) );
  NAND3X0_RVT U5595 ( .A1(count_cycle[1]), .A2(count_cycle[0]), .A3(
        count_cycle[2]), .Y(n5814) );
  AO21X1_RVT U5596 ( .A1(n4055), .A2(net30656), .A3(n5176), .Y(n5177) );
  NAND3X0_RVT U5597 ( .A1(pcpi_rs2[6]), .A2(net30702), .A3(n4246), .Y(n6413)
         );
  AOI22X1_RVT U5598 ( .A1(count_cycle[0]), .A2(n4357), .A3(count_instr[32]), 
        .A4(n4310), .Y(n7692) );
  AO21X1_RVT U5599 ( .A1(count_cycle[37]), .A2(n4258), .A3(n7722), .Y(n7727)
         );
  AOI22X1_RVT U5600 ( .A1(n4538), .A2(mem_rdata_word[6]), .A3(n4031), .A4(
        net30702), .Y(n7730) );
  AO21X1_RVT U5601 ( .A1(n4316), .A2(n6821), .A3(n6820), .Y(N1937) );
  AO21X1_RVT U5602 ( .A1(n4981), .A2(n4316), .A3(n4980), .Y(N1936) );
  AO21X1_RVT U5603 ( .A1(n4316), .A2(n6801), .A3(n6800), .Y(N1935) );
  AO22X1_RVT U5604 ( .A1(count_cycle[29]), .A2(n4356), .A3(count_cycle[61]), 
        .A4(n4259), .Y(n6799) );
  AO22X1_RVT U5605 ( .A1(count_cycle[28]), .A2(n4357), .A3(count_cycle[60]), 
        .A4(n4258), .Y(n5716) );
  AO21X1_RVT U5606 ( .A1(count_cycle[59]), .A2(n4258), .A3(n5703), .Y(n5704)
         );
  AO21X1_RVT U5607 ( .A1(n4316), .A2(n7800), .A3(n7799), .Y(N1926) );
  AO21X1_RVT U5608 ( .A1(n4320), .A2(n5145), .A3(n5144), .Y(n5150) );
  AO21X1_RVT U5609 ( .A1(n4320), .A2(n7767), .A3(n7766), .Y(n7768) );
  AO21X1_RVT U5610 ( .A1(n4316), .A2(n6535), .A3(n6534), .Y(N1918) );
  AO21X1_RVT U5611 ( .A1(n4320), .A2(n7744), .A3(n7743), .Y(n7745) );
  AO21X1_RVT U5612 ( .A1(n4320), .A2(n7736), .A3(n7735), .Y(n7737) );
  AO21X1_RVT U5613 ( .A1(n4320), .A2(n5722), .A3(n5721), .Y(n5723) );
  AO22X1_RVT U5614 ( .A1(count_cycle[7]), .A2(n7762), .A3(n4031), .A4(net30656), .Y(n5724) );
  AO21X1_RVT U5615 ( .A1(net30596), .A2(net30609), .A3(net25636), .Y(n5761) );
  AO22X1_RVT U5616 ( .A1(n6459), .A2(n6457), .A3(is_alu_reg_reg), .A4(n4540), 
        .Y(n3628) );
  AO22X1_RVT U5617 ( .A1(n6459), .A2(n6458), .A3(is_alu_reg_imm), .A4(n4541), 
        .Y(n3634) );
  AO22X1_RVT U5618 ( .A1(n6354), .A2(n2532), .A3(n4539), .A4(decoded_rd[4]), 
        .Y(n3699) );
  AO22X1_RVT U5619 ( .A1(n6354), .A2(n2533), .A3(n4540), .A4(decoded_rd[3]), 
        .Y(n3698) );
  AO22X1_RVT U5620 ( .A1(n6354), .A2(n2534), .A3(n4539), .A4(decoded_rd[2]), 
        .Y(n3697) );
  AO22X1_RVT U5621 ( .A1(n6354), .A2(n2535), .A3(n4541), .A4(decoded_rd[1]), 
        .Y(n3696) );
  AO22X1_RVT U5622 ( .A1(n6354), .A2(n2536), .A3(n4540), .A4(decoded_rd[0]), 
        .Y(n3695) );
  NAND3X0_RVT U5623 ( .A1(n7894), .A2(n7896), .A3(mem_valid), .Y(n7895) );
  AO21X1_RVT U5624 ( .A1(net30608), .A2(net30690), .A3(n5267), .Y(n5290) );
  AO22X1_RVT U5625 ( .A1(pcpi_rs1[16]), .A2(n4055), .A3(n4934), .A4(
        pcpi_rs1[15]), .Y(n5681) );
  AO21X1_RVT U5626 ( .A1(net30608), .A2(pcpi_rs1[20]), .A3(n5314), .Y(n5315)
         );
  AO22X1_RVT U5627 ( .A1(pcpi_rs1[22]), .A2(n4055), .A3(n5100), .A4(net29471), 
        .Y(n5101) );
  NAND4X0_RVT U5628 ( .A1(n5517), .A2(n4064), .A3(n4855), .A4(n7918), .Y(n5518) );
  OA21X1_RVT U5629 ( .A1(count_cycle[0]), .A2(count_cycle[1]), .A3(n5810), .Y(
        N919) );
  OA21X1_RVT U5630 ( .A1(count_cycle[25]), .A2(n5994), .A3(n5996), .Y(N943) );
  OA21X1_RVT U5631 ( .A1(n6019), .A2(count_cycle[27]), .A3(n6021), .Y(N945) );
  INVX0_RVT U5632 ( .A(n6179), .Y(n6146) );
  AO22X1_RVT U5633 ( .A1(pcpi_rs1[30]), .A2(net30625), .A3(n4213), .A4(
        net24605), .Y(n4212) );
  AND2X1_RVT U5634 ( .A1(n4214), .A2(pcpi_rs1[31]), .Y(n4213) );
  AND2X1_RVT U5635 ( .A1(pcpi_rs1[27]), .A2(net30560), .Y(n4215) );
  FADDX1_RVT U5636 ( .A(decoded_imm[30]), .B(net24609), .CI(pcpi_rs1[30]), 
        .CO(net24608), .S(net25872) );
  AOI22X1_RVT U5637 ( .A1(pcpi_rs1[25]), .A2(net24198), .A3(net26109), .A4(
        net29607), .Y(net26085) );
  FADDX1_RVT U5638 ( .A(decoded_imm[28]), .B(pcpi_rs1[28]), .CI(net26054), 
        .CO(net25873), .S(net26053) );
  AOI22X1_RVT U5639 ( .A1(pcpi_rs1[24]), .A2(net30560), .A3(net26053), .A4(
        net29606), .Y(net26030) );
  FADDX1_RVT U5640 ( .A(decoded_imm[27]), .B(net24547), .CI(pcpi_rs1[27]), 
        .CO(net26054), .S(net24546) );
  AO22X1_RVT U5641 ( .A1(pcpi_rs1[31]), .A2(net30389), .A3(net24546), .A4(
        net23007), .Y(net24543) );
  AO22X1_RVT U5642 ( .A1(pcpi_rs1[22]), .A2(net24198), .A3(net24133), .A4(
        net23007), .Y(net24127) );
  FADDX1_RVT U5643 ( .A(decoded_imm[25]), .B(net26110), .CI(pcpi_rs1[25]), 
        .CO(net24135), .S(net26527) );
  AO22X1_RVT U5644 ( .A1(pcpi_rs1[29]), .A2(net30391), .A3(net26527), .A4(
        net29607), .Y(net26526) );
  AO22X1_RVT U5645 ( .A1(pcpi_rs1[28]), .A2(net30389), .A3(net26245), .A4(
        net23007), .Y(net26243) );
  FADDX1_RVT U5646 ( .A(decoded_imm[23]), .B(net26528), .CI(pcpi_rs1[23]), 
        .CO(net26246), .S(net26559) );
  AO22X1_RVT U5647 ( .A1(pcpi_rs1[27]), .A2(net30390), .A3(net26559), .A4(
        net29607), .Y(net26558) );
  AO22X1_RVT U5648 ( .A1(pcpi_rs1[18]), .A2(net24198), .A3(net26360), .A4(
        net29607), .Y(net26359) );
  FADDX1_RVT U5649 ( .A(decoded_imm[21]), .B(pcpi_rs1[21]), .CI(net24201), 
        .CO(net26361), .S(net24199) );
  AO22X1_RVT U5650 ( .A1(pcpi_rs1[17]), .A2(net24198), .A3(net24199), .A4(
        net29606), .Y(net24197) );
  FADDX1_RVT U5651 ( .A(decoded_imm[20]), .B(pcpi_rs1[20]), .CI(net26447), 
        .CO(net24201), .S(net26446) );
  FADDX1_RVT U5652 ( .A(decoded_imm[19]), .B(n8076), .CI(net26116), .CO(
        net26447), .S(net26115) );
  AO22X1_RVT U5653 ( .A1(pcpi_rs1[18]), .A2(net30625), .A3(net26115), .A4(
        net29607), .Y(net26114) );
  FADDX1_RVT U5654 ( .A(decoded_imm[18]), .B(net25731), .CI(n4032), .CO(
        net26116), .S(net25730) );
  AO22X1_RVT U5655 ( .A1(pcpi_rs1[19]), .A2(net30609), .A3(net25730), .A4(
        net29606), .Y(net25729) );
  FADDX1_RVT U5656 ( .A(decoded_imm[17]), .B(net26331), .CI(pcpi_rs1[17]), 
        .CO(net25731), .S(net26330) );
  AO22X1_RVT U5657 ( .A1(pcpi_rs1[21]), .A2(net30390), .A3(net26330), .A4(
        net29606), .Y(net26329) );
  FADDX1_RVT U5658 ( .A(decoded_imm[16]), .B(net25700), .CI(pcpi_rs1[16]), 
        .CO(net26331), .S(net25699) );
  AO22X1_RVT U5659 ( .A1(pcpi_rs1[17]), .A2(net30609), .A3(net25699), .A4(
        net29607), .Y(net25698) );
  FADDX1_RVT U5660 ( .A(decoded_imm[15]), .B(net26477), .CI(pcpi_rs1[15]), 
        .CO(net25700), .S(net26476) );
  FADDX1_RVT U5661 ( .A(decoded_imm[14]), .B(net25576), .CI(n8080), .CO(
        net26477), .S(net25575) );
  AO22X1_RVT U5662 ( .A1(pcpi_rs1[18]), .A2(net30391), .A3(net25575), .A4(
        net29606), .Y(net25574) );
  FADDX1_RVT U5663 ( .A(decoded_imm[12]), .B(net24449), .CI(n8082), .CO(
        net26419), .S(net24447) );
  AO22X1_RVT U5664 ( .A1(pcpi_rs1[16]), .A2(net30390), .A3(net24447), .A4(
        net29607), .Y(net24444) );
  FADDX1_RVT U5665 ( .A(decoded_imm[11]), .B(n8083), .CI(net26060), .CO(
        net24449), .S(net26059) );
  AO22X1_RVT U5666 ( .A1(pcpi_rs1[10]), .A2(net30625), .A3(net26059), .A4(
        net29606), .Y(net26058) );
  FADDX1_RVT U5667 ( .A(decoded_imm[10]), .B(net26214), .CI(n8084), .CO(
        net26060), .S(net26213) );
  AO22X1_RVT U5668 ( .A1(pcpi_rs1[14]), .A2(net30389), .A3(net26213), .A4(
        net23007), .Y(net26211) );
  AO22X1_RVT U5669 ( .A1(pcpi_rs1[13]), .A2(net30391), .A3(net26588), .A4(
        net29606), .Y(net26587) );
  AO22X1_RVT U5670 ( .A1(pcpi_rs1[12]), .A2(net30389), .A3(net24503), .A4(
        net29606), .Y(net24498) );
  FADDX1_RVT U5671 ( .A(decoded_imm[7]), .B(n8087), .CI(net26276), .CO(
        net24504), .S(net26275) );
  AO22X1_RVT U5672 ( .A1(n8091), .A2(net24198), .A3(net26275), .A4(net23007), 
        .Y(net26273) );
  FADDX1_RVT U5673 ( .A(decoded_imm[6]), .B(net26390), .CI(n8088), .CO(
        net26276), .S(net26389) );
  AO22X1_RVT U5674 ( .A1(pcpi_rs1[4]), .A2(net30625), .A3(net26194), .A4(
        net29606), .Y(net26169) );
  FADDX1_RVT U5675 ( .A(n8089), .B(net23071), .CI(net23072), .CO(net24864), 
        .S(net23069) );
  FADDX1_RVT U5676 ( .A(decoded_imm[4]), .B(n8090), .CI(net26167), .CO(
        net26195), .S(net26166) );
  AO22X1_RVT U5677 ( .A1(net30659), .A2(net30625), .A3(net26166), .A4(net29607), .Y(net26141) );
  FADDX1_RVT U5678 ( .A(decoded_imm[3]), .B(n8091), .CI(net25816), .CO(
        net26167), .S(net25815) );
  FADDX1_RVT U5679 ( .A(n4121), .B(net25845), .CI(n8092), .CO(net25816), .S(
        net25844) );
  FADDX1_RVT U5680 ( .A(decoded_imm[1]), .B(net25787), .CI(n8093), .CO(
        net25845), .S(net25786) );
  AO22X1_RVT U5681 ( .A1(pcpi_rs1[4]), .A2(net30390), .A3(net25637), .A4(
        net29606), .Y(net25636) );
  AO222X1_RVT U5682 ( .A1(pcpi_rs2[6]), .A2(net29438), .A3(net30048), .A4(
        decoded_imm[6]), .A5(net23610), .A6(net30424), .Y(n3924) );
  AO222X1_RVT U5683 ( .A1(net30494), .A2(decoded_imm[6]), .A3(net22659), .A4(
        mem_rdata_q[26]), .A5(decoded_imm_j[6]), .A6(net30578), .Y(n3601) );
  FADDX1_RVT U5684 ( .A(reg_pc[6]), .B(decoded_imm[6]), .CI(net22948), .CO(
        net25657), .S(net22947) );
  AO222X1_RVT U5685 ( .A1(net30496), .A2(decoded_imm[0]), .A3(mem_rdata_q[7]), 
        .A4(net22737), .A5(mem_rdata_q[20]), .A6(net22738), .Y(n3741) );
  AND4X1_RVT U5686 ( .A1(n5970), .A2(count_cycle[23]), .A3(count_cycle[24]), 
        .A4(count_cycle[25]), .Y(n6012) );
  NAND2X0_RVT U5687 ( .A1(n6842), .A2(count_cycle[62]), .Y(n4216) );
  AOI21X1_RVT U5688 ( .A1(n4217), .A2(n6840), .A3(n4218), .Y(N980) );
  NAND2X0_RVT U5689 ( .A1(resetn), .A2(n4216), .Y(n4218) );
  OA21X1_RVT U5690 ( .A1(n6565), .A2(count_cycle[43]), .A3(n6567), .Y(N961) );
  OA21X1_RVT U5691 ( .A1(n6607), .A2(count_cycle[44]), .A3(n6609), .Y(N962) );
  AO22X1_RVT U5692 ( .A1(count_cycle[12]), .A2(n4357), .A3(count_cycle[44]), 
        .A4(n4259), .Y(n6533) );
  OA21X1_RVT U5693 ( .A1(n6519), .A2(count_cycle[41]), .A3(n6521), .Y(N959) );
  OA21X1_RVT U5694 ( .A1(n6490), .A2(count_cycle[40]), .A3(n6492), .Y(N958) );
  OA21X1_RVT U5695 ( .A1(count_cycle[19]), .A2(n5919), .A3(n5921), .Y(N937) );
  OR2X1_RVT U5696 ( .A1(n4221), .A2(n4222), .Y(n4236) );
  AO21X1_RVT U5697 ( .A1(n4934), .A2(net30690), .A3(n5076), .Y(n3734) );
  FADDX1_RVT U5698 ( .A(n7524), .B(n4237), .CI(n7881), .CO(n7522), .S(n7526)
         );
  FADDX1_RVT U5699 ( .A(n7527), .B(n4238), .CI(n7880), .CO(n7524), .S(n7528)
         );
  AND2X1_RVT U5700 ( .A1(n6012), .A2(count_cycle[26]), .Y(n4223) );
  AND2X1_RVT U5701 ( .A1(count_cycle[28]), .A2(count_cycle[27]), .Y(n4224) );
  OA21X1_RVT U5702 ( .A1(n5970), .A2(count_cycle[23]), .A3(n5972), .Y(N941) );
  OA21X1_RVT U5703 ( .A1(n6145), .A2(count_cycle[32]), .A3(n6147), .Y(N950) );
  OA21X1_RVT U5704 ( .A1(n6078), .A2(count_cycle[30]), .A3(n6080), .Y(N948) );
  OA21X1_RVT U5705 ( .A1(n6276), .A2(count_cycle[35]), .A3(n6278), .Y(N953) );
  OA21X1_RVT U5706 ( .A1(n6294), .A2(count_cycle[36]), .A3(n6296), .Y(N954) );
  OA21X1_RVT U5707 ( .A1(count_cycle[33]), .A2(n6179), .A3(n6181), .Y(N951) );
  OA21X1_RVT U5708 ( .A1(n6303), .A2(count_cycle[37]), .A3(n6305), .Y(N955) );
  OA21X1_RVT U5709 ( .A1(n5898), .A2(count_cycle[16]), .A3(n5900), .Y(N934) );
  AND2X1_RVT U5710 ( .A1(n6303), .A2(count_cycle[37]), .Y(n6344) );
  FADDX1_RVT U5711 ( .A(n7884), .B(n4238), .CI(n7511), .CO(n7502), .S(n7512)
         );
  OA22X1_RVT U5712 ( .A1(n5456), .A2(pcpi_rs1[4]), .A3(n8021), .A4(net30690), 
        .Y(n5460) );
  AO22X1_RVT U5713 ( .A1(net30560), .A2(net30713), .A3(net30609), .A4(net30656), .Y(n5073) );
  AO22X1_RVT U5714 ( .A1(net30656), .A2(net24129), .A3(pcpi_rs1[9]), .A4(
        net30608), .Y(n6669) );
  MUX21X1_RVT U5715 ( .A1(reg_next_pc[25]), .A2(reg_out[25]), .S0(n4630), .Y(
        n6944) );
  MUX21X1_RVT U5716 ( .A1(reg_next_pc[21]), .A2(reg_out[21]), .S0(n4631), .Y(
        n6942) );
  MUX21X1_RVT U5717 ( .A1(reg_next_pc[18]), .A2(reg_out[18]), .S0(n4630), .Y(
        n6940) );
  MUX21X1_RVT U5718 ( .A1(reg_next_pc[14]), .A2(reg_out[14]), .S0(n4630), .Y(
        n6938) );
  MUX21X1_RVT U5719 ( .A1(reg_next_pc[9]), .A2(reg_out[9]), .S0(n4188), .Y(
        n6934) );
  AND2X1_RVT U5720 ( .A1(n6719), .A2(count_cycle[46]), .Y(n4230) );
  AND2X1_RVT U5721 ( .A1(n4230), .A2(n4231), .Y(n6785) );
  AND2X1_RVT U5722 ( .A1(count_cycle[48]), .A2(count_cycle[47]), .Y(n4231) );
  AND2X1_RVT U5723 ( .A1(n6303), .A2(count_cycle[37]), .Y(n4232) );
  AND2X1_RVT U5724 ( .A1(count_cycle[39]), .A2(count_cycle[38]), .Y(n4233) );
  AND2X1_RVT U5725 ( .A1(n5898), .A2(count_cycle[16]), .Y(n4234) );
  AND2X1_RVT U5726 ( .A1(n4234), .A2(n4235), .Y(n5919) );
  AND2X1_RVT U5727 ( .A1(count_cycle[18]), .A2(count_cycle[17]), .Y(n4235) );
  NOR2X0_RVT U5728 ( .A1(n4236), .A2(n5817), .Y(n5824) );
  FADDX1_RVT U5729 ( .A(n7885), .B(n4238), .CI(n7502), .CO(n6949), .S(n7503)
         );
  AND3X1_RVT U5730 ( .A1(n8007), .A2(n4642), .A3(n4641), .Y(n4242) );
  NAND4X0_RVT U5731 ( .A1(n5135), .A2(n8043), .A3(n5134), .A4(n7976), .Y(n7603) );
  AND4X1_RVT U5732 ( .A1(n4866), .A2(n4867), .A3(n7815), .A4(net24034), .Y(
        net27408) );
  AO22X1_RVT U5733 ( .A1(net30391), .A2(pcpi_rs1[26]), .A3(pcpi_rs1[23]), .A4(
        net30609), .Y(n5098) );
  AO21X1_RVT U5734 ( .A1(net30608), .A2(pcpi_rs1[12]), .A3(n5363), .Y(n5364)
         );
  NAND2X0_RVT U5735 ( .A1(n4640), .A2(n4861), .Y(n4250) );
  AO22X1_RVT U5736 ( .A1(net30560), .A2(pcpi_rs1[14]), .A3(pcpi_rs1[22]), .A4(
        net30391), .Y(n5653) );
  AO22X1_RVT U5737 ( .A1(net24198), .A2(pcpi_rs1[12]), .A3(net30390), .A4(
        pcpi_rs1[20]), .Y(n5679) );
  AOI22X1_RVT U5738 ( .A1(net24198), .A2(net30668), .A3(pcpi_rs1[19]), .A4(
        net30391), .Y(n4301) );
  AOI22X1_RVT U5739 ( .A1(net30560), .A2(pcpi_rs1[16]), .A3(pcpi_rs1[24]), 
        .A4(net30390), .Y(n4302) );
  AO22X1_RVT U5740 ( .A1(net24198), .A2(n8094), .A3(net30390), .A4(n8086), .Y(
        n5267) );
  AO22X1_RVT U5741 ( .A1(net30560), .A2(pcpi_rs1[15]), .A3(pcpi_rs1[23]), .A4(
        net30391), .Y(n5314) );
  AO22X1_RVT U5742 ( .A1(net30560), .A2(n8093), .A3(net30391), .A4(pcpi_rs1[9]), .Y(n5242) );
  AO22X1_RVT U5743 ( .A1(net24198), .A2(n8087), .A3(net30390), .A4(
        pcpi_rs1[15]), .Y(n5363) );
  MUX21X1_RVT U5744 ( .A1(reg_next_pc[29]), .A2(reg_out[29]), .S0(n4631), .Y(
        n6947) );
  MUX21X1_RVT U5745 ( .A1(reg_next_pc[26]), .A2(reg_out[26]), .S0(n4631), .Y(
        n6945) );
  MUX21X1_RVT U5746 ( .A1(reg_next_pc[20]), .A2(reg_out[20]), .S0(n4229), .Y(
        n6941) );
  MUX21X1_RVT U5747 ( .A1(reg_next_pc[15]), .A2(reg_out[15]), .S0(n4229), .Y(
        n6939) );
  MUX21X1_RVT U5748 ( .A1(reg_next_pc[10]), .A2(reg_out[10]), .S0(n4630), .Y(
        n6935) );
  MUX21X1_RVT U5749 ( .A1(reg_next_pc[8]), .A2(reg_out[8]), .S0(n4631), .Y(
        n6933) );
  INVX1_RVT U5750 ( .A(n4799), .Y(n4254) );
  NAND2X0_RVT U5751 ( .A1(n6950), .A2(n4536), .Y(n4255) );
  NAND2X0_RVT U5752 ( .A1(reg_next_pc[31]), .A2(n4068), .Y(n4256) );
  NAND2X0_RVT U5753 ( .A1(n4354), .A2(n7887), .Y(n4257) );
  NAND3X0_RVT U5754 ( .A1(n4294), .A2(instr_rdcycleh), .A3(n7983), .Y(n7696)
         );
  AND3X1_RVT U5755 ( .A1(decoded_imm_j[3]), .A2(decoded_imm_j[2]), .A3(n8014), 
        .Y(n4829) );
  AND3X1_RVT U5756 ( .A1(n4292), .A2(n4293), .A3(n4530), .Y(n4291) );
  NAND2X0_RVT U5757 ( .A1(count_cycle[20]), .A2(n4356), .Y(n4295) );
  NAND2X0_RVT U5758 ( .A1(n4295), .A2(n4296), .Y(n7794) );
  NAND3X0_RVT U5759 ( .A1(n4300), .A2(n4301), .A3(net26475), .Y(n5003) );
  AOI22X1_RVT U5760 ( .A1(reg_pc[15]), .A2(net24496), .A3(n5002), .A4(n4058), 
        .Y(n4300) );
  NAND3X0_RVT U5761 ( .A1(net26445), .A2(n4302), .A3(n4303), .Y(n5027) );
  AOI22X1_RVT U5762 ( .A1(reg_pc[20]), .A2(net24496), .A3(n5026), .A4(n4060), 
        .Y(n4303) );
  OAI22X1_RVT U5763 ( .A1(n4307), .A2(n4308), .A3(n4343), .A4(n4309), .Y(n5078) );
  OAI22X1_RVT U5764 ( .A1(n4314), .A2(n4313), .A3(n4315), .A4(n7696), .Y(n5527) );
  INVX1_RVT U5765 ( .A(n7910), .Y(n4316) );
  AOI22X1_RVT U5766 ( .A1(count_cycle[6]), .A2(n4357), .A3(count_cycle[38]), 
        .A4(n4259), .Y(n7731) );
  NOR3X0_RVT U5767 ( .A1(cpu_state[3]), .A2(cpu_state[2]), .A3(n4853), .Y(
        n5237) );
  NAND4X0_RVT U5768 ( .A1(n4891), .A2(decoded_imm_j[18]), .A3(
        decoded_imm_j[17]), .A4(n7968), .Y(n4343) );
  NAND4X0_RVT U5769 ( .A1(n4515), .A2(n4325), .A3(n4241), .A4(n7917), .Y(n7818) );
  NAND4X0_RVT U5770 ( .A1(n4820), .A2(n5954), .A3(n7820), .A4(n4819), .Y(n4324) );
  AND2X1_RVT U5771 ( .A1(decoded_imm_j[16]), .A2(decoded_imm_j[15]), .Y(n4328)
         );
  AND2X1_RVT U5772 ( .A1(n4888), .A2(n4887), .Y(n4329) );
  AND2X1_RVT U5773 ( .A1(n4888), .A2(n4887), .Y(n4330) );
  AND2X1_RVT U5774 ( .A1(n4888), .A2(n4887), .Y(n5017) );
  AND2X1_RVT U5775 ( .A1(n4888), .A2(n4886), .Y(n4344) );
  AND2X1_RVT U5776 ( .A1(n4888), .A2(n4886), .Y(n4345) );
  AND2X1_RVT U5777 ( .A1(n4888), .A2(n4886), .Y(n6581) );
  AND2X1_RVT U5778 ( .A1(n4806), .A2(instr_rdcycle), .Y(n7762) );
  AND2X1_RVT U5779 ( .A1(n4888), .A2(n4881), .Y(n5745) );
  AND2X1_RVT U5780 ( .A1(n7988), .A2(n8009), .Y(n6508) );
  AO21X1_RVT U5781 ( .A1(n4376), .A2(net29472), .A3(n4377), .Y(n3719) );
  AO22X1_RVT U5782 ( .A1(pcpi_rs1[20]), .A2(n4934), .A3(net27408), .A4(
        pcpi_rs1[21]), .Y(n4377) );
  NAND3X0_RVT U5783 ( .A1(n4378), .A2(n5049), .A3(net26417), .Y(n5050) );
  AND2X1_RVT U5784 ( .A1(n4395), .A2(n4396), .Y(n4378) );
  AND3X1_RVT U5785 ( .A1(n7936), .A2(n8037), .A3(n4974), .Y(n4379) );
  AND2X1_RVT U5786 ( .A1(n6742), .A2(n6743), .Y(n4380) );
  AND2X1_RVT U5787 ( .A1(n5044), .A2(n5045), .Y(n4381) );
  AND2X1_RVT U5788 ( .A1(n4889), .A2(n4881), .Y(n6761) );
  AND3X1_RVT U5789 ( .A1(decoded_imm_j[19]), .A2(n7978), .A3(n8013), .Y(n4881)
         );
  AND2X1_RVT U5790 ( .A1(n4418), .A2(n4886), .Y(n6726) );
  AND2X1_RVT U5791 ( .A1(n4328), .A2(n4886), .Y(n6735) );
  NAND2X0_RVT U5792 ( .A1(n5048), .A2(n4059), .Y(n4395) );
  NAND2X0_RVT U5793 ( .A1(net30310), .A2(reg_pc[13]), .Y(n4396) );
  NAND3X0_RVT U5794 ( .A1(n4381), .A2(n5047), .A3(n5046), .Y(n5048) );
  AO22X1_RVT U5795 ( .A1(net30702), .A2(n4055), .A3(n5075), .A4(net29472), .Y(
        n5076) );
  NBUFFX2_RVT U5796 ( .A(n4889), .Y(n4414) );
  AO21X1_RVT U5797 ( .A1(n4934), .A2(pcpi_rs1[19]), .A3(n5028), .Y(n3720) );
  AO22X1_RVT U5798 ( .A1(pcpi_rs1[20]), .A2(n4054), .A3(n5027), .A4(net29472), 
        .Y(n5028) );
  NAND2X0_RVT U5799 ( .A1(reg_pc[21]), .A2(net30310), .Y(n4400) );
  NAND2X0_RVT U5800 ( .A1(n6744), .A2(n4061), .Y(n4401) );
  NAND2X0_RVT U5801 ( .A1(n4400), .A2(n4401), .Y(n6746) );
  NAND3X0_RVT U5802 ( .A1(n4380), .A2(n6740), .A3(n6741), .Y(n6744) );
  AND2X1_RVT U5803 ( .A1(n7982), .A2(n8019), .Y(n4418) );
  AND2X1_RVT U5804 ( .A1(instr_jal), .A2(decoded_imm_j[17]), .Y(n7582) );
  AO22X1_RVT U5805 ( .A1(pcpi_rs1[15]), .A2(n4054), .A3(n5003), .A4(n4056), 
        .Y(n5004) );
  AO22X1_RVT U5806 ( .A1(pcpi_rs1[13]), .A2(n4054), .A3(n5050), .A4(net29471), 
        .Y(n5051) );
  AND2X1_RVT U5807 ( .A1(n4830), .A2(n4832), .Y(n4429) );
  AND2X1_RVT U5808 ( .A1(n4830), .A2(n4832), .Y(n4430) );
  AND2X1_RVT U5809 ( .A1(n4812), .A2(n4399), .Y(n7569) );
  NAND2X0_RVT U5810 ( .A1(n4849), .A2(n4848), .Y(n4850) );
  NAND4X0_RVT U5811 ( .A1(n4854), .A2(cpu_state[1]), .A3(n4861), .A4(n8010), 
        .Y(n7933) );
  NBUFFX2_RVT U5812 ( .A(n4514), .Y(n4515) );
  NAND2X0_RVT U5813 ( .A1(n4863), .A2(n4862), .Y(n4531) );
  NBUFFX2_RVT U5814 ( .A(n6159), .Y(n4520) );
  NBUFFX2_RVT U5815 ( .A(n6159), .Y(n4521) );
  NBUFFX2_RVT U5816 ( .A(n6159), .Y(n4766) );
  NBUFFX2_RVT U5817 ( .A(n6153), .Y(n4522) );
  NBUFFX2_RVT U5818 ( .A(n6153), .Y(n4523) );
  NBUFFX2_RVT U5819 ( .A(n6153), .Y(n4776) );
  OA21X1_RVT U5820 ( .A1(n7922), .A2(net29419), .A3(n4513), .Y(n4524) );
  NBUFFX2_RVT U5821 ( .A(net26624), .Y(net29471) );
  AO21X1_RVT U5822 ( .A1(n4934), .A2(pcpi_rs1[14]), .A3(n5004), .Y(n3725) );
  AO22X1_RVT U5823 ( .A1(pcpi_rs1[14]), .A2(n4054), .A3(n4934), .A4(
        pcpi_rs1[13]), .Y(n5786) );
  AND2X1_RVT U5824 ( .A1(n4031), .A2(n4857), .Y(n4532) );
  NBUFFX2_RVT U5825 ( .A(n4533), .Y(n4633) );
  OR2X1_RVT U5826 ( .A1(n4534), .A2(n5292), .Y(n4865) );
  OR2X1_RVT U5827 ( .A1(net29419), .A2(n7814), .Y(n7815) );
  NBUFFX2_RVT U5828 ( .A(net24034), .Y(net29439) );
  NBUFFX2_RVT U5829 ( .A(net24034), .Y(net29438) );
  NBUFFX2_RVT U5830 ( .A(net24034), .Y(net27439) );
  OAI22X1_RVT U5831 ( .A1(n7969), .A2(n6354), .A3(n4542), .A4(n6361), .Y(n3692) );
  AO221X1_RVT U5832 ( .A1(n4645), .A2(n4644), .A3(n4645), .A4(n4808), .A5(
        n6429), .Y(n4542) );
  NAND2X0_RVT U5833 ( .A1(n4545), .A2(n4546), .Y(n6207) );
  NBUFFX2_RVT U5834 ( .A(n4385), .Y(n4564) );
  NBUFFX2_RVT U5835 ( .A(n4385), .Y(n4565) );
  NBUFFX2_RVT U5836 ( .A(n4099), .Y(n4597) );
  INVX0_RVT U5837 ( .A(n8025), .Y(n4610) );
  INVX1_RVT U5838 ( .A(n6298), .Y(n6460) );
  NBUFFX2_RVT U5839 ( .A(n6460), .Y(n4731) );
  INVX1_RVT U5840 ( .A(n6299), .Y(n6461) );
  NBUFFX2_RVT U5841 ( .A(n6461), .Y(n4730) );
  INVX1_RVT U5842 ( .A(n5524), .Y(n6462) );
  NBUFFX2_RVT U5843 ( .A(n6462), .Y(n4732) );
  INVX1_RVT U5844 ( .A(n6041), .Y(n6085) );
  NBUFFX2_RVT U5845 ( .A(n6085), .Y(n4790) );
  INVX1_RVT U5846 ( .A(n6042), .Y(n6086) );
  NBUFFX2_RVT U5847 ( .A(n6086), .Y(n4788) );
  NBUFFX2_RVT U5848 ( .A(n6086), .Y(n4789) );
  NBUFFX2_RVT U5849 ( .A(n6932), .Y(n4800) );
  NBUFFX2_RVT U5850 ( .A(n6932), .Y(n4801) );
  NBUFFX2_RVT U5851 ( .A(n6932), .Y(n4799) );
  AND2X1_RVT U5852 ( .A1(n4242), .A2(cpu_state[2]), .Y(n4640) );
  AND3X1_RVT U5853 ( .A1(n4643), .A2(n8006), .A3(n7974), .Y(n4861) );
  NBUFFX2_RVT U5854 ( .A(n6312), .Y(n4647) );
  NBUFFX2_RVT U5855 ( .A(n6312), .Y(n4648) );
  NBUFFX2_RVT U5856 ( .A(n6312), .Y(n4649) );
  NBUFFX2_RVT U5857 ( .A(n6310), .Y(n4651) );
  NBUFFX2_RVT U5858 ( .A(n6310), .Y(n4652) );
  NBUFFX2_RVT U5859 ( .A(n6307), .Y(n4653) );
  NBUFFX2_RVT U5860 ( .A(n6307), .Y(n4654) );
  NBUFFX2_RVT U5861 ( .A(n6307), .Y(n4655) );
  NBUFFX2_RVT U5862 ( .A(n6306), .Y(n4656) );
  NBUFFX2_RVT U5863 ( .A(n6306), .Y(n4657) );
  NBUFFX2_RVT U5864 ( .A(n6315), .Y(n4659) );
  NBUFFX2_RVT U5865 ( .A(n6315), .Y(n4660) );
  NBUFFX2_RVT U5866 ( .A(n6315), .Y(n4661) );
  NBUFFX2_RVT U5867 ( .A(n6314), .Y(n4662) );
  NBUFFX2_RVT U5868 ( .A(n6314), .Y(n4663) );
  NBUFFX2_RVT U5869 ( .A(n6314), .Y(n4664) );
  NBUFFX2_RVT U5870 ( .A(n6313), .Y(n4665) );
  NBUFFX2_RVT U5871 ( .A(n6313), .Y(n4666) );
  NBUFFX2_RVT U5872 ( .A(n6313), .Y(n4667) );
  NBUFFX2_RVT U5873 ( .A(n6311), .Y(n4668) );
  NBUFFX2_RVT U5874 ( .A(n6311), .Y(n4669) );
  NAND2X0_RVT U5875 ( .A1(n6309), .A2(n6297), .Y(n4671) );
  NBUFFX2_RVT U5876 ( .A(n6356), .Y(n4688) );
  NBUFFX2_RVT U5877 ( .A(n6356), .Y(n4689) );
  NBUFFX2_RVT U5878 ( .A(n6356), .Y(n4690) );
  NBUFFX2_RVT U5879 ( .A(n6357), .Y(n4694) );
  NBUFFX2_RVT U5880 ( .A(n6357), .Y(n4695) );
  NBUFFX2_RVT U5881 ( .A(n6357), .Y(n4696) );
  NBUFFX2_RVT U5882 ( .A(n6358), .Y(n4700) );
  NBUFFX2_RVT U5883 ( .A(n6358), .Y(n4701) );
  NBUFFX2_RVT U5884 ( .A(n6172), .Y(n4706) );
  NBUFFX2_RVT U5885 ( .A(n6172), .Y(n4707) );
  NBUFFX2_RVT U5886 ( .A(n6172), .Y(n4708) );
  NBUFFX2_RVT U5887 ( .A(n6175), .Y(n4709) );
  NBUFFX2_RVT U5888 ( .A(n6175), .Y(n4710) );
  NBUFFX2_RVT U5889 ( .A(n6175), .Y(n4711) );
  NBUFFX2_RVT U5890 ( .A(n6417), .Y(n4712) );
  NBUFFX2_RVT U5891 ( .A(n6417), .Y(n4713) );
  NBUFFX2_RVT U5892 ( .A(n6417), .Y(n4714) );
  NBUFFX2_RVT U5893 ( .A(n6416), .Y(n4715) );
  NBUFFX2_RVT U5894 ( .A(n6416), .Y(n4716) );
  NBUFFX2_RVT U5895 ( .A(n6416), .Y(n4717) );
  NBUFFX2_RVT U5896 ( .A(n6170), .Y(n4718) );
  NBUFFX2_RVT U5897 ( .A(n6170), .Y(n4719) );
  NBUFFX2_RVT U5898 ( .A(n6170), .Y(n4720) );
  NBUFFX2_RVT U5899 ( .A(n6177), .Y(n4721) );
  NBUFFX2_RVT U5900 ( .A(n6177), .Y(n4722) );
  NBUFFX2_RVT U5901 ( .A(n6169), .Y(n4724) );
  NBUFFX2_RVT U5902 ( .A(n6169), .Y(n4725) );
  NBUFFX2_RVT U5903 ( .A(n6169), .Y(n4726) );
  NBUFFX2_RVT U5904 ( .A(n6178), .Y(n4727) );
  NBUFFX2_RVT U5905 ( .A(n6178), .Y(n4728) );
  NBUFFX2_RVT U5906 ( .A(n6178), .Y(n4729) );
  NBUFFX2_RVT U5907 ( .A(n6087), .Y(n4763) );
  NBUFFX2_RVT U5908 ( .A(n6087), .Y(n4764) );
  NBUFFX2_RVT U5909 ( .A(n6087), .Y(n4765) );
  NBUFFX2_RVT U5910 ( .A(n6084), .Y(n4767) );
  NBUFFX2_RVT U5911 ( .A(n6084), .Y(n4768) );
  NBUFFX2_RVT U5912 ( .A(n6084), .Y(n4769) );
  NBUFFX2_RVT U5913 ( .A(n6081), .Y(n4773) );
  NBUFFX2_RVT U5914 ( .A(n6081), .Y(n4774) );
  NBUFFX2_RVT U5915 ( .A(n6081), .Y(n4775) );
  NBUFFX2_RVT U5916 ( .A(n6167), .Y(n4777) );
  NBUFFX2_RVT U5917 ( .A(n6167), .Y(n4778) );
  NBUFFX2_RVT U5918 ( .A(n6167), .Y(n4779) );
  NAND2X0_RVT U5919 ( .A1(n6309), .A2(n6059), .Y(n4783) );
  AO21X1_RVT U5920 ( .A1(n7945), .A2(n7977), .A3(n7890), .Y(n4791) );
  AND2X1_RVT U5921 ( .A1(n7927), .A2(n4321), .Y(n5208) );
  OA22X1_RVT U5922 ( .A1(n4241), .A2(n4802), .A3(n7975), .A4(n7801), .Y(n7686)
         );
  AOI22X1_RVT U5923 ( .A1(reg_sh[4]), .A2(n7683), .A3(reg_sh[3]), .A4(
        reg_sh[2]), .Y(n4802) );
  OR2X1_RVT U5924 ( .A1(instr_srai), .A2(instr_sra), .Y(n4804) );
  OR2X1_RVT U5925 ( .A1(net26087), .A2(n4804), .Y(n4858) );
  OR2X1_RVT U5926 ( .A1(instr_srli), .A2(instr_srl), .Y(n4805) );
  AND2X1_RVT U5927 ( .A1(resetn), .A2(n5833), .Y(n4810) );
  AND2X1_RVT U5928 ( .A1(resetn), .A2(n5833), .Y(n4811) );
  AO222X1_RVT U5929 ( .A1(n4517), .A2(n6496), .A3(n4372), .A4(reg_out[18]), 
        .A5(n4097), .A6(alu_out_q[18]), .Y(n7953) );
  AO222X1_RVT U5930 ( .A1(n4518), .A2(n6067), .A3(n4371), .A4(reg_out[29]), 
        .A5(alu_out_q[29]), .A6(n4549), .Y(n7949) );
  AO222X1_RVT U5931 ( .A1(n4518), .A2(n6070), .A3(n4370), .A4(reg_out[28]), 
        .A5(alu_out_q[28]), .A6(n4097), .Y(n7950) );
  NAND2X0_RVT U5932 ( .A1(mem_do_wdata), .A2(n7900), .Y(n7941) );
  OR2X1_RVT U5933 ( .A1(decoded_imm[25]), .A2(reg_pc[25]), .Y(n4968) );
  OR2X1_RVT U5934 ( .A1(decoded_imm[24]), .A2(reg_pc[24]), .Y(n4967) );
  AND2X1_RVT U5935 ( .A1(n4291), .A2(n4856), .Y(n4857) );
  AOI22X1_RVT U5936 ( .A1(n4843), .A2(n4312), .A3(n4842), .A4(n6855), .Y(n4844) );
  AO22X1_RVT U5937 ( .A1(reg_pc[24]), .A2(decoded_imm[24]), .A3(n6610), .A4(
        n4967), .Y(n5683) );
  OR2X1_RVT U5938 ( .A1(decoded_imm[9]), .A2(reg_pc[9]), .Y(n4963) );
  AND2X1_RVT U5939 ( .A1(n4845), .A2(n4844), .Y(n4846) );
  AO21X1_RVT U5940 ( .A1(reg_pc[17]), .A2(net24496), .A3(n5124), .Y(n5125) );
  AND2X1_RVT U5941 ( .A1(n4858), .A2(resetn), .Y(n4859) );
  XOR2X1_RVT U5942 ( .A1(n4610), .A2(pcpi_rs2[26]), .Y(n6285) );
  XOR2X1_RVT U5943 ( .A1(n4209), .A2(pcpi_rs2[16]), .Y(n6226) );
  XOR2X1_RVT U5944 ( .A1(n4069), .A2(pcpi_rs2[13]), .Y(n6258) );
  XOR2X1_RVT U5945 ( .A1(n4209), .A2(pcpi_rs2[11]), .Y(n6392) );
  XOR2X1_RVT U5946 ( .A1(n4069), .A2(pcpi_rs2[10]), .Y(n6234) );
  XOR2X1_RVT U5947 ( .A1(n4209), .A2(pcpi_rs2[6]), .Y(n6408) );
  OR2X1_RVT U5948 ( .A1(decoded_imm[30]), .A2(reg_pc[30]), .Y(n6811) );
  OR2X1_RVT U5949 ( .A1(decoded_imm[11]), .A2(reg_pc[11]), .Y(n4965) );
  OR2X1_RVT U5950 ( .A1(n5125), .A2(net26329), .Y(n5126) );
  XOR2X1_RVT U5951 ( .A1(n4209), .A2(pcpi_rs2[24]), .Y(n7530) );
  XOR2X1_RVT U5952 ( .A1(n4069), .A2(pcpi_rs2[17]), .Y(n7575) );
  XOR2X1_RVT U5953 ( .A1(n4069), .A2(pcpi_rs2[15]), .Y(n7588) );
  XOR2X1_RVT U5954 ( .A1(instr_sub), .A2(pcpi_rs2[5]), .Y(net23071) );
  AO222X1_RVT U5955 ( .A1(n4517), .A2(n6284), .A3(n4370), .A4(reg_out[31]), 
        .A5(alu_out_q[31]), .A6(n4097), .Y(n6525) );
  AO222X1_RVT U5956 ( .A1(n4519), .A2(n6183), .A3(n4370), .A4(reg_out[27]), 
        .A5(n6063), .A6(alu_out_q[27]), .Y(n7951) );
  AO222X1_RVT U5957 ( .A1(n4518), .A2(n6510), .A3(n4370), .A4(reg_out[24]), 
        .A5(n4549), .A6(alu_out_q[24]), .Y(n6709) );
  AO222X1_RVT U5958 ( .A1(n4517), .A2(n6516), .A3(n4372), .A4(reg_out[23]), 
        .A5(alu_out_q[23]), .A6(n4548), .Y(n6710) );
  AO222X1_RVT U5959 ( .A1(n4518), .A2(n6507), .A3(n4372), .A4(reg_out[20]), 
        .A5(alu_out_q[20]), .A6(n6063), .Y(n7952) );
  AO222X1_RVT U5960 ( .A1(n4517), .A2(n6164), .A3(n4370), .A4(reg_out[16]), 
        .A5(n4098), .A6(alu_out_q[16]), .Y(n6524) );
  XNOR2X1_RVT U5961 ( .A1(n7680), .A2(n7679), .Y(n7681) );
  OR2X1_RVT U5962 ( .A1(n4979), .A2(n4978), .Y(n4980) );
  AO222X1_RVT U5963 ( .A1(latched_branch), .A2(n6514), .A3(n4372), .A4(
        reg_out[30]), .A5(n6063), .A6(alu_out_q[30]), .Y(n6712) );
  AO21X1_RVT U5964 ( .A1(pcpi_rs1[10]), .A2(n4055), .A3(n5231), .Y(n5232) );
  AO21X1_RVT U5965 ( .A1(pcpi_rs1[24]), .A2(n4054), .A3(n5203), .Y(n5204) );
  MUX21X1_RVT U5966 ( .A1(reg_next_pc[5]), .A2(reg_out[5]), .S0(n4219), .Y(
        n6929) );
  MUX21X1_RVT U5967 ( .A1(reg_next_pc[13]), .A2(reg_out[13]), .S0(n4229), .Y(
        n6937) );
  MUX21X1_RVT U5968 ( .A1(reg_next_pc[24]), .A2(reg_out[24]), .S0(n4630), .Y(
        n6943) );
  OAI222X1_RVT U5969 ( .A1(n7685), .A2(net29419), .A3(net26648), .A4(n7987), 
        .A5(net26650), .A6(net26760), .Y(n3927) );
  OR2X1_RVT U5970 ( .A1(n5150), .A2(n5149), .Y(N1922) );
  MUX21X1_RVT U5971 ( .A1(n2513), .A2(decoded_imm_j[10]), .S0(n4541), .Y(n3617) );
  MUX21X1_RVT U5972 ( .A1(n2523), .A2(decoded_imm_j[11]), .S0(n4540), .Y(n3616) );
  MUX21X1_RVT U5973 ( .A1(n2512), .A2(decoded_imm_j[31]), .S0(n4541), .Y(n3607) );
  AND2X1_RVT U5974 ( .A1(cpu_state[5]), .A2(n8006), .Y(n4814) );
  NOR3X0_RVT U5975 ( .A1(instr_rdcycle), .A2(instr_rdinstr), .A3(
        instr_rdcycleh), .Y(n4974) );
  NOR4X1_RVT U5976 ( .A1(instr_rdcycle), .A2(instr_rdinstr), .A3(
        instr_rdcycleh), .A4(instr_rdinstrh), .Y(n7820) );
  NAND2X0_RVT U5977 ( .A1(n7969), .A2(n8025), .Y(n4815) );
  NOR4X1_RVT U5978 ( .A1(instr_add), .A2(instr_addi), .A3(N282), .A4(n4815), 
        .Y(n5954) );
  NOR4X1_RVT U5979 ( .A1(instr_bge), .A2(instr_beq), .A3(N284), .A4(n4858), 
        .Y(n4820) );
  OR2X1_RVT U5980 ( .A1(instr_and), .A2(instr_andi), .Y(n5136) );
  NOR4X1_RVT U5981 ( .A1(instr_bne), .A2(instr_bgeu), .A3(n5134), .A4(n5136), 
        .Y(n4818) );
  OR2X1_RVT U5982 ( .A1(instr_lh), .A2(instr_lb), .Y(n5238) );
  NOR4X1_RVT U5983 ( .A1(instr_fence), .A2(N286), .A3(N285), .A4(n5238), .Y(
        n4816) );
  AND4X1_RVT U5984 ( .A1(n5135), .A2(n4818), .A3(n4817), .A4(n4816), .Y(n4819)
         );
  NAND4X0_RVT U5985 ( .A1(n4820), .A2(n5954), .A3(n7820), .A4(n4819), .Y(n7936) );
  NAND3X0_RVT U5986 ( .A1(n4974), .A2(n8037), .A3(n4324), .Y(n4851) );
  OR2X1_RVT U5987 ( .A1(is_lui_auipc_jal), .A2(n4851), .Y(n4870) );
  NOR4X1_RVT U5988 ( .A1(is_jalr_addi_slti_sltiu_xori_ori_andi), .A2(
        is_lb_lh_lw_lbu_lhu), .A3(is_slli_srli_srai), .A4(n4870), .Y(n7925) );
  AND2X1_RVT U5989 ( .A1(n4806), .A2(n7925), .Y(n7253) );
  AND2X1_RVT U5990 ( .A1(decoded_imm_j[1]), .A2(n7979), .Y(n4833) );
  AND3X1_RVT U5991 ( .A1(decoded_imm_j[4]), .A2(decoded_imm_j[2]), .A3(n7975), 
        .Y(n7233) );
  AND2X1_RVT U5992 ( .A1(decoded_imm_j[11]), .A2(n8016), .Y(n4831) );
  AO22X1_RVT U5993 ( .A1(\cpuregs[30][3] ), .A2(n4501), .A3(\cpuregs[21][3] ), 
        .A4(n4446), .Y(n4824) );
  AND2X1_RVT U5994 ( .A1(decoded_imm_j[11]), .A2(decoded_imm_j[1]), .Y(n4832)
         );
  AO22X1_RVT U5995 ( .A1(n4461), .A2(\cpuregs[10][3] ), .A3(n4465), .A4(
        \cpuregs[31][3] ), .Y(n4823) );
  AND3X1_RVT U5996 ( .A1(decoded_imm_j[4]), .A2(n7975), .A3(n8017), .Y(n7227)
         );
  AO22X1_RVT U5997 ( .A1(\cpuregs[9][3] ), .A2(n4468), .A3(\cpuregs[19][3] ), 
        .A4(n4498), .Y(n4822) );
  AND3X1_RVT U5998 ( .A1(decoded_imm_j[2]), .A2(n7975), .A3(n8014), .Y(n4838)
         );
  AO22X1_RVT U5999 ( .A1(\cpuregs[13][3] ), .A2(n4452), .A3(\cpuregs[5][3] ), 
        .A4(n4477), .Y(n4821) );
  NOR4X1_RVT U6000 ( .A1(n4824), .A2(n4823), .A3(n4822), .A4(n4821), .Y(n4849)
         );
  AO22X1_RVT U6001 ( .A1(\cpuregs[23][3] ), .A2(n4443), .A3(\cpuregs[18][3] ), 
        .A4(n4504), .Y(n4828) );
  AND2X1_RVT U6002 ( .A1(n4830), .A2(n4832), .Y(n7376) );
  AND3X1_RVT U6003 ( .A1(decoded_imm_j[4]), .A2(decoded_imm_j[3]), .A3(n8017), 
        .Y(n7228) );
  AO22X1_RVT U6004 ( .A1(\cpuregs[3][3] ), .A2(n4429), .A3(\cpuregs[25][3] ), 
        .A4(n4480), .Y(n4827) );
  AO22X1_RVT U6005 ( .A1(\cpuregs[27][3] ), .A2(n4455), .A3(\cpuregs[14][3] ), 
        .A4(n4471), .Y(n4826) );
  AO22X1_RVT U6006 ( .A1(\cpuregs[17][3] ), .A2(n4492), .A3(\cpuregs[2][3] ), 
        .A4(n4464), .Y(n4825) );
  NOR4X1_RVT U6007 ( .A1(n4828), .A2(n4827), .A3(n4826), .A4(n4825), .Y(n4847)
         );
  AO22X1_RVT U6008 ( .A1(\cpuregs[22][3] ), .A2(n4495), .A3(\cpuregs[26][3] ), 
        .A4(n4510), .Y(n4837) );
  AO22X1_RVT U6009 ( .A1(\cpuregs[15][3] ), .A2(n4489), .A3(\cpuregs[1][3] ), 
        .A4(n4483), .Y(n4836) );
  AO22X1_RVT U6010 ( .A1(\cpuregs[29][3] ), .A2(n4507), .A3(\cpuregs[7][3] ), 
        .A4(n4437), .Y(n4835) );
  AO22X1_RVT U6011 ( .A1(\cpuregs[11][3] ), .A2(n4474), .A3(\cpuregs[6][3] ), 
        .A4(n4458), .Y(n4834) );
  NOR4X1_RVT U6012 ( .A1(n4837), .A2(n4836), .A3(n4835), .A4(n4834), .Y(n4845)
         );
  AO22X1_RVT U6013 ( .A1(\cpuregs[28][3] ), .A2(n7229), .A3(\cpuregs[20][3] ), 
        .A4(n7233), .Y(n4843) );
  OR2X1_RVT U6014 ( .A1(n4840), .A2(n4839), .Y(n4841) );
  AND2X1_RVT U6015 ( .A1(n4847), .A2(n4846), .Y(n4848) );
  NAND2X0_RVT U6016 ( .A1(n7253), .A2(n4850), .Y(n7685) );
  NAND2X0_RVT U6017 ( .A1(resetn), .A2(n4321), .Y(net24034) );
  NOR2X0_RVT U6018 ( .A1(is_lb_lh_lw_lbu_lhu), .A2(is_slli_srli_srai), .Y(
        n4852) );
  OA221X1_RVT U6019 ( .A1(is_lui_auipc_jal), .A2(
        is_jalr_addi_slti_sltiu_xori_ori_andi), .A3(is_lui_auipc_jal), .A4(
        n4852), .A5(n4379), .Y(n7929) );
  NOR2X0_RVT U6020 ( .A1(cpu_state[0]), .A2(cpu_state[7]), .Y(n4854) );
  AND2X1_RVT U6021 ( .A1(n7977), .A2(n8008), .Y(n7912) );
  NAND2X0_RVT U6022 ( .A1(n4635), .A2(n6207), .Y(n7892) );
  NAND3X0_RVT U6023 ( .A1(mem_do_rinst), .A2(mem_state[1]), .A3(mem_state[0]), 
        .Y(n7898) );
  AOI22X1_RVT U6024 ( .A1(n7980), .A2(n7912), .A3(n7898), .A4(n7892), .Y(n5292) );
  AND3X1_RVT U6025 ( .A1(n5234), .A2(n7977), .A3(n4865), .Y(n7904) );
  NAND2X0_RVT U6026 ( .A1(resetn), .A2(n7904), .Y(n4867) );
  OR2X1_RVT U6027 ( .A1(N1600), .A2(N1599), .Y(n4856) );
  NAND2X0_RVT U6028 ( .A1(n4634), .A2(n4857), .Y(n4868) );
  NAND2X0_RVT U6029 ( .A1(n4868), .A2(net30554), .Y(net24605) );
  NAND2X0_RVT U6030 ( .A1(net24605), .A2(n4859), .Y(n4866) );
  NOR2X0_RVT U6031 ( .A1(cpu_state[1]), .A2(cpu_state[2]), .Y(n4863) );
  AND2X1_RVT U6032 ( .A1(cpu_state[0]), .A2(n4638), .Y(n4860) );
  AND2X1_RVT U6033 ( .A1(n4861), .A2(n4860), .Y(n4862) );
  AND2X1_RVT U6034 ( .A1(n4972), .A2(n8008), .Y(n4864) );
  NAND2X0_RVT U6035 ( .A1(n4865), .A2(n4864), .Y(n7814) );
  NAND2X0_RVT U6036 ( .A1(net30560), .A2(n4057), .Y(n6617) );
  NAND2X0_RVT U6037 ( .A1(n4116), .A2(n4532), .Y(n5530) );
  OA22X1_RVT U6038 ( .A1(n6617), .A2(net16448), .A3(n5102), .A4(net16340), .Y(
        n4907) );
  NAND2X0_RVT U6039 ( .A1(n4532), .A2(n4869), .Y(net25875) );
  NAND2X0_RVT U6040 ( .A1(n4934), .A2(pcpi_rs1[8]), .Y(n4906) );
  NAND2X0_RVT U6041 ( .A1(n4054), .A2(pcpi_rs1[9]), .Y(n4905) );
  AND2X1_RVT U6042 ( .A1(decoded_imm_j[16]), .A2(decoded_imm_j[15]), .Y(n4891)
         );
  AND3X1_RVT U6043 ( .A1(decoded_imm_j[18]), .A2(decoded_imm_j[17]), .A3(n7968), .Y(n4880) );
  AND2X1_RVT U6044 ( .A1(decoded_imm_j[16]), .A2(n8019), .Y(n4888) );
  AND3X1_RVT U6045 ( .A1(n7968), .A2(n7978), .A3(n8013), .Y(n4890) );
  AND2X1_RVT U6046 ( .A1(n7982), .A2(n8019), .Y(n4892) );
  AO22X1_RVT U6047 ( .A1(n4389), .A2(\cpuregs[2][9] ), .A3(n4440), .A4(
        \cpuregs[4][9] ), .Y(n4873) );
  AO22X1_RVT U6048 ( .A1(n4361), .A2(\cpuregs[11][9] ), .A3(n4434), .A4(
        \cpuregs[10][9] ), .Y(n4872) );
  AO22X1_RVT U6049 ( .A1(n4358), .A2(\cpuregs[18][9] ), .A3(n4423), .A4(
        \cpuregs[7][9] ), .Y(n4871) );
  NOR4X1_RVT U6050 ( .A1(n4874), .A2(n4873), .A3(n4872), .A4(n4871), .Y(n4901)
         );
  AO22X1_RVT U6051 ( .A1(n4364), .A2(\cpuregs[8][9] ), .A3(n4392), .A4(
        \cpuregs[31][9] ), .Y(n4878) );
  AND2X1_RVT U6052 ( .A1(decoded_imm_j[15]), .A2(n7982), .Y(n4889) );
  AO22X1_RVT U6053 ( .A1(n4382), .A2(\cpuregs[16][9] ), .A3(n4431), .A4(
        \cpuregs[13][9] ), .Y(n4877) );
  AO22X1_RVT U6054 ( .A1(n4333), .A2(\cpuregs[25][9] ), .A3(n4415), .A4(
        \cpuregs[28][9] ), .Y(n4876) );
  AO22X1_RVT U6055 ( .A1(n4336), .A2(\cpuregs[19][9] ), .A3(n4344), .A4(
        \cpuregs[6][9] ), .Y(n4875) );
  NOR4X1_RVT U6056 ( .A1(n4878), .A2(n4877), .A3(n4876), .A4(n4875), .Y(n4900)
         );
  AO22X1_RVT U6057 ( .A1(n4386), .A2(\cpuregs[23][9] ), .A3(n4405), .A4(
        \cpuregs[29][9] ), .Y(n4885) );
  AND2X1_RVT U6058 ( .A1(n4879), .A2(n4414), .Y(n6725) );
  AO22X1_RVT U6059 ( .A1(n6725), .A2(\cpuregs[9][9] ), .A3(n4408), .A4(
        \cpuregs[12][9] ), .Y(n4884) );
  AO22X1_RVT U6060 ( .A1(n4402), .A2(\cpuregs[14][9] ), .A3(n4419), .A4(
        \cpuregs[30][9] ), .Y(n4883) );
  AO22X1_RVT U6061 ( .A1(n5017), .A2(\cpuregs[22][9] ), .A3(n6761), .A4(
        \cpuregs[17][9] ), .Y(n4882) );
  NOR4X1_RVT U6062 ( .A1(n4885), .A2(n4884), .A3(n4883), .A4(n4882), .Y(n4899)
         );
  AO22X1_RVT U6063 ( .A1(n4367), .A2(\cpuregs[5][9] ), .A3(n4449), .A4(
        \cpuregs[21][9] ), .Y(n4897) );
  AO22X1_RVT U6064 ( .A1(n4346), .A2(\cpuregs[20][9] ), .A3(n4411), .A4(
        \cpuregs[26][9] ), .Y(n4896) );
  AO22X1_RVT U6065 ( .A1(n4373), .A2(\cpuregs[1][9] ), .A3(n6592), .A4(
        \cpuregs[3][9] ), .Y(n4895) );
  NOR4X1_RVT U6066 ( .A1(n4897), .A2(n4896), .A3(n4895), .A4(n4894), .Y(n4898)
         );
  NAND4X0_RVT U6067 ( .A1(n4901), .A2(n4900), .A3(n4899), .A4(n4898), .Y(n4902) );
  AO22X1_RVT U6068 ( .A1(n4059), .A2(n4902), .A3(net24496), .A4(reg_pc[9]), 
        .Y(n4903) );
  NAND4X0_RVT U6069 ( .A1(n4907), .A2(n4906), .A3(n4905), .A4(n4904), .Y(n3731) );
  OA22X1_RVT U6070 ( .A1(n6617), .A2(net16362), .A3(n5102), .A4(net16451), .Y(
        n4933) );
  NAND2X0_RVT U6071 ( .A1(n4934), .A2(pcpi_rs1[22]), .Y(n4932) );
  NAND2X0_RVT U6072 ( .A1(n4055), .A2(pcpi_rs1[23]), .Y(n4931) );
  AND2X1_RVT U6073 ( .A1(n4387), .A2(\cpuregs[23][23] ), .Y(n4911) );
  AO22X1_RVT U6074 ( .A1(n4330), .A2(\cpuregs[22][23] ), .A3(n4417), .A4(
        \cpuregs[28][23] ), .Y(n4910) );
  AO22X1_RVT U6075 ( .A1(n4326), .A2(\cpuregs[27][23] ), .A3(n4359), .A4(
        \cpuregs[18][23] ), .Y(n4909) );
  AO22X1_RVT U6076 ( .A1(n4344), .A2(\cpuregs[6][23] ), .A3(n4393), .A4(
        \cpuregs[31][23] ), .Y(n4908) );
  NOR4X1_RVT U6077 ( .A1(n4911), .A2(n4910), .A3(n4909), .A4(n4908), .Y(n4927)
         );
  AO22X1_RVT U6078 ( .A1(n4402), .A2(\cpuregs[14][23] ), .A3(n4434), .A4(
        \cpuregs[10][23] ), .Y(n4915) );
  AO22X1_RVT U6079 ( .A1(n4419), .A2(\cpuregs[30][23] ), .A3(n4432), .A4(
        \cpuregs[13][23] ), .Y(n4914) );
  AO22X1_RVT U6080 ( .A1(n6761), .A2(\cpuregs[17][23] ), .A3(n4487), .A4(
        \cpuregs[24][23] ), .Y(n4913) );
  AO22X1_RVT U6081 ( .A1(n4348), .A2(\cpuregs[20][23] ), .A3(n4451), .A4(
        \cpuregs[21][23] ), .Y(n4912) );
  NOR4X1_RVT U6082 ( .A1(n4915), .A2(n4914), .A3(n4913), .A4(n4912), .Y(n4926)
         );
  AO22X1_RVT U6083 ( .A1(n4389), .A2(\cpuregs[2][23] ), .A3(n4411), .A4(
        \cpuregs[26][23] ), .Y(n4919) );
  AO22X1_RVT U6084 ( .A1(n4405), .A2(\cpuregs[29][23] ), .A3(n4361), .A4(
        \cpuregs[11][23] ), .Y(n4918) );
  AO22X1_RVT U6085 ( .A1(n4333), .A2(\cpuregs[25][23] ), .A3(n4365), .A4(
        \cpuregs[8][23] ), .Y(n4917) );
  AO22X1_RVT U6086 ( .A1(n4369), .A2(\cpuregs[5][23] ), .A3(n4383), .A4(
        \cpuregs[16][23] ), .Y(n4916) );
  NOR4X1_RVT U6087 ( .A1(n4919), .A2(n4918), .A3(n4917), .A4(n4916), .Y(n4925)
         );
  AO22X1_RVT U6088 ( .A1(n4336), .A2(\cpuregs[19][23] ), .A3(n4373), .A4(
        \cpuregs[1][23] ), .Y(n4923) );
  AO22X1_RVT U6089 ( .A1(n6725), .A2(\cpuregs[9][23] ), .A3(n4408), .A4(
        \cpuregs[12][23] ), .Y(n4922) );
  AO22X1_RVT U6090 ( .A1(n4422), .A2(\cpuregs[7][23] ), .A3(n4440), .A4(
        \cpuregs[4][23] ), .Y(n4921) );
  AO22X1_RVT U6091 ( .A1(n4273), .A2(\cpuregs[15][23] ), .A3(n4428), .A4(
        \cpuregs[3][23] ), .Y(n4920) );
  NOR4X1_RVT U6092 ( .A1(n4923), .A2(n4922), .A3(n4921), .A4(n4920), .Y(n4924)
         );
  NAND4X0_RVT U6093 ( .A1(n4927), .A2(n4926), .A3(n4925), .A4(n4924), .Y(n4928) );
  AO22X1_RVT U6094 ( .A1(reg_pc[23]), .A2(net24496), .A3(n4059), .A4(n4928), 
        .Y(n4929) );
  NAND4X0_RVT U6095 ( .A1(n4933), .A2(n4932), .A3(n4931), .A4(n4930), .Y(n3717) );
  OA22X1_RVT U6096 ( .A1(n6617), .A2(net16453), .A3(n5102), .A4(net16339), .Y(
        n4961) );
  NAND2X0_RVT U6097 ( .A1(n4934), .A2(pcpi_rs1[24]), .Y(n4960) );
  NAND2X0_RVT U6098 ( .A1(n4055), .A2(pcpi_rs1[25]), .Y(n4959) );
  AO22X1_RVT U6099 ( .A1(n4349), .A2(\cpuregs[9][25] ), .A3(n4348), .A4(
        \cpuregs[20][25] ), .Y(n4937) );
  AO22X1_RVT U6100 ( .A1(n4367), .A2(\cpuregs[5][25] ), .A3(n4433), .A4(
        \cpuregs[13][25] ), .Y(n4936) );
  AO22X1_RVT U6101 ( .A1(n4330), .A2(\cpuregs[22][25] ), .A3(n4334), .A4(
        \cpuregs[25][25] ), .Y(n4935) );
  NOR4X1_RVT U6102 ( .A1(n4938), .A2(n4937), .A3(n4936), .A4(n4935), .Y(n4955)
         );
  AO22X1_RVT U6103 ( .A1(n4364), .A2(\cpuregs[8][25] ), .A3(n4434), .A4(
        \cpuregs[10][25] ), .Y(n4942) );
  AO22X1_RVT U6104 ( .A1(n4361), .A2(\cpuregs[11][25] ), .A3(n4416), .A4(
        \cpuregs[28][25] ), .Y(n4941) );
  AO22X1_RVT U6105 ( .A1(n4389), .A2(\cpuregs[2][25] ), .A3(n4440), .A4(
        \cpuregs[4][25] ), .Y(n4940) );
  AO22X1_RVT U6106 ( .A1(n4406), .A2(\cpuregs[29][25] ), .A3(n4404), .A4(
        \cpuregs[14][25] ), .Y(n4939) );
  NOR4X1_RVT U6107 ( .A1(n4942), .A2(n4941), .A3(n4940), .A4(n4939), .Y(n4954)
         );
  AO22X1_RVT U6108 ( .A1(n4358), .A2(\cpuregs[18][25] ), .A3(n4486), .A4(
        \cpuregs[24][25] ), .Y(n4947) );
  AO22X1_RVT U6109 ( .A1(n6645), .A2(\cpuregs[27][25] ), .A3(n4423), .A4(
        \cpuregs[7][25] ), .Y(n4946) );
  AO22X1_RVT U6110 ( .A1(n4373), .A2(\cpuregs[1][25] ), .A3(n4426), .A4(
        \cpuregs[17][25] ), .Y(n4945) );
  AO22X1_RVT U6111 ( .A1(n4387), .A2(\cpuregs[23][25] ), .A3(n4421), .A4(
        \cpuregs[30][25] ), .Y(n4944) );
  NOR4X1_RVT U6112 ( .A1(n4947), .A2(n4946), .A3(n4945), .A4(n4944), .Y(n4953)
         );
  AO22X1_RVT U6113 ( .A1(n4408), .A2(\cpuregs[12][25] ), .A3(n4449), .A4(
        \cpuregs[21][25] ), .Y(n4951) );
  AO22X1_RVT U6114 ( .A1(n6581), .A2(\cpuregs[6][25] ), .A3(n4392), .A4(
        \cpuregs[31][25] ), .Y(n4950) );
  AO22X1_RVT U6115 ( .A1(n4336), .A2(\cpuregs[19][25] ), .A3(n4427), .A4(
        \cpuregs[3][25] ), .Y(n4949) );
  AO22X1_RVT U6116 ( .A1(n4383), .A2(\cpuregs[16][25] ), .A3(n4412), .A4(
        \cpuregs[26][25] ), .Y(n4948) );
  NOR4X1_RVT U6117 ( .A1(n4951), .A2(n4950), .A3(n4949), .A4(n4948), .Y(n4952)
         );
  NAND4X0_RVT U6118 ( .A1(n4955), .A2(n4954), .A3(n4953), .A4(n4952), .Y(n4956) );
  AO22X1_RVT U6119 ( .A1(reg_pc[25]), .A2(net24496), .A3(n4061), .A4(n4956), 
        .Y(n4957) );
  NAND4X0_RVT U6120 ( .A1(n4961), .A2(n4960), .A3(n4959), .A4(n4958), .Y(n3715) );
  AND2X1_RVT U6121 ( .A1(decoded_imm[1]), .A2(reg_pc[1]), .Y(n7701) );
  AO222X1_RVT U6122 ( .A1(decoded_imm[2]), .A2(n7701), .A3(decoded_imm[2]), 
        .A4(reg_pc[2]), .A5(n7701), .A6(reg_pc[2]), .Y(n7708) );
  AO222X1_RVT U6123 ( .A1(reg_pc[5]), .A2(decoded_imm[5]), .A3(reg_pc[5]), 
        .A4(n7723), .A5(n7723), .A6(decoded_imm[5]), .Y(net22948) );
  OR2X1_RVT U6124 ( .A1(decoded_imm[8]), .A2(reg_pc[8]), .Y(n4962) );
  AO22X1_RVT U6125 ( .A1(decoded_imm[9]), .A2(reg_pc[9]), .A3(n7740), .A4(
        n4963), .Y(n7748) );
  OR2X1_RVT U6126 ( .A1(decoded_imm[10]), .A2(reg_pc[10]), .Y(n4964) );
  AO22X1_RVT U6127 ( .A1(reg_pc[10]), .A2(decoded_imm[10]), .A3(n7748), .A4(
        n4964), .Y(n7755) );
  AO22X1_RVT U6128 ( .A1(reg_pc[11]), .A2(decoded_imm[11]), .A3(n7755), .A4(
        n4965), .Y(n6527) );
  AO222X1_RVT U6129 ( .A1(reg_pc[13]), .A2(decoded_imm[13]), .A3(reg_pc[13]), 
        .A4(n7763), .A5(decoded_imm[13]), .A6(n7763), .Y(n7772) );
  OR2X1_RVT U6130 ( .A1(decoded_imm[23]), .A2(reg_pc[23]), .Y(n4966) );
  AO22X1_RVT U6131 ( .A1(decoded_imm[25]), .A2(reg_pc[25]), .A3(n5683), .A4(
        n4968), .Y(n5691) );
  AO22X1_RVT U6132 ( .A1(decoded_imm[28]), .A2(reg_pc[28]), .A3(n5707), .A4(
        n4969), .Y(n6794) );
  OR2X1_RVT U6133 ( .A1(decoded_imm[29]), .A2(reg_pc[29]), .Y(n4970) );
  AO22X1_RVT U6134 ( .A1(decoded_imm[29]), .A2(reg_pc[29]), .A3(n6794), .A4(
        n4970), .Y(n6812) );
  AND2X1_RVT U6135 ( .A1(n7974), .A2(n8006), .Y(n4971) );
  NOR3X0_RVT U6136 ( .A1(cpu_state[1]), .A2(cpu_state[0]), .A3(n4639), .Y(
        n7688) );
  AO22X1_RVT U6137 ( .A1(count_cycle[62]), .A2(n4259), .A3(count_instr[30]), 
        .A4(n4351), .Y(n4979) );
  NOR2X0_RVT U6138 ( .A1(latched_is_lu), .A2(latched_is_lh), .Y(n6529) );
  NAND4X0_RVT U6139 ( .A1(latched_is_lb), .A2(n4972), .A3(mem_rdata_word[7]), 
        .A4(n6529), .Y(n7733) );
  NAND4X0_RVT U6140 ( .A1(n4972), .A2(latched_is_lh), .A3(mem_rdata_word[15]), 
        .A4(n8049), .Y(n4973) );
  AOI22X1_RVT U6141 ( .A1(count_instr[62]), .A2(n7788), .A3(n4633), .A4(
        pcpi_rs1[30]), .Y(n4977) );
  NAND2X0_RVT U6142 ( .A1(n6573), .A2(mem_rdata_word[30]), .Y(n4976) );
  NAND2X0_RVT U6143 ( .A1(count_cycle[30]), .A2(n4356), .Y(n4975) );
  NAND4X0_RVT U6144 ( .A1(n6817), .A2(n4977), .A3(n4976), .A4(n4975), .Y(n4978) );
  AND2X1_RVT U6145 ( .A1(n4405), .A2(\cpuregs[29][15] ), .Y(n4985) );
  AO22X1_RVT U6146 ( .A1(n4415), .A2(\cpuregs[28][15] ), .A3(n4449), .A4(
        \cpuregs[21][15] ), .Y(n4984) );
  AO22X1_RVT U6147 ( .A1(n4368), .A2(\cpuregs[5][15] ), .A3(n4426), .A4(
        \cpuregs[17][15] ), .Y(n4982) );
  NOR4X1_RVT U6148 ( .A1(n4985), .A2(n4984), .A3(n4983), .A4(n4982), .Y(n5001)
         );
  AO22X1_RVT U6149 ( .A1(n6725), .A2(\cpuregs[9][15] ), .A3(n4408), .A4(
        \cpuregs[12][15] ), .Y(n4989) );
  AO22X1_RVT U6150 ( .A1(n4389), .A2(\cpuregs[2][15] ), .A3(n4386), .A4(
        \cpuregs[23][15] ), .Y(n4988) );
  AO22X1_RVT U6151 ( .A1(n4273), .A2(\cpuregs[15][15] ), .A3(n4404), .A4(
        \cpuregs[14][15] ), .Y(n4987) );
  AO22X1_RVT U6152 ( .A1(n4329), .A2(\cpuregs[22][15] ), .A3(n4421), .A4(
        \cpuregs[30][15] ), .Y(n4986) );
  NOR4X1_RVT U6153 ( .A1(n4989), .A2(n4988), .A3(n4987), .A4(n4986), .Y(n5000)
         );
  AO22X1_RVT U6154 ( .A1(n6581), .A2(\cpuregs[6][15] ), .A3(n4427), .A4(
        \cpuregs[3][15] ), .Y(n4993) );
  AO22X1_RVT U6155 ( .A1(n4411), .A2(\cpuregs[26][15] ), .A3(n4440), .A4(
        \cpuregs[4][15] ), .Y(n4992) );
  AO22X1_RVT U6156 ( .A1(n4373), .A2(\cpuregs[1][15] ), .A3(n4423), .A4(
        \cpuregs[7][15] ), .Y(n4990) );
  NOR4X1_RVT U6157 ( .A1(n4993), .A2(n4992), .A3(n4991), .A4(n4990), .Y(n4999)
         );
  AO22X1_RVT U6158 ( .A1(n4336), .A2(\cpuregs[19][15] ), .A3(n4392), .A4(
        \cpuregs[31][15] ), .Y(n4997) );
  AO22X1_RVT U6159 ( .A1(n4382), .A2(\cpuregs[16][15] ), .A3(n4486), .A4(
        \cpuregs[24][15] ), .Y(n4996) );
  AO22X1_RVT U6160 ( .A1(n4358), .A2(\cpuregs[18][15] ), .A3(n4431), .A4(
        \cpuregs[13][15] ), .Y(n4994) );
  NOR4X1_RVT U6161 ( .A1(n4997), .A2(n4996), .A3(n4995), .A4(n4994), .Y(n4998)
         );
  NAND4X0_RVT U6162 ( .A1(n5001), .A2(n5000), .A3(n4999), .A4(n4998), .Y(n5002) );
  AND2X1_RVT U6163 ( .A1(n4390), .A2(\cpuregs[2][20] ), .Y(n5008) );
  AO22X1_RVT U6164 ( .A1(n4364), .A2(\cpuregs[8][20] ), .A3(n4434), .A4(
        \cpuregs[10][20] ), .Y(n5007) );
  AO22X1_RVT U6165 ( .A1(n4347), .A2(\cpuregs[20][20] ), .A3(n4369), .A4(
        \cpuregs[5][20] ), .Y(n5006) );
  AO22X1_RVT U6166 ( .A1(n4431), .A2(\cpuregs[13][20] ), .A3(n4487), .A4(
        \cpuregs[24][20] ), .Y(n5005) );
  NOR4X1_RVT U6167 ( .A1(n5008), .A2(n5007), .A3(n5006), .A4(n5005), .Y(n5025)
         );
  AO22X1_RVT U6168 ( .A1(n4408), .A2(\cpuregs[12][20] ), .A3(n4415), .A4(
        \cpuregs[28][20] ), .Y(n5012) );
  AO22X1_RVT U6169 ( .A1(n4382), .A2(\cpuregs[16][20] ), .A3(n4411), .A4(
        \cpuregs[26][20] ), .Y(n5011) );
  AO22X1_RVT U6170 ( .A1(n4333), .A2(\cpuregs[25][20] ), .A3(n4387), .A4(
        \cpuregs[23][20] ), .Y(n5010) );
  AO22X1_RVT U6171 ( .A1(n4345), .A2(\cpuregs[6][20] ), .A3(n4374), .A4(
        \cpuregs[1][20] ), .Y(n5009) );
  NOR4X1_RVT U6172 ( .A1(n5012), .A2(n5011), .A3(n5010), .A4(n5009), .Y(n5024)
         );
  AO22X1_RVT U6173 ( .A1(n4392), .A2(\cpuregs[31][20] ), .A3(n4422), .A4(
        \cpuregs[7][20] ), .Y(n5016) );
  AO22X1_RVT U6174 ( .A1(n6645), .A2(\cpuregs[27][20] ), .A3(n4363), .A4(
        \cpuregs[11][20] ), .Y(n5015) );
  AO22X1_RVT U6175 ( .A1(n4359), .A2(\cpuregs[18][20] ), .A3(n4406), .A4(
        \cpuregs[29][20] ), .Y(n5014) );
  NOR4X1_RVT U6176 ( .A1(n4297), .A2(n5016), .A3(n5015), .A4(n5014), .Y(n5023)
         );
  AO22X1_RVT U6177 ( .A1(n6725), .A2(\cpuregs[9][20] ), .A3(n4440), .A4(
        \cpuregs[4][20] ), .Y(n5021) );
  AO22X1_RVT U6178 ( .A1(n5017), .A2(\cpuregs[22][20] ), .A3(n6761), .A4(
        \cpuregs[17][20] ), .Y(n5020) );
  AO22X1_RVT U6179 ( .A1(n6592), .A2(\cpuregs[3][20] ), .A3(n4402), .A4(
        \cpuregs[14][20] ), .Y(n5019) );
  AO22X1_RVT U6180 ( .A1(n4337), .A2(\cpuregs[19][20] ), .A3(n4451), .A4(
        \cpuregs[21][20] ), .Y(n5018) );
  NOR4X1_RVT U6181 ( .A1(n5021), .A2(n5020), .A3(n5019), .A4(n5018), .Y(n5022)
         );
  NAND4X0_RVT U6182 ( .A1(n5025), .A2(n5024), .A3(n5023), .A4(n5022), .Y(n5026) );
  AND2X1_RVT U6183 ( .A1(n4428), .A2(\cpuregs[3][13] ), .Y(n5032) );
  AO22X1_RVT U6184 ( .A1(n4362), .A2(\cpuregs[11][13] ), .A3(n4434), .A4(
        \cpuregs[10][13] ), .Y(n5030) );
  AO22X1_RVT U6185 ( .A1(n4389), .A2(\cpuregs[2][13] ), .A3(n4408), .A4(
        \cpuregs[12][13] ), .Y(n5029) );
  NOR4X1_RVT U6186 ( .A1(n5032), .A2(n5031), .A3(n5030), .A4(n5029), .Y(n5047)
         );
  AO22X1_RVT U6187 ( .A1(n4349), .A2(\cpuregs[9][13] ), .A3(n4486), .A4(
        \cpuregs[24][13] ), .Y(n5036) );
  AO22X1_RVT U6188 ( .A1(n4386), .A2(\cpuregs[23][13] ), .A3(n4431), .A4(
        \cpuregs[13][13] ), .Y(n5035) );
  AO22X1_RVT U6189 ( .A1(n4327), .A2(\cpuregs[27][13] ), .A3(n4394), .A4(
        \cpuregs[31][13] ), .Y(n5034) );
  AO22X1_RVT U6190 ( .A1(n4382), .A2(\cpuregs[16][13] ), .A3(n4449), .A4(
        \cpuregs[21][13] ), .Y(n5033) );
  NOR4X1_RVT U6191 ( .A1(n5036), .A2(n5035), .A3(n5034), .A4(n5033), .Y(n5046)
         );
  AO22X1_RVT U6192 ( .A1(n6581), .A2(\cpuregs[6][13] ), .A3(n4358), .A4(
        \cpuregs[18][13] ), .Y(n5038) );
  AO22X1_RVT U6193 ( .A1(n4411), .A2(\cpuregs[26][13] ), .A3(n6761), .A4(
        \cpuregs[17][13] ), .Y(n5037) );
  NOR4X1_RVT U6194 ( .A1(n5039), .A2(n5038), .A3(n5037), .A4(n4317), .Y(n5045)
         );
  AO22X1_RVT U6195 ( .A1(n4373), .A2(\cpuregs[1][13] ), .A3(n4422), .A4(
        \cpuregs[7][13] ), .Y(n5043) );
  AO22X1_RVT U6196 ( .A1(n4336), .A2(\cpuregs[19][13] ), .A3(n4440), .A4(
        \cpuregs[4][13] ), .Y(n5041) );
  AO22X1_RVT U6197 ( .A1(n4329), .A2(\cpuregs[22][13] ), .A3(n4365), .A4(
        \cpuregs[8][13] ), .Y(n5040) );
  NOR4X1_RVT U6198 ( .A1(n5043), .A2(n5042), .A3(n5041), .A4(n5040), .Y(n5044)
         );
  AO21X1_RVT U6199 ( .A1(n4934), .A2(pcpi_rs1[12]), .A3(n5051), .Y(n3727) );
  AND2X1_RVT U6200 ( .A1(n4486), .A2(\cpuregs[24][6] ), .Y(n5056) );
  AO22X1_RVT U6201 ( .A1(n4367), .A2(\cpuregs[5][6] ), .A3(n4358), .A4(
        \cpuregs[18][6] ), .Y(n5054) );
  AO22X1_RVT U6202 ( .A1(n4392), .A2(\cpuregs[31][6] ), .A3(n4424), .A4(
        \cpuregs[7][6] ), .Y(n5053) );
  NOR4X1_RVT U6203 ( .A1(n5056), .A2(n5055), .A3(n5054), .A4(n5053), .Y(n5071)
         );
  AO22X1_RVT U6204 ( .A1(n4449), .A2(\cpuregs[21][6] ), .A3(n4440), .A4(
        \cpuregs[4][6] ), .Y(n5060) );
  AO22X1_RVT U6205 ( .A1(n6645), .A2(\cpuregs[27][6] ), .A3(n4386), .A4(
        \cpuregs[23][6] ), .Y(n5059) );
  AO22X1_RVT U6206 ( .A1(n4361), .A2(\cpuregs[11][6] ), .A3(n4434), .A4(
        \cpuregs[10][6] ), .Y(n5058) );
  AO22X1_RVT U6207 ( .A1(n4364), .A2(\cpuregs[8][6] ), .A3(n6761), .A4(
        \cpuregs[17][6] ), .Y(n5057) );
  NOR4X1_RVT U6208 ( .A1(n5060), .A2(n5057), .A3(n5058), .A4(n5059), .Y(n5070)
         );
  AO22X1_RVT U6209 ( .A1(n4333), .A2(\cpuregs[25][6] ), .A3(n6592), .A4(
        \cpuregs[3][6] ), .Y(n5064) );
  AO22X1_RVT U6210 ( .A1(n6581), .A2(\cpuregs[6][6] ), .A3(n4431), .A4(
        \cpuregs[13][6] ), .Y(n5063) );
  AO22X1_RVT U6211 ( .A1(n4346), .A2(\cpuregs[20][6] ), .A3(n4405), .A4(
        \cpuregs[29][6] ), .Y(n5061) );
  NOR4X1_RVT U6212 ( .A1(n5064), .A2(n5063), .A3(n5062), .A4(n5061), .Y(n5069)
         );
  AO22X1_RVT U6213 ( .A1(n4389), .A2(\cpuregs[2][6] ), .A3(n4419), .A4(
        \cpuregs[30][6] ), .Y(n5067) );
  AO22X1_RVT U6214 ( .A1(n5017), .A2(\cpuregs[22][6] ), .A3(n4411), .A4(
        \cpuregs[26][6] ), .Y(n5066) );
  AO22X1_RVT U6215 ( .A1(n6725), .A2(\cpuregs[9][6] ), .A3(n4408), .A4(
        \cpuregs[12][6] ), .Y(n5065) );
  NOR4X1_RVT U6216 ( .A1(n5067), .A2(n5066), .A3(n5065), .A4(n4342), .Y(n5068)
         );
  NAND4X0_RVT U6217 ( .A1(n5071), .A2(n5070), .A3(n5069), .A4(n5068), .Y(n5072) );
  AO22X1_RVT U6218 ( .A1(n4060), .A2(n5072), .A3(net24496), .A4(reg_pc[6]), 
        .Y(n5074) );
  AND2X1_RVT U6219 ( .A1(n4419), .A2(\cpuregs[30][22] ), .Y(n5080) );
  AO22X1_RVT U6220 ( .A1(n4333), .A2(\cpuregs[25][22] ), .A3(n4412), .A4(
        \cpuregs[26][22] ), .Y(n5079) );
  AO22X1_RVT U6221 ( .A1(n4364), .A2(\cpuregs[8][22] ), .A3(n4442), .A4(
        \cpuregs[4][22] ), .Y(n5077) );
  NOR4X1_RVT U6222 ( .A1(n5080), .A2(n5079), .A3(n5078), .A4(n5077), .Y(n5096)
         );
  AO22X1_RVT U6223 ( .A1(n4361), .A2(\cpuregs[11][22] ), .A3(n4422), .A4(
        \cpuregs[7][22] ), .Y(n5084) );
  AO22X1_RVT U6224 ( .A1(n4373), .A2(\cpuregs[1][22] ), .A3(n4431), .A4(
        \cpuregs[13][22] ), .Y(n5083) );
  AO22X1_RVT U6225 ( .A1(n4386), .A2(\cpuregs[23][22] ), .A3(n4434), .A4(
        \cpuregs[10][22] ), .Y(n5082) );
  AO22X1_RVT U6226 ( .A1(n4359), .A2(\cpuregs[18][22] ), .A3(n4393), .A4(
        \cpuregs[31][22] ), .Y(n5081) );
  NOR4X1_RVT U6227 ( .A1(n5084), .A2(n5083), .A3(n5082), .A4(n5081), .Y(n5095)
         );
  AO22X1_RVT U6228 ( .A1(n4336), .A2(\cpuregs[19][22] ), .A3(n4415), .A4(
        \cpuregs[28][22] ), .Y(n5088) );
  AO22X1_RVT U6229 ( .A1(n6581), .A2(\cpuregs[6][22] ), .A3(n6761), .A4(
        \cpuregs[17][22] ), .Y(n5087) );
  AO22X1_RVT U6230 ( .A1(n4346), .A2(\cpuregs[20][22] ), .A3(n4402), .A4(
        \cpuregs[14][22] ), .Y(n5086) );
  AO22X1_RVT U6231 ( .A1(n4382), .A2(\cpuregs[16][22] ), .A3(n4450), .A4(
        \cpuregs[21][22] ), .Y(n5085) );
  NOR4X1_RVT U6232 ( .A1(n5088), .A2(n5087), .A3(n5086), .A4(n5085), .Y(n5094)
         );
  AO22X1_RVT U6233 ( .A1(n4408), .A2(\cpuregs[12][22] ), .A3(n4486), .A4(
        \cpuregs[24][22] ), .Y(n5092) );
  AO22X1_RVT U6234 ( .A1(n4389), .A2(\cpuregs[2][22] ), .A3(n6592), .A4(
        \cpuregs[3][22] ), .Y(n5091) );
  AO22X1_RVT U6235 ( .A1(n6725), .A2(\cpuregs[9][22] ), .A3(n4367), .A4(
        \cpuregs[5][22] ), .Y(n5090) );
  AO22X1_RVT U6236 ( .A1(n5017), .A2(\cpuregs[22][22] ), .A3(n4407), .A4(
        \cpuregs[29][22] ), .Y(n5089) );
  NOR4X1_RVT U6237 ( .A1(n5092), .A2(n5091), .A3(n5090), .A4(n5089), .Y(n5093)
         );
  NAND4X0_RVT U6238 ( .A1(n5096), .A2(n5095), .A3(n5094), .A4(n5093), .Y(n5097) );
  AO22X1_RVT U6239 ( .A1(reg_pc[22]), .A2(net24496), .A3(n5097), .A4(n4061), 
        .Y(n5099) );
  AO21X1_RVT U6240 ( .A1(n4934), .A2(pcpi_rs1[21]), .A3(n5101), .Y(n3718) );
  AO22X1_RVT U6241 ( .A1(n4360), .A2(\cpuregs[18][17] ), .A3(n4432), .A4(
        \cpuregs[13][17] ), .Y(n5104) );
  AO22X1_RVT U6242 ( .A1(n4273), .A2(\cpuregs[15][17] ), .A3(n4420), .A4(
        \cpuregs[30][17] ), .Y(n5103) );
  OR2X1_RVT U6243 ( .A1(n5104), .A2(n5103), .Y(n5105) );
  AO21X1_RVT U6244 ( .A1(n4403), .A2(\cpuregs[14][17] ), .A3(n5105), .Y(n5123)
         );
  AO22X1_RVT U6245 ( .A1(n4365), .A2(\cpuregs[8][17] ), .A3(n4442), .A4(
        \cpuregs[4][17] ), .Y(n5122) );
  AO22X1_RVT U6246 ( .A1(n4391), .A2(\cpuregs[2][17] ), .A3(n4427), .A4(
        \cpuregs[3][17] ), .Y(n5109) );
  AO22X1_RVT U6247 ( .A1(n4337), .A2(\cpuregs[19][17] ), .A3(n4417), .A4(
        \cpuregs[28][17] ), .Y(n5108) );
  AO22X1_RVT U6248 ( .A1(n4349), .A2(\cpuregs[9][17] ), .A3(n4426), .A4(
        \cpuregs[17][17] ), .Y(n5106) );
  NOR4X1_RVT U6249 ( .A1(n5109), .A2(n5108), .A3(n5107), .A4(n5106), .Y(n5120)
         );
  AO22X1_RVT U6250 ( .A1(n4413), .A2(\cpuregs[26][17] ), .A3(n4423), .A4(
        \cpuregs[7][17] ), .Y(n5113) );
  AO22X1_RVT U6251 ( .A1(n4375), .A2(\cpuregs[1][17] ), .A3(n4436), .A4(
        \cpuregs[10][17] ), .Y(n5112) );
  AO22X1_RVT U6252 ( .A1(n4326), .A2(\cpuregs[27][17] ), .A3(n4451), .A4(
        \cpuregs[21][17] ), .Y(n5111) );
  AO22X1_RVT U6253 ( .A1(n4344), .A2(\cpuregs[6][17] ), .A3(n4369), .A4(
        \cpuregs[5][17] ), .Y(n5110) );
  NOR4X1_RVT U6254 ( .A1(n5113), .A2(n5112), .A3(n5111), .A4(n5110), .Y(n5119)
         );
  AO22X1_RVT U6255 ( .A1(n4405), .A2(\cpuregs[29][17] ), .A3(n4362), .A4(
        \cpuregs[11][17] ), .Y(n5117) );
  AO22X1_RVT U6256 ( .A1(n4329), .A2(\cpuregs[22][17] ), .A3(n4347), .A4(
        \cpuregs[20][17] ), .Y(n5116) );
  AO22X1_RVT U6257 ( .A1(n4393), .A2(\cpuregs[31][17] ), .A3(n4488), .A4(
        \cpuregs[24][17] ), .Y(n5115) );
  NOR4X1_RVT U6258 ( .A1(n5117), .A2(n5116), .A3(n5115), .A4(n5114), .Y(n5118)
         );
  NAND3X0_RVT U6259 ( .A1(n5120), .A2(n5119), .A3(n5118), .Y(n5121) );
  AO222X1_RVT U6260 ( .A1(n4063), .A2(n5123), .A3(n5208), .A4(n5122), .A5(
        n4063), .A6(n5121), .Y(n5127) );
  OA21X1_RVT U6261 ( .A1(n5127), .A2(n5126), .A3(net29472), .Y(n5128) );
  AO21X1_RVT U6262 ( .A1(n4054), .A2(pcpi_rs1[17]), .A3(n5128), .Y(n5129) );
  AO21X1_RVT U6263 ( .A1(n6776), .A2(pcpi_rs1[18]), .A3(n5129), .Y(n3723) );
  XOR2X1_RVT U6264 ( .A1(instr_sub), .A2(pcpi_rs2[4]), .Y(n7649) );
  XOR2X1_RVT U6265 ( .A1(n4069), .A2(pcpi_rs2[7]), .Y(n6552) );
  XOR2X1_RVT U6266 ( .A1(n4069), .A2(pcpi_rs2[9]), .Y(n7622) );
  XOR2X1_RVT U6267 ( .A1(n4209), .A2(pcpi_rs2[14]), .Y(n6560) );
  XOR2X1_RVT U6268 ( .A1(n4209), .A2(pcpi_rs2[22]), .Y(n7548) );
  XOR2X1_RVT U6269 ( .A1(n4069), .A2(pcpi_rs2[23]), .Y(n7539) );
  AND2X1_RVT U6270 ( .A1(n8023), .A2(net16372), .Y(n5133) );
  AO22X1_RVT U6271 ( .A1(pcpi_rs1[31]), .A2(pcpi_rs2[31]), .A3(net16372), .A4(
        n8023), .Y(n5395) );
  OR3X1_RVT U6272 ( .A1(n5135), .A2(is_compare), .A3(
        is_lui_auipc_jal_jalr_addi_add_sub), .Y(n6288) );
  OA22X1_RVT U6273 ( .A1(n7658), .A2(n5133), .A3(n5395), .A4(n6288), .Y(n5140)
         );
  NAND3X0_RVT U6274 ( .A1(n5138), .A2(n5137), .A3(n5136), .Y(n6420) );
  NAND3X0_RVT U6275 ( .A1(n6412), .A2(pcpi_rs1[31]), .A3(pcpi_rs2[31]), .Y(
        n5139) );
  NAND2X0_RVT U6276 ( .A1(n5140), .A2(n5139), .Y(n5141) );
  AO21X1_RVT U6277 ( .A1(n5142), .A2(n4528), .A3(n5141), .Y(alu_out[31]) );
  AO22X1_RVT U6278 ( .A1(count_cycle[48]), .A2(n4258), .A3(count_instr[16]), 
        .A4(n5718), .Y(n5144) );
  AOI22X1_RVT U6279 ( .A1(count_instr[48]), .A2(n7788), .A3(n4633), .A4(
        pcpi_rs1[16]), .Y(n5148) );
  NAND2X0_RVT U6280 ( .A1(n6573), .A2(mem_rdata_word[16]), .Y(n5147) );
  NAND2X0_RVT U6281 ( .A1(count_cycle[16]), .A2(n7762), .Y(n5146) );
  NAND4X0_RVT U6282 ( .A1(n6817), .A2(n5148), .A3(n5147), .A4(n5146), .Y(n5149) );
  AO22X1_RVT U6283 ( .A1(n4348), .A2(\cpuregs[20][7] ), .A3(n4375), .A4(
        \cpuregs[1][7] ), .Y(n5152) );
  AO22X1_RVT U6284 ( .A1(n4363), .A2(\cpuregs[11][7] ), .A3(n4423), .A4(
        \cpuregs[7][7] ), .Y(n5151) );
  OR2X1_RVT U6285 ( .A1(n5152), .A2(n5151), .Y(n5153) );
  AO21X1_RVT U6286 ( .A1(n4441), .A2(\cpuregs[4][7] ), .A3(n5153), .Y(n5171)
         );
  AO22X1_RVT U6287 ( .A1(n4329), .A2(\cpuregs[22][7] ), .A3(n4451), .A4(
        \cpuregs[21][7] ), .Y(n5170) );
  AO22X1_RVT U6288 ( .A1(n4335), .A2(\cpuregs[25][7] ), .A3(n4391), .A4(
        \cpuregs[2][7] ), .Y(n5157) );
  AO22X1_RVT U6289 ( .A1(n4344), .A2(\cpuregs[6][7] ), .A3(n4412), .A4(
        \cpuregs[26][7] ), .Y(n5156) );
  AO22X1_RVT U6290 ( .A1(n4388), .A2(\cpuregs[23][7] ), .A3(n4436), .A4(
        \cpuregs[10][7] ), .Y(n5155) );
  AO22X1_RVT U6291 ( .A1(n4350), .A2(\cpuregs[9][7] ), .A3(n4417), .A4(
        \cpuregs[28][7] ), .Y(n5154) );
  NOR4X1_RVT U6292 ( .A1(n5157), .A2(n5156), .A3(n5155), .A4(n5154), .Y(n5168)
         );
  AO22X1_RVT U6293 ( .A1(n4367), .A2(\cpuregs[5][7] ), .A3(n4360), .A4(
        \cpuregs[18][7] ), .Y(n5161) );
  AO22X1_RVT U6294 ( .A1(n4326), .A2(\cpuregs[27][7] ), .A3(n4394), .A4(
        \cpuregs[31][7] ), .Y(n5160) );
  AO22X1_RVT U6295 ( .A1(n4383), .A2(\cpuregs[16][7] ), .A3(n4428), .A4(
        \cpuregs[3][7] ), .Y(n5159) );
  AO22X1_RVT U6296 ( .A1(n4403), .A2(\cpuregs[14][7] ), .A3(n4433), .A4(
        \cpuregs[13][7] ), .Y(n5158) );
  NOR4X1_RVT U6297 ( .A1(n5161), .A2(n5160), .A3(n5159), .A4(n5158), .Y(n5167)
         );
  AO22X1_RVT U6298 ( .A1(n4271), .A2(\cpuregs[15][7] ), .A3(n4421), .A4(
        \cpuregs[30][7] ), .Y(n5165) );
  AO22X1_RVT U6299 ( .A1(n4410), .A2(\cpuregs[12][7] ), .A3(n4488), .A4(
        \cpuregs[24][7] ), .Y(n5164) );
  AO22X1_RVT U6300 ( .A1(n4366), .A2(\cpuregs[8][7] ), .A3(n4426), .A4(
        \cpuregs[17][7] ), .Y(n5163) );
  AO22X1_RVT U6301 ( .A1(n4337), .A2(\cpuregs[19][7] ), .A3(n4406), .A4(
        \cpuregs[29][7] ), .Y(n5162) );
  NOR4X1_RVT U6302 ( .A1(n5165), .A2(n5164), .A3(n5163), .A4(n5162), .Y(n5166)
         );
  NAND3X0_RVT U6303 ( .A1(n5168), .A2(n5167), .A3(n5166), .Y(n5169) );
  AO222X1_RVT U6304 ( .A1(n4060), .A2(n5171), .A3(n4063), .A4(n5170), .A5(
        n5169), .A6(n4062), .Y(n5175) );
  OR2X1_RVT U6305 ( .A1(net26273), .A2(n5172), .Y(n5173) );
  AO21X1_RVT U6306 ( .A1(net30310), .A2(reg_pc[7]), .A3(n5173), .Y(n5174) );
  OA21X1_RVT U6307 ( .A1(n5175), .A2(n5174), .A3(n4056), .Y(n5176) );
  AO21X1_RVT U6308 ( .A1(n6776), .A2(pcpi_rs1[8]), .A3(n5177), .Y(n3733) );
  AO22X1_RVT U6309 ( .A1(n4326), .A2(\cpuregs[27][24] ), .A3(n4416), .A4(
        \cpuregs[28][24] ), .Y(n5179) );
  AO22X1_RVT U6310 ( .A1(n4335), .A2(\cpuregs[25][24] ), .A3(n4433), .A4(
        \cpuregs[13][24] ), .Y(n5178) );
  OR2X1_RVT U6311 ( .A1(n5179), .A2(n5178), .Y(n5180) );
  AO21X1_RVT U6312 ( .A1(n4349), .A2(\cpuregs[9][24] ), .A3(n5180), .Y(n5198)
         );
  AO22X1_RVT U6313 ( .A1(n4406), .A2(\cpuregs[29][24] ), .A3(n4362), .A4(
        \cpuregs[11][24] ), .Y(n5197) );
  AO22X1_RVT U6314 ( .A1(n4330), .A2(\cpuregs[22][24] ), .A3(n4450), .A4(
        \cpuregs[21][24] ), .Y(n5184) );
  AO22X1_RVT U6315 ( .A1(n4383), .A2(\cpuregs[16][24] ), .A3(n4403), .A4(
        \cpuregs[14][24] ), .Y(n5183) );
  AO22X1_RVT U6316 ( .A1(n4387), .A2(\cpuregs[23][24] ), .A3(n4413), .A4(
        \cpuregs[26][24] ), .Y(n5182) );
  AO22X1_RVT U6317 ( .A1(n4348), .A2(\cpuregs[20][24] ), .A3(n4344), .A4(
        \cpuregs[6][24] ), .Y(n5181) );
  NOR4X1_RVT U6318 ( .A1(n5184), .A2(n5183), .A3(n5182), .A4(n5181), .Y(n5195)
         );
  AO22X1_RVT U6319 ( .A1(n4373), .A2(\cpuregs[1][24] ), .A3(n4409), .A4(
        \cpuregs[12][24] ), .Y(n5188) );
  AO22X1_RVT U6320 ( .A1(n4338), .A2(\cpuregs[19][24] ), .A3(n4423), .A4(
        \cpuregs[7][24] ), .Y(n5187) );
  AO22X1_RVT U6321 ( .A1(n4391), .A2(\cpuregs[2][24] ), .A3(n4421), .A4(
        \cpuregs[30][24] ), .Y(n5186) );
  AO22X1_RVT U6322 ( .A1(n4365), .A2(\cpuregs[8][24] ), .A3(n4441), .A4(
        \cpuregs[4][24] ), .Y(n5185) );
  NOR4X1_RVT U6323 ( .A1(n5188), .A2(n5187), .A3(n5186), .A4(n5185), .Y(n5194)
         );
  AO22X1_RVT U6324 ( .A1(n4272), .A2(\cpuregs[15][24] ), .A3(n4428), .A4(
        \cpuregs[3][24] ), .Y(n5192) );
  AO22X1_RVT U6325 ( .A1(n4368), .A2(\cpuregs[5][24] ), .A3(n4435), .A4(
        \cpuregs[10][24] ), .Y(n5191) );
  AO22X1_RVT U6326 ( .A1(n4359), .A2(\cpuregs[18][24] ), .A3(n4394), .A4(
        \cpuregs[31][24] ), .Y(n5190) );
  AO22X1_RVT U6327 ( .A1(n4426), .A2(\cpuregs[17][24] ), .A3(n4488), .A4(
        \cpuregs[24][24] ), .Y(n5189) );
  NOR4X1_RVT U6328 ( .A1(n5192), .A2(n5191), .A3(n5190), .A4(n5189), .Y(n5193)
         );
  NAND3X0_RVT U6329 ( .A1(n5195), .A2(n5194), .A3(n5193), .Y(n5196) );
  AO222X1_RVT U6330 ( .A1(n4059), .A2(n5198), .A3(n4058), .A4(n5197), .A5(
        n5196), .A6(n5208), .Y(n5202) );
  AO22X1_RVT U6331 ( .A1(pcpi_rs1[23]), .A2(net24129), .A3(pcpi_rs1[20]), .A4(
        net30560), .Y(n5199) );
  OR2X1_RVT U6332 ( .A1(n5199), .A2(net26243), .Y(n5200) );
  AO21X1_RVT U6333 ( .A1(reg_pc[24]), .A2(net30310), .A3(n5200), .Y(n5201) );
  OA21X1_RVT U6334 ( .A1(n5202), .A2(n5201), .A3(n4057), .Y(n5203) );
  AO21X1_RVT U6335 ( .A1(n6776), .A2(pcpi_rs1[25]), .A3(n5204), .Y(n3716) );
  AO22X1_RVT U6336 ( .A1(n4393), .A2(\cpuregs[31][10] ), .A3(n4428), .A4(
        \cpuregs[3][10] ), .Y(n5206) );
  AO22X1_RVT U6337 ( .A1(n4344), .A2(\cpuregs[6][10] ), .A3(n4375), .A4(
        \cpuregs[1][10] ), .Y(n5205) );
  OR2X1_RVT U6338 ( .A1(n5206), .A2(n5205), .Y(n5207) );
  AO21X1_RVT U6339 ( .A1(n4404), .A2(\cpuregs[14][10] ), .A3(n5207), .Y(n5226)
         );
  AO22X1_RVT U6340 ( .A1(n4326), .A2(\cpuregs[27][10] ), .A3(n4348), .A4(
        \cpuregs[20][10] ), .Y(n5225) );
  AO22X1_RVT U6341 ( .A1(n4360), .A2(\cpuregs[18][10] ), .A3(n4384), .A4(
        \cpuregs[16][10] ), .Y(n5212) );
  AO22X1_RVT U6342 ( .A1(n4423), .A2(\cpuregs[7][10] ), .A3(n4416), .A4(
        \cpuregs[28][10] ), .Y(n5211) );
  AO22X1_RVT U6343 ( .A1(n4365), .A2(\cpuregs[8][10] ), .A3(n4426), .A4(
        \cpuregs[17][10] ), .Y(n5210) );
  AO22X1_RVT U6344 ( .A1(n4390), .A2(\cpuregs[2][10] ), .A3(n4451), .A4(
        \cpuregs[21][10] ), .Y(n5209) );
  NOR4X1_RVT U6345 ( .A1(n5212), .A2(n5211), .A3(n5210), .A4(n5209), .Y(n5223)
         );
  AO22X1_RVT U6346 ( .A1(n4388), .A2(\cpuregs[23][10] ), .A3(n4488), .A4(
        \cpuregs[24][10] ), .Y(n5216) );
  AO22X1_RVT U6347 ( .A1(n4362), .A2(\cpuregs[11][10] ), .A3(n4420), .A4(
        \cpuregs[30][10] ), .Y(n5215) );
  AO22X1_RVT U6348 ( .A1(n4329), .A2(\cpuregs[22][10] ), .A3(n4441), .A4(
        \cpuregs[4][10] ), .Y(n5214) );
  AO22X1_RVT U6349 ( .A1(n4349), .A2(\cpuregs[9][10] ), .A3(n4368), .A4(
        \cpuregs[5][10] ), .Y(n5213) );
  NOR4X1_RVT U6350 ( .A1(n5216), .A2(n5215), .A3(n5214), .A4(n5213), .Y(n5222)
         );
  AO22X1_RVT U6351 ( .A1(n4273), .A2(\cpuregs[15][10] ), .A3(n4435), .A4(
        \cpuregs[10][10] ), .Y(n5220) );
  AO22X1_RVT U6352 ( .A1(n4405), .A2(\cpuregs[29][10] ), .A3(n4413), .A4(
        \cpuregs[26][10] ), .Y(n5219) );
  AO22X1_RVT U6353 ( .A1(n4338), .A2(\cpuregs[19][10] ), .A3(n4433), .A4(
        \cpuregs[13][10] ), .Y(n5218) );
  NOR4X1_RVT U6354 ( .A1(n5220), .A2(n5219), .A3(n5218), .A4(n5217), .Y(n5221)
         );
  NAND3X0_RVT U6355 ( .A1(n5223), .A2(n5222), .A3(n5221), .Y(n5224) );
  AO222X1_RVT U6356 ( .A1(n4059), .A2(n5226), .A3(n4061), .A4(n5225), .A5(
        n5224), .A6(n4062), .Y(n5230) );
  OR2X1_RVT U6357 ( .A1(net26211), .A2(n5227), .Y(n5228) );
  AO21X1_RVT U6358 ( .A1(net30309), .A2(reg_pc[10]), .A3(n5228), .Y(n5229) );
  OA21X1_RVT U6359 ( .A1(n5230), .A2(n5229), .A3(net29472), .Y(n5231) );
  AO21X1_RVT U6360 ( .A1(n6776), .A2(net30668), .A3(n5232), .Y(n3730) );
  AND2X1_RVT U6361 ( .A1(n7906), .A2(n4972), .Y(n5233) );
  OA21X1_RVT U6362 ( .A1(instr_lh), .A2(instr_lhu), .A3(n5233), .Y(n5235) );
  OA222X1_RVT U6363 ( .A1(n5235), .A2(instr_sh), .A3(n5235), .A4(n5234), .A5(
        n5235), .A6(n8066), .Y(n5241) );
  AO221X1_RVT U6364 ( .A1(n5236), .A2(N286), .A3(n5236), .A4(n5238), .A5(n5833), .Y(n5240) );
  OA221X1_RVT U6365 ( .A1(n5240), .A2(n7904), .A3(n5240), .A4(n5239), .A5(
        resetn), .Y(n7909) );
  AND2X1_RVT U6366 ( .A1(n4424), .A2(\cpuregs[7][5] ), .Y(n5246) );
  AO22X1_RVT U6367 ( .A1(n4426), .A2(\cpuregs[17][5] ), .A3(n4450), .A4(
        \cpuregs[21][5] ), .Y(n5245) );
  AO22X1_RVT U6368 ( .A1(n4366), .A2(\cpuregs[8][5] ), .A3(n4387), .A4(
        \cpuregs[23][5] ), .Y(n5244) );
  AO22X1_RVT U6369 ( .A1(n4345), .A2(\cpuregs[6][5] ), .A3(n4383), .A4(
        \cpuregs[16][5] ), .Y(n5243) );
  NOR4X1_RVT U6370 ( .A1(n5246), .A2(n5245), .A3(n5244), .A4(n5243), .Y(n5262)
         );
  AO22X1_RVT U6371 ( .A1(n4350), .A2(\cpuregs[9][5] ), .A3(n4363), .A4(
        \cpuregs[11][5] ), .Y(n5250) );
  AO22X1_RVT U6372 ( .A1(n4368), .A2(\cpuregs[5][5] ), .A3(n4435), .A4(
        \cpuregs[10][5] ), .Y(n5249) );
  AO22X1_RVT U6373 ( .A1(n4326), .A2(\cpuregs[27][5] ), .A3(n4427), .A4(
        \cpuregs[3][5] ), .Y(n5248) );
  AO22X1_RVT U6374 ( .A1(n4403), .A2(\cpuregs[14][5] ), .A3(n4487), .A4(
        \cpuregs[24][5] ), .Y(n5247) );
  NOR4X1_RVT U6375 ( .A1(n5250), .A2(n5249), .A3(n5248), .A4(n5247), .Y(n5261)
         );
  AO22X1_RVT U6376 ( .A1(n4360), .A2(\cpuregs[18][5] ), .A3(n4432), .A4(
        \cpuregs[13][5] ), .Y(n5254) );
  AO22X1_RVT U6377 ( .A1(n4348), .A2(\cpuregs[20][5] ), .A3(n4413), .A4(
        \cpuregs[26][5] ), .Y(n5253) );
  AO22X1_RVT U6378 ( .A1(n4272), .A2(\cpuregs[15][5] ), .A3(n4406), .A4(
        \cpuregs[29][5] ), .Y(n5252) );
  AO22X1_RVT U6379 ( .A1(n4335), .A2(\cpuregs[25][5] ), .A3(n4391), .A4(
        \cpuregs[2][5] ), .Y(n5251) );
  NOR4X1_RVT U6380 ( .A1(n5254), .A2(n5253), .A3(n5252), .A4(n5251), .Y(n5260)
         );
  AO22X1_RVT U6381 ( .A1(n4338), .A2(\cpuregs[19][5] ), .A3(n4394), .A4(
        \cpuregs[31][5] ), .Y(n5258) );
  AO22X1_RVT U6382 ( .A1(n4373), .A2(\cpuregs[1][5] ), .A3(n4442), .A4(
        \cpuregs[4][5] ), .Y(n5257) );
  AO22X1_RVT U6383 ( .A1(n4330), .A2(\cpuregs[22][5] ), .A3(n4416), .A4(
        \cpuregs[28][5] ), .Y(n5256) );
  AO22X1_RVT U6384 ( .A1(n4421), .A2(\cpuregs[30][5] ), .A3(n4410), .A4(
        \cpuregs[12][5] ), .Y(n5255) );
  NOR4X1_RVT U6385 ( .A1(n5258), .A2(n5257), .A3(n5256), .A4(n5255), .Y(n5259)
         );
  NAND4X0_RVT U6386 ( .A1(n5262), .A2(n5261), .A3(n5260), .A4(n5259), .Y(n5263) );
  AO22X1_RVT U6387 ( .A1(reg_pc[5]), .A2(net30310), .A3(n4062), .A4(n5263), 
        .Y(n5264) );
  MUX21X1_RVT U6388 ( .A1(net30690), .A2(n5266), .S0(net29471), .Y(n3735) );
  AND2X1_RVT U6389 ( .A1(n4368), .A2(\cpuregs[5][4] ), .Y(n5271) );
  AO22X1_RVT U6390 ( .A1(n4347), .A2(\cpuregs[20][4] ), .A3(n4427), .A4(
        \cpuregs[3][4] ), .Y(n5270) );
  AO22X1_RVT U6391 ( .A1(n4365), .A2(\cpuregs[8][4] ), .A3(n4433), .A4(
        \cpuregs[13][4] ), .Y(n5269) );
  AO22X1_RVT U6392 ( .A1(n4350), .A2(\cpuregs[9][4] ), .A3(n4451), .A4(
        \cpuregs[21][4] ), .Y(n5268) );
  NOR4X1_RVT U6393 ( .A1(n5271), .A2(n5270), .A3(n5269), .A4(n5268), .Y(n5287)
         );
  AO22X1_RVT U6394 ( .A1(n4382), .A2(\cpuregs[16][4] ), .A3(n4436), .A4(
        \cpuregs[10][4] ), .Y(n5275) );
  AO22X1_RVT U6395 ( .A1(n4391), .A2(\cpuregs[2][4] ), .A3(n4441), .A4(
        \cpuregs[4][4] ), .Y(n5274) );
  AO22X1_RVT U6396 ( .A1(n4388), .A2(\cpuregs[23][4] ), .A3(n4420), .A4(
        \cpuregs[30][4] ), .Y(n5273) );
  AO22X1_RVT U6397 ( .A1(n4362), .A2(\cpuregs[11][4] ), .A3(n4409), .A4(
        \cpuregs[12][4] ), .Y(n5272) );
  NOR4X1_RVT U6398 ( .A1(n5275), .A2(n5274), .A3(n5273), .A4(n5272), .Y(n5286)
         );
  AO22X1_RVT U6399 ( .A1(n4271), .A2(\cpuregs[15][4] ), .A3(n4345), .A4(
        \cpuregs[6][4] ), .Y(n5279) );
  AO22X1_RVT U6400 ( .A1(n4393), .A2(\cpuregs[31][4] ), .A3(n4425), .A4(
        \cpuregs[17][4] ), .Y(n5278) );
  AO22X1_RVT U6401 ( .A1(n4327), .A2(\cpuregs[27][4] ), .A3(n4403), .A4(
        \cpuregs[14][4] ), .Y(n5277) );
  AO22X1_RVT U6402 ( .A1(n4334), .A2(\cpuregs[25][4] ), .A3(n4487), .A4(
        \cpuregs[24][4] ), .Y(n5276) );
  NOR4X1_RVT U6403 ( .A1(n5279), .A2(n5278), .A3(n5277), .A4(n5276), .Y(n5285)
         );
  AO22X1_RVT U6404 ( .A1(n4337), .A2(\cpuregs[19][4] ), .A3(n4424), .A4(
        \cpuregs[7][4] ), .Y(n5283) );
  AO22X1_RVT U6405 ( .A1(n4330), .A2(\cpuregs[22][4] ), .A3(n4416), .A4(
        \cpuregs[28][4] ), .Y(n5282) );
  AO22X1_RVT U6406 ( .A1(n4360), .A2(\cpuregs[18][4] ), .A3(n4375), .A4(
        \cpuregs[1][4] ), .Y(n5281) );
  AO22X1_RVT U6407 ( .A1(n4406), .A2(\cpuregs[29][4] ), .A3(n4413), .A4(
        \cpuregs[26][4] ), .Y(n5280) );
  NOR4X1_RVT U6408 ( .A1(n5283), .A2(n5282), .A3(n5281), .A4(n5280), .Y(n5284)
         );
  NAND4X0_RVT U6409 ( .A1(n5287), .A2(n5286), .A3(n5285), .A4(n5284), .Y(n5288) );
  AO22X1_RVT U6410 ( .A1(reg_pc[4]), .A2(net30309), .A3(n4061), .A4(n5288), 
        .Y(n5289) );
  MUX21X1_RVT U6411 ( .A1(pcpi_rs1[4]), .A2(n5291), .S0(n4057), .Y(n3736) );
  AO22X1_RVT U6412 ( .A1(n4809), .A2(mem_rdata[31]), .A3(n4544), .A4(
        mem_rdata_q[31]), .Y(n2512) );
  AND2X1_RVT U6413 ( .A1(n4424), .A2(\cpuregs[7][19] ), .Y(n5296) );
  AO22X1_RVT U6414 ( .A1(n4344), .A2(\cpuregs[6][19] ), .A3(n4420), .A4(
        \cpuregs[30][19] ), .Y(n5295) );
  AO22X1_RVT U6415 ( .A1(n4394), .A2(\cpuregs[31][19] ), .A3(n4404), .A4(
        \cpuregs[14][19] ), .Y(n5294) );
  AO22X1_RVT U6416 ( .A1(n4406), .A2(\cpuregs[29][19] ), .A3(n4436), .A4(
        \cpuregs[10][19] ), .Y(n5293) );
  NOR4X1_RVT U6417 ( .A1(n5296), .A2(n5295), .A3(n5294), .A4(n5293), .Y(n5312)
         );
  AO22X1_RVT U6418 ( .A1(n5017), .A2(\cpuregs[22][19] ), .A3(n4349), .A4(
        \cpuregs[9][19] ), .Y(n5300) );
  AO22X1_RVT U6419 ( .A1(n4411), .A2(\cpuregs[26][19] ), .A3(n4428), .A4(
        \cpuregs[3][19] ), .Y(n5299) );
  AO22X1_RVT U6420 ( .A1(n4382), .A2(\cpuregs[16][19] ), .A3(n4426), .A4(
        \cpuregs[17][19] ), .Y(n5298) );
  AO22X1_RVT U6421 ( .A1(n4327), .A2(\cpuregs[27][19] ), .A3(n4442), .A4(
        \cpuregs[4][19] ), .Y(n5297) );
  NOR4X1_RVT U6422 ( .A1(n5300), .A2(n5299), .A3(n5298), .A4(n5297), .Y(n5311)
         );
  AO22X1_RVT U6423 ( .A1(n4358), .A2(\cpuregs[18][19] ), .A3(n4486), .A4(
        \cpuregs[24][19] ), .Y(n5304) );
  AO22X1_RVT U6424 ( .A1(n4364), .A2(\cpuregs[8][19] ), .A3(n4451), .A4(
        \cpuregs[21][19] ), .Y(n5303) );
  AO22X1_RVT U6425 ( .A1(n4333), .A2(\cpuregs[25][19] ), .A3(n4363), .A4(
        \cpuregs[11][19] ), .Y(n5302) );
  AO22X1_RVT U6426 ( .A1(n4388), .A2(\cpuregs[23][19] ), .A3(n4432), .A4(
        \cpuregs[13][19] ), .Y(n5301) );
  NOR4X1_RVT U6427 ( .A1(n5304), .A2(n5303), .A3(n5302), .A4(n5301), .Y(n5310)
         );
  AO22X1_RVT U6428 ( .A1(n4271), .A2(\cpuregs[15][19] ), .A3(n4367), .A4(
        \cpuregs[5][19] ), .Y(n5308) );
  AO22X1_RVT U6429 ( .A1(n4336), .A2(\cpuregs[19][19] ), .A3(n4415), .A4(
        \cpuregs[28][19] ), .Y(n5307) );
  AO22X1_RVT U6430 ( .A1(n4346), .A2(\cpuregs[20][19] ), .A3(n4375), .A4(
        \cpuregs[1][19] ), .Y(n5306) );
  AO22X1_RVT U6431 ( .A1(n4390), .A2(\cpuregs[2][19] ), .A3(n4409), .A4(
        \cpuregs[12][19] ), .Y(n5305) );
  NOR4X1_RVT U6432 ( .A1(n5308), .A2(n5307), .A3(n5306), .A4(n5305), .Y(n5309)
         );
  NAND4X0_RVT U6433 ( .A1(n5312), .A2(n5311), .A3(n5310), .A4(n5309), .Y(n5313) );
  AO22X1_RVT U6434 ( .A1(reg_pc[19]), .A2(net24496), .A3(n4058), .A4(n5313), 
        .Y(n5316) );
  MUX21X1_RVT U6435 ( .A1(pcpi_rs1[19]), .A2(n5317), .S0(net29472), .Y(n3721)
         );
  OA22X1_RVT U6436 ( .A1(net16452), .A2(n5530), .A3(net16345), .A4(net25875), 
        .Y(n5340) );
  AND2X1_RVT U6437 ( .A1(n4390), .A2(\cpuregs[2][29] ), .Y(n5321) );
  AO22X1_RVT U6438 ( .A1(n5017), .A2(\cpuregs[22][29] ), .A3(n4349), .A4(
        \cpuregs[9][29] ), .Y(n5320) );
  AO22X1_RVT U6439 ( .A1(n4382), .A2(\cpuregs[16][29] ), .A3(n4410), .A4(
        \cpuregs[12][29] ), .Y(n5319) );
  AO22X1_RVT U6440 ( .A1(n4393), .A2(\cpuregs[31][29] ), .A3(n4436), .A4(
        \cpuregs[10][29] ), .Y(n5318) );
  NOR4X1_RVT U6441 ( .A1(n5321), .A2(n5320), .A3(n5319), .A4(n5318), .Y(n5337)
         );
  AO22X1_RVT U6442 ( .A1(n4422), .A2(\cpuregs[7][29] ), .A3(n4449), .A4(
        \cpuregs[21][29] ), .Y(n5325) );
  AO22X1_RVT U6443 ( .A1(n6645), .A2(\cpuregs[27][29] ), .A3(n4337), .A4(
        \cpuregs[19][29] ), .Y(n5324) );
  AO22X1_RVT U6444 ( .A1(n4358), .A2(\cpuregs[18][29] ), .A3(n4486), .A4(
        \cpuregs[24][29] ), .Y(n5323) );
  AO22X1_RVT U6445 ( .A1(n4272), .A2(\cpuregs[15][29] ), .A3(n4407), .A4(
        \cpuregs[29][29] ), .Y(n5322) );
  NOR4X1_RVT U6446 ( .A1(n5325), .A2(n5324), .A3(n5323), .A4(n5322), .Y(n5336)
         );
  AO22X1_RVT U6447 ( .A1(n6581), .A2(\cpuregs[6][29] ), .A3(n4367), .A4(
        \cpuregs[5][29] ), .Y(n5329) );
  AO22X1_RVT U6448 ( .A1(n4346), .A2(\cpuregs[20][29] ), .A3(n4364), .A4(
        \cpuregs[8][29] ), .Y(n5328) );
  AO22X1_RVT U6449 ( .A1(n4420), .A2(\cpuregs[30][29] ), .A3(n4416), .A4(
        \cpuregs[28][29] ), .Y(n5327) );
  AO22X1_RVT U6450 ( .A1(n4375), .A2(\cpuregs[1][29] ), .A3(n4441), .A4(
        \cpuregs[4][29] ), .Y(n5326) );
  NOR4X1_RVT U6451 ( .A1(n5329), .A2(n5328), .A3(n5327), .A4(n5326), .Y(n5335)
         );
  AO22X1_RVT U6452 ( .A1(n4361), .A2(\cpuregs[11][29] ), .A3(n6592), .A4(
        \cpuregs[3][29] ), .Y(n5333) );
  AO22X1_RVT U6453 ( .A1(n4333), .A2(\cpuregs[25][29] ), .A3(n4431), .A4(
        \cpuregs[13][29] ), .Y(n5332) );
  AO22X1_RVT U6454 ( .A1(n4386), .A2(\cpuregs[23][29] ), .A3(n4413), .A4(
        \cpuregs[26][29] ), .Y(n5331) );
  AO22X1_RVT U6455 ( .A1(n4402), .A2(\cpuregs[14][29] ), .A3(n4425), .A4(
        \cpuregs[17][29] ), .Y(n5330) );
  NOR4X1_RVT U6456 ( .A1(n5333), .A2(n5332), .A3(n5331), .A4(n5330), .Y(n5334)
         );
  NAND4X0_RVT U6457 ( .A1(n5337), .A2(n5336), .A3(n5335), .A4(n5334), .Y(n5338) );
  AOI22X1_RVT U6458 ( .A1(n4060), .A2(n5338), .A3(net30310), .A4(reg_pc[29]), 
        .Y(n5339) );
  NAND4X0_RVT U6459 ( .A1(n5340), .A2(net26085), .A3(n5339), .A4(net25850), 
        .Y(n5341) );
  MUX21X1_RVT U6460 ( .A1(pcpi_rs1[29]), .A2(n5341), .S0(net26624), .Y(n3711)
         );
  AND2X1_RVT U6461 ( .A1(n4389), .A2(\cpuregs[2][11] ), .Y(n5345) );
  AO22X1_RVT U6462 ( .A1(n6645), .A2(\cpuregs[27][11] ), .A3(n4422), .A4(
        \cpuregs[7][11] ), .Y(n5344) );
  AO22X1_RVT U6463 ( .A1(n6725), .A2(\cpuregs[9][11] ), .A3(n4374), .A4(
        \cpuregs[1][11] ), .Y(n5343) );
  AO22X1_RVT U6464 ( .A1(n4338), .A2(\cpuregs[19][11] ), .A3(n4383), .A4(
        \cpuregs[16][11] ), .Y(n5342) );
  NOR4X1_RVT U6465 ( .A1(n5345), .A2(n5344), .A3(n5343), .A4(n5342), .Y(n5361)
         );
  AO22X1_RVT U6466 ( .A1(n4361), .A2(\cpuregs[11][11] ), .A3(n4411), .A4(
        \cpuregs[26][11] ), .Y(n5348) );
  AO22X1_RVT U6467 ( .A1(n5017), .A2(\cpuregs[22][11] ), .A3(n4392), .A4(
        \cpuregs[31][11] ), .Y(n5347) );
  AO22X1_RVT U6468 ( .A1(n4271), .A2(\cpuregs[15][11] ), .A3(n4433), .A4(
        \cpuregs[13][11] ), .Y(n5346) );
  NOR4X1_RVT U6469 ( .A1(n5349), .A2(n5348), .A3(n5347), .A4(n5346), .Y(n5360)
         );
  AO22X1_RVT U6470 ( .A1(n4358), .A2(\cpuregs[18][11] ), .A3(n4405), .A4(
        \cpuregs[29][11] ), .Y(n5353) );
  AO22X1_RVT U6471 ( .A1(n4419), .A2(\cpuregs[30][11] ), .A3(n4440), .A4(
        \cpuregs[4][11] ), .Y(n5352) );
  AO22X1_RVT U6472 ( .A1(n4346), .A2(\cpuregs[20][11] ), .A3(n4449), .A4(
        \cpuregs[21][11] ), .Y(n5351) );
  AO22X1_RVT U6473 ( .A1(n4408), .A2(\cpuregs[12][11] ), .A3(n4486), .A4(
        \cpuregs[24][11] ), .Y(n5350) );
  NOR4X1_RVT U6474 ( .A1(n5353), .A2(n5352), .A3(n5351), .A4(n5350), .Y(n5359)
         );
  AO22X1_RVT U6475 ( .A1(n4364), .A2(\cpuregs[8][11] ), .A3(n4415), .A4(
        \cpuregs[28][11] ), .Y(n5357) );
  AO22X1_RVT U6476 ( .A1(n6592), .A2(\cpuregs[3][11] ), .A3(n4402), .A4(
        \cpuregs[14][11] ), .Y(n5356) );
  AO22X1_RVT U6477 ( .A1(n4367), .A2(\cpuregs[5][11] ), .A3(n4386), .A4(
        \cpuregs[23][11] ), .Y(n5355) );
  AO22X1_RVT U6478 ( .A1(n4434), .A2(\cpuregs[10][11] ), .A3(n4425), .A4(
        \cpuregs[17][11] ), .Y(n5354) );
  NOR4X1_RVT U6479 ( .A1(n5357), .A2(n5356), .A3(n5355), .A4(n5354), .Y(n5358)
         );
  NAND4X0_RVT U6480 ( .A1(n5361), .A2(n5360), .A3(n5359), .A4(n5358), .Y(n5362) );
  AO22X1_RVT U6481 ( .A1(n4060), .A2(n5362), .A3(net30309), .A4(reg_pc[11]), 
        .Y(n5365) );
  OA22X1_RVT U6482 ( .A1(net16338), .A2(net25875), .A3(net16540), .A4(n5530), 
        .Y(n5389) );
  AND2X1_RVT U6483 ( .A1(n4327), .A2(\cpuregs[27][28] ), .Y(n5370) );
  AO22X1_RVT U6484 ( .A1(n4367), .A2(\cpuregs[5][28] ), .A3(n4432), .A4(
        \cpuregs[13][28] ), .Y(n5369) );
  AO22X1_RVT U6485 ( .A1(n4361), .A2(\cpuregs[11][28] ), .A3(n4403), .A4(
        \cpuregs[14][28] ), .Y(n5368) );
  AO22X1_RVT U6486 ( .A1(n4428), .A2(\cpuregs[3][28] ), .A3(n4487), .A4(
        \cpuregs[24][28] ), .Y(n5367) );
  NOR4X1_RVT U6487 ( .A1(n5370), .A2(n5369), .A3(n5368), .A4(n5367), .Y(n5386)
         );
  AO22X1_RVT U6488 ( .A1(n4422), .A2(\cpuregs[7][28] ), .A3(n4449), .A4(
        \cpuregs[21][28] ), .Y(n5374) );
  AO22X1_RVT U6489 ( .A1(n4271), .A2(\cpuregs[15][28] ), .A3(n4347), .A4(
        \cpuregs[20][28] ), .Y(n5373) );
  AO22X1_RVT U6490 ( .A1(n4358), .A2(\cpuregs[18][28] ), .A3(n4409), .A4(
        \cpuregs[12][28] ), .Y(n5372) );
  AO22X1_RVT U6491 ( .A1(n4390), .A2(\cpuregs[2][28] ), .A3(n4442), .A4(
        \cpuregs[4][28] ), .Y(n5371) );
  NOR4X1_RVT U6492 ( .A1(n5374), .A2(n5373), .A3(n5372), .A4(n5371), .Y(n5385)
         );
  AO22X1_RVT U6493 ( .A1(n5017), .A2(\cpuregs[22][28] ), .A3(n6761), .A4(
        \cpuregs[17][28] ), .Y(n5378) );
  AO22X1_RVT U6494 ( .A1(n6725), .A2(\cpuregs[9][28] ), .A3(n4338), .A4(
        \cpuregs[19][28] ), .Y(n5377) );
  AO22X1_RVT U6495 ( .A1(n4405), .A2(\cpuregs[29][28] ), .A3(n4417), .A4(
        \cpuregs[28][28] ), .Y(n5376) );
  AO22X1_RVT U6496 ( .A1(n4412), .A2(\cpuregs[26][28] ), .A3(n4420), .A4(
        \cpuregs[30][28] ), .Y(n5375) );
  NOR4X1_RVT U6497 ( .A1(n5378), .A2(n5377), .A3(n5376), .A4(n5375), .Y(n5384)
         );
  AO22X1_RVT U6498 ( .A1(n4373), .A2(\cpuregs[1][28] ), .A3(n4392), .A4(
        \cpuregs[31][28] ), .Y(n5382) );
  AO22X1_RVT U6499 ( .A1(n4333), .A2(\cpuregs[25][28] ), .A3(n4345), .A4(
        \cpuregs[6][28] ), .Y(n5381) );
  AO22X1_RVT U6500 ( .A1(n4386), .A2(\cpuregs[23][28] ), .A3(n4436), .A4(
        \cpuregs[10][28] ), .Y(n5380) );
  AO22X1_RVT U6501 ( .A1(n4364), .A2(\cpuregs[8][28] ), .A3(n4384), .A4(
        \cpuregs[16][28] ), .Y(n5379) );
  NOR4X1_RVT U6502 ( .A1(n5382), .A2(n5381), .A3(n5380), .A4(n5379), .Y(n5383)
         );
  NAND4X0_RVT U6503 ( .A1(n5386), .A2(n5385), .A3(n5384), .A4(n5383), .Y(n5387) );
  AOI22X1_RVT U6504 ( .A1(n4059), .A2(n5387), .A3(net30309), .A4(reg_pc[28]), 
        .Y(n5388) );
  NAND4X0_RVT U6505 ( .A1(n5389), .A2(net26030), .A3(n5388), .A4(net25850), 
        .Y(n5390) );
  MUX21X1_RVT U6506 ( .A1(pcpi_rs1[28]), .A2(n5390), .S0(net29472), .Y(n3712)
         );
  NAND2X0_RVT U6507 ( .A1(mem_wordsize[1]), .A2(n7971), .Y(n5791) );
  AO22X1_RVT U6508 ( .A1(pcpi_rs2[12]), .A2(n8070), .A3(pcpi_rs2[4]), .A4(
        n7810), .Y(n3954) );
  AO22X1_RVT U6509 ( .A1(pcpi_rs2[8]), .A2(n8070), .A3(pcpi_rs2[0]), .A4(n7810), .Y(n3958) );
  AO22X1_RVT U6510 ( .A1(pcpi_rs2[15]), .A2(n8070), .A3(pcpi_rs2[7]), .A4(
        n7810), .Y(n3951) );
  AO22X1_RVT U6511 ( .A1(pcpi_rs2[14]), .A2(n8070), .A3(pcpi_rs2[6]), .A4(
        n7810), .Y(n3952) );
  AO22X1_RVT U6512 ( .A1(pcpi_rs2[13]), .A2(n8070), .A3(pcpi_rs2[5]), .A4(
        n7810), .Y(n3953) );
  AO22X1_RVT U6513 ( .A1(pcpi_rs2[11]), .A2(n8070), .A3(pcpi_rs2[3]), .A4(
        n7810), .Y(n3955) );
  OA221X1_RVT U6514 ( .A1(n4630), .A2(reg_next_pc[2]), .A3(n4632), .A4(
        reg_out[2]), .A5(n4053), .Y(n5391) );
  AO21X1_RVT U6515 ( .A1(net30713), .A2(n6209), .A3(n5391), .Y(mem_la_addr[2])
         );
  OA221X1_RVT U6516 ( .A1(n4631), .A2(reg_next_pc[30]), .A3(n4632), .A4(
        reg_out[30]), .A5(n4052), .Y(n5392) );
  AO21X1_RVT U6517 ( .A1(pcpi_rs1[30]), .A2(n4323), .A3(n5392), .Y(
        mem_la_addr[30]) );
  OA221X1_RVT U6518 ( .A1(n4188), .A2(reg_next_pc[28]), .A3(n4632), .A4(
        reg_out[28]), .A5(n4052), .Y(n5393) );
  AO21X1_RVT U6519 ( .A1(pcpi_rs1[28]), .A2(n4322), .A3(n5393), .Y(
        mem_la_addr[28]) );
  OA221X1_RVT U6520 ( .A1(n4188), .A2(reg_next_pc[22]), .A3(n4220), .A4(
        reg_out[22]), .A5(n4052), .Y(n5394) );
  AO21X1_RVT U6521 ( .A1(pcpi_rs1[22]), .A2(n4322), .A3(n5394), .Y(
        mem_la_addr[22]) );
  NAND2X0_RVT U6522 ( .A1(pcpi_rs2[22]), .A2(pcpi_rs1[22]), .Y(n7547) );
  NAND2X0_RVT U6523 ( .A1(n8041), .A2(net16467), .Y(n7553) );
  AO222X1_RVT U6524 ( .A1(pcpi_rs2[2]), .A2(net16336), .A3(n7985), .A4(n8092), 
        .A5(n7547), .A6(n7553), .Y(n5413) );
  NAND2X0_RVT U6525 ( .A1(pcpi_rs2[4]), .A2(pcpi_rs1[4]), .Y(n7648) );
  NAND2X0_RVT U6526 ( .A1(n7998), .A2(net16330), .Y(n7654) );
  AO22X1_RVT U6527 ( .A1(n8081), .A2(pcpi_rs2[13]), .A3(net16341), .A4(n7989), 
        .Y(n6261) );
  AO22X1_RVT U6528 ( .A1(n8072), .A2(pcpi_rs2[26]), .A3(net16339), .A4(n7995), 
        .Y(n6289) );
  NAND4X0_RVT U6529 ( .A1(n7605), .A2(n5395), .A3(n6261), .A4(n6289), .Y(n5411) );
  AO22X1_RVT U6530 ( .A1(pcpi_rs1[25]), .A2(pcpi_rs2[25]), .A3(net16364), .A4(
        n8030), .Y(n6271) );
  OA221X1_RVT U6531 ( .A1(pcpi_rs1[9]), .A2(n8029), .A3(net13612), .A4(
        pcpi_rs2[9]), .A5(n6271), .Y(n5397) );
  AO22X1_RVT U6532 ( .A1(pcpi_rs1[19]), .A2(pcpi_rs2[19]), .A3(net16362), .A4(
        n8026), .Y(n6253) );
  OA221X1_RVT U6533 ( .A1(pcpi_rs2[29]), .A2(net16540), .A3(n8031), .A4(
        pcpi_rs1[29]), .A5(n6253), .Y(n5396) );
  AO22X1_RVT U6534 ( .A1(pcpi_rs1[28]), .A2(pcpi_rs2[28]), .A3(net16345), .A4(
        n7973), .Y(n6403) );
  AND4X1_RVT U6535 ( .A1(n5397), .A2(n5396), .A3(n6403), .A4(n6422), .Y(n5409)
         );
  NAND2X0_RVT U6536 ( .A1(pcpi_rs2[15]), .A2(pcpi_rs1[15]), .Y(n7587) );
  NAND2X0_RVT U6537 ( .A1(n8033), .A2(net16327), .Y(n7593) );
  AO222X1_RVT U6538 ( .A1(n8073), .A2(n8036), .A3(net16451), .A4(pcpi_rs2[24]), 
        .A5(n7587), .A6(n7593), .Y(n5406) );
  NAND2X0_RVT U6539 ( .A1(pcpi_rs1[14]), .A2(pcpi_rs2[14]), .Y(n6558) );
  NAND2X0_RVT U6540 ( .A1(n7997), .A2(net16348), .Y(n6563) );
  AO222X1_RVT U6541 ( .A1(pcpi_rs1[23]), .A2(n7994), .A3(net16360), .A4(
        pcpi_rs2[23]), .A5(n6558), .A6(n6563), .Y(n5405) );
  AO22X1_RVT U6542 ( .A1(n8086), .A2(pcpi_rs2[8]), .A3(net16337), .A4(n7992), 
        .Y(n6387) );
  AO22X1_RVT U6543 ( .A1(n8083), .A2(pcpi_rs2[11]), .A3(net16317), .A4(n7972), 
        .Y(n6395) );
  AO22X1_RVT U6544 ( .A1(pcpi_rs1[30]), .A2(pcpi_rs2[30]), .A3(net16452), .A4(
        n8024), .Y(n5398) );
  AO22X1_RVT U6545 ( .A1(pcpi_rs1[18]), .A2(pcpi_rs2[18]), .A3(net16365), .A4(
        n7990), .Y(n6245) );
  NAND4X0_RVT U6546 ( .A1(n6387), .A2(n6395), .A3(n5398), .A4(n6245), .Y(n5404) );
  AO22X1_RVT U6547 ( .A1(pcpi_rs1[16]), .A2(pcpi_rs2[16]), .A3(net16357), .A4(
        n7993), .Y(n6229) );
  OA221X1_RVT U6548 ( .A1(pcpi_rs2[5]), .A2(net16448), .A3(n8021), .A4(
        net30690), .A5(n6229), .Y(n5402) );
  NAND2X0_RVT U6549 ( .A1(pcpi_rs2[20]), .A2(pcpi_rs1[20]), .Y(n7559) );
  NAND2X0_RVT U6550 ( .A1(n7996), .A2(net16349), .Y(n7565) );
  AOI222X1_RVT U6551 ( .A1(n7987), .A2(n8091), .A3(pcpi_rs2[3]), .A4(net16367), 
        .A5(n7559), .A6(n7565), .Y(n5401) );
  AO22X1_RVT U6552 ( .A1(n8088), .A2(pcpi_rs2[6]), .A3(net16359), .A4(net16468), .Y(n6410) );
  OA221X1_RVT U6553 ( .A1(n8087), .A2(n7986), .A3(net16363), .A4(pcpi_rs2[7]), 
        .A5(n6410), .Y(n5400) );
  AO22X1_RVT U6554 ( .A1(pcpi_rs1[21]), .A2(pcpi_rs2[21]), .A3(net16453), .A4(
        n8027), .Y(n6379) );
  OA221X1_RVT U6555 ( .A1(pcpi_rs2[17]), .A2(net16361), .A3(n8028), .A4(
        pcpi_rs1[17]), .A5(n6379), .Y(n5399) );
  NAND4X0_RVT U6556 ( .A1(n5402), .A2(n5401), .A3(n5400), .A4(n5399), .Y(n5403) );
  NOR4X1_RVT U6557 ( .A1(n5406), .A2(n5405), .A3(n5404), .A4(n5403), .Y(n5408)
         );
  AO22X1_RVT U6558 ( .A1(pcpi_rs1[27]), .A2(pcpi_rs2[27]), .A3(net16338), .A4(
        n8032), .Y(n5407) );
  AO22X1_RVT U6559 ( .A1(pcpi_rs1[10]), .A2(pcpi_rs2[10]), .A3(net16340), .A4(
        n7991), .Y(n6237) );
  NAND4X0_RVT U6560 ( .A1(n5409), .A2(n5408), .A3(n5407), .A4(n6237), .Y(n5410) );
  NOR4X1_RVT U6561 ( .A1(n5413), .A2(n5412), .A3(n5411), .A4(n5410), .Y(n5510)
         );
  NAND2X0_RVT U6562 ( .A1(n8073), .A2(n8036), .Y(n5494) );
  NAND2X0_RVT U6563 ( .A1(pcpi_rs1[25]), .A2(n8030), .Y(n5493) );
  AO22X1_RVT U6564 ( .A1(n8072), .A2(n7995), .A3(pcpi_rs1[27]), .A4(n8032), 
        .Y(n5490) );
  AO22X1_RVT U6565 ( .A1(pcpi_rs1[30]), .A2(n8024), .A3(pcpi_rs2[31]), .A4(
        net16372), .Y(n5483) );
  NAND2X0_RVT U6566 ( .A1(pcpi_rs1[28]), .A2(n7973), .Y(n5488) );
  NAND2X0_RVT U6567 ( .A1(pcpi_rs1[29]), .A2(n8031), .Y(n5487) );
  NAND3X0_RVT U6568 ( .A1(n5414), .A2(n5488), .A3(n5487), .Y(n5484) );
  NOR2X0_RVT U6569 ( .A1(n5490), .A2(n5484), .Y(n5473) );
  NAND2X0_RVT U6570 ( .A1(n8076), .A2(n8026), .Y(n5415) );
  NAND2X0_RVT U6571 ( .A1(pcpi_rs2[18]), .A2(n5415), .Y(n5416) );
  OA22X1_RVT U6572 ( .A1(n8076), .A2(n8026), .A3(n4032), .A4(n5416), .Y(n5419)
         );
  NAND2X0_RVT U6573 ( .A1(pcpi_rs1[17]), .A2(n8028), .Y(n5463) );
  NAND2X0_RVT U6574 ( .A1(pcpi_rs2[16]), .A2(n5463), .Y(n5417) );
  OA22X1_RVT U6575 ( .A1(n8028), .A2(pcpi_rs1[17]), .A3(n5417), .A4(
        pcpi_rs1[16]), .Y(n5418) );
  AO22X1_RVT U6576 ( .A1(n4032), .A2(n7990), .A3(n8076), .A4(n8026), .Y(n5466)
         );
  AO22X1_RVT U6577 ( .A1(n5419), .A2(n5418), .A3(n5419), .A4(n5466), .Y(n5428)
         );
  NAND2X0_RVT U6578 ( .A1(pcpi_rs1[21]), .A2(n8027), .Y(n5421) );
  NAND2X0_RVT U6579 ( .A1(pcpi_rs2[20]), .A2(n5421), .Y(n5422) );
  OA22X1_RVT U6580 ( .A1(n8027), .A2(pcpi_rs1[21]), .A3(n5422), .A4(
        pcpi_rs1[20]), .Y(n5427) );
  NAND2X0_RVT U6581 ( .A1(pcpi_rs1[23]), .A2(n7994), .Y(n5423) );
  NAND2X0_RVT U6582 ( .A1(pcpi_rs2[22]), .A2(n5423), .Y(n5424) );
  OA22X1_RVT U6583 ( .A1(n7994), .A2(pcpi_rs1[23]), .A3(n5424), .A4(
        pcpi_rs1[22]), .Y(n5425) );
  OA221X1_RVT U6584 ( .A1(n5428), .A2(n5465), .A3(n5427), .A4(n5426), .A5(
        n5425), .Y(n5472) );
  NAND2X0_RVT U6585 ( .A1(n8083), .A2(n7972), .Y(n5429) );
  NAND2X0_RVT U6586 ( .A1(pcpi_rs2[10]), .A2(n5429), .Y(n5430) );
  OA22X1_RVT U6587 ( .A1(n8083), .A2(n7972), .A3(pcpi_rs1[10]), .A4(n5430), 
        .Y(n5433) );
  NAND2X0_RVT U6588 ( .A1(n8085), .A2(n8029), .Y(n5444) );
  NAND2X0_RVT U6589 ( .A1(pcpi_rs2[8]), .A2(n5444), .Y(n5431) );
  OA22X1_RVT U6590 ( .A1(n8029), .A2(pcpi_rs1[9]), .A3(n5431), .A4(n8086), .Y(
        n5432) );
  AO22X1_RVT U6591 ( .A1(pcpi_rs1[10]), .A2(n7991), .A3(n8083), .A4(n7972), 
        .Y(n5447) );
  AO22X1_RVT U6592 ( .A1(n5433), .A2(n5432), .A3(n5433), .A4(n5447), .Y(n5443)
         );
  NAND2X0_RVT U6593 ( .A1(pcpi_rs1[12]), .A2(n8001), .Y(n5434) );
  NAND2X0_RVT U6594 ( .A1(n8081), .A2(n7989), .Y(n5436) );
  NAND3X0_RVT U6595 ( .A1(n5435), .A2(n5434), .A3(n5436), .Y(n5446) );
  NAND2X0_RVT U6596 ( .A1(pcpi_rs2[12]), .A2(n5436), .Y(n5437) );
  OA22X1_RVT U6597 ( .A1(n7989), .A2(n8081), .A3(n5437), .A4(pcpi_rs1[12]), 
        .Y(n5442) );
  NAND2X0_RVT U6598 ( .A1(pcpi_rs1[15]), .A2(n8033), .Y(n5438) );
  NAND2X0_RVT U6599 ( .A1(pcpi_rs2[14]), .A2(n5438), .Y(n5439) );
  OA221X1_RVT U6600 ( .A1(n5443), .A2(n5446), .A3(n5442), .A4(n5441), .A5(
        n5440), .Y(n5470) );
  OAI21X1_RVT U6601 ( .A1(pcpi_rs2[8]), .A2(net16337), .A3(n5444), .Y(n5445)
         );
  NAND2X0_RVT U6602 ( .A1(n8091), .A2(n7987), .Y(n5448) );
  NAND2X0_RVT U6603 ( .A1(pcpi_rs2[2]), .A2(n5448), .Y(n5449) );
  AO22X1_RVT U6604 ( .A1(n8092), .A2(n7985), .A3(n8091), .A4(n7987), .Y(n5453)
         );
  NAND2X0_RVT U6605 ( .A1(pcpi_rs2[0]), .A2(net16449), .Y(n5450) );
  AO222X1_RVT U6606 ( .A1(n8093), .A2(n5450), .A3(n8035), .A4(n5450), .A5(
        n8093), .A6(n8035), .Y(n5452) );
  AO22X1_RVT U6607 ( .A1(net30690), .A2(n8021), .A3(pcpi_rs1[4]), .A4(n7998), 
        .Y(n5451) );
  AO221X1_RVT U6608 ( .A1(n5454), .A2(n5453), .A3(n5454), .A4(n5452), .A5(
        n5451), .Y(n5462) );
  AO22X1_RVT U6609 ( .A1(n8088), .A2(net16468), .A3(n8087), .A4(n7986), .Y(
        n5461) );
  NAND2X0_RVT U6610 ( .A1(net30690), .A2(n8021), .Y(n5455) );
  NAND2X0_RVT U6611 ( .A1(pcpi_rs2[4]), .A2(n5455), .Y(n5456) );
  NAND2X0_RVT U6612 ( .A1(n8087), .A2(n7986), .Y(n5457) );
  NAND2X0_RVT U6613 ( .A1(pcpi_rs2[6]), .A2(n5457), .Y(n5458) );
  OA221X1_RVT U6614 ( .A1(n5462), .A2(n5461), .A3(n5460), .A4(n5461), .A5(
        n5459), .Y(n5468) );
  AO221X1_RVT U6615 ( .A1(n5470), .A2(n5469), .A3(n5470), .A4(n5468), .A5(
        n5467), .Y(n5471) );
  NAND2X0_RVT U6616 ( .A1(n5472), .A2(n5471), .Y(n5491) );
  NAND4X0_RVT U6617 ( .A1(n5494), .A2(n5493), .A3(n5473), .A4(n5491), .Y(n5486) );
  NAND2X0_RVT U6618 ( .A1(pcpi_rs1[27]), .A2(n8032), .Y(n5474) );
  NAND2X0_RVT U6619 ( .A1(pcpi_rs2[26]), .A2(n5474), .Y(n5475) );
  OA22X1_RVT U6620 ( .A1(pcpi_rs1[27]), .A2(n8032), .A3(n8072), .A4(n5475), 
        .Y(n5478) );
  NAND2X0_RVT U6621 ( .A1(pcpi_rs2[24]), .A2(n5493), .Y(n5476) );
  OA22X1_RVT U6622 ( .A1(n8030), .A2(pcpi_rs1[25]), .A3(n5476), .A4(n8073), 
        .Y(n5477) );
  AO22X1_RVT U6623 ( .A1(n5478), .A2(n5477), .A3(n5478), .A4(n5490), .Y(n5501)
         );
  NAND2X0_RVT U6624 ( .A1(pcpi_rs2[28]), .A2(n5487), .Y(n5479) );
  OA22X1_RVT U6625 ( .A1(n8031), .A2(pcpi_rs1[29]), .A3(n5479), .A4(
        pcpi_rs1[28]), .Y(n5499) );
  NAND2X0_RVT U6626 ( .A1(pcpi_rs2[31]), .A2(net16372), .Y(n5480) );
  NAND2X0_RVT U6627 ( .A1(pcpi_rs2[30]), .A2(n5480), .Y(n5481) );
  OA22X1_RVT U6628 ( .A1(net16372), .A2(pcpi_rs2[31]), .A3(n5481), .A4(
        pcpi_rs1[30]), .Y(n5482) );
  OA221X1_RVT U6629 ( .A1(n5501), .A2(n5484), .A3(n5499), .A4(n5483), .A5(
        n5482), .Y(n5485) );
  NAND2X0_RVT U6630 ( .A1(n5486), .A2(n5485), .Y(n5508) );
  NAND2X0_RVT U6631 ( .A1(n5508), .A2(is_slti_blt_slt), .Y(n5506) );
  AO22X1_RVT U6632 ( .A1(pcpi_rs1[30]), .A2(n8024), .A3(pcpi_rs1[31]), .A4(
        n8023), .Y(n5498) );
  NAND3X0_RVT U6633 ( .A1(n5489), .A2(n5488), .A3(n5487), .Y(n5500) );
  NOR2X0_RVT U6634 ( .A1(n5490), .A2(n5500), .Y(n5492) );
  NAND4X0_RVT U6635 ( .A1(n5494), .A2(n5493), .A3(n5492), .A4(n5491), .Y(n5503) );
  NAND2X0_RVT U6636 ( .A1(pcpi_rs1[31]), .A2(n8023), .Y(n5495) );
  NAND2X0_RVT U6637 ( .A1(pcpi_rs2[30]), .A2(n5495), .Y(n5496) );
  OA22X1_RVT U6638 ( .A1(n8023), .A2(pcpi_rs1[31]), .A3(n5496), .A4(
        pcpi_rs1[30]), .Y(n5497) );
  OA221X1_RVT U6639 ( .A1(n5501), .A2(n5500), .A3(n5499), .A4(n5498), .A5(
        n5497), .Y(n5502) );
  NAND2X0_RVT U6640 ( .A1(n5503), .A2(n5502), .Y(n5504) );
  NAND3X0_RVT U6641 ( .A1(n5504), .A2(is_sltiu_bltu_sltu), .A3(n8052), .Y(
        n5505) );
  OA222X1_RVT U6642 ( .A1(instr_bgeu), .A2(n5506), .A3(instr_bgeu), .A4(n5505), 
        .A5(n5504), .A6(n8048), .Y(n5507) );
  AO221X1_RVT U6643 ( .A1(instr_bge), .A2(n5508), .A3(n8051), .A4(n5507), .A5(
        instr_bne), .Y(n5509) );
  AND2X1_RVT U6644 ( .A1(is_beq_bne_blt_bge_bltu_bgeu), .A2(n7819), .Y(n6464)
         );
  AND2X1_RVT U6645 ( .A1(is_lb_lh_lw_lbu_lhu), .A2(n7927), .Y(n7923) );
  AOI21X1_RVT U6646 ( .A1(n8055), .A2(n7253), .A3(n5513), .Y(n5512) );
  NAND2X0_RVT U6647 ( .A1(n4806), .A2(n7929), .Y(n5511) );
  NAND2X0_RVT U6648 ( .A1(n5512), .A2(n5511), .Y(n5515) );
  OA22X1_RVT U6649 ( .A1(mem_do_prefetch), .A2(n5513), .A3(n4633), .A4(n5515), 
        .Y(n5514) );
  NAND2X0_RVT U6650 ( .A1(decoder_trigger), .A2(n8042), .Y(n6050) );
  AND2X1_RVT U6651 ( .A1(resetn), .A2(n4855), .Y(n7920) );
  OA221X1_RVT U6652 ( .A1(n5514), .A2(n5833), .A3(n5514), .A4(n6050), .A5(
        n7920), .Y(n5519) );
  AND2X1_RVT U6653 ( .A1(resetn), .A2(n7823), .Y(n7886) );
  NAND2X0_RVT U6654 ( .A1(n4633), .A2(n4291), .Y(n5516) );
  MUX21X1_RVT U6655 ( .A1(mem_do_rinst), .A2(n5519), .S0(n5518), .Y(n5520) );
  AO21X1_RVT U6656 ( .A1(resetn), .A2(n6464), .A3(n5520), .Y(n3708) );
  AO22X1_RVT U6657 ( .A1(n4635), .A2(mem_rdata[22]), .A3(n5521), .A4(
        mem_rdata_q[22]), .Y(n2521) );
  MUX21X1_RVT U6658 ( .A1(n2521), .A2(decoded_imm_j[2]), .S0(n4539), .Y(n3625)
         );
  AO22X1_RVT U6659 ( .A1(n4808), .A2(mem_rdata[28]), .A3(n5521), .A4(
        mem_rdata_q[28]), .Y(n2515) );
  MUX21X1_RVT U6660 ( .A1(n2515), .A2(decoded_imm_j[8]), .S0(n4541), .Y(n3619)
         );
  AO22X1_RVT U6661 ( .A1(n4808), .A2(mem_rdata[26]), .A3(n4807), .A4(
        mem_rdata_q[26]), .Y(n2517) );
  MUX21X1_RVT U6662 ( .A1(n2517), .A2(decoded_imm_j[6]), .S0(n4539), .Y(n3621)
         );
  AO22X1_RVT U6663 ( .A1(n4809), .A2(mem_rdata[16]), .A3(n4807), .A4(
        mem_rdata_q[16]), .Y(n2527) );
  MUX21X1_RVT U6664 ( .A1(n2527), .A2(decoded_imm_j[16]), .S0(n4540), .Y(n3611) );
  AO22X1_RVT U6665 ( .A1(n4808), .A2(mem_rdata[25]), .A3(n4807), .A4(
        mem_rdata_q[25]), .Y(n2518) );
  MUX21X1_RVT U6666 ( .A1(n2518), .A2(decoded_imm_j[5]), .S0(n4541), .Y(n3622)
         );
  AO22X1_RVT U6667 ( .A1(n4809), .A2(mem_rdata[27]), .A3(n5521), .A4(
        mem_rdata_q[27]), .Y(n2516) );
  MUX21X1_RVT U6668 ( .A1(n2516), .A2(decoded_imm_j[7]), .S0(n4539), .Y(n3620)
         );
  AO22X1_RVT U6669 ( .A1(n4635), .A2(mem_rdata[15]), .A3(n5521), .A4(
        mem_rdata_q[15]), .Y(n2528) );
  MUX21X1_RVT U6670 ( .A1(n2528), .A2(decoded_imm_j[15]), .S0(n4541), .Y(n3612) );
  AO22X1_RVT U6671 ( .A1(n4543), .A2(mem_rdata[21]), .A3(n4544), .A4(
        mem_rdata_q[21]), .Y(n2522) );
  MUX21X1_RVT U6672 ( .A1(n2522), .A2(decoded_imm_j[1]), .S0(n4541), .Y(n3626)
         );
  AO22X1_RVT U6673 ( .A1(n4808), .A2(mem_rdata[29]), .A3(n4807), .A4(
        mem_rdata_q[29]), .Y(n2514) );
  MUX21X1_RVT U6674 ( .A1(n2514), .A2(decoded_imm_j[9]), .S0(n4539), .Y(n3618)
         );
  AO22X1_RVT U6675 ( .A1(n4808), .A2(mem_rdata[20]), .A3(n4544), .A4(
        mem_rdata_q[20]), .Y(n2523) );
  AO22X1_RVT U6676 ( .A1(n4543), .A2(mem_rdata[30]), .A3(n4544), .A4(
        mem_rdata_q[30]), .Y(n2513) );
  AO22X1_RVT U6677 ( .A1(n4809), .A2(mem_rdata[12]), .A3(n4544), .A4(
        mem_rdata_q[12]), .Y(n2531) );
  MUX21X1_RVT U6678 ( .A1(n2531), .A2(decoded_imm_j[12]), .S0(n4539), .Y(n3615) );
  AO22X1_RVT U6679 ( .A1(n4808), .A2(mem_rdata[13]), .A3(n5521), .A4(
        mem_rdata_q[13]), .Y(n2530) );
  MUX21X1_RVT U6680 ( .A1(n2530), .A2(decoded_imm_j[13]), .S0(n4540), .Y(n3614) );
  AO22X1_RVT U6681 ( .A1(n4635), .A2(mem_rdata[14]), .A3(n4544), .A4(
        mem_rdata_q[14]), .Y(n2529) );
  MUX21X1_RVT U6682 ( .A1(n2529), .A2(decoded_imm_j[14]), .S0(n4540), .Y(n3613) );
  AO22X1_RVT U6683 ( .A1(n4543), .A2(mem_rdata[24]), .A3(n4544), .A4(
        mem_rdata_q[24]), .Y(n2519) );
  MUX21X1_RVT U6684 ( .A1(n2519), .A2(decoded_imm_j[4]), .S0(n4540), .Y(n3623)
         );
  AO22X1_RVT U6685 ( .A1(n4543), .A2(mem_rdata[23]), .A3(n5521), .A4(
        mem_rdata_q[23]), .Y(n2520) );
  MUX21X1_RVT U6686 ( .A1(n2520), .A2(decoded_imm_j[3]), .S0(n4541), .Y(n3624)
         );
  AO22X1_RVT U6687 ( .A1(n4543), .A2(mem_rdata[17]), .A3(n4544), .A4(
        mem_rdata_q[17]), .Y(n2526) );
  MUX21X1_RVT U6688 ( .A1(n2526), .A2(decoded_imm_j[17]), .S0(n4539), .Y(n3610) );
  AO22X1_RVT U6689 ( .A1(n4809), .A2(mem_rdata[18]), .A3(n5521), .A4(
        mem_rdata_q[18]), .Y(n2525) );
  MUX21X1_RVT U6690 ( .A1(n2525), .A2(decoded_imm_j[18]), .S0(n4540), .Y(n3609) );
  AO22X1_RVT U6691 ( .A1(n4809), .A2(mem_rdata[19]), .A3(n4807), .A4(
        mem_rdata_q[19]), .Y(n2524) );
  MUX21X1_RVT U6692 ( .A1(n2524), .A2(n4399), .S0(n4539), .Y(n3608) );
  AO22X1_RVT U6693 ( .A1(n4808), .A2(mem_rdata[5]), .A3(n5521), .A4(
        mem_rdata_q[5]), .Y(n2538) );
  AO22X1_RVT U6694 ( .A1(n4809), .A2(mem_rdata[4]), .A3(n5521), .A4(
        mem_rdata_q[4]), .Y(n2539) );
  AO22X1_RVT U6695 ( .A1(n4809), .A2(mem_rdata[6]), .A3(n4544), .A4(
        mem_rdata_q[6]), .Y(n2537) );
  AO22X1_RVT U6696 ( .A1(n4809), .A2(mem_rdata[3]), .A3(n5521), .A4(
        mem_rdata_q[3]), .Y(n2540) );
  AO22X1_RVT U6697 ( .A1(n4808), .A2(mem_rdata[2]), .A3(n5521), .A4(
        mem_rdata_q[2]), .Y(n2541) );
  AND2X1_RVT U6698 ( .A1(latched_rd[3]), .A2(n4810), .Y(n5522) );
  OA21X1_RVT U6699 ( .A1(latched_store), .A2(latched_branch), .A3(n5522), .Y(
        n6308) );
  AO22X1_RVT U6700 ( .A1(n4732), .A2(n4595), .A3(n4621), .A4(\cpuregs[31][25] ), .Y(n3559) );
  AO22X1_RVT U6701 ( .A1(n4175), .A2(mem_rdata_word[21]), .A3(n4634), .A4(
        pcpi_rs1[21]), .Y(n5526) );
  OR2X1_RVT U6702 ( .A1(n5527), .A2(n5526), .Y(n5528) );
  AND2X1_RVT U6703 ( .A1(n4486), .A2(\cpuregs[24][30] ), .Y(n5534) );
  AO22X1_RVT U6704 ( .A1(n4367), .A2(\cpuregs[5][30] ), .A3(n4393), .A4(
        \cpuregs[31][30] ), .Y(n5533) );
  AO22X1_RVT U6705 ( .A1(n4386), .A2(\cpuregs[23][30] ), .A3(n4436), .A4(
        \cpuregs[10][30] ), .Y(n5532) );
  AO22X1_RVT U6706 ( .A1(n4433), .A2(\cpuregs[13][30] ), .A3(n4416), .A4(
        \cpuregs[28][30] ), .Y(n5531) );
  NOR4X1_RVT U6707 ( .A1(n5534), .A2(n5533), .A3(n5532), .A4(n5531), .Y(n5550)
         );
  AO22X1_RVT U6708 ( .A1(n4422), .A2(\cpuregs[7][30] ), .A3(n4440), .A4(
        \cpuregs[4][30] ), .Y(n5538) );
  AO22X1_RVT U6709 ( .A1(n4373), .A2(\cpuregs[1][30] ), .A3(n4408), .A4(
        \cpuregs[12][30] ), .Y(n5537) );
  AO22X1_RVT U6710 ( .A1(n4358), .A2(\cpuregs[18][30] ), .A3(n4362), .A4(
        \cpuregs[11][30] ), .Y(n5536) );
  AO22X1_RVT U6711 ( .A1(n4407), .A2(\cpuregs[29][30] ), .A3(n4427), .A4(
        \cpuregs[3][30] ), .Y(n5535) );
  NOR4X1_RVT U6712 ( .A1(n5538), .A2(n5537), .A3(n5536), .A4(n5535), .Y(n5549)
         );
  AO22X1_RVT U6713 ( .A1(n4336), .A2(\cpuregs[19][30] ), .A3(n4402), .A4(
        \cpuregs[14][30] ), .Y(n5542) );
  AO22X1_RVT U6714 ( .A1(n4271), .A2(\cpuregs[15][30] ), .A3(n4413), .A4(
        \cpuregs[26][30] ), .Y(n5541) );
  AO22X1_RVT U6715 ( .A1(n6645), .A2(\cpuregs[27][30] ), .A3(n6761), .A4(
        \cpuregs[17][30] ), .Y(n5540) );
  AO22X1_RVT U6716 ( .A1(n4335), .A2(\cpuregs[25][30] ), .A3(n4390), .A4(
        \cpuregs[2][30] ), .Y(n5539) );
  NOR4X1_RVT U6717 ( .A1(n5542), .A2(n5541), .A3(n5540), .A4(n5539), .Y(n5548)
         );
  AO22X1_RVT U6718 ( .A1(n4419), .A2(\cpuregs[30][30] ), .A3(n4449), .A4(
        \cpuregs[21][30] ), .Y(n5546) );
  AO22X1_RVT U6719 ( .A1(n5017), .A2(\cpuregs[22][30] ), .A3(n6581), .A4(
        \cpuregs[6][30] ), .Y(n5545) );
  AO22X1_RVT U6720 ( .A1(n6725), .A2(\cpuregs[9][30] ), .A3(n4384), .A4(
        \cpuregs[16][30] ), .Y(n5544) );
  AO22X1_RVT U6721 ( .A1(n4346), .A2(\cpuregs[20][30] ), .A3(n4366), .A4(
        \cpuregs[8][30] ), .Y(n5543) );
  NOR4X1_RVT U6722 ( .A1(n5546), .A2(n5545), .A3(n5544), .A4(n5543), .Y(n5547)
         );
  NAND4X0_RVT U6723 ( .A1(n5550), .A2(n5549), .A3(n5548), .A4(n5547), .Y(n5551) );
  AOI22X1_RVT U6724 ( .A1(n4061), .A2(n5551), .A3(net30310), .A4(reg_pc[30]), 
        .Y(n5552) );
  OR2X1_RVT U6725 ( .A1(net25842), .A2(n5554), .Y(n5555) );
  AO21X1_RVT U6726 ( .A1(reg_pc[2]), .A2(net30309), .A3(n5555), .Y(n5578) );
  AO22X1_RVT U6727 ( .A1(n4334), .A2(\cpuregs[25][2] ), .A3(n4345), .A4(
        \cpuregs[6][2] ), .Y(n5557) );
  AO22X1_RVT U6728 ( .A1(n4433), .A2(\cpuregs[13][2] ), .A3(n4442), .A4(
        \cpuregs[4][2] ), .Y(n5556) );
  OR2X1_RVT U6729 ( .A1(n5557), .A2(n5556), .Y(n5558) );
  AO21X1_RVT U6730 ( .A1(n4394), .A2(\cpuregs[31][2] ), .A3(n5558), .Y(n5576)
         );
  AO22X1_RVT U6731 ( .A1(n4337), .A2(\cpuregs[19][2] ), .A3(n4388), .A4(
        \cpuregs[23][2] ), .Y(n5575) );
  AO22X1_RVT U6732 ( .A1(n4407), .A2(\cpuregs[29][2] ), .A3(n4427), .A4(
        \cpuregs[3][2] ), .Y(n5562) );
  AO22X1_RVT U6733 ( .A1(n4410), .A2(\cpuregs[12][2] ), .A3(n4450), .A4(
        \cpuregs[21][2] ), .Y(n5561) );
  AO22X1_RVT U6734 ( .A1(n4272), .A2(\cpuregs[15][2] ), .A3(n4349), .A4(
        \cpuregs[9][2] ), .Y(n5560) );
  AO22X1_RVT U6735 ( .A1(n4360), .A2(\cpuregs[18][2] ), .A3(n4421), .A4(
        \cpuregs[30][2] ), .Y(n5559) );
  NOR4X1_RVT U6736 ( .A1(n5562), .A2(n5561), .A3(n5560), .A4(n5559), .Y(n5573)
         );
  AO22X1_RVT U6737 ( .A1(n4424), .A2(\cpuregs[7][2] ), .A3(n4426), .A4(
        \cpuregs[17][2] ), .Y(n5566) );
  AO22X1_RVT U6738 ( .A1(n4375), .A2(\cpuregs[1][2] ), .A3(n4404), .A4(
        \cpuregs[14][2] ), .Y(n5565) );
  AO22X1_RVT U6739 ( .A1(n4347), .A2(\cpuregs[20][2] ), .A3(n4391), .A4(
        \cpuregs[2][2] ), .Y(n5564) );
  AO22X1_RVT U6740 ( .A1(n4363), .A2(\cpuregs[11][2] ), .A3(n4412), .A4(
        \cpuregs[26][2] ), .Y(n5563) );
  NOR4X1_RVT U6741 ( .A1(n5566), .A2(n5565), .A3(n5564), .A4(n5563), .Y(n5572)
         );
  AO22X1_RVT U6742 ( .A1(n4384), .A2(\cpuregs[16][2] ), .A3(n4487), .A4(
        \cpuregs[24][2] ), .Y(n5570) );
  AO22X1_RVT U6743 ( .A1(n4326), .A2(\cpuregs[27][2] ), .A3(n4369), .A4(
        \cpuregs[5][2] ), .Y(n5569) );
  AO22X1_RVT U6744 ( .A1(n4330), .A2(\cpuregs[22][2] ), .A3(n4435), .A4(
        \cpuregs[10][2] ), .Y(n5568) );
  AO22X1_RVT U6745 ( .A1(n4365), .A2(\cpuregs[8][2] ), .A3(n4417), .A4(
        \cpuregs[28][2] ), .Y(n5567) );
  NOR4X1_RVT U6746 ( .A1(n5570), .A2(n5569), .A3(n5568), .A4(n5567), .Y(n5571)
         );
  NAND3X0_RVT U6747 ( .A1(n5573), .A2(n5572), .A3(n5571), .Y(n5574) );
  AO222X1_RVT U6748 ( .A1(n4060), .A2(n5576), .A3(n4062), .A4(n5575), .A5(
        n5208), .A6(n5574), .Y(n5577) );
  OA21X1_RVT U6749 ( .A1(n5578), .A2(n5577), .A3(n4057), .Y(n5579) );
  AO21X1_RVT U6750 ( .A1(n4054), .A2(net30713), .A3(n5579), .Y(n3738) );
  OR2X1_RVT U6751 ( .A1(net25813), .A2(n5580), .Y(n5581) );
  AO22X1_RVT U6752 ( .A1(n4407), .A2(\cpuregs[29][3] ), .A3(n4420), .A4(
        \cpuregs[30][3] ), .Y(n5583) );
  AO22X1_RVT U6753 ( .A1(n4327), .A2(\cpuregs[27][3] ), .A3(n4350), .A4(
        \cpuregs[9][3] ), .Y(n5582) );
  OR2X1_RVT U6754 ( .A1(n5583), .A2(n5582), .Y(n5584) );
  AO21X1_RVT U6755 ( .A1(n4425), .A2(\cpuregs[17][3] ), .A3(n5584), .Y(n5602)
         );
  AO22X1_RVT U6756 ( .A1(n4272), .A2(\cpuregs[15][3] ), .A3(n4366), .A4(
        \cpuregs[8][3] ), .Y(n5601) );
  AO22X1_RVT U6757 ( .A1(n4427), .A2(\cpuregs[3][3] ), .A3(n4424), .A4(
        \cpuregs[7][3] ), .Y(n5588) );
  AO22X1_RVT U6758 ( .A1(n4388), .A2(\cpuregs[23][3] ), .A3(n4393), .A4(
        \cpuregs[31][3] ), .Y(n5587) );
  AO22X1_RVT U6759 ( .A1(n4337), .A2(\cpuregs[19][3] ), .A3(n4390), .A4(
        \cpuregs[2][3] ), .Y(n5586) );
  AO22X1_RVT U6760 ( .A1(n4374), .A2(\cpuregs[1][3] ), .A3(n4433), .A4(
        \cpuregs[13][3] ), .Y(n5585) );
  NOR4X1_RVT U6761 ( .A1(n5588), .A2(n5587), .A3(n5586), .A4(n5585), .Y(n5599)
         );
  AO22X1_RVT U6762 ( .A1(n4330), .A2(\cpuregs[22][3] ), .A3(n4487), .A4(
        \cpuregs[24][3] ), .Y(n5591) );
  AO22X1_RVT U6763 ( .A1(n4334), .A2(\cpuregs[25][3] ), .A3(n4362), .A4(
        \cpuregs[11][3] ), .Y(n5590) );
  AO22X1_RVT U6764 ( .A1(n4344), .A2(\cpuregs[6][3] ), .A3(n4450), .A4(
        \cpuregs[21][3] ), .Y(n5589) );
  NOR4X1_RVT U6765 ( .A1(n5592), .A2(n5591), .A3(n5590), .A4(n5589), .Y(n5598)
         );
  AO22X1_RVT U6766 ( .A1(n4360), .A2(\cpuregs[18][3] ), .A3(n4442), .A4(
        \cpuregs[4][3] ), .Y(n5596) );
  AO22X1_RVT U6767 ( .A1(n4412), .A2(\cpuregs[26][3] ), .A3(n4410), .A4(
        \cpuregs[12][3] ), .Y(n5595) );
  AO22X1_RVT U6768 ( .A1(n4436), .A2(\cpuregs[10][3] ), .A3(n4416), .A4(
        \cpuregs[28][3] ), .Y(n5594) );
  AO22X1_RVT U6769 ( .A1(n4348), .A2(\cpuregs[20][3] ), .A3(n4403), .A4(
        \cpuregs[14][3] ), .Y(n5593) );
  NOR4X1_RVT U6770 ( .A1(n5596), .A2(n5595), .A3(n5594), .A4(n5593), .Y(n5597)
         );
  NAND3X0_RVT U6771 ( .A1(n5599), .A2(n5598), .A3(n5597), .Y(n5600) );
  AO222X1_RVT U6772 ( .A1(n4063), .A2(n5602), .A3(n4063), .A4(n5601), .A5(
        n4058), .A6(n5600), .Y(n5603) );
  OA21X1_RVT U6773 ( .A1(n5604), .A2(n5603), .A3(net29471), .Y(n5605) );
  AO21X1_RVT U6774 ( .A1(n4055), .A2(net30659), .A3(n5605), .Y(n3737) );
  AO22X1_RVT U6775 ( .A1(n8092), .A2(net30608), .A3(n8094), .A4(net30625), .Y(
        n5606) );
  OR2X1_RVT U6776 ( .A1(net25784), .A2(n5606), .Y(n5607) );
  AO21X1_RVT U6777 ( .A1(reg_pc[1]), .A2(net30309), .A3(n5607), .Y(n5630) );
  AO22X1_RVT U6778 ( .A1(\cpuregs[9][1] ), .A2(n4350), .A3(\cpuregs[19][1] ), 
        .A4(n4338), .Y(n5609) );
  AO22X1_RVT U6779 ( .A1(\cpuregs[25][1] ), .A2(n4335), .A3(\cpuregs[20][1] ), 
        .A4(n4347), .Y(n5608) );
  OR2X1_RVT U6780 ( .A1(n5609), .A2(n5608), .Y(n5610) );
  AO21X1_RVT U6781 ( .A1(\cpuregs[27][1] ), .A2(n4327), .A3(n5610), .Y(n5628)
         );
  AO22X1_RVT U6782 ( .A1(\cpuregs[15][1] ), .A2(n4273), .A3(\cpuregs[22][1] ), 
        .A4(n4330), .Y(n5627) );
  AO22X1_RVT U6783 ( .A1(\cpuregs[6][1] ), .A2(n4345), .A3(\cpuregs[8][1] ), 
        .A4(n4365), .Y(n5614) );
  AO22X1_RVT U6784 ( .A1(\cpuregs[5][1] ), .A2(n4368), .A3(\cpuregs[2][1] ), 
        .A4(n4391), .Y(n5613) );
  AO22X1_RVT U6785 ( .A1(\cpuregs[18][1] ), .A2(n4360), .A3(\cpuregs[23][1] ), 
        .A4(n4387), .Y(n5612) );
  AO22X1_RVT U6786 ( .A1(\cpuregs[29][1] ), .A2(n4406), .A3(\cpuregs[16][1] ), 
        .A4(n4383), .Y(n5611) );
  NOR4X1_RVT U6787 ( .A1(n5614), .A2(n5613), .A3(n5612), .A4(n5611), .Y(n5625)
         );
  AO22X1_RVT U6788 ( .A1(\cpuregs[1][1] ), .A2(n4374), .A3(\cpuregs[11][1] ), 
        .A4(n4362), .Y(n5618) );
  AO22X1_RVT U6789 ( .A1(\cpuregs[26][1] ), .A2(n4413), .A3(\cpuregs[31][1] ), 
        .A4(n4394), .Y(n5617) );
  AO22X1_RVT U6790 ( .A1(\cpuregs[3][1] ), .A2(n4428), .A3(\cpuregs[14][1] ), 
        .A4(n4404), .Y(n5616) );
  AO22X1_RVT U6791 ( .A1(\cpuregs[30][1] ), .A2(n4421), .A3(\cpuregs[13][1] ), 
        .A4(n4432), .Y(n5615) );
  NOR4X1_RVT U6792 ( .A1(n5618), .A2(n5617), .A3(n5616), .A4(n5615), .Y(n5624)
         );
  AO22X1_RVT U6793 ( .A1(\cpuregs[7][1] ), .A2(n4423), .A3(\cpuregs[10][1] ), 
        .A4(n4436), .Y(n5622) );
  AO22X1_RVT U6794 ( .A1(\cpuregs[17][1] ), .A2(n4425), .A3(\cpuregs[12][1] ), 
        .A4(n4409), .Y(n5621) );
  AO22X1_RVT U6795 ( .A1(\cpuregs[28][1] ), .A2(n4417), .A3(\cpuregs[21][1] ), 
        .A4(n4451), .Y(n5620) );
  AO22X1_RVT U6796 ( .A1(\cpuregs[4][1] ), .A2(n4441), .A3(\cpuregs[24][1] ), 
        .A4(n4487), .Y(n5619) );
  NOR4X1_RVT U6797 ( .A1(n5622), .A2(n5621), .A3(n5620), .A4(n5619), .Y(n5623)
         );
  NAND3X0_RVT U6798 ( .A1(n5625), .A2(n5624), .A3(n5623), .Y(n5626) );
  AO222X1_RVT U6799 ( .A1(n5208), .A2(n5628), .A3(n4062), .A4(n5627), .A5(
        n4060), .A6(n5626), .Y(n5629) );
  OA21X1_RVT U6800 ( .A1(n5630), .A2(n5629), .A3(n4056), .Y(n5631) );
  AO21X1_RVT U6801 ( .A1(n4054), .A2(net30596), .A3(n5631), .Y(n3739) );
  AND2X1_RVT U6802 ( .A1(n4374), .A2(\cpuregs[1][18] ), .Y(n5635) );
  AO22X1_RVT U6803 ( .A1(n4362), .A2(\cpuregs[11][18] ), .A3(n4428), .A4(
        \cpuregs[3][18] ), .Y(n5634) );
  AO22X1_RVT U6804 ( .A1(n4272), .A2(\cpuregs[15][18] ), .A3(n4435), .A4(
        \cpuregs[10][18] ), .Y(n5633) );
  AO22X1_RVT U6805 ( .A1(n4368), .A2(\cpuregs[5][18] ), .A3(n4441), .A4(
        \cpuregs[4][18] ), .Y(n5632) );
  NOR4X1_RVT U6806 ( .A1(n5635), .A2(n5634), .A3(n5633), .A4(n5632), .Y(n5651)
         );
  AO22X1_RVT U6807 ( .A1(n4338), .A2(\cpuregs[19][18] ), .A3(n4407), .A4(
        \cpuregs[29][18] ), .Y(n5639) );
  AO22X1_RVT U6808 ( .A1(n4422), .A2(\cpuregs[7][18] ), .A3(n4425), .A4(
        \cpuregs[17][18] ), .Y(n5638) );
  AO22X1_RVT U6809 ( .A1(n4387), .A2(\cpuregs[23][18] ), .A3(n4487), .A4(
        \cpuregs[24][18] ), .Y(n5637) );
  AO22X1_RVT U6810 ( .A1(n4366), .A2(\cpuregs[8][18] ), .A3(n4410), .A4(
        \cpuregs[12][18] ), .Y(n5636) );
  NOR4X1_RVT U6811 ( .A1(n5639), .A2(n5638), .A3(n5637), .A4(n5636), .Y(n5650)
         );
  AO22X1_RVT U6812 ( .A1(n4330), .A2(\cpuregs[22][18] ), .A3(n4360), .A4(
        \cpuregs[18][18] ), .Y(n5643) );
  AO22X1_RVT U6813 ( .A1(n4431), .A2(\cpuregs[13][18] ), .A3(n4451), .A4(
        \cpuregs[21][18] ), .Y(n5642) );
  AO22X1_RVT U6814 ( .A1(n4384), .A2(\cpuregs[16][18] ), .A3(n4417), .A4(
        \cpuregs[28][18] ), .Y(n5641) );
  AO22X1_RVT U6815 ( .A1(n4348), .A2(\cpuregs[20][18] ), .A3(n4390), .A4(
        \cpuregs[2][18] ), .Y(n5640) );
  NOR4X1_RVT U6816 ( .A1(n5643), .A2(n5642), .A3(n5641), .A4(n5640), .Y(n5649)
         );
  AO22X1_RVT U6817 ( .A1(n6645), .A2(\cpuregs[27][18] ), .A3(n4345), .A4(
        \cpuregs[6][18] ), .Y(n5647) );
  AO22X1_RVT U6818 ( .A1(n4392), .A2(\cpuregs[31][18] ), .A3(n4404), .A4(
        \cpuregs[14][18] ), .Y(n5646) );
  AO22X1_RVT U6819 ( .A1(n4350), .A2(\cpuregs[9][18] ), .A3(n4420), .A4(
        \cpuregs[30][18] ), .Y(n5645) );
  AO22X1_RVT U6820 ( .A1(n4334), .A2(\cpuregs[25][18] ), .A3(n4412), .A4(
        \cpuregs[26][18] ), .Y(n5644) );
  NOR4X1_RVT U6821 ( .A1(n5647), .A2(n5646), .A3(n5645), .A4(n5644), .Y(n5648)
         );
  NAND4X0_RVT U6822 ( .A1(n5651), .A2(n5650), .A3(n5649), .A4(n5648), .Y(n5652) );
  AO22X1_RVT U6823 ( .A1(reg_pc[18]), .A2(net30309), .A3(n5208), .A4(n5652), 
        .Y(n5654) );
  AO21X1_RVT U6824 ( .A1(n5656), .A2(net29471), .A3(n5655), .Y(n3722) );
  AND2X1_RVT U6825 ( .A1(n4350), .A2(\cpuregs[9][16] ), .Y(n5660) );
  AO22X1_RVT U6826 ( .A1(n4326), .A2(\cpuregs[27][16] ), .A3(n4407), .A4(
        \cpuregs[29][16] ), .Y(n5659) );
  AO22X1_RVT U6827 ( .A1(n4347), .A2(\cpuregs[20][16] ), .A3(n4432), .A4(
        \cpuregs[13][16] ), .Y(n5658) );
  AO22X1_RVT U6828 ( .A1(n4338), .A2(\cpuregs[19][16] ), .A3(n4421), .A4(
        \cpuregs[30][16] ), .Y(n5657) );
  NOR4X1_RVT U6829 ( .A1(n5660), .A2(n5659), .A3(n5658), .A4(n5657), .Y(n5677)
         );
  AO22X1_RVT U6830 ( .A1(n4361), .A2(\cpuregs[11][16] ), .A3(n4441), .A4(
        \cpuregs[4][16] ), .Y(n5664) );
  AO22X1_RVT U6831 ( .A1(n4394), .A2(\cpuregs[31][16] ), .A3(n4435), .A4(
        \cpuregs[10][16] ), .Y(n5662) );
  AO22X1_RVT U6832 ( .A1(n4329), .A2(\cpuregs[22][16] ), .A3(n4384), .A4(
        \cpuregs[16][16] ), .Y(n5661) );
  NOR4X1_RVT U6833 ( .A1(n5664), .A2(n5663), .A3(n5662), .A4(n5661), .Y(n5676)
         );
  AO22X1_RVT U6834 ( .A1(n4386), .A2(\cpuregs[23][16] ), .A3(n4427), .A4(
        \cpuregs[3][16] ), .Y(n5669) );
  AO22X1_RVT U6835 ( .A1(n4272), .A2(\cpuregs[15][16] ), .A3(n4410), .A4(
        \cpuregs[12][16] ), .Y(n5668) );
  AO22X1_RVT U6836 ( .A1(n4369), .A2(\cpuregs[5][16] ), .A3(n4424), .A4(
        \cpuregs[7][16] ), .Y(n5667) );
  AO22X1_RVT U6837 ( .A1(n4425), .A2(\cpuregs[17][16] ), .A3(n4488), .A4(
        \cpuregs[24][16] ), .Y(n5666) );
  NOR4X1_RVT U6838 ( .A1(n5669), .A2(n5668), .A3(n5667), .A4(n5666), .Y(n5675)
         );
  AO22X1_RVT U6839 ( .A1(n6581), .A2(\cpuregs[6][16] ), .A3(n4412), .A4(
        \cpuregs[26][16] ), .Y(n5673) );
  AO22X1_RVT U6840 ( .A1(n4389), .A2(\cpuregs[2][16] ), .A3(n4359), .A4(
        \cpuregs[18][16] ), .Y(n5672) );
  AO22X1_RVT U6841 ( .A1(n4403), .A2(\cpuregs[14][16] ), .A3(n4417), .A4(
        \cpuregs[28][16] ), .Y(n5671) );
  AO22X1_RVT U6842 ( .A1(n4375), .A2(\cpuregs[1][16] ), .A3(n4450), .A4(
        \cpuregs[21][16] ), .Y(n5670) );
  NOR4X1_RVT U6843 ( .A1(n5673), .A2(n5672), .A3(n5671), .A4(n5670), .Y(n5674)
         );
  NAND4X0_RVT U6844 ( .A1(n5677), .A2(n5676), .A3(n5675), .A4(n5674), .Y(n5678) );
  AO22X1_RVT U6845 ( .A1(reg_pc[16]), .A2(net30310), .A3(n4062), .A4(n5678), 
        .Y(n5680) );
  AO21X1_RVT U6846 ( .A1(n5682), .A2(net29472), .A3(n5681), .Y(n3724) );
  HADDX1_RVT U6847 ( .A0(decoded_imm[25]), .B0(n5683), .SO(n5684) );
  AO22X1_RVT U6848 ( .A1(n4175), .A2(mem_rdata_word[25]), .A3(pcpi_rs1[25]), 
        .A4(n4535), .Y(n5685) );
  OR2X1_RVT U6849 ( .A1(n4263), .A2(n5685), .Y(n5686) );
  AO21X1_RVT U6850 ( .A1(count_instr[57]), .A2(n4311), .A3(n5686), .Y(n5687)
         );
  OR2X1_RVT U6851 ( .A1(n7797), .A2(n5689), .Y(n5690) );
  AO21X1_RVT U6852 ( .A1(count_cycle[25]), .A2(n4357), .A3(n5690), .Y(N1931)
         );
  AO22X1_RVT U6853 ( .A1(count_cycle[58]), .A2(n4258), .A3(count_instr[26]), 
        .A4(n4352), .Y(n5694) );
  FADDX1_RVT U6854 ( .A(reg_pc[26]), .B(decoded_imm[26]), .CI(n5691), .CO(
        n5699), .S(n5692) );
  AO22X1_RVT U6855 ( .A1(n4320), .A2(n5692), .A3(n4175), .A4(
        mem_rdata_word[26]), .Y(n5693) );
  OR2X1_RVT U6856 ( .A1(n5694), .A2(n5693), .Y(n5695) );
  AO21X1_RVT U6857 ( .A1(count_cycle[26]), .A2(n4356), .A3(n5695), .Y(n5696)
         );
  OR2X1_RVT U6858 ( .A1(n7797), .A2(n5696), .Y(n5697) );
  AO21X1_RVT U6859 ( .A1(pcpi_rs1[26]), .A2(n4031), .A3(n5697), .Y(n5698) );
  AO21X1_RVT U6860 ( .A1(count_instr[58]), .A2(n4310), .A3(n5698), .Y(N1932)
         );
  AO22X1_RVT U6861 ( .A1(count_cycle[27]), .A2(n4356), .A3(count_instr[27]), 
        .A4(n5718), .Y(n5702) );
  FADDX1_RVT U6862 ( .A(reg_pc[27]), .B(decoded_imm[27]), .CI(n5699), .CO(
        n5707), .S(n5700) );
  AO22X1_RVT U6863 ( .A1(n4320), .A2(n5700), .A3(n4175), .A4(
        mem_rdata_word[27]), .Y(n5701) );
  OR2X1_RVT U6864 ( .A1(n5702), .A2(n5701), .Y(n5703) );
  OR2X1_RVT U6865 ( .A1(n7797), .A2(n5704), .Y(n5705) );
  AO21X1_RVT U6866 ( .A1(pcpi_rs1[27]), .A2(n4633), .A3(n5705), .Y(n5706) );
  AO21X1_RVT U6867 ( .A1(count_instr[59]), .A2(n4311), .A3(n5706), .Y(N1933)
         );
  NAND2X0_RVT U6868 ( .A1(decoded_imm[28]), .A2(n5707), .Y(n5708) );
  NAND2X0_RVT U6869 ( .A1(n5709), .A2(n5708), .Y(n5710) );
  HADDX1_RVT U6870 ( .A0(reg_pc[28]), .B0(n5710), .SO(n5711) );
  OA22X1_RVT U6871 ( .A1(n4020), .A2(n5711), .A3(n4241), .A4(net16345), .Y(
        n5714) );
  NAND2X0_RVT U6872 ( .A1(count_instr[28]), .A2(n5718), .Y(n5713) );
  NAND2X0_RVT U6873 ( .A1(n6573), .A2(mem_rdata_word[28]), .Y(n5712) );
  NAND4X0_RVT U6874 ( .A1(n6817), .A2(n5714), .A3(n5713), .A4(n5712), .Y(n5715) );
  OR2X1_RVT U6875 ( .A1(n5716), .A2(n5715), .Y(n5717) );
  AO21X1_RVT U6876 ( .A1(count_instr[60]), .A2(n7788), .A3(n5717), .Y(N1934)
         );
  NOR4X1_RVT U6877 ( .A1(mem_rdata_q[25]), .A2(mem_rdata_q[26]), .A3(
        mem_rdata_q[28]), .A4(mem_rdata_q[29]), .Y(n6028) );
  AND3X1_RVT U6878 ( .A1(n6028), .A2(n8046), .A3(n8000), .Y(n6095) );
  NAND2X0_RVT U6879 ( .A1(mem_rdata_q[12]), .A2(n7999), .Y(n7942) );
  OA21X1_RVT U6880 ( .A1(mem_rdata_q[14]), .A2(n8044), .A3(n6142), .Y(n6096)
         );
  AND3X1_RVT U6881 ( .A1(is_alu_reg_imm), .A2(n6095), .A3(n6096), .Y(n5997) );
  AO21X1_RVT U6882 ( .A1(is_slli_srli_srai), .A2(net30497), .A3(n5997), .Y(
        n3630) );
  AO22X1_RVT U6883 ( .A1(count_cycle[39]), .A2(n4259), .A3(count_instr[7]), 
        .A4(n5718), .Y(n5719) );
  OR2X1_RVT U6884 ( .A1(n5720), .A2(n5719), .Y(n5721) );
  OR2X1_RVT U6885 ( .A1(n5724), .A2(n5723), .Y(n5725) );
  AO21X1_RVT U6886 ( .A1(count_instr[39]), .A2(n4311), .A3(n5725), .Y(N1913)
         );
  NAND2X0_RVT U6887 ( .A1(decoded_imm[15]), .A2(n5726), .Y(n5728) );
  NAND2X0_RVT U6888 ( .A1(n5728), .A2(n5727), .Y(n5729) );
  HADDX1_RVT U6889 ( .A0(reg_pc[15]), .B0(n5729), .SO(n5730) );
  NAND2X0_RVT U6890 ( .A1(count_instr[15]), .A2(n4352), .Y(n5732) );
  NAND2X0_RVT U6891 ( .A1(mem_rdata_word[15]), .A2(n6573), .Y(n5731) );
  NAND4X0_RVT U6892 ( .A1(n6817), .A2(n5733), .A3(n5732), .A4(n5731), .Y(n5734) );
  OR2X1_RVT U6893 ( .A1(n5735), .A2(n5734), .Y(n5736) );
  AO21X1_RVT U6894 ( .A1(count_instr[47]), .A2(n4310), .A3(n5736), .Y(N1921)
         );
  AND2X1_RVT U6895 ( .A1(n4407), .A2(\cpuregs[29][0] ), .Y(n5740) );
  AO22X1_RVT U6896 ( .A1(n4272), .A2(\cpuregs[15][0] ), .A3(n4409), .A4(
        \cpuregs[12][0] ), .Y(n5739) );
  AO22X1_RVT U6897 ( .A1(n4348), .A2(\cpuregs[20][0] ), .A3(n4393), .A4(
        \cpuregs[31][0] ), .Y(n5738) );
  AO22X1_RVT U6898 ( .A1(n4329), .A2(\cpuregs[22][0] ), .A3(n4335), .A4(
        \cpuregs[25][0] ), .Y(n5737) );
  NOR4X1_RVT U6899 ( .A1(n5740), .A2(n5739), .A3(n5738), .A4(n5737), .Y(n5758)
         );
  AO22X1_RVT U6900 ( .A1(n4391), .A2(\cpuregs[2][0] ), .A3(n4425), .A4(
        \cpuregs[17][0] ), .Y(n5744) );
  AO22X1_RVT U6901 ( .A1(n4363), .A2(\cpuregs[11][0] ), .A3(n4427), .A4(
        \cpuregs[3][0] ), .Y(n5743) );
  AO22X1_RVT U6902 ( .A1(n4375), .A2(\cpuregs[1][0] ), .A3(n4413), .A4(
        \cpuregs[26][0] ), .Y(n5742) );
  AO22X1_RVT U6903 ( .A1(n4338), .A2(\cpuregs[19][0] ), .A3(n4369), .A4(
        \cpuregs[5][0] ), .Y(n5741) );
  NOR4X1_RVT U6904 ( .A1(n5744), .A2(n5743), .A3(n5742), .A4(n5741), .Y(n5757)
         );
  AO22X1_RVT U6905 ( .A1(n4344), .A2(\cpuregs[6][0] ), .A3(n4435), .A4(
        \cpuregs[10][0] ), .Y(n5749) );
  AO22X1_RVT U6906 ( .A1(n4421), .A2(\cpuregs[30][0] ), .A3(n4424), .A4(
        \cpuregs[7][0] ), .Y(n5748) );
  AO22X1_RVT U6907 ( .A1(n4366), .A2(\cpuregs[8][0] ), .A3(n4359), .A4(
        \cpuregs[18][0] ), .Y(n5747) );
  AO22X1_RVT U6908 ( .A1(n4383), .A2(\cpuregs[16][0] ), .A3(n4441), .A4(
        \cpuregs[4][0] ), .Y(n5746) );
  NOR4X1_RVT U6909 ( .A1(n5749), .A2(n5748), .A3(n5747), .A4(n5746), .Y(n5756)
         );
  AO22X1_RVT U6910 ( .A1(n4404), .A2(\cpuregs[14][0] ), .A3(n4450), .A4(
        \cpuregs[21][0] ), .Y(n5754) );
  AO22X1_RVT U6911 ( .A1(n4417), .A2(\cpuregs[28][0] ), .A3(n4488), .A4(
        \cpuregs[24][0] ), .Y(n5753) );
  AO22X1_RVT U6912 ( .A1(n4327), .A2(\cpuregs[27][0] ), .A3(n4387), .A4(
        \cpuregs[23][0] ), .Y(n5752) );
  AO22X1_RVT U6913 ( .A1(n4350), .A2(\cpuregs[9][0] ), .A3(n4433), .A4(
        \cpuregs[13][0] ), .Y(n5751) );
  NOR4X1_RVT U6914 ( .A1(n5754), .A2(n5753), .A3(n5752), .A4(n5751), .Y(n5755)
         );
  NAND4X0_RVT U6915 ( .A1(n5758), .A2(n5757), .A3(n5756), .A4(n5755), .Y(n5759) );
  AND2X1_RVT U6916 ( .A1(n4061), .A2(n5759), .Y(n5760) );
  OA21X1_RVT U6917 ( .A1(n5761), .A2(n5760), .A3(n4056), .Y(n5762) );
  AO21X1_RVT U6918 ( .A1(n4054), .A2(pcpi_rs1[0]), .A3(n5762), .Y(n3740) );
  AND2X1_RVT U6919 ( .A1(n4388), .A2(\cpuregs[23][14] ), .Y(n5766) );
  AO22X1_RVT U6920 ( .A1(n4382), .A2(\cpuregs[16][14] ), .A3(n4435), .A4(
        \cpuregs[10][14] ), .Y(n5765) );
  AO22X1_RVT U6921 ( .A1(n4440), .A2(\cpuregs[4][14] ), .A3(n4487), .A4(
        \cpuregs[24][14] ), .Y(n5764) );
  AO22X1_RVT U6922 ( .A1(n4273), .A2(\cpuregs[15][14] ), .A3(n4407), .A4(
        \cpuregs[29][14] ), .Y(n5763) );
  NOR4X1_RVT U6923 ( .A1(n5766), .A2(n5765), .A3(n5764), .A4(n5763), .Y(n5782)
         );
  AO22X1_RVT U6924 ( .A1(n4336), .A2(\cpuregs[19][14] ), .A3(n4334), .A4(
        \cpuregs[25][14] ), .Y(n5770) );
  AO22X1_RVT U6925 ( .A1(n4346), .A2(\cpuregs[20][14] ), .A3(n4431), .A4(
        \cpuregs[13][14] ), .Y(n5769) );
  AO22X1_RVT U6926 ( .A1(n4350), .A2(\cpuregs[9][14] ), .A3(n4374), .A4(
        \cpuregs[1][14] ), .Y(n5768) );
  AO22X1_RVT U6927 ( .A1(n4363), .A2(\cpuregs[11][14] ), .A3(n4410), .A4(
        \cpuregs[12][14] ), .Y(n5767) );
  NOR4X1_RVT U6928 ( .A1(n5770), .A2(n5769), .A3(n5768), .A4(n5767), .Y(n5781)
         );
  AO22X1_RVT U6929 ( .A1(n4392), .A2(\cpuregs[31][14] ), .A3(n4449), .A4(
        \cpuregs[21][14] ), .Y(n5774) );
  AO22X1_RVT U6930 ( .A1(n6592), .A2(\cpuregs[3][14] ), .A3(n4424), .A4(
        \cpuregs[7][14] ), .Y(n5773) );
  AO22X1_RVT U6931 ( .A1(n4411), .A2(\cpuregs[26][14] ), .A3(n4404), .A4(
        \cpuregs[14][14] ), .Y(n5772) );
  AO22X1_RVT U6932 ( .A1(n4345), .A2(\cpuregs[6][14] ), .A3(n4369), .A4(
        \cpuregs[5][14] ), .Y(n5771) );
  NOR4X1_RVT U6933 ( .A1(n5774), .A2(n5773), .A3(n5772), .A4(n5771), .Y(n5780)
         );
  AO22X1_RVT U6934 ( .A1(n4419), .A2(\cpuregs[30][14] ), .A3(n4415), .A4(
        \cpuregs[28][14] ), .Y(n5778) );
  AO22X1_RVT U6935 ( .A1(n4358), .A2(\cpuregs[18][14] ), .A3(n6761), .A4(
        \cpuregs[17][14] ), .Y(n5777) );
  AO22X1_RVT U6936 ( .A1(n6645), .A2(\cpuregs[27][14] ), .A3(n4391), .A4(
        \cpuregs[2][14] ), .Y(n5776) );
  AO22X1_RVT U6937 ( .A1(n4329), .A2(\cpuregs[22][14] ), .A3(n4366), .A4(
        \cpuregs[8][14] ), .Y(n5775) );
  NOR4X1_RVT U6938 ( .A1(n5778), .A2(n5777), .A3(n5776), .A4(n5775), .Y(n5779)
         );
  NAND4X0_RVT U6939 ( .A1(n5782), .A2(n5781), .A3(n5780), .A4(n5779), .Y(n5783) );
  AO22X1_RVT U6940 ( .A1(n4062), .A2(n5783), .A3(net30309), .A4(reg_pc[14]), 
        .Y(n5785) );
  AO21X1_RVT U6941 ( .A1(n5787), .A2(n4056), .A3(n5786), .Y(n3726) );
  AO21X1_RVT U6942 ( .A1(net16449), .A2(n7971), .A3(n8070), .Y(n5790) );
  NAND2X0_RVT U6943 ( .A1(net30596), .A2(n7812), .Y(n7809) );
  AND2X1_RVT U6944 ( .A1(n5790), .A2(n7809), .Y(n3959) );
  AND4X1_RVT U6945 ( .A1(pcpi_rs1[0]), .A2(mem_wordsize[1]), .A3(net16466), 
        .A4(n7971), .Y(n5806) );
  AO22X1_RVT U6946 ( .A1(mem_rdata[7]), .A2(n3959), .A3(mem_rdata[15]), .A4(
        n5806), .Y(n5789) );
  AND3X1_RVT U6947 ( .A1(net30596), .A2(n5790), .A3(n7812), .Y(n5805) );
  AND4X1_RVT U6948 ( .A1(pcpi_rs1[0]), .A2(net30596), .A3(mem_wordsize[1]), 
        .A4(n7971), .Y(n5807) );
  AO22X1_RVT U6949 ( .A1(mem_rdata[23]), .A2(n5805), .A3(mem_rdata[31]), .A4(
        n5807), .Y(n5788) );
  OR2X1_RVT U6950 ( .A1(n5789), .A2(n5788), .Y(n3970) );
  AND2X1_RVT U6951 ( .A1(mem_rdata[18]), .A2(n7813), .Y(N218) );
  AND2X1_RVT U6952 ( .A1(mem_rdata[19]), .A2(n7813), .Y(N219) );
  NAND2X0_RVT U6953 ( .A1(net16466), .A2(n7812), .Y(n7808) );
  AND2X1_RVT U6954 ( .A1(n5790), .A2(n7808), .Y(n3961) );
  NAND2X0_RVT U6955 ( .A1(mem_wordsize[0]), .A2(n8070), .Y(n5792) );
  NAND2X0_RVT U6956 ( .A1(n5792), .A2(n5791), .Y(n7811) );
  AO22X1_RVT U6957 ( .A1(pcpi_rs2[23]), .A2(n7813), .A3(pcpi_rs2[7]), .A4(
        n7811), .Y(n3943) );
  AO22X1_RVT U6958 ( .A1(pcpi_rs2[22]), .A2(n7813), .A3(pcpi_rs2[6]), .A4(
        n7811), .Y(n3944) );
  AO22X1_RVT U6959 ( .A1(mem_rdata[1]), .A2(n3959), .A3(mem_rdata[9]), .A4(
        n5806), .Y(n5794) );
  AO22X1_RVT U6960 ( .A1(mem_rdata[25]), .A2(n5807), .A3(mem_rdata[17]), .A4(
        n5805), .Y(n5793) );
  OR2X1_RVT U6961 ( .A1(n5794), .A2(n5793), .Y(n3964) );
  AO22X1_RVT U6962 ( .A1(mem_rdata[3]), .A2(n3959), .A3(mem_rdata[11]), .A4(
        n5806), .Y(n5796) );
  AO22X1_RVT U6963 ( .A1(mem_rdata[27]), .A2(n5807), .A3(mem_rdata[19]), .A4(
        n5805), .Y(n5795) );
  OR2X1_RVT U6964 ( .A1(n5796), .A2(n5795), .Y(n3966) );
  AND2X1_RVT U6965 ( .A1(mem_rdata[16]), .A2(n7813), .Y(N216) );
  AO22X1_RVT U6966 ( .A1(mem_rdata[5]), .A2(n3959), .A3(mem_rdata[13]), .A4(
        n5806), .Y(n5798) );
  AO22X1_RVT U6967 ( .A1(mem_rdata[21]), .A2(n5805), .A3(mem_rdata[29]), .A4(
        n5807), .Y(n5797) );
  OR2X1_RVT U6968 ( .A1(n5798), .A2(n5797), .Y(n3968) );
  AND2X1_RVT U6969 ( .A1(mem_rdata[17]), .A2(n7813), .Y(N217) );
  AO22X1_RVT U6970 ( .A1(pcpi_rs2[16]), .A2(n7813), .A3(pcpi_rs2[0]), .A4(
        n7811), .Y(n3950) );
  AND2X1_RVT U6971 ( .A1(mem_rdata[26]), .A2(n7813), .Y(N226) );
  AND2X1_RVT U6972 ( .A1(mem_rdata[23]), .A2(n7813), .Y(N223) );
  AND2X1_RVT U6973 ( .A1(mem_rdata[31]), .A2(n7813), .Y(N231) );
  AND2X1_RVT U6974 ( .A1(mem_rdata[30]), .A2(n7813), .Y(N230) );
  AO22X1_RVT U6975 ( .A1(mem_rdata[8]), .A2(n5806), .A3(mem_rdata[16]), .A4(
        n5805), .Y(n5800) );
  AO22X1_RVT U6976 ( .A1(mem_rdata[0]), .A2(n3959), .A3(mem_rdata[24]), .A4(
        n5807), .Y(n5799) );
  OR2X1_RVT U6977 ( .A1(n5800), .A2(n5799), .Y(n3963) );
  AND2X1_RVT U6978 ( .A1(mem_rdata[20]), .A2(n7813), .Y(N220) );
  AND2X1_RVT U6979 ( .A1(mem_rdata[25]), .A2(n7813), .Y(N225) );
  AND2X1_RVT U6980 ( .A1(mem_rdata[27]), .A2(n7813), .Y(N227) );
  AND2X1_RVT U6981 ( .A1(mem_rdata[21]), .A2(n7813), .Y(N221) );
  AO22X1_RVT U6982 ( .A1(mem_rdata[6]), .A2(n3959), .A3(mem_rdata[22]), .A4(
        n5805), .Y(n5802) );
  AO22X1_RVT U6983 ( .A1(mem_rdata[14]), .A2(n5806), .A3(mem_rdata[30]), .A4(
        n5807), .Y(n5801) );
  OR2X1_RVT U6984 ( .A1(n5802), .A2(n5801), .Y(n3969) );
  AND2X1_RVT U6985 ( .A1(mem_rdata[24]), .A2(n7813), .Y(N224) );
  AND2X1_RVT U6986 ( .A1(mem_rdata[22]), .A2(n7813), .Y(N222) );
  AO22X1_RVT U6987 ( .A1(mem_rdata[2]), .A2(n3959), .A3(mem_rdata[18]), .A4(
        n5805), .Y(n5804) );
  AO22X1_RVT U6988 ( .A1(mem_rdata[10]), .A2(n5806), .A3(mem_rdata[26]), .A4(
        n5807), .Y(n5803) );
  OR2X1_RVT U6989 ( .A1(n5804), .A2(n5803), .Y(n3965) );
  AND2X1_RVT U6990 ( .A1(mem_rdata[29]), .A2(n7813), .Y(N229) );
  AND2X1_RVT U6991 ( .A1(mem_rdata[28]), .A2(n7813), .Y(N228) );
  AO22X1_RVT U6992 ( .A1(mem_rdata[12]), .A2(n5806), .A3(mem_rdata[20]), .A4(
        n5805), .Y(n5809) );
  AO22X1_RVT U6993 ( .A1(mem_rdata[4]), .A2(n3959), .A3(mem_rdata[28]), .A4(
        n5807), .Y(n5808) );
  OR2X1_RVT U6994 ( .A1(n5809), .A2(n5808), .Y(n3967) );
  AND2X1_RVT U6995 ( .A1(n4322), .A2(n8008), .Y(n7945) );
  NOR3X0_RVT U6996 ( .A1(n7945), .A2(n6207), .A3(net29419), .Y(mem_la_read) );
  NOR3X0_RVT U6997 ( .A1(net29419), .A2(n7977), .A3(n6207), .Y(mem_la_write)
         );
  NAND2X0_RVT U6998 ( .A1(count_cycle[1]), .A2(count_cycle[0]), .Y(n5813) );
  AND2X1_RVT U6999 ( .A1(n5813), .A2(resetn), .Y(n5810) );
  AND2X1_RVT U7000 ( .A1(resetn), .A2(n5817), .Y(n5811) );
  OA21X1_RVT U7001 ( .A1(count_cycle[3]), .A2(n5812), .A3(n5811), .Y(N921) );
  AND2X1_RVT U7002 ( .A1(n5814), .A2(resetn), .Y(n5815) );
  OA21X1_RVT U7003 ( .A1(count_cycle[2]), .A2(n5816), .A3(n5815), .Y(N920) );
  AND2X1_RVT U7004 ( .A1(n5818), .A2(count_cycle[4]), .Y(n5821) );
  AND2X1_RVT U7005 ( .A1(resetn), .A2(n5819), .Y(n5820) );
  OA21X1_RVT U7006 ( .A1(count_cycle[4]), .A2(n5818), .A3(n5820), .Y(N922) );
  AND2X1_RVT U7007 ( .A1(resetn), .A2(n5822), .Y(n5823) );
  OA21X1_RVT U7008 ( .A1(n5821), .A2(count_cycle[5]), .A3(n5823), .Y(N923) );
  AND2X1_RVT U7009 ( .A1(resetn), .A2(n5825), .Y(n5826) );
  AND2X1_RVT U7010 ( .A1(n5827), .A2(count_cycle[7]), .Y(n5830) );
  AND2X1_RVT U7011 ( .A1(resetn), .A2(n5828), .Y(n5829) );
  AND2X1_RVT U7012 ( .A1(resetn), .A2(n5831), .Y(n5832) );
  AND4X1_RVT U7013 ( .A1(count_instr[10]), .A2(count_instr[26]), .A3(
        count_instr[25]), .A4(count_instr[28]), .Y(n5834) );
  AND4X1_RVT U7014 ( .A1(count_instr[7]), .A2(count_instr[6]), .A3(
        count_instr[27]), .A4(n5834), .Y(n5839) );
  AND2X1_RVT U7015 ( .A1(count_instr[13]), .A2(count_instr[12]), .Y(n5964) );
  AND4X1_RVT U7016 ( .A1(count_instr[17]), .A2(count_instr[16]), .A3(
        count_instr[19]), .A4(count_instr[18]), .Y(n5835) );
  AND4X1_RVT U7017 ( .A1(n5964), .A2(count_instr[15]), .A3(count_instr[14]), 
        .A4(n5835), .Y(n5973) );
  NAND4X0_RVT U7018 ( .A1(n5973), .A2(count_instr[21]), .A3(count_instr[20]), 
        .A4(count_instr[22]), .Y(n5922) );
  AND4X1_RVT U7019 ( .A1(count_instr[1]), .A2(count_instr[0]), .A3(
        count_instr[2]), .A4(count_instr[3]), .Y(n7832) );
  NAND2X0_RVT U7020 ( .A1(n7832), .A2(count_instr[4]), .Y(n7833) );
  NAND4X0_RVT U7021 ( .A1(count_instr[32]), .A2(count_instr[31]), .A3(
        count_instr[9]), .A4(count_instr[8]), .Y(n5837) );
  NAND4X0_RVT U7022 ( .A1(count_instr[24]), .A2(count_instr[23]), .A3(
        count_instr[30]), .A4(count_instr[29]), .Y(n5836) );
  NOR4X1_RVT U7023 ( .A1(n5922), .A2(n7833), .A3(n5837), .A4(n5836), .Y(n5838)
         );
  NAND4X0_RVT U7024 ( .A1(count_instr[5]), .A2(count_instr[11]), .A3(n5839), 
        .A4(n5838), .Y(n7846) );
  NAND3X0_RVT U7025 ( .A1(count_instr[34]), .A2(count_instr[35]), .A3(
        count_instr[33]), .Y(n5840) );
  NAND2X0_RVT U7026 ( .A1(n5842), .A2(count_instr[36]), .Y(n5846) );
  AND2X1_RVT U7027 ( .A1(n5846), .A2(resetn), .Y(n5841) );
  AND2X1_RVT U7028 ( .A1(n5843), .A2(count_cycle[9]), .Y(n5849) );
  AND2X1_RVT U7029 ( .A1(resetn), .A2(n5844), .Y(n5845) );
  NAND2X0_RVT U7030 ( .A1(n5848), .A2(count_instr[37]), .Y(n5854) );
  AND2X1_RVT U7031 ( .A1(n5854), .A2(resetn), .Y(n5847) );
  AND2X1_RVT U7032 ( .A1(n5850), .A2(resetn), .Y(n5851) );
  NAND4X0_RVT U7033 ( .A1(n7888), .A2(n7832), .A3(count_instr[4]), .A4(
        count_instr[5]), .Y(n7836) );
  AND2X1_RVT U7034 ( .A1(n7836), .A2(resetn), .Y(n5852) );
  NAND2X0_RVT U7035 ( .A1(n5856), .A2(count_instr[38]), .Y(n5862) );
  AND2X1_RVT U7036 ( .A1(resetn), .A2(n5858), .Y(n5859) );
  AND2X1_RVT U7037 ( .A1(count_instr[6]), .A2(n7837), .Y(n5861) );
  NAND3X0_RVT U7038 ( .A1(count_instr[7]), .A2(count_instr[6]), .A3(n7837), 
        .Y(n5868) );
  AND2X1_RVT U7039 ( .A1(n5868), .A2(resetn), .Y(n5860) );
  NAND2X0_RVT U7040 ( .A1(n5864), .A2(count_instr[39]), .Y(n5871) );
  AND2X1_RVT U7041 ( .A1(resetn), .A2(n5866), .Y(n5867) );
  NAND2X0_RVT U7042 ( .A1(count_instr[8]), .A2(n5870), .Y(n5877) );
  AND2X1_RVT U7043 ( .A1(n5877), .A2(resetn), .Y(n5869) );
  NAND2X0_RVT U7044 ( .A1(n5873), .A2(count_instr[40]), .Y(n5880) );
  AND2X1_RVT U7045 ( .A1(n5880), .A2(resetn), .Y(n5872) );
  AND2X1_RVT U7046 ( .A1(resetn), .A2(n5875), .Y(n5876) );
  NAND2X0_RVT U7047 ( .A1(count_instr[9]), .A2(n5879), .Y(n5886) );
  AND2X1_RVT U7048 ( .A1(n5886), .A2(resetn), .Y(n5878) );
  NAND2X0_RVT U7049 ( .A1(n5882), .A2(count_instr[41]), .Y(n5889) );
  AND2X1_RVT U7050 ( .A1(n5889), .A2(resetn), .Y(n5881) );
  AND2X1_RVT U7051 ( .A1(n5883), .A2(count_cycle[14]), .Y(n5892) );
  AND2X1_RVT U7052 ( .A1(resetn), .A2(n5884), .Y(n5885) );
  NAND2X0_RVT U7053 ( .A1(count_instr[10]), .A2(n5888), .Y(n5901) );
  AND2X1_RVT U7054 ( .A1(n5901), .A2(resetn), .Y(n5887) );
  INVX1_RVT U7055 ( .A(n5889), .Y(n5891) );
  NAND2X0_RVT U7056 ( .A1(n5891), .A2(count_instr[42]), .Y(n5895) );
  AND2X1_RVT U7057 ( .A1(n5895), .A2(resetn), .Y(n5890) );
  AND2X1_RVT U7058 ( .A1(resetn), .A2(n5893), .Y(n5894) );
  INVX1_RVT U7059 ( .A(n5895), .Y(n5897) );
  NAND2X0_RVT U7060 ( .A1(n5897), .A2(count_instr[43]), .Y(n5904) );
  AND2X1_RVT U7061 ( .A1(n5904), .A2(resetn), .Y(n5896) );
  AND2X1_RVT U7062 ( .A1(resetn), .A2(n5899), .Y(n5900) );
  NAND2X0_RVT U7063 ( .A1(count_instr[11]), .A2(n5903), .Y(n7838) );
  AND2X1_RVT U7064 ( .A1(n7838), .A2(resetn), .Y(n5902) );
  INVX1_RVT U7065 ( .A(n5904), .Y(n5906) );
  NAND2X0_RVT U7066 ( .A1(n5906), .A2(count_instr[44]), .Y(n5910) );
  AND2X1_RVT U7067 ( .A1(n5910), .A2(resetn), .Y(n5905) );
  AND2X1_RVT U7068 ( .A1(n5907), .A2(count_cycle[17]), .Y(n5913) );
  AND2X1_RVT U7069 ( .A1(resetn), .A2(n5908), .Y(n5909) );
  INVX1_RVT U7070 ( .A(n5910), .Y(n5912) );
  NAND2X0_RVT U7071 ( .A1(n5912), .A2(count_instr[45]), .Y(n5916) );
  AND2X1_RVT U7072 ( .A1(n5916), .A2(resetn), .Y(n5911) );
  AND2X1_RVT U7073 ( .A1(resetn), .A2(n5914), .Y(n5915) );
  INVX1_RVT U7074 ( .A(n5916), .Y(n5918) );
  NAND2X0_RVT U7075 ( .A1(n5918), .A2(count_instr[46]), .Y(n5925) );
  AND2X1_RVT U7076 ( .A1(n5925), .A2(resetn), .Y(n5917) );
  AND2X1_RVT U7077 ( .A1(n5919), .A2(count_cycle[19]), .Y(n5928) );
  AND2X1_RVT U7078 ( .A1(resetn), .A2(n5920), .Y(n5921) );
  AND2X1_RVT U7079 ( .A1(count_instr[23]), .A2(n7845), .Y(n5924) );
  NAND3X0_RVT U7080 ( .A1(count_instr[24]), .A2(count_instr[23]), .A3(n7845), 
        .Y(n5931) );
  AND2X1_RVT U7081 ( .A1(n5931), .A2(resetn), .Y(n5923) );
  OA21X1_RVT U7082 ( .A1(n5924), .A2(count_instr[24]), .A3(n5923), .Y(n3869)
         );
  INVX1_RVT U7083 ( .A(n5925), .Y(n5927) );
  NAND2X0_RVT U7084 ( .A1(n5927), .A2(count_instr[47]), .Y(n5934) );
  AND2X1_RVT U7085 ( .A1(n5934), .A2(resetn), .Y(n5926) );
  AND2X1_RVT U7086 ( .A1(resetn), .A2(n5929), .Y(n5930) );
  NAND2X0_RVT U7087 ( .A1(count_instr[25]), .A2(n5933), .Y(n5940) );
  AND2X1_RVT U7088 ( .A1(n5940), .A2(resetn), .Y(n5932) );
  OA21X1_RVT U7089 ( .A1(n5933), .A2(count_instr[25]), .A3(n5932), .Y(n3868)
         );
  INVX1_RVT U7090 ( .A(n5934), .Y(n5936) );
  NAND2X0_RVT U7091 ( .A1(n5936), .A2(count_instr[48]), .Y(n5943) );
  AND2X1_RVT U7092 ( .A1(n5943), .A2(resetn), .Y(n5935) );
  AND2X1_RVT U7093 ( .A1(n5937), .A2(count_cycle[21]), .Y(n5949) );
  AND2X1_RVT U7094 ( .A1(n5938), .A2(resetn), .Y(n5939) );
  OA21X1_RVT U7095 ( .A1(count_cycle[21]), .A2(n5937), .A3(n5939), .Y(N939) );
  NAND2X0_RVT U7096 ( .A1(count_instr[26]), .A2(n5942), .Y(n5946) );
  AND2X1_RVT U7097 ( .A1(n5946), .A2(resetn), .Y(n5941) );
  OA21X1_RVT U7098 ( .A1(n5942), .A2(count_instr[26]), .A3(n5941), .Y(n3867)
         );
  INVX1_RVT U7099 ( .A(n5943), .Y(n5945) );
  NAND2X0_RVT U7100 ( .A1(n5945), .A2(count_instr[49]), .Y(n5957) );
  AND2X1_RVT U7101 ( .A1(n5957), .A2(resetn), .Y(n5944) );
  NAND2X0_RVT U7102 ( .A1(count_instr[27]), .A2(n5948), .Y(n5967) );
  AND2X1_RVT U7103 ( .A1(n5967), .A2(resetn), .Y(n5947) );
  OA21X1_RVT U7104 ( .A1(n5948), .A2(count_instr[27]), .A3(n5947), .Y(n3866)
         );
  INVX0_RVT U7105 ( .A(n5970), .Y(n5950) );
  AND2X1_RVT U7106 ( .A1(resetn), .A2(n5950), .Y(n5951) );
  AND4X1_RVT U7107 ( .A1(n5973), .A2(count_instr[21]), .A3(count_instr[20]), 
        .A4(n7839), .Y(n5953) );
  AND2X1_RVT U7108 ( .A1(n7844), .A2(resetn), .Y(n5952) );
  OA21X1_RVT U7109 ( .A1(n5953), .A2(count_instr[22]), .A3(n5952), .Y(n3871)
         );
  AND2X1_RVT U7110 ( .A1(count_instr[12]), .A2(n7839), .Y(n5956) );
  NAND2X0_RVT U7111 ( .A1(n5964), .A2(n7839), .Y(n5960) );
  AND2X1_RVT U7112 ( .A1(n5960), .A2(resetn), .Y(n5955) );
  OA21X1_RVT U7113 ( .A1(n5956), .A2(count_instr[13]), .A3(n5955), .Y(n3880)
         );
  INVX1_RVT U7114 ( .A(n5957), .Y(n5959) );
  NAND2X0_RVT U7115 ( .A1(n5959), .A2(count_instr[50]), .Y(n5976) );
  AND2X1_RVT U7116 ( .A1(n5976), .A2(resetn), .Y(n5958) );
  NAND3X0_RVT U7117 ( .A1(n5964), .A2(count_instr[14]), .A3(n7839), .Y(n5963)
         );
  AND2X1_RVT U7118 ( .A1(n5963), .A2(resetn), .Y(n5961) );
  OA21X1_RVT U7119 ( .A1(n5962), .A2(count_instr[14]), .A3(n5961), .Y(n3879)
         );
  NAND4X0_RVT U7120 ( .A1(n5964), .A2(count_instr[15]), .A3(count_instr[14]), 
        .A4(n7839), .Y(n5979) );
  AND2X1_RVT U7121 ( .A1(n5979), .A2(resetn), .Y(n5965) );
  OA21X1_RVT U7122 ( .A1(n5966), .A2(count_instr[15]), .A3(n5965), .Y(n3878)
         );
  NAND2X0_RVT U7123 ( .A1(count_instr[28]), .A2(n5969), .Y(n5982) );
  AND2X1_RVT U7124 ( .A1(n5982), .A2(resetn), .Y(n5968) );
  OA21X1_RVT U7125 ( .A1(n5969), .A2(count_instr[28]), .A3(n5968), .Y(n3865)
         );
  AND2X1_RVT U7126 ( .A1(resetn), .A2(n5971), .Y(n5972) );
  AND2X1_RVT U7127 ( .A1(mem_rdata_q[14]), .A2(n7999), .Y(n6188) );
  AND3X1_RVT U7128 ( .A1(is_lb_lh_lw_lbu_lhu), .A2(n4267), .A3(n6188), .Y(
        n6102) );
  AO22X1_RVT U7129 ( .A1(instr_lhu), .A2(net30494), .A3(mem_rdata_q[12]), .A4(
        n6102), .Y(n3679) );
  NAND2X0_RVT U7130 ( .A1(n5973), .A2(n7839), .Y(n6001) );
  NAND3X0_RVT U7131 ( .A1(n5973), .A2(count_instr[20]), .A3(n7839), .Y(n7842)
         );
  AND2X1_RVT U7132 ( .A1(n7842), .A2(resetn), .Y(n5974) );
  OA21X1_RVT U7133 ( .A1(n5975), .A2(count_instr[20]), .A3(n5974), .Y(n3873)
         );
  INVX1_RVT U7134 ( .A(n5976), .Y(n5978) );
  NAND2X0_RVT U7135 ( .A1(n5978), .A2(count_instr[51]), .Y(n5988) );
  AND2X1_RVT U7136 ( .A1(n5988), .A2(resetn), .Y(n5977) );
  NAND2X0_RVT U7137 ( .A1(count_instr[16]), .A2(n5981), .Y(n5998) );
  AND2X1_RVT U7138 ( .A1(n5998), .A2(resetn), .Y(n5980) );
  OA21X1_RVT U7139 ( .A1(n5981), .A2(count_instr[16]), .A3(n5980), .Y(n3877)
         );
  NAND2X0_RVT U7140 ( .A1(count_instr[29]), .A2(n5984), .Y(n5991) );
  AND2X1_RVT U7141 ( .A1(n5991), .A2(resetn), .Y(n5983) );
  OA21X1_RVT U7142 ( .A1(n5984), .A2(count_instr[29]), .A3(n5983), .Y(n3864)
         );
  AND2X1_RVT U7143 ( .A1(n5985), .A2(count_cycle[24]), .Y(n5994) );
  AND2X1_RVT U7144 ( .A1(resetn), .A2(n5986), .Y(n5987) );
  OA21X1_RVT U7145 ( .A1(count_cycle[24]), .A2(n5985), .A3(n5987), .Y(N942) );
  AND2X1_RVT U7146 ( .A1(n6142), .A2(n7970), .Y(n6107) );
  AO22X1_RVT U7147 ( .A1(is_lb_lh_lw_lbu_lhu), .A2(n6107), .A3(instr_lh), .A4(
        net30496), .Y(n3682) );
  INVX1_RVT U7148 ( .A(n5988), .Y(n5990) );
  NAND2X0_RVT U7149 ( .A1(n5990), .A2(count_instr[52]), .Y(n6004) );
  AND2X1_RVT U7150 ( .A1(n6004), .A2(resetn), .Y(n5989) );
  OA21X1_RVT U7151 ( .A1(count_instr[52]), .A2(n5990), .A3(n5989), .Y(n3841)
         );
  AND4X1_RVT U7152 ( .A1(mem_rdata_q[14]), .A2(is_alu_reg_imm), .A3(n6095), 
        .A4(n6142), .Y(n6114) );
  AO22X1_RVT U7153 ( .A1(instr_srli), .A2(net30496), .A3(n6114), .A4(n8044), 
        .Y(n3632) );
  NAND2X0_RVT U7154 ( .A1(count_instr[30]), .A2(n5993), .Y(n6007) );
  AND2X1_RVT U7155 ( .A1(n6007), .A2(resetn), .Y(n5992) );
  OA21X1_RVT U7156 ( .A1(n5993), .A2(count_instr[30]), .A3(n5992), .Y(n3863)
         );
  INVX0_RVT U7157 ( .A(n6012), .Y(n5995) );
  AND2X1_RVT U7158 ( .A1(resetn), .A2(n5995), .Y(n5996) );
  AND2X1_RVT U7159 ( .A1(mem_rdata_q[13]), .A2(n8045), .Y(n6202) );
  AND3X1_RVT U7160 ( .A1(n4267), .A2(n6202), .A3(n7970), .Y(n6191) );
  AO22X1_RVT U7161 ( .A1(is_sb_sh_sw), .A2(n6191), .A3(instr_sw), .A4(net30497), .Y(n3675) );
  AO22X1_RVT U7162 ( .A1(instr_slli), .A2(net30496), .A3(n5997), .A4(n7970), 
        .Y(n3633) );
  NAND2X0_RVT U7163 ( .A1(count_instr[17]), .A2(n6000), .Y(n7840) );
  AND2X1_RVT U7164 ( .A1(n7840), .A2(resetn), .Y(n5999) );
  OA21X1_RVT U7165 ( .A1(n6000), .A2(count_instr[17]), .A3(n5999), .Y(n3876)
         );
  AND2X1_RVT U7166 ( .A1(count_instr[18]), .A2(n7841), .Y(n6003) );
  AND2X1_RVT U7167 ( .A1(n6001), .A2(resetn), .Y(n6002) );
  OA21X1_RVT U7168 ( .A1(n6003), .A2(count_instr[19]), .A3(n6002), .Y(n3874)
         );
  INVX1_RVT U7169 ( .A(n6004), .Y(n6006) );
  NAND2X0_RVT U7170 ( .A1(n6006), .A2(count_instr[53]), .Y(n6013) );
  AND2X1_RVT U7171 ( .A1(n6013), .A2(resetn), .Y(n6005) );
  OA21X1_RVT U7172 ( .A1(count_instr[53]), .A2(n6006), .A3(n6005), .Y(n3840)
         );
  NAND2X0_RVT U7173 ( .A1(count_instr[31]), .A2(n6009), .Y(n6016) );
  AND2X1_RVT U7174 ( .A1(n6016), .A2(resetn), .Y(n6008) );
  OA21X1_RVT U7175 ( .A1(n6009), .A2(count_instr[31]), .A3(n6008), .Y(n3862)
         );
  AND2X1_RVT U7176 ( .A1(n6010), .A2(resetn), .Y(n6011) );
  INVX1_RVT U7177 ( .A(n6013), .Y(n6015) );
  NAND2X0_RVT U7178 ( .A1(n6015), .A2(count_instr[54]), .Y(n6044) );
  AND2X1_RVT U7179 ( .A1(n6044), .A2(resetn), .Y(n6014) );
  OA21X1_RVT U7180 ( .A1(count_instr[54]), .A2(n6015), .A3(n6014), .Y(n3839)
         );
  NAND2X0_RVT U7181 ( .A1(count_instr[32]), .A2(n6018), .Y(n7847) );
  AND2X1_RVT U7182 ( .A1(n7847), .A2(resetn), .Y(n6017) );
  OA21X1_RVT U7183 ( .A1(n6018), .A2(count_instr[32]), .A3(n6017), .Y(n3861)
         );
  AND2X1_RVT U7184 ( .A1(n6019), .A2(count_cycle[27]), .Y(n6047) );
  AND2X1_RVT U7185 ( .A1(resetn), .A2(n6020), .Y(n6021) );
  NAND4X0_RVT U7186 ( .A1(mem_rdata_q[0]), .A2(mem_rdata_q[1]), .A3(n4267), 
        .A4(n6202), .Y(n6026) );
  NOR4X1_RVT U7187 ( .A1(mem_rdata_q[16]), .A2(mem_rdata_q[17]), .A3(
        mem_rdata_q[18]), .A4(mem_rdata_q[19]), .Y(n6023) );
  NOR4X1_RVT U7188 ( .A1(mem_rdata_q[23]), .A2(mem_rdata_q[22]), .A3(
        mem_rdata_q[24]), .A4(n8046), .Y(n6022) );
  NAND4X0_RVT U7189 ( .A1(mem_rdata_q[6]), .A2(n6024), .A3(n6023), .A4(n6022), 
        .Y(n6025) );
  NOR4X1_RVT U7190 ( .A1(mem_rdata_q[14]), .A2(n8044), .A3(n6026), .A4(n6025), 
        .Y(n6027) );
  AND4X1_RVT U7191 ( .A1(mem_rdata_q[5]), .A2(mem_rdata_q[4]), .A3(n6028), 
        .A4(n6027), .Y(n6097) );
  AND2X1_RVT U7192 ( .A1(n6097), .A2(n8061), .Y(n6101) );
  AO22X1_RVT U7193 ( .A1(instr_rdcycleh), .A2(net30497), .A3(mem_rdata_q[27]), 
        .A4(n6101), .Y(n3688) );
  AND2X1_RVT U7194 ( .A1(n8012), .A2(n4810), .Y(n6029) );
  OA21X1_RVT U7195 ( .A1(latched_store), .A2(latched_branch), .A3(n6029), .Y(
        n6127) );
  AO22X1_RVT U7196 ( .A1(n4751), .A2(n6366), .A3(n4754), .A4(\cpuregs[7][6] ), 
        .Y(n2772) );
  NAND3X0_RVT U7197 ( .A1(n7984), .A2(n7969), .A3(n8022), .Y(n6032) );
  NAND3X0_RVT U7198 ( .A1(n6033), .A2(n4267), .A3(n6032), .Y(net25183) );
  AND2X1_RVT U7199 ( .A1(n6033), .A2(n4266), .Y(n6034) );
  AND4X1_RVT U7200 ( .A1(n6034), .A2(n7984), .A3(n7969), .A4(n8022), .Y(n6133)
         );
  OA21X1_RVT U7201 ( .A1(is_sb_sh_sw), .A2(is_beq_bne_blt_bge_bltu_bgeu), .A3(
        n6133), .Y(n6130) );
  OR2X1_RVT U7202 ( .A1(n6036), .A2(n6035), .Y(n3604) );
  OR2X1_RVT U7203 ( .A1(n6038), .A2(n6037), .Y(n3605) );
  AND2X1_RVT U7204 ( .A1(latched_rd[4]), .A2(n6127), .Y(n6140) );
  AND2X1_RVT U7205 ( .A1(latched_rd[0]), .A2(n6140), .Y(n6059) );
  HADDX1_RVT U7206 ( .A0(reg_pc[12]), .B0(n6039), .C1(n6503), .SO(n6040) );
  AO22X1_RVT U7207 ( .A1(n4072), .A2(n4586), .A3(n4626), .A4(\cpuregs[21][12] ), .Y(n3226) );
  AO22X1_RVT U7208 ( .A1(n4071), .A2(n4587), .A3(n4629), .A4(\cpuregs[19][12] ), .Y(n3162) );
  NAND2X0_RVT U7209 ( .A1(n6309), .A2(n6059), .Y(n6043) );
  INVX1_RVT U7210 ( .A(n6043), .Y(n6068) );
  AO22X1_RVT U7211 ( .A1(n4784), .A2(n4586), .A3(n4034), .A4(\cpuregs[23][12] ), .Y(n3290) );
  INVX1_RVT U7212 ( .A(n6044), .Y(n6046) );
  NAND2X0_RVT U7213 ( .A1(n6046), .A2(count_instr[55]), .Y(n6056) );
  AND2X1_RVT U7214 ( .A1(n6056), .A2(resetn), .Y(n6045) );
  OA21X1_RVT U7215 ( .A1(count_instr[55]), .A2(n6046), .A3(n6045), .Y(n3838)
         );
  AND2X1_RVT U7216 ( .A1(resetn), .A2(n6048), .Y(n6049) );
  OA21X1_RVT U7217 ( .A1(n6047), .A2(count_cycle[28]), .A3(n6049), .Y(N946) );
  NOR2X0_RVT U7218 ( .A1(instr_auipc), .A2(instr_lui), .Y(n6051) );
  AO22X1_RVT U7219 ( .A1(mem_rdata_q[14]), .A2(n6128), .A3(n7944), .A4(
        decoded_imm_j[14]), .Y(n6052) );
  OR2X1_RVT U7220 ( .A1(n6098), .A2(n6052), .Y(n6053) );
  AO21X1_RVT U7221 ( .A1(decoded_imm[14]), .A2(net30494), .A3(n6053), .Y(n3593) );
  AO22X1_RVT U7222 ( .A1(decoded_imm_j[18]), .A2(n7944), .A3(n6128), .A4(
        mem_rdata_q[18]), .Y(n6054) );
  OR2X1_RVT U7223 ( .A1(n6098), .A2(n6054), .Y(n6055) );
  AO21X1_RVT U7224 ( .A1(decoded_imm[18]), .A2(net30497), .A3(n6055), .Y(n3589) );
  INVX1_RVT U7225 ( .A(n6056), .Y(n6058) );
  NAND2X0_RVT U7226 ( .A1(n6058), .A2(count_instr[56]), .Y(n6071) );
  AND2X1_RVT U7227 ( .A1(n6071), .A2(resetn), .Y(n6057) );
  OA21X1_RVT U7228 ( .A1(count_instr[56]), .A2(n6058), .A3(n6057), .Y(n3837)
         );
  AO22X1_RVT U7229 ( .A1(n4077), .A2(n4588), .A3(n4525), .A4(\cpuregs[17][12] ), .Y(n3098) );
  AND2X1_RVT U7230 ( .A1(n6061), .A2(resetn), .Y(n6062) );
  OA21X1_RVT U7231 ( .A1(count_cycle[29]), .A2(n6060), .A3(n6062), .Y(N947) );
  INVX1_RVT U7232 ( .A(n6159), .Y(n6087) );
  AO22X1_RVT U7233 ( .A1(n4763), .A2(n4588), .A3(n4766), .A4(\cpuregs[20][12] ), .Y(n3194) );
  INVX1_RVT U7234 ( .A(n6153), .Y(n6081) );
  AO22X1_RVT U7235 ( .A1(n4773), .A2(n4587), .A3(n4522), .A4(\cpuregs[18][12] ), .Y(n3130) );
  AO22X1_RVT U7236 ( .A1(n4767), .A2(n4587), .A3(n4770), .A4(\cpuregs[22][12] ), .Y(n3258) );
  AO22X1_RVT U7237 ( .A1(n4072), .A2(n4547), .A3(n4625), .A4(\cpuregs[21][0] ), 
        .Y(n3246) );
  AO22X1_RVT U7238 ( .A1(n4786), .A2(n4398), .A3(n4034), .A4(\cpuregs[23][0] ), 
        .Y(n3310) );
  AO22X1_RVT U7239 ( .A1(n4788), .A2(n4547), .A3(n4628), .A4(\cpuregs[19][0] ), 
        .Y(n3182) );
  HADDX1_RVT U7240 ( .A0(reg_pc[25]), .B0(n6064), .C1(n6066), .SO(n5523) );
  AO22X1_RVT U7241 ( .A1(n4784), .A2(n4563), .A3(n4783), .A4(\cpuregs[23][26] ), .Y(n3304) );
  AO22X1_RVT U7242 ( .A1(n4784), .A2(n4608), .A3(n4787), .A4(\cpuregs[23][2] ), 
        .Y(n3280) );
  HADDX1_RVT U7243 ( .A0(reg_pc[26]), .B0(n6066), .C1(n6182), .SO(n6065) );
  AO22X1_RVT U7244 ( .A1(n4786), .A2(n7949), .A3(n4787), .A4(\cpuregs[23][29] ), .Y(n3307) );
  HADDX1_RVT U7245 ( .A0(reg_pc[28]), .B0(n6069), .C1(n6282), .SO(n6070) );
  AO22X1_RVT U7246 ( .A1(n4785), .A2(n4602), .A3(n4034), .A4(\cpuregs[23][28] ), .Y(n3306) );
  INVX1_RVT U7247 ( .A(n6071), .Y(n6073) );
  NAND2X0_RVT U7248 ( .A1(n6073), .A2(count_instr[57]), .Y(n6088) );
  AND2X1_RVT U7249 ( .A1(n6088), .A2(resetn), .Y(n6072) );
  OA21X1_RVT U7250 ( .A1(count_instr[57]), .A2(n6073), .A3(n6072), .Y(n3836)
         );
  AO22X1_RVT U7251 ( .A1(decoded_imm[31]), .A2(net27467), .A3(mem_rdata_q[31]), 
        .A4(n4240), .Y(n6074) );
  OR2X1_RVT U7252 ( .A1(n4248), .A2(n6074), .Y(n3576) );
  AO22X1_RVT U7253 ( .A1(decoded_imm[30]), .A2(net30495), .A3(n4240), .A4(
        mem_rdata_q[30]), .Y(n6075) );
  OR2X1_RVT U7254 ( .A1(n4249), .A2(n6075), .Y(n3577) );
  HADDX1_RVT U7255 ( .A0(reg_pc[21]), .B0(n6076), .C1(n6082), .SO(n6077) );
  AO222X1_RVT U7256 ( .A1(n4519), .A2(n6077), .A3(n4372), .A4(reg_out[21]), 
        .A5(alu_out_q[21]), .A6(n4548), .Y(n7955) );
  AO22X1_RVT U7257 ( .A1(n6086), .A2(n4086), .A3(n4629), .A4(\cpuregs[19][21] ), .Y(n3171) );
  AO22X1_RVT U7258 ( .A1(n4786), .A2(n4569), .A3(n4783), .A4(\cpuregs[23][21] ), .Y(n3299) );
  AO22X1_RVT U7259 ( .A1(n4090), .A2(n4086), .A3(n4625), .A4(\cpuregs[21][21] ), .Y(n3235) );
  AO22X1_RVT U7260 ( .A1(n4769), .A2(n4569), .A3(n4771), .A4(\cpuregs[22][21] ), .Y(n3267) );
  AO22X1_RVT U7261 ( .A1(n4108), .A2(n4101), .A3(n4525), .A4(\cpuregs[17][21] ), .Y(n3107) );
  AO22X1_RVT U7262 ( .A1(n4765), .A2(n4569), .A3(n4766), .A4(\cpuregs[20][21] ), .Y(n3203) );
  AO22X1_RVT U7263 ( .A1(n4775), .A2(n4086), .A3(n4776), .A4(\cpuregs[18][21] ), .Y(n3139) );
  AO22X1_RVT U7264 ( .A1(n4764), .A2(n4547), .A3(n4520), .A4(\cpuregs[20][0] ), 
        .Y(n3214) );
  AO22X1_RVT U7265 ( .A1(n4774), .A2(n4547), .A3(n4523), .A4(\cpuregs[18][0] ), 
        .Y(n3150) );
  AO22X1_RVT U7266 ( .A1(n4768), .A2(n4398), .A3(n4772), .A4(\cpuregs[22][0] ), 
        .Y(n3278) );
  AND2X1_RVT U7267 ( .A1(resetn), .A2(n6079), .Y(n6080) );
  HADDX1_RVT U7268 ( .A0(reg_pc[22]), .B0(n6082), .C1(n6515), .SO(n6083) );
  AO22X1_RVT U7269 ( .A1(n4774), .A2(n4551), .A3(n4776), .A4(\cpuregs[18][22] ), .Y(n3140) );
  AO22X1_RVT U7270 ( .A1(n4768), .A2(n4551), .A3(n4771), .A4(\cpuregs[22][22] ), .Y(n3268) );
  AO22X1_RVT U7271 ( .A1(n4790), .A2(n4552), .A3(n4624), .A4(\cpuregs[21][22] ), .Y(n3236) );
  AO22X1_RVT U7272 ( .A1(n4789), .A2(n4552), .A3(n4627), .A4(\cpuregs[19][22] ), .Y(n3172) );
  AO22X1_RVT U7273 ( .A1(n4746), .A2(n4551), .A3(n4748), .A4(\cpuregs[5][22] ), 
        .Y(n2724) );
  AO22X1_RVT U7274 ( .A1(n4707), .A2(n4551), .A3(n4709), .A4(\cpuregs[6][22] ), 
        .Y(n2756) );
  AO22X1_RVT U7275 ( .A1(n4764), .A2(n4553), .A3(n4766), .A4(\cpuregs[20][22] ), .Y(n3204) );
  AO22X1_RVT U7276 ( .A1(n4752), .A2(n4554), .A3(n4756), .A4(\cpuregs[7][22] ), 
        .Y(n2788) );
  AO22X1_RVT U7277 ( .A1(n4719), .A2(n4553), .A3(n4721), .A4(\cpuregs[4][22] ), 
        .Y(n2692) );
  AO22X1_RVT U7278 ( .A1(n4786), .A2(n4554), .A3(n4783), .A4(\cpuregs[23][22] ), .Y(n3300) );
  AO22X1_RVT U7279 ( .A1(n4725), .A2(n4552), .A3(n4727), .A4(\cpuregs[2][22] ), 
        .Y(n2628) );
  INVX1_RVT U7280 ( .A(n6088), .Y(n6090) );
  NAND2X0_RVT U7281 ( .A1(n6090), .A2(count_instr[58]), .Y(n6137) );
  AND2X1_RVT U7282 ( .A1(n6137), .A2(resetn), .Y(n6089) );
  OA21X1_RVT U7283 ( .A1(count_instr[58]), .A2(n6090), .A3(n6089), .Y(n3835)
         );
  AO22X1_RVT U7284 ( .A1(decoded_imm_j[17]), .A2(n7944), .A3(n6128), .A4(
        mem_rdata_q[17]), .Y(n6091) );
  OR2X1_RVT U7285 ( .A1(n6098), .A2(n6091), .Y(n6092) );
  AO21X1_RVT U7286 ( .A1(decoded_imm[17]), .A2(net30496), .A3(n6092), .Y(n3590) );
  AO22X1_RVT U7287 ( .A1(decoded_imm_j[15]), .A2(n7944), .A3(n6128), .A4(
        mem_rdata_q[15]), .Y(n6093) );
  OR2X1_RVT U7288 ( .A1(n6098), .A2(n6093), .Y(n6094) );
  AO21X1_RVT U7289 ( .A1(decoded_imm[15]), .A2(net30495), .A3(n6094), .Y(n3592) );
  AND2X1_RVT U7290 ( .A1(is_alu_reg_reg), .A2(n6095), .Y(n6144) );
  AO22X1_RVT U7291 ( .A1(is_sll_srl_sra), .A2(net30495), .A3(n6144), .A4(n6096), .Y(n3627) );
  AND3X1_RVT U7292 ( .A1(mem_rdata_q[21]), .A2(n6097), .A3(net16302), .Y(n6103) );
  AO22X1_RVT U7293 ( .A1(instr_rdinstr), .A2(net27467), .A3(n6103), .A4(n8000), 
        .Y(n3689) );
  AO22X1_RVT U7294 ( .A1(n4399), .A2(n7944), .A3(n6128), .A4(mem_rdata_q[19]), 
        .Y(n6099) );
  OR2X1_RVT U7295 ( .A1(n6098), .A2(n6099), .Y(n6100) );
  AO21X1_RVT U7296 ( .A1(decoded_imm[19]), .A2(net30495), .A3(n6100), .Y(n3588) );
  AO22X1_RVT U7297 ( .A1(instr_rdcycle), .A2(net30496), .A3(n6101), .A4(n8000), 
        .Y(n3687) );
  AO22X1_RVT U7298 ( .A1(instr_lbu), .A2(net30495), .A3(n6102), .A4(n8045), 
        .Y(n3680) );
  AO22X1_RVT U7299 ( .A1(instr_rdinstrh), .A2(net30495), .A3(mem_rdata_q[27]), 
        .A4(n6103), .Y(n3690) );
  INVX0_RVT U7300 ( .A(n6145), .Y(n6105) );
  AND2X1_RVT U7301 ( .A1(resetn), .A2(n6105), .Y(n6106) );
  OA21X1_RVT U7302 ( .A1(count_cycle[31]), .A2(n6104), .A3(n6106), .Y(N949) );
  AO22X1_RVT U7303 ( .A1(is_lb_lh_lw_lbu_lhu), .A2(n6191), .A3(instr_lw), .A4(
        net30495), .Y(n3681) );
  AO22X1_RVT U7304 ( .A1(is_sb_sh_sw), .A2(n6107), .A3(instr_sh), .A4(net30496), .Y(n3676) );
  AND3X1_RVT U7305 ( .A1(n7970), .A2(n7999), .A3(n8045), .Y(n6430) );
  OA222X1_RVT U7306 ( .A1(net30494), .A2(is_lb_lh_lw_lbu_lhu), .A3(net30497), 
        .A4(n6430), .A5(instr_lb), .A6(n4267), .Y(n3683) );
  AO22X1_RVT U7307 ( .A1(decoded_imm_j[16]), .A2(n7944), .A3(n6128), .A4(
        mem_rdata_q[16]), .Y(n6108) );
  OR2X1_RVT U7308 ( .A1(n6098), .A2(n6108), .Y(n6109) );
  AO21X1_RVT U7309 ( .A1(decoded_imm[16]), .A2(net30496), .A3(n6109), .Y(n3591) );
  AO22X1_RVT U7310 ( .A1(mem_rdata_q[13]), .A2(n6128), .A3(n7944), .A4(
        decoded_imm_j[13]), .Y(n6110) );
  OR2X1_RVT U7311 ( .A1(n6098), .A2(n6110), .Y(n6111) );
  AO21X1_RVT U7312 ( .A1(decoded_imm[13]), .A2(net30497), .A3(n6111), .Y(n3594) );
  AO22X1_RVT U7313 ( .A1(mem_rdata_q[12]), .A2(n6128), .A3(n7944), .A4(
        decoded_imm_j[12]), .Y(n6112) );
  OR2X1_RVT U7314 ( .A1(n6098), .A2(n6112), .Y(n6113) );
  AO21X1_RVT U7315 ( .A1(decoded_imm[12]), .A2(net30497), .A3(n6113), .Y(n3595) );
  AO22X1_RVT U7316 ( .A1(instr_srai), .A2(net27467), .A3(mem_rdata_q[30]), 
        .A4(n6114), .Y(n3631) );
  AO22X1_RVT U7317 ( .A1(n4091), .A2(n4547), .A3(n4527), .A4(\cpuregs[17][0] ), 
        .Y(n3118) );
  AO22X1_RVT U7318 ( .A1(n4108), .A2(n4551), .A3(n4525), .A4(\cpuregs[17][22] ), .Y(n3108) );
  AO22X1_RVT U7319 ( .A1(n4108), .A2(n7966), .A3(n4525), .A4(\cpuregs[17][2] ), 
        .Y(n3088) );
  AO22X1_RVT U7320 ( .A1(decoded_imm[21]), .A2(net30494), .A3(n4240), .A4(
        mem_rdata_q[21]), .Y(n6116) );
  OR2X1_RVT U7321 ( .A1(n4249), .A2(n6116), .Y(n3586) );
  AO22X1_RVT U7322 ( .A1(decoded_imm[25]), .A2(net27467), .A3(n4240), .A4(
        mem_rdata_q[25]), .Y(n6117) );
  OR2X1_RVT U7323 ( .A1(n4248), .A2(n6117), .Y(n3582) );
  AO22X1_RVT U7324 ( .A1(decoded_imm[24]), .A2(net30497), .A3(n4240), .A4(
        mem_rdata_q[24]), .Y(n6118) );
  OR2X1_RVT U7325 ( .A1(n4249), .A2(n6118), .Y(n3583) );
  AO22X1_RVT U7326 ( .A1(decoded_imm[20]), .A2(net30496), .A3(mem_rdata_q[20]), 
        .A4(n6128), .Y(n6119) );
  OR2X1_RVT U7327 ( .A1(n4249), .A2(n6119), .Y(n3587) );
  AO22X1_RVT U7328 ( .A1(decoded_imm[1]), .A2(net30494), .A3(decoded_imm_j[1]), 
        .A4(net30578), .Y(n6120) );
  OR2X1_RVT U7329 ( .A1(n6121), .A2(n6120), .Y(n3606) );
  OA222X1_RVT U7330 ( .A1(net30495), .A2(is_sb_sh_sw), .A3(net30496), .A4(
        n6430), .A5(instr_sb), .A6(n4267), .Y(n3677) );
  AO22X1_RVT U7331 ( .A1(decoded_imm[23]), .A2(net30495), .A3(n4240), .A4(
        mem_rdata_q[23]), .Y(n6122) );
  OR2X1_RVT U7332 ( .A1(n4248), .A2(n6122), .Y(n3584) );
  AO22X1_RVT U7333 ( .A1(decoded_imm[27]), .A2(net27467), .A3(n4240), .A4(
        mem_rdata_q[27]), .Y(n6123) );
  OR2X1_RVT U7334 ( .A1(n4248), .A2(n6123), .Y(n3580) );
  AO22X1_RVT U7335 ( .A1(decoded_imm[26]), .A2(net27467), .A3(n4240), .A4(
        mem_rdata_q[26]), .Y(n6124) );
  OR2X1_RVT U7336 ( .A1(n4248), .A2(n6124), .Y(n3581) );
  AO22X1_RVT U7337 ( .A1(decoded_imm[29]), .A2(net27467), .A3(n4240), .A4(
        mem_rdata_q[29]), .Y(n6125) );
  OR2X1_RVT U7338 ( .A1(n4248), .A2(n6125), .Y(n3578) );
  AO22X1_RVT U7339 ( .A1(decoded_imm[28]), .A2(net30497), .A3(n4240), .A4(
        mem_rdata_q[28]), .Y(n6126) );
  OR2X1_RVT U7340 ( .A1(n4249), .A2(n6126), .Y(n3579) );
  AO22X1_RVT U7341 ( .A1(n4739), .A2(n4101), .A3(n4742), .A4(\cpuregs[3][21] ), 
        .Y(n2659) );
  AO22X1_RVT U7342 ( .A1(n4733), .A2(n4086), .A3(n4738), .A4(\cpuregs[1][21] ), 
        .Y(n2595) );
  AO22X1_RVT U7343 ( .A1(n4741), .A2(n4586), .A3(n4742), .A4(\cpuregs[3][12] ), 
        .Y(n2650) );
  AO22X1_RVT U7344 ( .A1(n4735), .A2(n4586), .A3(n4736), .A4(\cpuregs[1][12] ), 
        .Y(n2586) );
  AO22X1_RVT U7345 ( .A1(decoded_imm[22]), .A2(net30496), .A3(n4240), .A4(
        mem_rdata_q[22]), .Y(n6129) );
  OR2X1_RVT U7346 ( .A1(n4249), .A2(n6129), .Y(n3585) );
  AO22X1_RVT U7347 ( .A1(decoded_imm[4]), .A2(net30495), .A3(decoded_imm_j[4]), 
        .A4(net30578), .Y(n6131) );
  OR2X1_RVT U7348 ( .A1(n6132), .A2(n6131), .Y(n3603) );
  AOI22X1_RVT U7349 ( .A1(net30494), .A2(decoded_imm[11]), .A3(
        decoded_imm_j[11]), .A4(n7944), .Y(n6136) );
  NAND3X0_RVT U7350 ( .A1(is_beq_bne_blt_bge_bltu_bgeu), .A2(n6133), .A3(
        mem_rdata_q[7]), .Y(n6135) );
  NAND3X0_RVT U7351 ( .A1(is_sb_sh_sw), .A2(n6133), .A3(n8018), .Y(net22739)
         );
  NAND3X0_RVT U7352 ( .A1(n6136), .A2(n6135), .A3(n6134), .Y(n3596) );
  INVX1_RVT U7353 ( .A(n6137), .Y(n6139) );
  NAND2X0_RVT U7354 ( .A1(n6139), .A2(count_instr[59]), .Y(n6148) );
  AND2X1_RVT U7355 ( .A1(n6148), .A2(resetn), .Y(n6138) );
  OA21X1_RVT U7356 ( .A1(count_instr[59]), .A2(n6139), .A3(n6138), .Y(n3834)
         );
  AO22X1_RVT U7357 ( .A1(n4778), .A2(n4553), .A3(n4780), .A4(\cpuregs[16][22] ), .Y(n3076) );
  AND2X1_RVT U7358 ( .A1(resetn), .A2(net30494), .Y(n6192) );
  AND3X1_RVT U7359 ( .A1(mem_rdata_q[14]), .A2(n7999), .A3(n8045), .Y(n6197)
         );
  AO22X1_RVT U7360 ( .A1(instr_blt), .A2(n4276), .A3(n4266), .A4(n6141), .Y(
        n3763) );
  AND2X1_RVT U7361 ( .A1(mem_rdata_q[14]), .A2(n6202), .Y(n6186) );
  AO22X1_RVT U7362 ( .A1(instr_bltu), .A2(n4276), .A3(
        is_beq_bne_blt_bge_bltu_bgeu), .A4(n6196), .Y(n3761) );
  AO22X1_RVT U7363 ( .A1(instr_bge), .A2(n4276), .A3(mem_rdata_q[14]), .A4(
        n6143), .Y(n3762) );
  AO22X1_RVT U7364 ( .A1(instr_bne), .A2(n4096), .A3(n6143), .A4(n7970), .Y(
        n3764) );
  AND2X1_RVT U7365 ( .A1(n6430), .A2(n6194), .Y(n6199) );
  AO22X1_RVT U7366 ( .A1(n4610), .A2(n4096), .A3(n6199), .A4(mem_rdata_q[30]), 
        .Y(n3752) );
  AND3X1_RVT U7367 ( .A1(resetn), .A2(n6430), .A3(n4267), .Y(n6198) );
  AO22X1_RVT U7368 ( .A1(instr_beq), .A2(n6192), .A3(
        is_beq_bne_blt_bge_bltu_bgeu), .A4(n6198), .Y(n3765) );
  AND2X1_RVT U7369 ( .A1(mem_rdata_q[13]), .A2(mem_rdata_q[12]), .Y(n6204) );
  AND2X1_RVT U7370 ( .A1(mem_rdata_q[14]), .A2(n6204), .Y(n6200) );
  AND3X1_RVT U7371 ( .A1(resetn), .A2(n4267), .A3(n6200), .Y(n6189) );
  AO22X1_RVT U7372 ( .A1(instr_bgeu), .A2(n4096), .A3(
        is_beq_bne_blt_bge_bltu_bgeu), .A4(n6189), .Y(n3760) );
  AND2X1_RVT U7373 ( .A1(n6145), .A2(count_cycle[32]), .Y(n6179) );
  AND2X1_RVT U7374 ( .A1(resetn), .A2(n6146), .Y(n6147) );
  AO22X1_RVT U7375 ( .A1(n4107), .A2(n4565), .A3(n4624), .A4(\cpuregs[21][26] ), .Y(n3240) );
  AO22X1_RVT U7376 ( .A1(n4763), .A2(n4385), .A3(n4521), .A4(\cpuregs[20][26] ), .Y(n3208) );
  AO22X1_RVT U7377 ( .A1(n4071), .A2(n4563), .A3(n4629), .A4(\cpuregs[19][26] ), .Y(n3176) );
  AO22X1_RVT U7378 ( .A1(n4091), .A2(n4385), .A3(n4526), .A4(\cpuregs[17][26] ), .Y(n3112) );
  AO22X1_RVT U7379 ( .A1(n4773), .A2(n4564), .A3(n4523), .A4(\cpuregs[18][26] ), .Y(n3144) );
  INVX1_RVT U7380 ( .A(n6148), .Y(n6150) );
  NAND2X0_RVT U7381 ( .A1(n6150), .A2(count_instr[60]), .Y(n6212) );
  AND2X1_RVT U7382 ( .A1(n6212), .A2(resetn), .Y(n6149) );
  OA21X1_RVT U7383 ( .A1(count_instr[60]), .A2(n6150), .A3(n6149), .Y(n3833)
         );
  AO22X1_RVT U7384 ( .A1(n4769), .A2(n4385), .A3(n4772), .A4(\cpuregs[22][26] ), .Y(n3272) );
  AO22X1_RVT U7385 ( .A1(n4104), .A2(n4585), .A3(n4628), .A4(\cpuregs[19][11] ), .Y(n3161) );
  AO22X1_RVT U7386 ( .A1(n4785), .A2(n7959), .A3(n4034), .A4(\cpuregs[23][11] ), .Y(n3289) );
  AO22X1_RVT U7387 ( .A1(n4773), .A2(n4092), .A3(n4522), .A4(\cpuregs[18][11] ), .Y(n3129) );
  AO22X1_RVT U7388 ( .A1(n4104), .A2(n4550), .A3(n4628), .A4(\cpuregs[19][5] ), 
        .Y(n3155) );
  AO22X1_RVT U7389 ( .A1(n4775), .A2(n7963), .A3(n4776), .A4(\cpuregs[18][5] ), 
        .Y(n3123) );
  AO22X1_RVT U7390 ( .A1(n4775), .A2(n4555), .A3(n4523), .A4(\cpuregs[18][10] ), .Y(n3128) );
  AO22X1_RVT U7391 ( .A1(n6086), .A2(n4555), .A3(n4627), .A4(\cpuregs[19][10] ), .Y(n3160) );
  AO22X1_RVT U7392 ( .A1(n4646), .A2(n7959), .A3(n4526), .A4(\cpuregs[17][11] ), .Y(n3097) );
  AO22X1_RVT U7393 ( .A1(n4763), .A2(n4109), .A3(n4520), .A4(\cpuregs[20][11] ), .Y(n3193) );
  AO22X1_RVT U7394 ( .A1(n4072), .A2(n4585), .A3(n4626), .A4(\cpuregs[21][11] ), .Y(n3225) );
  AO22X1_RVT U7395 ( .A1(n4767), .A2(n4109), .A3(n4770), .A4(\cpuregs[22][11] ), .Y(n3257) );
  AO22X1_RVT U7396 ( .A1(n6085), .A2(n4008), .A3(n4626), .A4(\cpuregs[21][5] ), 
        .Y(n3219) );
  AO22X1_RVT U7397 ( .A1(n4107), .A2(n4556), .A3(n4624), .A4(\cpuregs[21][10] ), .Y(n3224) );
  AO22X1_RVT U7398 ( .A1(n4077), .A2(n7963), .A3(n4525), .A4(\cpuregs[17][5] ), 
        .Y(n3091) );
  AO22X1_RVT U7399 ( .A1(n4784), .A2(n4557), .A3(n4783), .A4(\cpuregs[23][10] ), .Y(n3288) );
  AO22X1_RVT U7400 ( .A1(n4091), .A2(n4556), .A3(n4527), .A4(\cpuregs[17][10] ), .Y(n3096) );
  AO22X1_RVT U7401 ( .A1(n4786), .A2(n4008), .A3(n4787), .A4(\cpuregs[23][5] ), 
        .Y(n3283) );
  AO22X1_RVT U7402 ( .A1(n4765), .A2(n4008), .A3(n4521), .A4(\cpuregs[20][5] ), 
        .Y(n3187) );
  AO22X1_RVT U7403 ( .A1(n4765), .A2(n4557), .A3(n4521), .A4(\cpuregs[20][10] ), .Y(n3192) );
  AO22X1_RVT U7404 ( .A1(n4769), .A2(n4606), .A3(n4772), .A4(\cpuregs[22][2] ), 
        .Y(n3248) );
  AO22X1_RVT U7405 ( .A1(n6085), .A2(n4607), .A3(n4625), .A4(\cpuregs[21][2] ), 
        .Y(n3216) );
  AO22X1_RVT U7406 ( .A1(n4764), .A2(n4607), .A3(n4766), .A4(\cpuregs[20][2] ), 
        .Y(n3184) );
  AO22X1_RVT U7407 ( .A1(n4768), .A2(n4550), .A3(n4771), .A4(\cpuregs[22][5] ), 
        .Y(n3251) );
  AO22X1_RVT U7408 ( .A1(n4767), .A2(n4555), .A3(n4771), .A4(\cpuregs[22][10] ), .Y(n3256) );
  AO22X1_RVT U7409 ( .A1(n4774), .A2(n4606), .A3(n4776), .A4(\cpuregs[18][2] ), 
        .Y(n3120) );
  AO22X1_RVT U7410 ( .A1(n4788), .A2(n4606), .A3(n4628), .A4(\cpuregs[19][2] ), 
        .Y(n3152) );
  HADDX1_RVT U7411 ( .A0(reg_pc[17]), .B0(n6161), .C1(n6495), .SO(n6162) );
  AO22X1_RVT U7412 ( .A1(n4778), .A2(n4589), .A3(n4781), .A4(\cpuregs[16][17] ), .Y(n3071) );
  HADDX1_RVT U7413 ( .A0(reg_pc[16]), .B0(n6163), .C1(n6161), .SO(n6164) );
  AO22X1_RVT U7414 ( .A1(n4779), .A2(n6524), .A3(n4780), .A4(\cpuregs[16][16] ), .Y(n3070) );
  AO22X1_RVT U7415 ( .A1(n4107), .A2(n4015), .A3(n4625), .A4(\cpuregs[21][15] ), .Y(n3229) );
  AO22X1_RVT U7416 ( .A1(n4764), .A2(n6367), .A3(n4521), .A4(\cpuregs[20][15] ), .Y(n3197) );
  AO22X1_RVT U7417 ( .A1(n4788), .A2(n4015), .A3(n4629), .A4(\cpuregs[19][15] ), .Y(n3165) );
  AO22X1_RVT U7418 ( .A1(n4777), .A2(n6367), .A3(n4782), .A4(\cpuregs[16][15] ), .Y(n3069) );
  AO22X1_RVT U7419 ( .A1(n4091), .A2(n4017), .A3(n4527), .A4(\cpuregs[17][15] ), .Y(n3101) );
  AO22X1_RVT U7420 ( .A1(n4706), .A2(n4017), .A3(n4711), .A4(\cpuregs[6][15] ), 
        .Y(n2749) );
  AO22X1_RVT U7421 ( .A1(n4753), .A2(n4014), .A3(n4755), .A4(\cpuregs[7][15] ), 
        .Y(n2781) );
  AO22X1_RVT U7422 ( .A1(n4785), .A2(n4015), .A3(n4783), .A4(\cpuregs[23][15] ), .Y(n3293) );
  AO22X1_RVT U7423 ( .A1(n4768), .A2(n4014), .A3(n4770), .A4(\cpuregs[22][15] ), .Y(n3261) );
  AO22X1_RVT U7424 ( .A1(n4724), .A2(n4015), .A3(n4729), .A4(\cpuregs[2][15] ), 
        .Y(n2621) );
  AO22X1_RVT U7425 ( .A1(n4734), .A2(n4016), .A3(n4736), .A4(\cpuregs[1][15] ), 
        .Y(n2589) );
  AO22X1_RVT U7426 ( .A1(n4786), .A2(n4567), .A3(n4783), .A4(\cpuregs[23][16] ), .Y(n3294) );
  AO22X1_RVT U7427 ( .A1(n4774), .A2(n6367), .A3(n4523), .A4(\cpuregs[18][15] ), .Y(n3133) );
  AO22X1_RVT U7428 ( .A1(n4107), .A2(n4567), .A3(n4624), .A4(\cpuregs[21][16] ), .Y(n3230) );
  AO22X1_RVT U7429 ( .A1(n4763), .A2(n4567), .A3(n4520), .A4(\cpuregs[20][16] ), .Y(n3198) );
  AO22X1_RVT U7430 ( .A1(n4725), .A2(n4589), .A3(n4728), .A4(\cpuregs[2][17] ), 
        .Y(n2623) );
  AO22X1_RVT U7431 ( .A1(n4719), .A2(n4591), .A3(n4722), .A4(\cpuregs[4][17] ), 
        .Y(n2687) );
  AO22X1_RVT U7432 ( .A1(n4745), .A2(n6367), .A3(n4750), .A4(\cpuregs[5][15] ), 
        .Y(n2717) );
  AO22X1_RVT U7433 ( .A1(n4718), .A2(n6367), .A3(n4723), .A4(\cpuregs[4][15] ), 
        .Y(n2685) );
  AO22X1_RVT U7434 ( .A1(n4740), .A2(n4017), .A3(n4744), .A4(\cpuregs[3][15] ), 
        .Y(n2653) );
  AO22X1_RVT U7435 ( .A1(n4720), .A2(n6366), .A3(n4722), .A4(\cpuregs[4][6] ), 
        .Y(n2676) );
  AO22X1_RVT U7436 ( .A1(n4747), .A2(n4579), .A3(n4749), .A4(\cpuregs[5][6] ), 
        .Y(n2708) );
  AO22X1_RVT U7437 ( .A1(n4708), .A2(n4578), .A3(n4710), .A4(\cpuregs[6][6] ), 
        .Y(n2740) );
  AO22X1_RVT U7438 ( .A1(n4779), .A2(n4578), .A3(n4781), .A4(\cpuregs[16][6] ), 
        .Y(n3060) );
  AO22X1_RVT U7439 ( .A1(n4108), .A2(n4579), .A3(n6158), .A4(\cpuregs[17][6] ), 
        .Y(n3092) );
  AO22X1_RVT U7440 ( .A1(n4775), .A2(n4579), .A3(n4776), .A4(\cpuregs[18][6] ), 
        .Y(n3124) );
  AO22X1_RVT U7441 ( .A1(n4071), .A2(n4578), .A3(n4628), .A4(\cpuregs[19][6] ), 
        .Y(n3156) );
  AO22X1_RVT U7442 ( .A1(n4765), .A2(n4578), .A3(n4766), .A4(\cpuregs[20][6] ), 
        .Y(n3188) );
  AO22X1_RVT U7443 ( .A1(n4107), .A2(n4580), .A3(n4624), .A4(\cpuregs[21][6] ), 
        .Y(n3220) );
  AO22X1_RVT U7444 ( .A1(n4769), .A2(n4580), .A3(n4770), .A4(\cpuregs[22][6] ), 
        .Y(n3252) );
  AO22X1_RVT U7445 ( .A1(n4786), .A2(n6366), .A3(n4787), .A4(\cpuregs[23][6] ), 
        .Y(n3284) );
  AO22X1_RVT U7446 ( .A1(n4746), .A2(n4589), .A3(n4749), .A4(\cpuregs[5][17] ), 
        .Y(n2719) );
  AO22X1_RVT U7447 ( .A1(n4707), .A2(n4589), .A3(n4710), .A4(\cpuregs[6][17] ), 
        .Y(n2751) );
  AO22X1_RVT U7448 ( .A1(n4752), .A2(n4591), .A3(n4755), .A4(\cpuregs[7][17] ), 
        .Y(n2783) );
  AO22X1_RVT U7449 ( .A1(n4788), .A2(n4566), .A3(n4628), .A4(\cpuregs[19][16] ), .Y(n3166) );
  AO22X1_RVT U7450 ( .A1(n4773), .A2(n4566), .A3(n4522), .A4(\cpuregs[18][16] ), .Y(n3134) );
  AO22X1_RVT U7451 ( .A1(n4091), .A2(n4566), .A3(n6158), .A4(\cpuregs[17][16] ), .Y(n3102) );
  AO22X1_RVT U7452 ( .A1(n4767), .A2(n4566), .A3(n4771), .A4(\cpuregs[22][16] ), .Y(n3262) );
  AO22X1_RVT U7453 ( .A1(n4751), .A2(n6524), .A3(n4754), .A4(\cpuregs[7][16] ), 
        .Y(n2782) );
  AO22X1_RVT U7454 ( .A1(n4708), .A2(n4566), .A3(n4709), .A4(\cpuregs[6][16] ), 
        .Y(n2750) );
  AO22X1_RVT U7455 ( .A1(n4747), .A2(n4567), .A3(n4748), .A4(\cpuregs[5][16] ), 
        .Y(n2718) );
  AO22X1_RVT U7456 ( .A1(n4720), .A2(n4566), .A3(n4721), .A4(\cpuregs[4][16] ), 
        .Y(n2686) );
  AO22X1_RVT U7457 ( .A1(n4735), .A2(n4578), .A3(n4738), .A4(\cpuregs[1][6] ), 
        .Y(n2580) );
  AO22X1_RVT U7458 ( .A1(n4726), .A2(n4578), .A3(n4728), .A4(\cpuregs[2][6] ), 
        .Y(n2612) );
  AO22X1_RVT U7459 ( .A1(n4741), .A2(n4579), .A3(n4744), .A4(\cpuregs[3][6] ), 
        .Y(n2644) );
  AO22X1_RVT U7460 ( .A1(n4108), .A2(n4589), .A3(n4525), .A4(\cpuregs[17][17] ), .Y(n3103) );
  AO22X1_RVT U7461 ( .A1(n4775), .A2(n4589), .A3(n4522), .A4(\cpuregs[18][17] ), .Y(n3135) );
  AO22X1_RVT U7462 ( .A1(n4789), .A2(n4590), .A3(n4628), .A4(\cpuregs[19][17] ), .Y(n3167) );
  AO22X1_RVT U7463 ( .A1(n4765), .A2(n4589), .A3(n4766), .A4(\cpuregs[20][17] ), .Y(n3199) );
  AO22X1_RVT U7464 ( .A1(n4072), .A2(n4591), .A3(n4624), .A4(\cpuregs[21][17] ), .Y(n3231) );
  AO22X1_RVT U7465 ( .A1(n4769), .A2(n6523), .A3(n4770), .A4(\cpuregs[22][17] ), .Y(n3263) );
  AO22X1_RVT U7466 ( .A1(n4784), .A2(n6523), .A3(n4787), .A4(\cpuregs[23][17] ), .Y(n3295) );
  AO22X1_RVT U7467 ( .A1(n4726), .A2(n4568), .A3(n4727), .A4(\cpuregs[2][16] ), 
        .Y(n2622) );
  AND2X1_RVT U7468 ( .A1(n6179), .A2(count_cycle[33]), .Y(n6221) );
  AND2X1_RVT U7469 ( .A1(resetn), .A2(n6180), .Y(n6181) );
  HADDX1_RVT U7470 ( .A0(reg_pc[27]), .B0(n6182), .C1(n6069), .SO(n6183) );
  AO22X1_RVT U7471 ( .A1(n4784), .A2(n4598), .A3(n4783), .A4(\cpuregs[23][27] ), .Y(n3305) );
  AO22X1_RVT U7472 ( .A1(n4108), .A2(n4599), .A3(n6158), .A4(\cpuregs[17][27] ), .Y(n3113) );
  AO22X1_RVT U7473 ( .A1(n4767), .A2(n4599), .A3(n4772), .A4(\cpuregs[22][27] ), .Y(n3273) );
  AO22X1_RVT U7474 ( .A1(n4773), .A2(n4600), .A3(n4523), .A4(\cpuregs[18][27] ), .Y(n3145) );
  AO22X1_RVT U7475 ( .A1(n6086), .A2(n4600), .A3(n4629), .A4(\cpuregs[19][27] ), .Y(n3177) );
  AO22X1_RVT U7476 ( .A1(n4763), .A2(n4598), .A3(n4521), .A4(\cpuregs[20][27] ), .Y(n3209) );
  AO22X1_RVT U7477 ( .A1(n4090), .A2(n4600), .A3(n4626), .A4(\cpuregs[21][27] ), .Y(n3241) );
  AO22X1_RVT U7478 ( .A1(n4739), .A2(n4598), .A3(n4742), .A4(\cpuregs[3][27] ), 
        .Y(n2665) );
  AO22X1_RVT U7479 ( .A1(n4733), .A2(n7951), .A3(n4736), .A4(\cpuregs[1][27] ), 
        .Y(n2601) );
  AND4X1_RVT U7480 ( .A1(mem_rdata_q[3]), .A2(mem_rdata_q[2]), .A3(n8004), 
        .A4(n8065), .Y(n6184) );
  AND4X1_RVT U7481 ( .A1(mem_rdata_q[1]), .A2(mem_rdata_q[0]), .A3(n6184), 
        .A4(n8069), .Y(n6185) );
  AO22X1_RVT U7482 ( .A1(instr_fence), .A2(n4096), .A3(n6198), .A4(n6185), .Y(
        n3743) );
  AND2X1_RVT U7483 ( .A1(n6194), .A2(n8044), .Y(n6201) );
  AO22X1_RVT U7484 ( .A1(instr_or), .A2(n6192), .A3(n6201), .A4(n6186), .Y(
        n3745) );
  AND2X1_RVT U7485 ( .A1(n6201), .A2(n7970), .Y(n6203) );
  AO22X1_RVT U7486 ( .A1(instr_sll), .A2(n4276), .A3(n6187), .A4(n6203), .Y(
        n3751) );
  AND3X1_RVT U7487 ( .A1(mem_rdata_q[14]), .A2(mem_rdata_q[12]), .A3(n7999), 
        .Y(n6193) );
  AO22X1_RVT U7488 ( .A1(instr_srl), .A2(n6192), .A3(n6201), .A4(n6193), .Y(
        n3747) );
  AND4X1_RVT U7489 ( .A1(is_alu_reg_imm), .A2(resetn), .A3(n4267), .A4(n7942), 
        .Y(n6190) );
  AO22X1_RVT U7490 ( .A1(instr_xori), .A2(n6192), .A3(n6188), .A4(n6190), .Y(
        n3756) );
  AO22X1_RVT U7491 ( .A1(instr_andi), .A2(n4276), .A3(is_alu_reg_imm), .A4(
        n6189), .Y(n3754) );
  AO22X1_RVT U7492 ( .A1(instr_slti), .A2(n4276), .A3(n6191), .A4(n6190), .Y(
        n3758) );
  AO22X1_RVT U7493 ( .A1(instr_sltu), .A2(n6192), .A3(n6203), .A4(n6204), .Y(
        n3749) );
  AND2X1_RVT U7494 ( .A1(n6194), .A2(n6193), .Y(n6195) );
  AO22X1_RVT U7495 ( .A1(instr_sra), .A2(n4096), .A3(mem_rdata_q[30]), .A4(
        n6195), .Y(n3746) );
  AO22X1_RVT U7496 ( .A1(instr_ori), .A2(n4096), .A3(is_alu_reg_imm), .A4(
        n6196), .Y(n3755) );
  AO22X1_RVT U7497 ( .A1(instr_xor), .A2(n4096), .A3(n6201), .A4(n6197), .Y(
        n3748) );
  AO22X1_RVT U7498 ( .A1(instr_addi), .A2(n6192), .A3(is_alu_reg_imm), .A4(
        n6198), .Y(n3759) );
  AO22X1_RVT U7499 ( .A1(instr_add), .A2(n6192), .A3(n6199), .A4(n8044), .Y(
        n3753) );
  AO22X1_RVT U7500 ( .A1(instr_and), .A2(n4276), .A3(n6201), .A4(n6200), .Y(
        n3744) );
  AO22X1_RVT U7501 ( .A1(instr_slt), .A2(n4276), .A3(n6203), .A4(n6202), .Y(
        n3750) );
  AND4X1_RVT U7502 ( .A1(resetn), .A2(is_alu_reg_imm), .A3(n4266), .A4(n6204), 
        .Y(n6205) );
  AO22X1_RVT U7503 ( .A1(instr_sltiu), .A2(n4276), .A3(n6205), .A4(n7970), .Y(
        n3757) );
  AO22X1_RVT U7504 ( .A1(n6209), .A2(pcpi_rs1[4]), .A3(n4052), .A4(n6206), .Y(
        mem_la_addr[4]) );
  INVX1_RVT U7505 ( .A(n6222), .Y(n6211) );
  AO22X1_RVT U7506 ( .A1(n4794), .A2(mem_la_addr[4]), .A3(n4795), .A4(
        mem_addr[4]), .Y(n2572) );
  MUX21X1_RVT U7507 ( .A1(reg_next_pc[27]), .A2(reg_out[27]), .S0(n4229), .Y(
        n6946) );
  AO22X1_RVT U7508 ( .A1(n6209), .A2(pcpi_rs1[27]), .A3(n7891), .A4(n6946), 
        .Y(mem_la_addr[27]) );
  AO22X1_RVT U7509 ( .A1(n4792), .A2(mem_la_addr[27]), .A3(n4795), .A4(
        mem_addr[27]), .Y(n2549) );
  AO22X1_RVT U7510 ( .A1(n4323), .A2(net30656), .A3(n4052), .A4(n6931), .Y(
        mem_la_addr[7]) );
  AO22X1_RVT U7511 ( .A1(n4792), .A2(mem_la_addr[7]), .A3(n4796), .A4(
        mem_addr[7]), .Y(n2569) );
  AO22X1_RVT U7512 ( .A1(n4631), .A2(reg_out[3]), .A3(n4632), .A4(
        reg_next_pc[3]), .Y(n6208) );
  AO22X1_RVT U7513 ( .A1(n6209), .A2(net30659), .A3(n4053), .A4(n6208), .Y(
        mem_la_addr[3]) );
  AO22X1_RVT U7514 ( .A1(n4793), .A2(mem_la_addr[3]), .A3(n4795), .A4(
        mem_addr[3]), .Y(n2573) );
  AO22X1_RVT U7515 ( .A1(n4323), .A2(pcpi_rs1[17]), .A3(n4052), .A4(n6210), 
        .Y(mem_la_addr[17]) );
  AO22X1_RVT U7516 ( .A1(n4793), .A2(mem_la_addr[17]), .A3(n4791), .A4(
        mem_addr[17]), .Y(n2559) );
  AO22X1_RVT U7517 ( .A1(n4323), .A2(pcpi_rs1[15]), .A3(n4053), .A4(n6939), 
        .Y(mem_la_addr[15]) );
  AO22X1_RVT U7518 ( .A1(n4794), .A2(mem_la_addr[15]), .A3(n6222), .A4(
        mem_addr[15]), .Y(n2561) );
  AO22X1_RVT U7519 ( .A1(n6209), .A2(pcpi_rs1[18]), .A3(n7891), .A4(n6940), 
        .Y(mem_la_addr[18]) );
  AO22X1_RVT U7520 ( .A1(n4792), .A2(mem_la_addr[18]), .A3(n4796), .A4(
        mem_addr[18]), .Y(n2558) );
  MUX21X1_RVT U7521 ( .A1(reg_next_pc[31]), .A2(reg_out[31]), .S0(n4229), .Y(
        n6948) );
  AO22X1_RVT U7522 ( .A1(n4323), .A2(pcpi_rs1[31]), .A3(n4052), .A4(n6948), 
        .Y(mem_la_addr[31]) );
  AO22X1_RVT U7523 ( .A1(n4793), .A2(mem_la_addr[31]), .A3(n6222), .A4(
        mem_addr[31]), .Y(n2545) );
  AO22X1_RVT U7524 ( .A1(n6209), .A2(pcpi_rs1[26]), .A3(n7891), .A4(n6945), 
        .Y(mem_la_addr[26]) );
  AO22X1_RVT U7525 ( .A1(n4794), .A2(mem_la_addr[26]), .A3(n4791), .A4(
        mem_addr[26]), .Y(n2550) );
  AO22X1_RVT U7526 ( .A1(n4322), .A2(pcpi_rs1[24]), .A3(n4053), .A4(n6943), 
        .Y(mem_la_addr[24]) );
  AO22X1_RVT U7527 ( .A1(n4793), .A2(mem_la_addr[24]), .A3(n4795), .A4(
        mem_addr[24]), .Y(n2552) );
  AO22X1_RVT U7528 ( .A1(n4323), .A2(pcpi_rs1[20]), .A3(n4052), .A4(n6941), 
        .Y(mem_la_addr[20]) );
  AO22X1_RVT U7529 ( .A1(n4792), .A2(mem_la_addr[20]), .A3(n4795), .A4(
        mem_addr[20]), .Y(n2556) );
  AO22X1_RVT U7530 ( .A1(n4322), .A2(net30668), .A3(n7891), .A4(n6936), .Y(
        mem_la_addr[11]) );
  AO22X1_RVT U7531 ( .A1(n4793), .A2(mem_la_addr[11]), .A3(n6222), .A4(
        mem_addr[11]), .Y(n2565) );
  INVX1_RVT U7532 ( .A(n6212), .Y(n6214) );
  NAND2X0_RVT U7533 ( .A1(n6214), .A2(count_instr[61]), .Y(n6279) );
  AND2X1_RVT U7534 ( .A1(n6279), .A2(resetn), .Y(n6213) );
  OA21X1_RVT U7535 ( .A1(count_instr[61]), .A2(n6214), .A3(n6213), .Y(n3832)
         );
  AO22X1_RVT U7536 ( .A1(n4229), .A2(reg_out[12]), .A3(n4632), .A4(
        reg_next_pc[12]), .Y(n6215) );
  AO22X1_RVT U7537 ( .A1(n4323), .A2(pcpi_rs1[12]), .A3(n4053), .A4(n6215), 
        .Y(mem_la_addr[12]) );
  AO22X1_RVT U7538 ( .A1(n4794), .A2(mem_la_addr[12]), .A3(n6222), .A4(
        mem_addr[12]), .Y(n2564) );
  AO22X1_RVT U7539 ( .A1(n4323), .A2(pcpi_rs1[9]), .A3(n4053), .A4(n6934), .Y(
        mem_la_addr[9]) );
  AO22X1_RVT U7540 ( .A1(n4792), .A2(mem_la_addr[9]), .A3(n6222), .A4(
        mem_addr[9]), .Y(n2567) );
  AO22X1_RVT U7541 ( .A1(n6209), .A2(pcpi_rs1[13]), .A3(n4052), .A4(n6937), 
        .Y(mem_la_addr[13]) );
  AO22X1_RVT U7542 ( .A1(n4794), .A2(mem_la_addr[13]), .A3(n4791), .A4(
        mem_addr[13]), .Y(n2563) );
  AO22X1_RVT U7543 ( .A1(n4323), .A2(pcpi_rs1[25]), .A3(n4053), .A4(n6944), 
        .Y(mem_la_addr[25]) );
  AO22X1_RVT U7544 ( .A1(n4792), .A2(mem_la_addr[25]), .A3(n4796), .A4(
        mem_addr[25]), .Y(n2551) );
  AO22X1_RVT U7545 ( .A1(n4631), .A2(reg_out[16]), .A3(n4632), .A4(
        reg_next_pc[16]), .Y(n6216) );
  AO22X1_RVT U7546 ( .A1(n6209), .A2(pcpi_rs1[16]), .A3(n4053), .A4(n6216), 
        .Y(mem_la_addr[16]) );
  AO22X1_RVT U7547 ( .A1(n4793), .A2(mem_la_addr[16]), .A3(n4795), .A4(
        mem_addr[16]), .Y(n2560) );
  AO22X1_RVT U7548 ( .A1(n4323), .A2(pcpi_rs1[23]), .A3(n4053), .A4(n6217), 
        .Y(mem_la_addr[23]) );
  AO22X1_RVT U7549 ( .A1(n4794), .A2(mem_la_addr[23]), .A3(n4791), .A4(
        mem_addr[23]), .Y(n2553) );
  AO22X1_RVT U7550 ( .A1(n6209), .A2(pcpi_rs1[8]), .A3(n4052), .A4(n6933), .Y(
        mem_la_addr[8]) );
  AO22X1_RVT U7551 ( .A1(n4792), .A2(mem_la_addr[8]), .A3(n6222), .A4(
        mem_addr[8]), .Y(n2568) );
  AO22X1_RVT U7552 ( .A1(n4323), .A2(net30690), .A3(n4053), .A4(n6929), .Y(
        mem_la_addr[5]) );
  AO22X1_RVT U7553 ( .A1(n4793), .A2(mem_la_addr[5]), .A3(n4791), .A4(
        mem_addr[5]), .Y(n2571) );
  AO22X1_RVT U7554 ( .A1(n6209), .A2(net30702), .A3(n4052), .A4(n6930), .Y(
        mem_la_addr[6]) );
  AO22X1_RVT U7555 ( .A1(n4793), .A2(mem_la_addr[6]), .A3(n4796), .A4(
        mem_addr[6]), .Y(n2570) );
  AO22X1_RVT U7556 ( .A1(n4188), .A2(reg_out[19]), .A3(n4632), .A4(
        reg_next_pc[19]), .Y(n6218) );
  AO22X1_RVT U7557 ( .A1(n6209), .A2(pcpi_rs1[19]), .A3(n4053), .A4(n6218), 
        .Y(mem_la_addr[19]) );
  AO22X1_RVT U7558 ( .A1(n4794), .A2(mem_la_addr[19]), .A3(n6222), .A4(
        mem_addr[19]), .Y(n2557) );
  AO22X1_RVT U7559 ( .A1(n4323), .A2(pcpi_rs1[29]), .A3(n4052), .A4(n6947), 
        .Y(mem_la_addr[29]) );
  AO22X1_RVT U7560 ( .A1(n4794), .A2(mem_la_addr[29]), .A3(n4791), .A4(
        mem_addr[29]), .Y(n2547) );
  AO22X1_RVT U7561 ( .A1(n6209), .A2(pcpi_rs1[21]), .A3(n4053), .A4(n6942), 
        .Y(mem_la_addr[21]) );
  AO22X1_RVT U7562 ( .A1(n4794), .A2(mem_la_addr[21]), .A3(n4796), .A4(
        mem_addr[21]), .Y(n2555) );
  AO22X1_RVT U7563 ( .A1(n4323), .A2(pcpi_rs1[14]), .A3(n4052), .A4(n6938), 
        .Y(mem_la_addr[14]) );
  AO22X1_RVT U7564 ( .A1(n4792), .A2(mem_la_addr[14]), .A3(n4795), .A4(
        mem_addr[14]), .Y(n2562) );
  AO22X1_RVT U7565 ( .A1(n6209), .A2(pcpi_rs1[10]), .A3(n4053), .A4(n6935), 
        .Y(mem_la_addr[10]) );
  AO22X1_RVT U7566 ( .A1(n4792), .A2(mem_la_addr[10]), .A3(n4791), .A4(
        mem_addr[10]), .Y(n2566) );
  AO22X1_RVT U7567 ( .A1(n4765), .A2(n4603), .A3(n4520), .A4(\cpuregs[20][28] ), .Y(n3210) );
  AO22X1_RVT U7568 ( .A1(n4090), .A2(n4601), .A3(n4626), .A4(\cpuregs[21][28] ), .Y(n3242) );
  AO22X1_RVT U7569 ( .A1(n4775), .A2(n7950), .A3(n4522), .A4(\cpuregs[18][28] ), .Y(n3146) );
  AO22X1_RVT U7570 ( .A1(n4091), .A2(n4601), .A3(n4525), .A4(\cpuregs[17][28] ), .Y(n3114) );
  AO22X1_RVT U7571 ( .A1(n4071), .A2(n4602), .A3(n4627), .A4(\cpuregs[19][28] ), .Y(n3178) );
  AO22X1_RVT U7572 ( .A1(n4769), .A2(n4602), .A3(n4772), .A4(\cpuregs[22][28] ), .Y(n3274) );
  AND2X1_RVT U7573 ( .A1(n6221), .A2(count_cycle[34]), .Y(n6276) );
  AND2X1_RVT U7574 ( .A1(n6219), .A2(resetn), .Y(n6220) );
  OA21X1_RVT U7575 ( .A1(count_cycle[34]), .A2(n6221), .A3(n6220), .Y(N952) );
  AO22X1_RVT U7576 ( .A1(n4793), .A2(mem_la_addr[2]), .A3(n4796), .A4(
        mem_addr[2]), .Y(n2574) );
  AO22X1_RVT U7577 ( .A1(n4792), .A2(mem_la_addr[30]), .A3(n4796), .A4(
        mem_addr[30]), .Y(n2546) );
  AO22X1_RVT U7578 ( .A1(n4793), .A2(mem_la_addr[28]), .A3(n4795), .A4(
        mem_addr[28]), .Y(n2548) );
  AO22X1_RVT U7579 ( .A1(n4739), .A2(n4589), .A3(n4742), .A4(\cpuregs[3][17] ), 
        .Y(n2655) );
  AO22X1_RVT U7580 ( .A1(n4740), .A2(n4009), .A3(n4743), .A4(\cpuregs[3][11] ), 
        .Y(n2649) );
  AO22X1_RVT U7581 ( .A1(n4740), .A2(n4385), .A3(n4743), .A4(\cpuregs[3][26] ), 
        .Y(n2664) );
  AO22X1_RVT U7582 ( .A1(n4733), .A2(n4585), .A3(n4738), .A4(\cpuregs[1][11] ), 
        .Y(n2585) );
  AO22X1_RVT U7583 ( .A1(n4734), .A2(n4602), .A3(n4736), .A4(\cpuregs[1][28] ), 
        .Y(n2602) );
  AO22X1_RVT U7584 ( .A1(n4734), .A2(n4385), .A3(n4737), .A4(\cpuregs[1][26] ), 
        .Y(n2600) );
  AO22X1_RVT U7585 ( .A1(n4734), .A2(n4398), .A3(n4737), .A4(\cpuregs[1][0] ), 
        .Y(n2606) );
  AO22X1_RVT U7586 ( .A1(n4735), .A2(n4590), .A3(n4736), .A4(\cpuregs[1][17] ), 
        .Y(n2591) );
  AO22X1_RVT U7587 ( .A1(n4740), .A2(n7950), .A3(n4743), .A4(\cpuregs[3][28] ), 
        .Y(n2666) );
  AO22X1_RVT U7588 ( .A1(n4741), .A2(n4397), .A3(n4743), .A4(\cpuregs[3][0] ), 
        .Y(n2670) );
  AO22X1_RVT U7589 ( .A1(n4733), .A2(n4607), .A3(n4737), .A4(\cpuregs[1][2] ), 
        .Y(n2576) );
  AO22X1_RVT U7590 ( .A1(n4739), .A2(n4608), .A3(n4743), .A4(\cpuregs[3][2] ), 
        .Y(n2640) );
  AO22X1_RVT U7591 ( .A1(n4735), .A2(n7960), .A3(n4737), .A4(\cpuregs[1][10] ), 
        .Y(n2584) );
  AO22X1_RVT U7592 ( .A1(n4741), .A2(n4556), .A3(n4743), .A4(\cpuregs[3][10] ), 
        .Y(n2648) );
  AO22X1_RVT U7593 ( .A1(n4794), .A2(mem_la_addr[22]), .A3(n4796), .A4(
        mem_addr[22]), .Y(n2554) );
  AO22X1_RVT U7594 ( .A1(n4763), .A2(n4082), .A3(n4766), .A4(\cpuregs[20][29] ), .Y(n3211) );
  AO22X1_RVT U7595 ( .A1(n4790), .A2(n4082), .A3(n4625), .A4(\cpuregs[21][29] ), .Y(n3243) );
  AO22X1_RVT U7596 ( .A1(n4741), .A2(n4082), .A3(n4744), .A4(\cpuregs[3][29] ), 
        .Y(n2667) );
  AO22X1_RVT U7597 ( .A1(n4773), .A2(n4082), .A3(n4776), .A4(\cpuregs[18][29] ), .Y(n3147) );
  AO22X1_RVT U7598 ( .A1(n4077), .A2(n4604), .A3(n4526), .A4(\cpuregs[17][29] ), .Y(n3115) );
  AO22X1_RVT U7599 ( .A1(n4789), .A2(n4605), .A3(n4628), .A4(\cpuregs[19][29] ), .Y(n3179) );
  AO22X1_RVT U7600 ( .A1(n4735), .A2(n4082), .A3(n4738), .A4(\cpuregs[1][29] ), 
        .Y(n2603) );
  AO22X1_RVT U7601 ( .A1(n4767), .A2(n4082), .A3(n4770), .A4(\cpuregs[22][29] ), .Y(n3275) );
  AND3X1_RVT U7602 ( .A1(latched_rd[0]), .A2(n6308), .A3(n8015), .Y(n6297) );
  NAND2X0_RVT U7603 ( .A1(n6309), .A2(n6297), .Y(n6225) );
  INVX1_RVT U7604 ( .A(n6225), .Y(n6316) );
  AO22X1_RVT U7605 ( .A1(n4672), .A2(n4579), .A3(n4675), .A4(\cpuregs[15][6] ), 
        .Y(n3028) );
  AO22X1_RVT U7606 ( .A1(n4674), .A2(n6367), .A3(n4671), .A4(\cpuregs[15][15] ), .Y(n3037) );
  AO22X1_RVT U7607 ( .A1(n4673), .A2(n4586), .A3(n4675), .A4(\cpuregs[15][12] ), .Y(n3034) );
  AO22X1_RVT U7608 ( .A1(n4674), .A2(n7955), .A3(n6225), .A4(\cpuregs[15][21] ), .Y(n3043) );
  FADDX1_RVT U7609 ( .A(pcpi_rs1[16]), .B(n6227), .CI(n6226), .CO(n7576), .S(
        n6228) );
  NAND2X0_RVT U7610 ( .A1(n6228), .A2(n4528), .Y(n6233) );
  NAND2X0_RVT U7611 ( .A1(pcpi_rs1[16]), .A2(pcpi_rs2[16]), .Y(n6230) );
  OA22X1_RVT U7612 ( .A1(n6230), .A2(n4247), .A3(n6229), .A4(n4196), .Y(n6232)
         );
  AO21X1_RVT U7613 ( .A1(n7993), .A2(net16357), .A3(n7658), .Y(n6231) );
  NAND3X0_RVT U7614 ( .A1(n6233), .A2(n6232), .A3(n6231), .Y(alu_out[16]) );
  FADDX1_RVT U7615 ( .A(pcpi_rs1[10]), .B(n6235), .CI(n6234), .CO(n6393), .S(
        n6236) );
  NAND2X0_RVT U7616 ( .A1(n6236), .A2(n4529), .Y(n6241) );
  NAND2X0_RVT U7617 ( .A1(pcpi_rs1[10]), .A2(pcpi_rs2[10]), .Y(n6238) );
  OA22X1_RVT U7618 ( .A1(n6238), .A2(n4247), .A3(n6237), .A4(n4196), .Y(n6240)
         );
  AO21X1_RVT U7619 ( .A1(n7991), .A2(net16340), .A3(n7658), .Y(n6239) );
  NAND3X0_RVT U7620 ( .A1(n6241), .A2(n6240), .A3(n6239), .Y(alu_out[10]) );
  FADDX1_RVT U7621 ( .A(n4032), .B(n6243), .CI(n6242), .CO(n6251), .S(n6244)
         );
  NAND2X0_RVT U7622 ( .A1(n6244), .A2(n4529), .Y(n6249) );
  NAND2X0_RVT U7623 ( .A1(pcpi_rs1[18]), .A2(pcpi_rs2[18]), .Y(n6246) );
  OA22X1_RVT U7624 ( .A1(n6246), .A2(n4247), .A3(n6245), .A4(n6288), .Y(n6248)
         );
  AO21X1_RVT U7625 ( .A1(n7990), .A2(net16365), .A3(n7658), .Y(n6247) );
  NAND3X0_RVT U7626 ( .A1(n6249), .A2(n6248), .A3(n6247), .Y(alu_out[18]) );
  FADDX1_RVT U7627 ( .A(n8076), .B(n6251), .CI(n6250), .CO(n7561), .S(n6252)
         );
  NAND2X0_RVT U7628 ( .A1(n6252), .A2(n4529), .Y(n6257) );
  NAND2X0_RVT U7629 ( .A1(pcpi_rs1[19]), .A2(pcpi_rs2[19]), .Y(n6254) );
  OA22X1_RVT U7630 ( .A1(n6254), .A2(n4247), .A3(n6253), .A4(n4196), .Y(n6256)
         );
  AO21X1_RVT U7631 ( .A1(n8026), .A2(net16362), .A3(n7658), .Y(n6255) );
  NAND3X0_RVT U7632 ( .A1(n6257), .A2(n6256), .A3(n6255), .Y(alu_out[19]) );
  AO22X1_RVT U7633 ( .A1(n4672), .A2(n4600), .A3(n4675), .A4(\cpuregs[15][27] ), .Y(n3049) );
  FADDX1_RVT U7634 ( .A(n8081), .B(n6259), .CI(n6258), .CO(n6561), .S(n6260)
         );
  NAND2X0_RVT U7635 ( .A1(n6260), .A2(n4528), .Y(n6265) );
  NAND2X0_RVT U7636 ( .A1(pcpi_rs1[13]), .A2(pcpi_rs2[13]), .Y(n6262) );
  OA22X1_RVT U7637 ( .A1(n6262), .A2(n4247), .A3(n6261), .A4(n6288), .Y(n6264)
         );
  AO21X1_RVT U7638 ( .A1(n7989), .A2(net16341), .A3(n7658), .Y(n6263) );
  NAND3X0_RVT U7639 ( .A1(n6265), .A2(n6264), .A3(n6263), .Y(alu_out[13]) );
  NAND2X0_RVT U7640 ( .A1(n6300), .A2(n6297), .Y(n6266) );
  AO22X1_RVT U7641 ( .A1(n4025), .A2(n6366), .A3(n4023), .A4(\cpuregs[13][6] ), 
        .Y(n2964) );
  NAND2X0_RVT U7642 ( .A1(n6302), .A2(n6297), .Y(n6267) );
  AO22X1_RVT U7643 ( .A1(n4681), .A2(n4599), .A3(n4027), .A4(\cpuregs[11][27] ), .Y(n2921) );
  AO22X1_RVT U7644 ( .A1(n4680), .A2(n4016), .A3(n4026), .A4(\cpuregs[11][15] ), .Y(n2909) );
  AO22X1_RVT U7645 ( .A1(n4028), .A2(n4579), .A3(n4026), .A4(\cpuregs[11][6] ), 
        .Y(n2900) );
  AO22X1_RVT U7646 ( .A1(n4679), .A2(n4086), .A3(n4027), .A4(\cpuregs[11][21] ), .Y(n2915) );
  AO22X1_RVT U7647 ( .A1(n4028), .A2(n4586), .A3(n4027), .A4(\cpuregs[11][12] ), .Y(n2906) );
  AO22X1_RVT U7648 ( .A1(n6317), .A2(n4569), .A3(n4024), .A4(\cpuregs[13][21] ), .Y(n2979) );
  AO22X1_RVT U7649 ( .A1(n4025), .A2(n4587), .A3(n4024), .A4(\cpuregs[13][12] ), .Y(n2970) );
  AO22X1_RVT U7650 ( .A1(n4676), .A2(n6367), .A3(n4024), .A4(\cpuregs[13][15] ), .Y(n2973) );
  AO22X1_RVT U7651 ( .A1(n6317), .A2(n4599), .A3(n6266), .A4(\cpuregs[13][27] ), .Y(n2985) );
  FADDX1_RVT U7652 ( .A(pcpi_rs1[25]), .B(n6268), .CI(n6269), .CO(n6286), .S(
        n6270) );
  NAND2X0_RVT U7653 ( .A1(pcpi_rs1[25]), .A2(pcpi_rs2[25]), .Y(n6272) );
  OA22X1_RVT U7654 ( .A1(n6272), .A2(n4247), .A3(n6271), .A4(n4196), .Y(n6274)
         );
  AO21X1_RVT U7655 ( .A1(n8030), .A2(net16364), .A3(n7658), .Y(n6273) );
  NAND3X0_RVT U7656 ( .A1(n6275), .A2(n6274), .A3(n6273), .Y(alu_out[25]) );
  AO22X1_RVT U7657 ( .A1(n4734), .A2(n4550), .A3(n4736), .A4(\cpuregs[1][5] ), 
        .Y(n2579) );
  AO22X1_RVT U7658 ( .A1(n4739), .A2(n4552), .A3(n4742), .A4(\cpuregs[3][22] ), 
        .Y(n2660) );
  AO22X1_RVT U7659 ( .A1(n4740), .A2(n7963), .A3(n4744), .A4(\cpuregs[3][5] ), 
        .Y(n2643) );
  AO22X1_RVT U7660 ( .A1(n4733), .A2(n4567), .A3(n4738), .A4(\cpuregs[1][16] ), 
        .Y(n2590) );
  AO22X1_RVT U7661 ( .A1(n4741), .A2(n4567), .A3(n4742), .A4(\cpuregs[3][16] ), 
        .Y(n2654) );
  AO22X1_RVT U7662 ( .A1(n4735), .A2(n4553), .A3(n4737), .A4(\cpuregs[1][22] ), 
        .Y(n2596) );
  INVX0_RVT U7663 ( .A(n6294), .Y(n6277) );
  AND2X1_RVT U7664 ( .A1(resetn), .A2(n6277), .Y(n6278) );
  INVX1_RVT U7665 ( .A(n6279), .Y(n6281) );
  NAND2X0_RVT U7666 ( .A1(n6281), .A2(count_instr[62]), .Y(n7853) );
  AND2X1_RVT U7667 ( .A1(n7853), .A2(resetn), .Y(n6280) );
  OA21X1_RVT U7668 ( .A1(count_instr[62]), .A2(n6281), .A3(n6280), .Y(n3831)
         );
  AO22X1_RVT U7669 ( .A1(n4635), .A2(mem_rdata[9]), .A3(n4544), .A4(
        mem_rdata_q[9]), .Y(n2534) );
  AO22X1_RVT U7670 ( .A1(n4808), .A2(mem_rdata[11]), .A3(n4544), .A4(
        mem_rdata_q[11]), .Y(n2532) );
  AO22X1_RVT U7671 ( .A1(n4635), .A2(mem_rdata[10]), .A3(n5521), .A4(
        mem_rdata_q[10]), .Y(n2533) );
  AO22X1_RVT U7672 ( .A1(n4809), .A2(mem_rdata[7]), .A3(n5521), .A4(
        mem_rdata_q[7]), .Y(n2536) );
  AO22X1_RVT U7673 ( .A1(n4635), .A2(mem_rdata[8]), .A3(n4807), .A4(
        mem_rdata_q[8]), .Y(n2535) );
  HADDX1_RVT U7674 ( .A0(reg_pc[29]), .B0(n6282), .C1(n6513), .SO(n6067) );
  HADDX1_RVT U7675 ( .A0(n6283), .B0(reg_pc[31]), .SO(n6284) );
  AO22X1_RVT U7676 ( .A1(n6085), .A2(n4571), .A3(n4624), .A4(\cpuregs[21][31] ), .Y(n3245) );
  AO22X1_RVT U7677 ( .A1(n4740), .A2(n4572), .A3(n4742), .A4(\cpuregs[3][31] ), 
        .Y(n2669) );
  AO22X1_RVT U7678 ( .A1(n4785), .A2(n6525), .A3(n4783), .A4(\cpuregs[23][31] ), .Y(n3309) );
  AO22X1_RVT U7679 ( .A1(n6086), .A2(n4570), .A3(n4629), .A4(\cpuregs[19][31] ), .Y(n3181) );
  AO22X1_RVT U7680 ( .A1(n4646), .A2(n4572), .A3(n4526), .A4(\cpuregs[17][31] ), .Y(n3117) );
  AO22X1_RVT U7681 ( .A1(n4706), .A2(n4571), .A3(n4710), .A4(\cpuregs[6][31] ), 
        .Y(n2765) );
  AO22X1_RVT U7682 ( .A1(n4751), .A2(n4570), .A3(n4755), .A4(\cpuregs[7][31] ), 
        .Y(n2797) );
  AO22X1_RVT U7683 ( .A1(n4718), .A2(n6525), .A3(n4722), .A4(\cpuregs[4][31] ), 
        .Y(n2701) );
  AO22X1_RVT U7684 ( .A1(n4774), .A2(n4570), .A3(n4522), .A4(\cpuregs[18][31] ), .Y(n3149) );
  AO22X1_RVT U7685 ( .A1(n4724), .A2(n4570), .A3(n4728), .A4(\cpuregs[2][31] ), 
        .Y(n2637) );
  AO22X1_RVT U7686 ( .A1(n4764), .A2(n4572), .A3(n4520), .A4(\cpuregs[20][31] ), .Y(n3213) );
  AO22X1_RVT U7687 ( .A1(n4745), .A2(n6525), .A3(n4749), .A4(\cpuregs[5][31] ), 
        .Y(n2733) );
  AO22X1_RVT U7688 ( .A1(n4768), .A2(n6525), .A3(n4772), .A4(\cpuregs[22][31] ), .Y(n3277) );
  AO22X1_RVT U7689 ( .A1(n4734), .A2(n4572), .A3(n4736), .A4(\cpuregs[1][31] ), 
        .Y(n2605) );
  FADDX1_RVT U7690 ( .A(n8072), .B(n6286), .CI(n6285), .CO(n7517), .S(n6287)
         );
  NAND2X0_RVT U7691 ( .A1(pcpi_rs1[26]), .A2(pcpi_rs2[26]), .Y(n6290) );
  OA22X1_RVT U7692 ( .A1(n6290), .A2(n4247), .A3(n6289), .A4(n4196), .Y(n6292)
         );
  AO21X1_RVT U7693 ( .A1(n7995), .A2(net16339), .A3(n7658), .Y(n6291) );
  NAND3X0_RVT U7694 ( .A1(n6293), .A2(n6292), .A3(n6291), .Y(alu_out[26]) );
  AO22X1_RVT U7695 ( .A1(n4777), .A2(n4571), .A3(n4781), .A4(\cpuregs[16][31] ), .Y(n3085) );
  AND2X1_RVT U7696 ( .A1(n6294), .A2(count_cycle[36]), .Y(n6303) );
  INVX0_RVT U7697 ( .A(n6303), .Y(n6295) );
  AND2X1_RVT U7698 ( .A1(resetn), .A2(n6295), .Y(n6296) );
  AO22X1_RVT U7699 ( .A1(n4682), .A2(n4578), .A3(n4685), .A4(\cpuregs[9][6] ), 
        .Y(n2836) );
  AO22X1_RVT U7700 ( .A1(n4688), .A2(n4598), .A3(n4691), .A4(\cpuregs[28][27] ), .Y(n3465) );
  INVX1_RVT U7701 ( .A(n6349), .Y(n6357) );
  AO22X1_RVT U7702 ( .A1(n4694), .A2(n4598), .A3(n4697), .A4(\cpuregs[26][27] ), .Y(n3401) );
  AO22X1_RVT U7703 ( .A1(n4700), .A2(n4599), .A3(n4703), .A4(\cpuregs[30][27] ), .Y(n3529) );
  AO22X1_RVT U7704 ( .A1(n4088), .A2(n7958), .A3(n4617), .A4(\cpuregs[29][12] ), .Y(n3482) );
  AO22X1_RVT U7705 ( .A1(n4106), .A2(n7951), .A3(n4616), .A4(\cpuregs[29][27] ), .Y(n3497) );
  AO22X1_RVT U7706 ( .A1(n4731), .A2(n4101), .A3(n4615), .A4(\cpuregs[29][21] ), .Y(n3491) );
  AO22X1_RVT U7707 ( .A1(n4074), .A2(n4579), .A3(n4616), .A4(\cpuregs[29][6] ), 
        .Y(n3476) );
  AO22X1_RVT U7708 ( .A1(n4089), .A2(n7955), .A3(n4619), .A4(\cpuregs[27][21] ), .Y(n3427) );
  AO22X1_RVT U7709 ( .A1(n6461), .A2(n4600), .A3(n4619), .A4(\cpuregs[27][27] ), .Y(n3433) );
  AO22X1_RVT U7710 ( .A1(n4079), .A2(n4580), .A3(n4618), .A4(\cpuregs[27][6] ), 
        .Y(n3412) );
  AO22X1_RVT U7711 ( .A1(n4076), .A2(n4588), .A3(n4619), .A4(\cpuregs[27][12] ), .Y(n3418) );
  AO22X1_RVT U7712 ( .A1(n4089), .A2(n4016), .A3(n4619), .A4(\cpuregs[27][15] ), .Y(n3421) );
  AO22X1_RVT U7713 ( .A1(n4731), .A2(n4017), .A3(n4616), .A4(\cpuregs[29][15] ), .Y(n3485) );
  AO22X1_RVT U7714 ( .A1(n4075), .A2(n4086), .A3(n4622), .A4(\cpuregs[31][21] ), .Y(n3555) );
  AO22X1_RVT U7715 ( .A1(n4073), .A2(n7958), .A3(n4621), .A4(\cpuregs[31][12] ), .Y(n3546) );
  AO22X1_RVT U7716 ( .A1(n4105), .A2(n4016), .A3(n4622), .A4(\cpuregs[31][15] ), .Y(n3549) );
  AO22X1_RVT U7717 ( .A1(n4105), .A2(n4600), .A3(n4622), .A4(\cpuregs[31][27] ), .Y(n3561) );
  AO22X1_RVT U7718 ( .A1(n6462), .A2(n4580), .A3(n4623), .A4(\cpuregs[31][6] ), 
        .Y(n3540) );
  AO22X1_RVT U7719 ( .A1(n4654), .A2(n4567), .A3(n4656), .A4(\cpuregs[12][16] ), .Y(n2942) );
  AO22X1_RVT U7720 ( .A1(n4648), .A2(n4567), .A3(n4650), .A4(\cpuregs[8][16] ), 
        .Y(n2814) );
  AO22X1_RVT U7721 ( .A1(n4666), .A2(n6524), .A3(n4668), .A4(\cpuregs[10][16] ), .Y(n2878) );
  AND2X1_RVT U7722 ( .A1(resetn), .A2(n6304), .Y(n6305) );
  AO22X1_RVT U7723 ( .A1(n4665), .A2(n4580), .A3(n4668), .A4(\cpuregs[10][6] ), 
        .Y(n2868) );
  AO22X1_RVT U7724 ( .A1(n4653), .A2(n4017), .A3(n4656), .A4(\cpuregs[12][15] ), .Y(n2941) );
  AO22X1_RVT U7725 ( .A1(n4655), .A2(n4580), .A3(n4657), .A4(\cpuregs[12][6] ), 
        .Y(n2932) );
  AO22X1_RVT U7726 ( .A1(n4647), .A2(n4579), .A3(n4650), .A4(\cpuregs[8][6] ), 
        .Y(n2804) );
  AO22X1_RVT U7727 ( .A1(n4649), .A2(n4014), .A3(n4651), .A4(\cpuregs[8][15] ), 
        .Y(n2813) );
  AO22X1_RVT U7728 ( .A1(n4667), .A2(n4014), .A3(n4669), .A4(\cpuregs[10][15] ), .Y(n2877) );
  AO22X1_RVT U7729 ( .A1(n4655), .A2(n4571), .A3(n4658), .A4(\cpuregs[12][31] ), .Y(n2957) );
  AO22X1_RVT U7730 ( .A1(n4654), .A2(n4590), .A3(n4657), .A4(\cpuregs[12][17] ), .Y(n2943) );
  AO22X1_RVT U7731 ( .A1(n4653), .A2(n4552), .A3(n4657), .A4(\cpuregs[12][22] ), .Y(n2948) );
  AO22X1_RVT U7732 ( .A1(n4660), .A2(n4567), .A3(n4662), .A4(\cpuregs[14][16] ), .Y(n3006) );
  AO22X1_RVT U7733 ( .A1(n4649), .A2(n4078), .A3(n4652), .A4(\cpuregs[8][22] ), 
        .Y(n2820) );
  AO22X1_RVT U7734 ( .A1(n4665), .A2(n4571), .A3(n4670), .A4(\cpuregs[10][31] ), .Y(n2893) );
  AO22X1_RVT U7735 ( .A1(n4647), .A2(n4572), .A3(n4651), .A4(\cpuregs[8][31] ), 
        .Y(n2829) );
  AO22X1_RVT U7736 ( .A1(n4648), .A2(n4590), .A3(n4651), .A4(\cpuregs[8][17] ), 
        .Y(n2815) );
  AO22X1_RVT U7737 ( .A1(n4665), .A2(n4085), .A3(n4669), .A4(\cpuregs[10][22] ), .Y(n2884) );
  AO22X1_RVT U7738 ( .A1(n4666), .A2(n4590), .A3(n4669), .A4(\cpuregs[10][17] ), .Y(n2879) );
  AO22X1_RVT U7739 ( .A1(n4659), .A2(n4016), .A3(n4662), .A4(\cpuregs[14][15] ), .Y(n3005) );
  AO22X1_RVT U7740 ( .A1(n4661), .A2(n4580), .A3(n4663), .A4(\cpuregs[14][6] ), 
        .Y(n2996) );
  AO22X1_RVT U7741 ( .A1(n4661), .A2(n4553), .A3(n4664), .A4(\cpuregs[14][22] ), .Y(n3012) );
  AO22X1_RVT U7742 ( .A1(n4659), .A2(n4572), .A3(n4663), .A4(\cpuregs[14][31] ), .Y(n3021) );
  AO22X1_RVT U7743 ( .A1(n4660), .A2(n4591), .A3(n4663), .A4(\cpuregs[14][17] ), .Y(n3007) );
  AO22X1_RVT U7744 ( .A1(n4672), .A2(n4568), .A3(n4671), .A4(\cpuregs[15][16] ), .Y(n3038) );
  AO22X1_RVT U7745 ( .A1(n4673), .A2(n4591), .A3(n4671), .A4(\cpuregs[15][17] ), .Y(n3039) );
  AO22X1_RVT U7746 ( .A1(n4674), .A2(n4082), .A3(n4675), .A4(\cpuregs[15][29] ), .Y(n3051) );
  AO22X1_RVT U7747 ( .A1(n4672), .A2(n4547), .A3(n6225), .A4(\cpuregs[15][0] ), 
        .Y(n3054) );
  AO22X1_RVT U7748 ( .A1(n4673), .A2(n4572), .A3(n4671), .A4(\cpuregs[15][31] ), .Y(n3053) );
  AO22X1_RVT U7749 ( .A1(n4673), .A2(n4555), .A3(n6225), .A4(\cpuregs[15][10] ), .Y(n3032) );
  AO22X1_RVT U7750 ( .A1(n4674), .A2(n4603), .A3(n6225), .A4(\cpuregs[15][28] ), .Y(n3050) );
  AO22X1_RVT U7751 ( .A1(n4674), .A2(n7966), .A3(n4671), .A4(\cpuregs[15][2] ), 
        .Y(n3024) );
  AO22X1_RVT U7752 ( .A1(n4673), .A2(n4550), .A3(n4675), .A4(\cpuregs[15][5] ), 
        .Y(n3027) );
  AO22X1_RVT U7753 ( .A1(n4674), .A2(n4565), .A3(n6225), .A4(\cpuregs[15][26] ), .Y(n3048) );
  AO22X1_RVT U7754 ( .A1(n4672), .A2(n4585), .A3(n6225), .A4(\cpuregs[15][11] ), .Y(n3033) );
  AO22X1_RVT U7755 ( .A1(n4672), .A2(n4554), .A3(n4671), .A4(\cpuregs[15][22] ), .Y(n3044) );
  AO22X1_RVT U7756 ( .A1(n4025), .A2(n4092), .A3(n4022), .A4(\cpuregs[13][11] ), .Y(n2969) );
  AO22X1_RVT U7757 ( .A1(n4678), .A2(n6524), .A3(n4024), .A4(\cpuregs[13][16] ), .Y(n2974) );
  AO22X1_RVT U7758 ( .A1(n4676), .A2(n4547), .A3(n4022), .A4(\cpuregs[13][0] ), 
        .Y(n2990) );
  AO22X1_RVT U7759 ( .A1(n4677), .A2(n4570), .A3(n4022), .A4(\cpuregs[13][31] ), .Y(n2989) );
  AO22X1_RVT U7760 ( .A1(n4028), .A2(n4604), .A3(n4027), .A4(\cpuregs[11][29] ), .Y(n2923) );
  AO22X1_RVT U7761 ( .A1(n6318), .A2(n4601), .A3(n4029), .A4(\cpuregs[11][28] ), .Y(n2922) );
  AO22X1_RVT U7762 ( .A1(n6318), .A2(n4571), .A3(n4029), .A4(\cpuregs[11][31] ), .Y(n2925) );
  AO22X1_RVT U7763 ( .A1(n4680), .A2(n4555), .A3(n4030), .A4(\cpuregs[11][10] ), .Y(n2904) );
  AO22X1_RVT U7764 ( .A1(n4028), .A2(n4114), .A3(n4029), .A4(\cpuregs[11][5] ), 
        .Y(n2899) );
  AO22X1_RVT U7765 ( .A1(n4680), .A2(n4398), .A3(n4027), .A4(\cpuregs[11][0] ), 
        .Y(n2926) );
  AO22X1_RVT U7766 ( .A1(n4679), .A2(n4109), .A3(n4029), .A4(\cpuregs[11][11] ), .Y(n2905) );
  AO22X1_RVT U7767 ( .A1(n4680), .A2(n4551), .A3(n4026), .A4(\cpuregs[11][22] ), .Y(n2916) );
  AO22X1_RVT U7768 ( .A1(n4680), .A2(n4566), .A3(n4026), .A4(\cpuregs[11][16] ), .Y(n2910) );
  AO22X1_RVT U7769 ( .A1(n4679), .A2(n4607), .A3(n4029), .A4(\cpuregs[11][2] ), 
        .Y(n2896) );
  AO22X1_RVT U7770 ( .A1(n4679), .A2(n4564), .A3(n4030), .A4(\cpuregs[11][26] ), .Y(n2920) );
  AO22X1_RVT U7771 ( .A1(n4680), .A2(n4590), .A3(n4030), .A4(\cpuregs[11][17] ), .Y(n2911) );
  AO22X1_RVT U7772 ( .A1(n4025), .A2(n4550), .A3(n4024), .A4(\cpuregs[13][5] ), 
        .Y(n2963) );
  AO22X1_RVT U7773 ( .A1(n4676), .A2(n4608), .A3(n4022), .A4(\cpuregs[13][2] ), 
        .Y(n2960) );
  AO22X1_RVT U7774 ( .A1(n4025), .A2(n4603), .A3(n4022), .A4(\cpuregs[13][28] ), .Y(n2986) );
  AO22X1_RVT U7775 ( .A1(n4025), .A2(n4385), .A3(n4022), .A4(\cpuregs[13][26] ), .Y(n2984) );
  AO22X1_RVT U7776 ( .A1(n4677), .A2(n4556), .A3(n4022), .A4(\cpuregs[13][10] ), .Y(n2968) );
  AO22X1_RVT U7777 ( .A1(n4025), .A2(n4605), .A3(n4024), .A4(\cpuregs[13][29] ), .Y(n2987) );
  AO22X1_RVT U7778 ( .A1(n6317), .A2(n4552), .A3(n4022), .A4(\cpuregs[13][22] ), .Y(n2980) );
  AO22X1_RVT U7779 ( .A1(n6317), .A2(n4590), .A3(n6266), .A4(\cpuregs[13][17] ), .Y(n2975) );
  AO22X1_RVT U7780 ( .A1(\cpuregs[8][1] ), .A2(n7226), .A3(\cpuregs[4][1] ), 
        .A4(n4838), .Y(n6339) );
  AO22X1_RVT U7781 ( .A1(\cpuregs[16][1] ), .A2(n7227), .A3(\cpuregs[24][1] ), 
        .A4(n7228), .Y(n6320) );
  OR2X1_RVT U7782 ( .A1(n6320), .A2(n6319), .Y(n6321) );
  AO22X1_RVT U7783 ( .A1(\cpuregs[22][1] ), .A2(n4495), .A3(\cpuregs[9][1] ), 
        .A4(n4468), .Y(n6325) );
  AO22X1_RVT U7784 ( .A1(\cpuregs[11][1] ), .A2(n4474), .A3(\cpuregs[17][1] ), 
        .A4(n4492), .Y(n6324) );
  AO22X1_RVT U7785 ( .A1(\cpuregs[15][1] ), .A2(n4489), .A3(\cpuregs[3][1] ), 
        .A4(n7376), .Y(n6323) );
  AO22X1_RVT U7786 ( .A1(\cpuregs[25][1] ), .A2(n4480), .A3(\cpuregs[13][1] ), 
        .A4(n4452), .Y(n6322) );
  NOR4X1_RVT U7787 ( .A1(n6325), .A2(n6324), .A3(n6323), .A4(n6322), .Y(n6336)
         );
  AO22X1_RVT U7788 ( .A1(\cpuregs[23][1] ), .A2(n4443), .A3(\cpuregs[29][1] ), 
        .A4(n4507), .Y(n6329) );
  AO22X1_RVT U7789 ( .A1(\cpuregs[31][1] ), .A2(n4465), .A3(\cpuregs[21][1] ), 
        .A4(n4446), .Y(n6328) );
  AO22X1_RVT U7790 ( .A1(\cpuregs[27][1] ), .A2(n4455), .A3(\cpuregs[30][1] ), 
        .A4(n4501), .Y(n6327) );
  AO22X1_RVT U7791 ( .A1(\cpuregs[6][1] ), .A2(n4458), .A3(\cpuregs[18][1] ), 
        .A4(n4504), .Y(n6326) );
  NOR4X1_RVT U7792 ( .A1(n6329), .A2(n6328), .A3(n6327), .A4(n6326), .Y(n6335)
         );
  AO22X1_RVT U7793 ( .A1(\cpuregs[2][1] ), .A2(n4464), .A3(\cpuregs[26][1] ), 
        .A4(n4510), .Y(n6333) );
  AO22X1_RVT U7794 ( .A1(\cpuregs[14][1] ), .A2(n4471), .A3(\cpuregs[7][1] ), 
        .A4(n4437), .Y(n6332) );
  AO22X1_RVT U7795 ( .A1(\cpuregs[5][1] ), .A2(n4477), .A3(\cpuregs[10][1] ), 
        .A4(n4461), .Y(n6331) );
  AO22X1_RVT U7796 ( .A1(\cpuregs[19][1] ), .A2(n4498), .A3(\cpuregs[1][1] ), 
        .A4(n4483), .Y(n6330) );
  NOR4X1_RVT U7797 ( .A1(n6333), .A2(n6332), .A3(n6331), .A4(n6330), .Y(n6334)
         );
  NAND3X0_RVT U7798 ( .A1(n6336), .A2(n6335), .A3(n6334), .Y(n6337) );
  AO221X1_RVT U7799 ( .A1(n4312), .A2(n6339), .A3(n4312), .A4(n6338), .A5(
        n6337), .Y(n6340) );
  NAND2X0_RVT U7800 ( .A1(n7253), .A2(n6340), .Y(n7203) );
  NAND2X0_RVT U7801 ( .A1(decoded_imm_j[1]), .A2(n7684), .Y(n6343) );
  NAND2X0_RVT U7802 ( .A1(n4291), .A2(n8053), .Y(n6341) );
  NAND3X0_RVT U7803 ( .A1(N1600), .A2(n4535), .A3(n6341), .Y(n6342) );
  AND2X1_RVT U7804 ( .A1(n6344), .A2(count_cycle[38]), .Y(n6373) );
  AND2X1_RVT U7805 ( .A1(resetn), .A2(n6345), .Y(n6346) );
  OA21X1_RVT U7806 ( .A1(count_cycle[38]), .A2(n6344), .A3(n6346), .Y(N956) );
  AO22X1_RVT U7807 ( .A1(n4809), .A2(mem_rdata[0]), .A3(n4807), .A4(
        mem_rdata_q[0]), .Y(n2511) );
  AO22X1_RVT U7808 ( .A1(n4808), .A2(mem_rdata[1]), .A3(n4807), .A4(
        mem_rdata_q[1]), .Y(n2542) );
  NAND2X0_RVT U7809 ( .A1(n2541), .A2(n2540), .Y(n6347) );
  NAND4X0_RVT U7810 ( .A1(n6363), .A2(n6368), .A3(n2537), .A4(n2538), .Y(n6352) );
  OAI22X1_RVT U7811 ( .A1(n6354), .A2(n8042), .A3(n6347), .A4(n6352), .Y(n3691) );
  AO22X1_RVT U7812 ( .A1(n4684), .A2(n7958), .A3(n4687), .A4(\cpuregs[9][12] ), 
        .Y(n2842) );
  AO22X1_RVT U7813 ( .A1(n4683), .A2(n6367), .A3(n4686), .A4(\cpuregs[9][15] ), 
        .Y(n2845) );
  AO22X1_RVT U7814 ( .A1(n4684), .A2(n4598), .A3(n4686), .A4(\cpuregs[9][27] ), 
        .Y(n2857) );
  AO22X1_RVT U7815 ( .A1(n4682), .A2(n4569), .A3(n4685), .A4(\cpuregs[9][21] ), 
        .Y(n2851) );
  AO22X1_RVT U7816 ( .A1(n4696), .A2(n4016), .A3(n4697), .A4(\cpuregs[26][15] ), .Y(n3389) );
  AO22X1_RVT U7817 ( .A1(n4690), .A2(n4014), .A3(n4691), .A4(\cpuregs[28][15] ), .Y(n3453) );
  AO22X1_RVT U7818 ( .A1(n4695), .A2(n6366), .A3(n4698), .A4(\cpuregs[26][6] ), 
        .Y(n3380) );
  AO22X1_RVT U7819 ( .A1(n4689), .A2(n4579), .A3(n4692), .A4(\cpuregs[28][6] ), 
        .Y(n3444) );
  AO22X1_RVT U7820 ( .A1(n4702), .A2(n4580), .A3(n4703), .A4(\cpuregs[30][6] ), 
        .Y(n3508) );
  AO22X1_RVT U7821 ( .A1(n4701), .A2(n4014), .A3(n4705), .A4(\cpuregs[30][15] ), .Y(n3517) );
  NAND2X0_RVT U7822 ( .A1(resetn), .A2(is_beq_bne_blt_bge_bltu_bgeu), .Y(n6353) );
  OR2X1_RVT U7823 ( .A1(n2540), .A2(n6352), .Y(n6429) );
  OAI22X1_RVT U7824 ( .A1(n6354), .A2(n6353), .A3(n2541), .A4(n6429), .Y(n3742) );
  AO22X1_RVT U7825 ( .A1(n4682), .A2(n4563), .A3(n4686), .A4(\cpuregs[9][26] ), 
        .Y(n2856) );
  AO22X1_RVT U7826 ( .A1(n4683), .A2(n4397), .A3(n4687), .A4(\cpuregs[9][0] ), 
        .Y(n2862) );
  AO22X1_RVT U7827 ( .A1(n4683), .A2(n4601), .A3(n4685), .A4(\cpuregs[9][28] ), 
        .Y(n2858) );
  AO22X1_RVT U7828 ( .A1(n4683), .A2(n4606), .A3(n4686), .A4(\cpuregs[9][2] ), 
        .Y(n2832) );
  AO22X1_RVT U7829 ( .A1(n4684), .A2(n7949), .A3(n4687), .A4(\cpuregs[9][29] ), 
        .Y(n2859) );
  AO22X1_RVT U7830 ( .A1(n4682), .A2(n4114), .A3(n4686), .A4(\cpuregs[9][5] ), 
        .Y(n2835) );
  AO22X1_RVT U7831 ( .A1(n4684), .A2(n7960), .A3(n4687), .A4(\cpuregs[9][10] ), 
        .Y(n2840) );
  AO22X1_RVT U7832 ( .A1(n4684), .A2(n7959), .A3(n4685), .A4(\cpuregs[9][11] ), 
        .Y(n2841) );
  AO22X1_RVT U7833 ( .A1(n4683), .A2(n4590), .A3(n4685), .A4(\cpuregs[9][17] ), 
        .Y(n2847) );
  AO22X1_RVT U7834 ( .A1(n4682), .A2(n4085), .A3(n4687), .A4(\cpuregs[9][22] ), 
        .Y(n2852) );
  AO22X1_RVT U7835 ( .A1(n4684), .A2(n6524), .A3(n4685), .A4(\cpuregs[9][16] ), 
        .Y(n2846) );
  AO22X1_RVT U7836 ( .A1(n4683), .A2(n6525), .A3(n4685), .A4(\cpuregs[9][31] ), 
        .Y(n2861) );
  AO22X1_RVT U7837 ( .A1(n4688), .A2(n4397), .A3(n4693), .A4(\cpuregs[28][0] ), 
        .Y(n3470) );
  AO22X1_RVT U7838 ( .A1(n4689), .A2(n4566), .A3(n4691), .A4(\cpuregs[28][16] ), .Y(n3454) );
  AO22X1_RVT U7839 ( .A1(n4689), .A2(n7966), .A3(n4693), .A4(\cpuregs[28][2] ), 
        .Y(n3440) );
  AO22X1_RVT U7840 ( .A1(n4689), .A2(n7959), .A3(n4692), .A4(\cpuregs[28][11] ), .Y(n3449) );
  AO22X1_RVT U7841 ( .A1(n4690), .A2(n4555), .A3(n4692), .A4(\cpuregs[28][10] ), .Y(n3448) );
  AO22X1_RVT U7842 ( .A1(n4690), .A2(n7963), .A3(n4693), .A4(\cpuregs[28][5] ), 
        .Y(n3443) );
  AO22X1_RVT U7843 ( .A1(n4688), .A2(n7950), .A3(n4691), .A4(\cpuregs[28][28] ), .Y(n3466) );
  AO22X1_RVT U7844 ( .A1(n4688), .A2(n4604), .A3(n4693), .A4(\cpuregs[28][29] ), .Y(n3467) );
  AO22X1_RVT U7845 ( .A1(n4694), .A2(n4604), .A3(n4697), .A4(\cpuregs[26][29] ), .Y(n3403) );
  AO22X1_RVT U7846 ( .A1(n4695), .A2(n4601), .A3(n4699), .A4(\cpuregs[26][28] ), .Y(n3402) );
  AO22X1_RVT U7847 ( .A1(n4696), .A2(n4568), .A3(n4699), .A4(\cpuregs[26][16] ), .Y(n3390) );
  AO22X1_RVT U7848 ( .A1(n4695), .A2(n4397), .A3(n4698), .A4(\cpuregs[26][0] ), 
        .Y(n3406) );
  AO22X1_RVT U7849 ( .A1(n4695), .A2(n4550), .A3(n4699), .A4(\cpuregs[26][5] ), 
        .Y(n3379) );
  AO22X1_RVT U7850 ( .A1(n4694), .A2(n4555), .A3(n4697), .A4(\cpuregs[26][10] ), .Y(n3384) );
  AO22X1_RVT U7851 ( .A1(n4696), .A2(n4606), .A3(n4698), .A4(\cpuregs[26][2] ), 
        .Y(n3376) );
  AO22X1_RVT U7852 ( .A1(n4694), .A2(n4092), .A3(n4699), .A4(\cpuregs[26][11] ), .Y(n3385) );
  AO22X1_RVT U7853 ( .A1(n4700), .A2(n4605), .A3(n4703), .A4(\cpuregs[30][29] ), .Y(n3531) );
  AO22X1_RVT U7854 ( .A1(n4701), .A2(n4602), .A3(n4703), .A4(\cpuregs[30][28] ), .Y(n3530) );
  AO22X1_RVT U7855 ( .A1(n4702), .A2(n6524), .A3(n4705), .A4(\cpuregs[30][16] ), .Y(n3518) );
  AO22X1_RVT U7856 ( .A1(n4701), .A2(n7966), .A3(n4704), .A4(\cpuregs[30][2] ), 
        .Y(n3504) );
  AO22X1_RVT U7857 ( .A1(n4701), .A2(n4398), .A3(n4705), .A4(\cpuregs[30][0] ), 
        .Y(n3534) );
  AO22X1_RVT U7858 ( .A1(n4702), .A2(n7959), .A3(n4705), .A4(\cpuregs[30][11] ), .Y(n3513) );
  AO22X1_RVT U7859 ( .A1(n4700), .A2(n4008), .A3(n4704), .A4(\cpuregs[30][5] ), 
        .Y(n3507) );
  AO22X1_RVT U7860 ( .A1(n4700), .A2(n4557), .A3(n4704), .A4(\cpuregs[30][10] ), .Y(n3512) );
  AO22X1_RVT U7861 ( .A1(n4757), .A2(n7951), .A3(n4760), .A4(\cpuregs[25][27] ), .Y(n3369) );
  AO22X1_RVT U7862 ( .A1(n4759), .A2(n7958), .A3(n4761), .A4(\cpuregs[25][12] ), .Y(n3354) );
  AO22X1_RVT U7863 ( .A1(n4758), .A2(n4578), .A3(n4762), .A4(\cpuregs[25][6] ), 
        .Y(n3348) );
  AO22X1_RVT U7864 ( .A1(n4759), .A2(n4101), .A3(n4762), .A4(\cpuregs[25][21] ), .Y(n3363) );
  AO22X1_RVT U7865 ( .A1(n4757), .A2(n6367), .A3(n4760), .A4(\cpuregs[25][15] ), .Y(n3357) );
  NAND2X0_RVT U7866 ( .A1(n6363), .A2(n2538), .Y(n6362) );
  NAND4X0_RVT U7867 ( .A1(n6361), .A2(n6370), .A3(n6369), .A4(n6368), .Y(n6455) );
  OAI22X1_RVT U7868 ( .A1(n6354), .A2(n8047), .A3(n6362), .A4(n6455), .Y(n3678) );
  NAND2X0_RVT U7869 ( .A1(n6371), .A2(n6363), .Y(n6364) );
  OAI22X1_RVT U7870 ( .A1(n6354), .A2(n7984), .A3(n6455), .A4(n6364), .Y(n3684) );
  AO22X1_RVT U7871 ( .A1(n4712), .A2(n4101), .A3(n4715), .A4(\cpuregs[24][21] ), .Y(n3331) );
  AO22X1_RVT U7872 ( .A1(n4714), .A2(n4588), .A3(n4716), .A4(\cpuregs[24][12] ), .Y(n3322) );
  AO22X1_RVT U7873 ( .A1(n4713), .A2(n4580), .A3(n4717), .A4(\cpuregs[24][6] ), 
        .Y(n3316) );
  AO22X1_RVT U7874 ( .A1(n4714), .A2(n4017), .A3(n4716), .A4(\cpuregs[24][15] ), .Y(n3325) );
  AND4X1_RVT U7875 ( .A1(n6370), .A2(n6369), .A3(n6368), .A4(n2541), .Y(n6372)
         );
  AND2X1_RVT U7876 ( .A1(n6371), .A2(n2539), .Y(n6458) );
  AO22X1_RVT U7877 ( .A1(instr_auipc), .A2(n4539), .A3(n6372), .A4(n6458), .Y(
        n3693) );
  AND2X1_RVT U7878 ( .A1(n2538), .A2(n2539), .Y(n6457) );
  AO22X1_RVT U7879 ( .A1(n4540), .A2(instr_lui), .A3(n6457), .A4(n6372), .Y(
        n3694) );
  AND2X1_RVT U7880 ( .A1(n6374), .A2(resetn), .Y(n6375) );
  OA21X1_RVT U7881 ( .A1(count_cycle[39]), .A2(n6373), .A3(n6375), .Y(N957) );
  FADDX1_RVT U7882 ( .A(pcpi_rs1[21]), .B(n6376), .CI(n6377), .CO(n7549), .S(
        n6378) );
  NAND2X0_RVT U7883 ( .A1(pcpi_rs1[21]), .A2(pcpi_rs2[21]), .Y(n6380) );
  OA22X1_RVT U7884 ( .A1(n6380), .A2(n4247), .A3(n6379), .A4(n4196), .Y(n6382)
         );
  AO21X1_RVT U7885 ( .A1(n8027), .A2(net16453), .A3(n7658), .Y(n6381) );
  NAND3X0_RVT U7886 ( .A1(n6383), .A2(n6382), .A3(n6381), .Y(alu_out[21]) );
  FADDX1_RVT U7887 ( .A(n8086), .B(n6384), .CI(n6385), .CO(n7623), .S(n6386)
         );
  NAND2X0_RVT U7888 ( .A1(n6386), .A2(n4529), .Y(n6391) );
  NAND2X0_RVT U7889 ( .A1(n8086), .A2(pcpi_rs2[8]), .Y(n6388) );
  OA22X1_RVT U7890 ( .A1(n6388), .A2(n4247), .A3(n6387), .A4(n4196), .Y(n6390)
         );
  AO21X1_RVT U7891 ( .A1(n7992), .A2(net16337), .A3(n7658), .Y(n6389) );
  NAND3X0_RVT U7892 ( .A1(n6391), .A2(n6390), .A3(n6389), .Y(alu_out[8]) );
  FADDX1_RVT U7893 ( .A(n8083), .B(n6393), .CI(n6392), .CO(n7607), .S(n6394)
         );
  NAND2X0_RVT U7894 ( .A1(n6394), .A2(n4529), .Y(n6399) );
  NAND2X0_RVT U7895 ( .A1(net30668), .A2(pcpi_rs2[11]), .Y(n6396) );
  OA22X1_RVT U7896 ( .A1(n6396), .A2(n4247), .A3(n6395), .A4(n6288), .Y(n6398)
         );
  AO21X1_RVT U7897 ( .A1(n7972), .A2(net16317), .A3(n7658), .Y(n6397) );
  NAND3X0_RVT U7898 ( .A1(n6399), .A2(n6398), .A3(n6397), .Y(alu_out[11]) );
  FADDX1_RVT U7899 ( .A(pcpi_rs1[28]), .B(n6400), .CI(n6401), .CO(n7506), .S(
        n6402) );
  NAND2X0_RVT U7900 ( .A1(n6402), .A2(n4529), .Y(n6407) );
  OA22X1_RVT U7901 ( .A1(n6404), .A2(n7658), .A3(n6288), .A4(n6403), .Y(n6406)
         );
  NAND3X0_RVT U7902 ( .A1(pcpi_rs2[28]), .A2(pcpi_rs1[28]), .A3(n6412), .Y(
        n6405) );
  NAND3X0_RVT U7903 ( .A1(n6407), .A2(n6406), .A3(n6405), .Y(alu_out[28]) );
  FADDX1_RVT U7904 ( .A(n8088), .B(net24864), .CI(n6408), .CO(n6553), .S(n6409) );
  NAND2X0_RVT U7905 ( .A1(n6409), .A2(n4528), .Y(n6415) );
  OA22X1_RVT U7906 ( .A1(n6411), .A2(n7658), .A3(n6288), .A4(n6410), .Y(n6414)
         );
  NAND3X0_RVT U7907 ( .A1(n6415), .A2(n6414), .A3(n6413), .Y(alu_out[6]) );
  AO22X1_RVT U7908 ( .A1(n4696), .A2(n4563), .A3(n4698), .A4(\cpuregs[26][26] ), .Y(n3400) );
  AO22X1_RVT U7909 ( .A1(n4696), .A2(n4078), .A3(n4699), .A4(\cpuregs[26][22] ), .Y(n3396) );
  AO22X1_RVT U7910 ( .A1(n4695), .A2(n4570), .A3(n4697), .A4(\cpuregs[26][31] ), .Y(n3405) );
  AO22X1_RVT U7911 ( .A1(n4695), .A2(n4591), .A3(n4699), .A4(\cpuregs[26][17] ), .Y(n3391) );
  AO22X1_RVT U7912 ( .A1(n4696), .A2(n4586), .A3(n4698), .A4(\cpuregs[26][12] ), .Y(n3386) );
  AO22X1_RVT U7913 ( .A1(n4694), .A2(n4569), .A3(n4699), .A4(\cpuregs[26][21] ), .Y(n3395) );
  AO22X1_RVT U7914 ( .A1(n4690), .A2(n4570), .A3(n4692), .A4(\cpuregs[28][31] ), .Y(n3469) );
  AO22X1_RVT U7915 ( .A1(n4689), .A2(n4078), .A3(n4693), .A4(\cpuregs[28][22] ), .Y(n3460) );
  AO22X1_RVT U7916 ( .A1(n4690), .A2(n4564), .A3(n4691), .A4(\cpuregs[28][26] ), .Y(n3464) );
  AO22X1_RVT U7917 ( .A1(n4689), .A2(n4591), .A3(n4693), .A4(\cpuregs[28][17] ), .Y(n3455) );
  AO22X1_RVT U7918 ( .A1(n4690), .A2(n4086), .A3(n4692), .A4(\cpuregs[28][21] ), .Y(n3459) );
  AO22X1_RVT U7919 ( .A1(n4688), .A2(n4587), .A3(n4693), .A4(\cpuregs[28][12] ), .Y(n3450) );
  AO22X1_RVT U7920 ( .A1(n4702), .A2(n4563), .A3(n4704), .A4(\cpuregs[30][26] ), .Y(n3528) );
  AO22X1_RVT U7921 ( .A1(n4702), .A2(n4571), .A3(n4705), .A4(\cpuregs[30][31] ), .Y(n3533) );
  AO22X1_RVT U7922 ( .A1(n4702), .A2(n4586), .A3(n4703), .A4(\cpuregs[30][12] ), .Y(n3514) );
  AO22X1_RVT U7923 ( .A1(n4700), .A2(n4101), .A3(n4705), .A4(\cpuregs[30][21] ), .Y(n3523) );
  AO22X1_RVT U7924 ( .A1(n4701), .A2(n4078), .A3(n4704), .A4(\cpuregs[30][22] ), .Y(n3524) );
  AO22X1_RVT U7925 ( .A1(n4701), .A2(n6523), .A3(n4705), .A4(\cpuregs[30][17] ), .Y(n3519) );
  AO22X1_RVT U7926 ( .A1(n4713), .A2(n7966), .A3(n4715), .A4(\cpuregs[24][2] ), 
        .Y(n3312) );
  AO22X1_RVT U7927 ( .A1(n4714), .A2(n4565), .A3(n4716), .A4(\cpuregs[24][26] ), .Y(n3336) );
  AO22X1_RVT U7928 ( .A1(n4712), .A2(n4082), .A3(n4717), .A4(\cpuregs[24][29] ), .Y(n3339) );
  AO22X1_RVT U7929 ( .A1(n4713), .A2(n4603), .A3(n4716), .A4(\cpuregs[24][28] ), .Y(n3338) );
  AO22X1_RVT U7930 ( .A1(n4714), .A2(n4397), .A3(n4715), .A4(\cpuregs[24][0] ), 
        .Y(n3342) );
  NAND3X0_RVT U7931 ( .A1(is_compare), .A2(n6418), .A3(n7976), .Y(n6428) );
  NAND2X0_RVT U7932 ( .A1(n8094), .A2(pcpi_rs2[0]), .Y(n6419) );
  OA22X1_RVT U7933 ( .A1(n6421), .A2(n7658), .A3(n4247), .A4(n6419), .Y(n6427)
         );
  OR2X1_RVT U7934 ( .A1(n6422), .A2(n6288), .Y(n6426) );
  FADDX1_RVT U7935 ( .A(instr_sub), .B(n6423), .CI(n8094), .CO(n6546), .S(
        n6424) );
  NAND2X0_RVT U7936 ( .A1(n6424), .A2(n4528), .Y(n6425) );
  NAND4X0_RVT U7937 ( .A1(n6428), .A2(n6427), .A3(n6426), .A4(n6425), .Y(
        alu_out[0]) );
  AO22X1_RVT U7938 ( .A1(n4713), .A2(n4585), .A3(n4716), .A4(\cpuregs[24][11] ), .Y(n3321) );
  AO22X1_RVT U7939 ( .A1(n4712), .A2(n4557), .A3(n4715), .A4(\cpuregs[24][10] ), .Y(n3320) );
  AO22X1_RVT U7940 ( .A1(n4714), .A2(n4114), .A3(n4717), .A4(\cpuregs[24][5] ), 
        .Y(n3315) );
  AO22X1_RVT U7941 ( .A1(n4712), .A2(n4566), .A3(n4717), .A4(\cpuregs[24][16] ), .Y(n3326) );
  AO22X1_RVT U7942 ( .A1(n4712), .A2(n6523), .A3(n4717), .A4(\cpuregs[24][17] ), .Y(n3327) );
  AO22X1_RVT U7943 ( .A1(n4714), .A2(n4085), .A3(n4715), .A4(\cpuregs[24][22] ), .Y(n3332) );
  AO22X1_RVT U7944 ( .A1(n4713), .A2(n4572), .A3(n4717), .A4(\cpuregs[24][31] ), .Y(n3341) );
  AO22X1_RVT U7945 ( .A1(\cpuregs[8][4] ), .A2(n7226), .A3(\cpuregs[4][4] ), 
        .A4(n4838), .Y(n6451) );
  AO22X1_RVT U7946 ( .A1(\cpuregs[12][4] ), .A2(n4829), .A3(\cpuregs[28][4] ), 
        .A4(n7229), .Y(n6432) );
  AO22X1_RVT U7947 ( .A1(\cpuregs[20][4] ), .A2(n7233), .A3(\cpuregs[24][4] ), 
        .A4(n7228), .Y(n6431) );
  OR2X1_RVT U7948 ( .A1(n6432), .A2(n6431), .Y(n6433) );
  AO22X1_RVT U7949 ( .A1(\cpuregs[21][4] ), .A2(n4446), .A3(\cpuregs[11][4] ), 
        .A4(n4474), .Y(n6437) );
  AO22X1_RVT U7950 ( .A1(\cpuregs[23][4] ), .A2(n4443), .A3(\cpuregs[22][4] ), 
        .A4(n4495), .Y(n6436) );
  AO22X1_RVT U7951 ( .A1(\cpuregs[10][4] ), .A2(n4461), .A3(\cpuregs[26][4] ), 
        .A4(n4510), .Y(n6435) );
  AO22X1_RVT U7952 ( .A1(\cpuregs[30][4] ), .A2(n4501), .A3(\cpuregs[1][4] ), 
        .A4(n4483), .Y(n6434) );
  NOR4X1_RVT U7953 ( .A1(n6437), .A2(n6436), .A3(n6435), .A4(n6434), .Y(n6448)
         );
  AO22X1_RVT U7954 ( .A1(\cpuregs[15][4] ), .A2(n4489), .A3(\cpuregs[19][4] ), 
        .A4(n4498), .Y(n6441) );
  AO22X1_RVT U7955 ( .A1(\cpuregs[2][4] ), .A2(n4464), .A3(\cpuregs[18][4] ), 
        .A4(n4504), .Y(n6440) );
  AO22X1_RVT U7956 ( .A1(\cpuregs[6][4] ), .A2(n4458), .A3(\cpuregs[7][4] ), 
        .A4(n4437), .Y(n6439) );
  AO22X1_RVT U7957 ( .A1(\cpuregs[31][4] ), .A2(n4465), .A3(\cpuregs[14][4] ), 
        .A4(n4471), .Y(n6438) );
  NOR4X1_RVT U7958 ( .A1(n6441), .A2(n6440), .A3(n6439), .A4(n6438), .Y(n6447)
         );
  AO22X1_RVT U7959 ( .A1(\cpuregs[3][4] ), .A2(n7376), .A3(\cpuregs[13][4] ), 
        .A4(n4452), .Y(n6445) );
  AO22X1_RVT U7960 ( .A1(\cpuregs[5][4] ), .A2(n4477), .A3(\cpuregs[9][4] ), 
        .A4(n4468), .Y(n6444) );
  AO22X1_RVT U7961 ( .A1(\cpuregs[27][4] ), .A2(n4455), .A3(\cpuregs[29][4] ), 
        .A4(n4507), .Y(n6443) );
  AO22X1_RVT U7962 ( .A1(\cpuregs[17][4] ), .A2(n4492), .A3(\cpuregs[25][4] ), 
        .A4(n4480), .Y(n6442) );
  NOR4X1_RVT U7963 ( .A1(n6445), .A2(n6444), .A3(n6443), .A4(n6442), .Y(n6446)
         );
  NAND3X0_RVT U7964 ( .A1(n6448), .A2(n6447), .A3(n6446), .Y(n6449) );
  AO221X1_RVT U7965 ( .A1(n6855), .A2(n6451), .A3(n6855), .A4(n6450), .A5(
        n6449), .Y(n6452) );
  NAND2X0_RVT U7966 ( .A1(n7253), .A2(n6452), .Y(n7204) );
  NAND2X0_RVT U7967 ( .A1(decoded_imm_j[4]), .A2(n7684), .Y(n6454) );
  NAND3X0_RVT U7968 ( .A1(reg_sh[4]), .A2(n4634), .A3(n7682), .Y(n6453) );
  NAND3X0_RVT U7969 ( .A1(n7204), .A2(n6454), .A3(n6453), .Y(N1942) );
  AO22X1_RVT U7970 ( .A1(n6460), .A2(n4601), .A3(n4617), .A4(\cpuregs[29][28] ), .Y(n3498) );
  AO22X1_RVT U7971 ( .A1(n6460), .A2(n4556), .A3(n4617), .A4(\cpuregs[29][10] ), .Y(n3480) );
  AO22X1_RVT U7972 ( .A1(n4731), .A2(n7949), .A3(n4617), .A4(\cpuregs[29][29] ), .Y(n3499) );
  AO22X1_RVT U7973 ( .A1(n4106), .A2(n4008), .A3(n4615), .A4(\cpuregs[29][5] ), 
        .Y(n3475) );
  AO22X1_RVT U7974 ( .A1(n4731), .A2(n4564), .A3(n4616), .A4(\cpuregs[29][26] ), .Y(n3496) );
  AO22X1_RVT U7975 ( .A1(n4088), .A2(n4585), .A3(n4616), .A4(\cpuregs[29][11] ), .Y(n3481) );
  AO22X1_RVT U7976 ( .A1(n4074), .A2(n4397), .A3(n4616), .A4(\cpuregs[29][0] ), 
        .Y(n3502) );
  AO22X1_RVT U7977 ( .A1(n4076), .A2(n4565), .A3(n4618), .A4(\cpuregs[27][26] ), .Y(n3432) );
  AO22X1_RVT U7978 ( .A1(n4089), .A2(n4566), .A3(n4618), .A4(\cpuregs[27][16] ), .Y(n3422) );
  AO22X1_RVT U7979 ( .A1(n6461), .A2(n4605), .A3(n4619), .A4(\cpuregs[27][29] ), .Y(n3435) );
  AO22X1_RVT U7980 ( .A1(n6461), .A2(n4114), .A3(n4620), .A4(\cpuregs[27][5] ), 
        .Y(n3411) );
  AO22X1_RVT U7981 ( .A1(n4730), .A2(n4398), .A3(n4620), .A4(\cpuregs[27][0] ), 
        .Y(n3438) );
  AO22X1_RVT U7982 ( .A1(n4730), .A2(n4607), .A3(n4619), .A4(\cpuregs[27][2] ), 
        .Y(n3408) );
  AO22X1_RVT U7983 ( .A1(n4730), .A2(n4553), .A3(n4618), .A4(\cpuregs[27][22] ), .Y(n3428) );
  AO22X1_RVT U7984 ( .A1(n4089), .A2(n7950), .A3(n4620), .A4(\cpuregs[27][28] ), .Y(n3434) );
  AO22X1_RVT U7985 ( .A1(n4089), .A2(n4589), .A3(n4619), .A4(\cpuregs[27][17] ), .Y(n3423) );
  AO22X1_RVT U7986 ( .A1(n4089), .A2(n4571), .A3(n4619), .A4(\cpuregs[27][31] ), .Y(n3437) );
  AO22X1_RVT U7987 ( .A1(n4076), .A2(n4009), .A3(n4620), .A4(\cpuregs[27][11] ), .Y(n3417) );
  AO22X1_RVT U7988 ( .A1(n6461), .A2(n4557), .A3(n4618), .A4(\cpuregs[27][10] ), .Y(n3416) );
  AO22X1_RVT U7989 ( .A1(n4106), .A2(n4608), .A3(n4617), .A4(\cpuregs[29][2] ), 
        .Y(n3472) );
  AO22X1_RVT U7990 ( .A1(n4074), .A2(n6525), .A3(n4615), .A4(\cpuregs[29][31] ), .Y(n3501) );
  AO22X1_RVT U7991 ( .A1(n6460), .A2(n4554), .A3(n4616), .A4(\cpuregs[29][22] ), .Y(n3492) );
  AO22X1_RVT U7992 ( .A1(n4106), .A2(n6523), .A3(n4617), .A4(\cpuregs[29][17] ), .Y(n3487) );
  AO22X1_RVT U7993 ( .A1(n4088), .A2(n4568), .A3(n4615), .A4(\cpuregs[29][16] ), .Y(n3486) );
  AO22X1_RVT U7994 ( .A1(n4105), .A2(n4550), .A3(n4621), .A4(\cpuregs[31][5] ), 
        .Y(n3539) );
  AO22X1_RVT U7995 ( .A1(n4075), .A2(n4085), .A3(n4621), .A4(\cpuregs[31][22] ), .Y(n3556) );
  AO22X1_RVT U7996 ( .A1(n6462), .A2(n4555), .A3(n4621), .A4(\cpuregs[31][10] ), .Y(n3544) );
  AO22X1_RVT U7997 ( .A1(n4073), .A2(n4585), .A3(n4622), .A4(\cpuregs[31][11] ), .Y(n3545) );
  AO22X1_RVT U7998 ( .A1(n4105), .A2(n4607), .A3(n4622), .A4(\cpuregs[31][2] ), 
        .Y(n3536) );
  AO22X1_RVT U7999 ( .A1(n4075), .A2(n6523), .A3(n4623), .A4(\cpuregs[31][17] ), .Y(n3551) );
  AO22X1_RVT U8000 ( .A1(n6462), .A2(n4547), .A3(n4623), .A4(\cpuregs[31][0] ), 
        .Y(n3566) );
  AO22X1_RVT U8001 ( .A1(n4075), .A2(n4604), .A3(n4623), .A4(\cpuregs[31][29] ), .Y(n3563) );
  AO22X1_RVT U8002 ( .A1(n4105), .A2(n4565), .A3(n4621), .A4(\cpuregs[31][26] ), .Y(n3560) );
  AO22X1_RVT U8003 ( .A1(n4105), .A2(n4603), .A3(n4621), .A4(\cpuregs[31][28] ), .Y(n3562) );
  AO22X1_RVT U8004 ( .A1(n6462), .A2(n4570), .A3(n4622), .A4(\cpuregs[31][31] ), .Y(n3565) );
  AO22X1_RVT U8005 ( .A1(n4075), .A2(n4568), .A3(n4623), .A4(\cpuregs[31][16] ), .Y(n3550) );
  AND2X1_RVT U8006 ( .A1(resetn), .A2(n4320), .Y(n7947) );
  AO22X1_RVT U8007 ( .A1(n7888), .A2(instr_jal), .A3(instr_jalr), .A4(n7817), 
        .Y(n6463) );
  AO22X1_RVT U8008 ( .A1(n4829), .A2(\cpuregs[12][0] ), .A3(n7226), .A4(
        \cpuregs[8][0] ), .Y(n6466) );
  OR2X1_RVT U8009 ( .A1(n6466), .A2(n6465), .Y(n6467) );
  AO22X1_RVT U8010 ( .A1(n4504), .A2(\cpuregs[18][0] ), .A3(n4443), .A4(
        \cpuregs[23][0] ), .Y(n6472) );
  AO22X1_RVT U8011 ( .A1(n4480), .A2(\cpuregs[25][0] ), .A3(n4471), .A4(
        \cpuregs[14][0] ), .Y(n6471) );
  AO22X1_RVT U8012 ( .A1(n4489), .A2(\cpuregs[15][0] ), .A3(n4492), .A4(
        \cpuregs[17][0] ), .Y(n6470) );
  AO22X1_RVT U8013 ( .A1(n4510), .A2(\cpuregs[26][0] ), .A3(n4455), .A4(
        \cpuregs[27][0] ), .Y(n6469) );
  NOR4X1_RVT U8014 ( .A1(n6472), .A2(n6471), .A3(n6470), .A4(n6469), .Y(n6483)
         );
  AO22X1_RVT U8015 ( .A1(n4483), .A2(\cpuregs[1][0] ), .A3(n4464), .A4(
        \cpuregs[2][0] ), .Y(n6476) );
  AO22X1_RVT U8016 ( .A1(n4495), .A2(\cpuregs[22][0] ), .A3(n4477), .A4(
        \cpuregs[5][0] ), .Y(n6475) );
  AO22X1_RVT U8017 ( .A1(n4501), .A2(\cpuregs[30][0] ), .A3(n4465), .A4(
        \cpuregs[31][0] ), .Y(n6474) );
  AO22X1_RVT U8018 ( .A1(n4458), .A2(\cpuregs[6][0] ), .A3(n4452), .A4(
        \cpuregs[13][0] ), .Y(n6473) );
  NOR4X1_RVT U8019 ( .A1(n6476), .A2(n6475), .A3(n6474), .A4(n6473), .Y(n6482)
         );
  AO22X1_RVT U8020 ( .A1(n4446), .A2(\cpuregs[21][0] ), .A3(n4498), .A4(
        \cpuregs[19][0] ), .Y(n6480) );
  AO22X1_RVT U8021 ( .A1(n4474), .A2(\cpuregs[11][0] ), .A3(n4430), .A4(
        \cpuregs[3][0] ), .Y(n6479) );
  AO22X1_RVT U8022 ( .A1(n4437), .A2(\cpuregs[7][0] ), .A3(n4461), .A4(
        \cpuregs[10][0] ), .Y(n6478) );
  AO22X1_RVT U8023 ( .A1(n4507), .A2(\cpuregs[29][0] ), .A3(n4468), .A4(
        \cpuregs[9][0] ), .Y(n6477) );
  NOR4X1_RVT U8024 ( .A1(n6480), .A2(n6479), .A3(n6478), .A4(n6477), .Y(n6481)
         );
  NAND3X0_RVT U8025 ( .A1(n6483), .A2(n6482), .A3(n6481), .Y(n6484) );
  AO221X1_RVT U8026 ( .A1(n4312), .A2(n6486), .A3(n4312), .A4(n6485), .A5(
        n6484), .Y(n6487) );
  NAND2X0_RVT U8027 ( .A1(n7253), .A2(n6487), .Y(net23637) );
  NAND4X0_RVT U8028 ( .A1(n4291), .A2(n4535), .A3(N1600), .A4(n8053), .Y(n6488) );
  NAND3X0_RVT U8029 ( .A1(n6489), .A2(net23637), .A3(n6488), .Y(N1938) );
  AND2X1_RVT U8030 ( .A1(resetn), .A2(n6491), .Y(n6492) );
  AO22X1_RVT U8031 ( .A1(n4714), .A2(n4575), .A3(n4716), .A4(\cpuregs[24][4] ), 
        .Y(n3314) );
  HADDX1_RVT U8032 ( .A0(reg_pc[18]), .B0(n6495), .C1(n6501), .SO(n6496) );
  AO22X1_RVT U8033 ( .A1(n4025), .A2(n4558), .A3(n4024), .A4(\cpuregs[13][18] ), .Y(n2976) );
  AO22X1_RVT U8034 ( .A1(n4712), .A2(n7962), .A3(n4717), .A4(\cpuregs[24][8] ), 
        .Y(n3318) );
  AO22X1_RVT U8035 ( .A1(n4702), .A2(n4582), .A3(n4703), .A4(\cpuregs[30][8] ), 
        .Y(n3510) );
  AO22X1_RVT U8036 ( .A1(n4672), .A2(n4559), .A3(n4675), .A4(\cpuregs[15][18] ), .Y(n3040) );
  AO22X1_RVT U8037 ( .A1(n4677), .A2(n7961), .A3(n4023), .A4(\cpuregs[13][9] ), 
        .Y(n2967) );
  AO22X1_RVT U8038 ( .A1(n4673), .A2(n4583), .A3(n4675), .A4(\cpuregs[15][9] ), 
        .Y(n3031) );
  AO22X1_RVT U8039 ( .A1(n4702), .A2(n4573), .A3(n4703), .A4(\cpuregs[30][4] ), 
        .Y(n3506) );
  HADDX1_RVT U8040 ( .A0(reg_pc[19]), .B0(n6501), .C1(n6506), .SO(n6502) );
  AO22X1_RVT U8041 ( .A1(n4732), .A2(n4087), .A3(n4621), .A4(\cpuregs[31][19] ), .Y(n3553) );
  AO22X1_RVT U8042 ( .A1(n4700), .A2(n7957), .A3(n4704), .A4(\cpuregs[30][13] ), .Y(n3515) );
  AO22X1_RVT U8043 ( .A1(n4025), .A2(n7965), .A3(n4023), .A4(\cpuregs[13][3] ), 
        .Y(n2961) );
  AO22X1_RVT U8044 ( .A1(n4025), .A2(n4050), .A3(n4022), .A4(\cpuregs[13][13] ), .Y(n2971) );
  HADDX1_RVT U8045 ( .A0(reg_pc[20]), .B0(n6506), .C1(n6076), .SO(n6507) );
  AO22X1_RVT U8046 ( .A1(n4077), .A2(n4592), .A3(n4527), .A4(\cpuregs[17][20] ), .Y(n3106) );
  AO22X1_RVT U8047 ( .A1(n4677), .A2(n4103), .A3(n4023), .A4(\cpuregs[13][19] ), .Y(n2977) );
  AO22X1_RVT U8048 ( .A1(n4712), .A2(n4049), .A3(n4715), .A4(\cpuregs[24][13] ), .Y(n3323) );
  AO22X1_RVT U8049 ( .A1(n4678), .A2(n4592), .A3(n4024), .A4(\cpuregs[13][20] ), .Y(n2978) );
  AO22X1_RVT U8050 ( .A1(n4700), .A2(n4115), .A3(n4704), .A4(\cpuregs[30][3] ), 
        .Y(n3505) );
  AO22X1_RVT U8051 ( .A1(n4767), .A2(n7965), .A3(n4771), .A4(\cpuregs[22][3] ), 
        .Y(n3249) );
  AO22X1_RVT U8052 ( .A1(n4700), .A2(n4609), .A3(n4703), .A4(\cpuregs[30][1] ), 
        .Y(n3503) );
  AO22X1_RVT U8053 ( .A1(n4714), .A2(n4609), .A3(n4716), .A4(\cpuregs[24][1] ), 
        .Y(n3311) );
  HADDX1_RVT U8054 ( .A0(reg_pc[24]), .B0(n6509), .C1(n6064), .SO(n6510) );
  AO22X1_RVT U8055 ( .A1(n4712), .A2(n4594), .A3(n4717), .A4(\cpuregs[24][24] ), .Y(n3334) );
  AO22X1_RVT U8056 ( .A1(n4701), .A2(n4594), .A3(n4704), .A4(\cpuregs[30][24] ), .Y(n3526) );
  AO22X1_RVT U8057 ( .A1(n4649), .A2(n4095), .A3(n4652), .A4(\cpuregs[8][7] ), 
        .Y(n2805) );
  AO22X1_RVT U8058 ( .A1(n4696), .A2(n6714), .A3(n4697), .A4(\cpuregs[26][7] ), 
        .Y(n3381) );
  AO22X1_RVT U8059 ( .A1(n4757), .A2(n4594), .A3(n4760), .A4(\cpuregs[25][24] ), .Y(n3366) );
  AO22X1_RVT U8060 ( .A1(n4753), .A2(n4081), .A3(n4756), .A4(\cpuregs[7][7] ), 
        .Y(n2773) );
  HADDX1_RVT U8061 ( .A0(reg_pc[30]), .B0(n6513), .C1(n6283), .SO(n6514) );
  AO22X1_RVT U8062 ( .A1(n4678), .A2(n4047), .A3(n4024), .A4(\cpuregs[13][30] ), .Y(n2988) );
  HADDX1_RVT U8063 ( .A0(reg_pc[23]), .B0(n6515), .C1(n6509), .SO(n6516) );
  AO22X1_RVT U8064 ( .A1(n4647), .A2(n4013), .A3(n4651), .A4(\cpuregs[8][23] ), 
        .Y(n2821) );
  AO22X1_RVT U8065 ( .A1(n4732), .A2(n4095), .A3(n4622), .A4(\cpuregs[31][7] ), 
        .Y(n3541) );
  AO22X1_RVT U8066 ( .A1(n4713), .A2(n6714), .A3(n4715), .A4(\cpuregs[24][7] ), 
        .Y(n3317) );
  AO22X1_RVT U8067 ( .A1(n4690), .A2(n4581), .A3(n4691), .A4(\cpuregs[28][7] ), 
        .Y(n3445) );
  AO22X1_RVT U8068 ( .A1(n4678), .A2(n4012), .A3(n4023), .A4(\cpuregs[13][23] ), .Y(n2981) );
  AO22X1_RVT U8069 ( .A1(n4661), .A2(n4581), .A3(n4664), .A4(\cpuregs[14][7] ), 
        .Y(n2997) );
  AO22X1_RVT U8070 ( .A1(n4701), .A2(n4046), .A3(n4705), .A4(\cpuregs[30][30] ), .Y(n3532) );
  AO22X1_RVT U8071 ( .A1(n4667), .A2(n6710), .A3(n4669), .A4(\cpuregs[10][23] ), .Y(n2885) );
  AO22X1_RVT U8072 ( .A1(n4648), .A2(n4047), .A3(n4650), .A4(\cpuregs[8][30] ), 
        .Y(n2828) );
  AO22X1_RVT U8073 ( .A1(n4712), .A2(n6712), .A3(n4715), .A4(\cpuregs[24][30] ), .Y(n3340) );
  AO22X1_RVT U8074 ( .A1(n4074), .A2(n4594), .A3(n4616), .A4(\cpuregs[29][24] ), .Y(n3494) );
  AO22X1_RVT U8075 ( .A1(n4758), .A2(n6712), .A3(n4761), .A4(\cpuregs[25][30] ), .Y(n3372) );
  AO22X1_RVT U8076 ( .A1(n4666), .A2(n4045), .A3(n4668), .A4(\cpuregs[10][30] ), .Y(n2892) );
  AO22X1_RVT U8077 ( .A1(n4667), .A2(n4594), .A3(n4670), .A4(\cpuregs[10][24] ), .Y(n2886) );
  AO22X1_RVT U8078 ( .A1(n4700), .A2(n4013), .A3(n4704), .A4(\cpuregs[30][23] ), .Y(n3525) );
  AO22X1_RVT U8079 ( .A1(n4649), .A2(n4084), .A3(n4652), .A4(\cpuregs[8][24] ), 
        .Y(n2822) );
  AO22X1_RVT U8080 ( .A1(n4088), .A2(n4013), .A3(n4617), .A4(\cpuregs[29][23] ), .Y(n3493) );
  AO22X1_RVT U8081 ( .A1(n4713), .A2(n4013), .A3(n4715), .A4(\cpuregs[24][23] ), .Y(n3333) );
  AO22X1_RVT U8082 ( .A1(n4676), .A2(n4594), .A3(n4023), .A4(\cpuregs[13][24] ), .Y(n2982) );
  AO22X1_RVT U8083 ( .A1(n4074), .A2(n4045), .A3(n4615), .A4(\cpuregs[29][30] ), .Y(n3500) );
  AO22X1_RVT U8084 ( .A1(n4713), .A2(n4083), .A3(n4715), .A4(\cpuregs[24][25] ), .Y(n3335) );
  AO22X1_RVT U8085 ( .A1(n4648), .A2(n4595), .A3(n4651), .A4(\cpuregs[8][25] ), 
        .Y(n2823) );
  HADDX1_RVT U8086 ( .A0(reg_pc[14]), .B0(n6517), .C1(n6165), .SO(n6518) );
  AO22X1_RVT U8087 ( .A1(n4696), .A2(n4044), .A3(n4697), .A4(\cpuregs[26][14] ), .Y(n3388) );
  AO22X1_RVT U8088 ( .A1(n4667), .A2(n4596), .A3(n4670), .A4(\cpuregs[10][25] ), .Y(n2887) );
  AO22X1_RVT U8089 ( .A1(n4713), .A2(n4039), .A3(n4717), .A4(\cpuregs[24][14] ), .Y(n3324) );
  AO22X1_RVT U8090 ( .A1(n4088), .A2(n4596), .A3(n4616), .A4(\cpuregs[29][25] ), .Y(n3495) );
  AO22X1_RVT U8091 ( .A1(n6462), .A2(n4036), .A3(n4623), .A4(\cpuregs[31][14] ), .Y(n3548) );
  AO22X1_RVT U8092 ( .A1(n4684), .A2(n4597), .A3(n4687), .A4(\cpuregs[9][25] ), 
        .Y(n2855) );
  AO22X1_RVT U8093 ( .A1(n4647), .A2(n4041), .A3(n4650), .A4(\cpuregs[8][14] ), 
        .Y(n2812) );
  AO22X1_RVT U8094 ( .A1(n4753), .A2(n4036), .A3(n4755), .A4(\cpuregs[7][14] ), 
        .Y(n2780) );
  AO22X1_RVT U8095 ( .A1(n4690), .A2(n4040), .A3(n4691), .A4(\cpuregs[28][14] ), .Y(n3452) );
  AO22X1_RVT U8096 ( .A1(n4659), .A2(n4039), .A3(n4663), .A4(\cpuregs[14][14] ), .Y(n3004) );
  AND2X1_RVT U8097 ( .A1(resetn), .A2(n6520), .Y(n6521) );
  AO22X1_RVT U8098 ( .A1(n4758), .A2(n7960), .A3(n4762), .A4(\cpuregs[25][10] ), .Y(n3352) );
  AO22X1_RVT U8099 ( .A1(n4758), .A2(n4114), .A3(n4762), .A4(\cpuregs[25][5] ), 
        .Y(n3347) );
  AO22X1_RVT U8100 ( .A1(n4759), .A2(n4606), .A3(n4760), .A4(\cpuregs[25][2] ), 
        .Y(n3344) );
  AO22X1_RVT U8101 ( .A1(n4757), .A2(n4092), .A3(n4760), .A4(\cpuregs[25][11] ), .Y(n3353) );
  AO22X1_RVT U8102 ( .A1(n4759), .A2(n4398), .A3(n4761), .A4(\cpuregs[25][0] ), 
        .Y(n3374) );
  AO22X1_RVT U8103 ( .A1(n4757), .A2(n7950), .A3(n4760), .A4(\cpuregs[25][28] ), .Y(n3370) );
  AO22X1_RVT U8104 ( .A1(n4757), .A2(n4087), .A3(n4762), .A4(\cpuregs[25][19] ), .Y(n3361) );
  AO22X1_RVT U8105 ( .A1(n4758), .A2(n7952), .A3(n4761), .A4(\cpuregs[25][20] ), .Y(n3362) );
  AO22X1_RVT U8106 ( .A1(n4759), .A2(n7949), .A3(n4761), .A4(\cpuregs[25][29] ), .Y(n3371) );
  AO22X1_RVT U8107 ( .A1(n4757), .A2(n4591), .A3(n4761), .A4(\cpuregs[25][17] ), .Y(n3359) );
  AO22X1_RVT U8108 ( .A1(n4757), .A2(n6710), .A3(n4762), .A4(\cpuregs[25][23] ), .Y(n3365) );
  AO22X1_RVT U8109 ( .A1(n4759), .A2(n4568), .A3(n4760), .A4(\cpuregs[25][16] ), .Y(n3358) );
  AO22X1_RVT U8110 ( .A1(n4758), .A2(n4565), .A3(n4761), .A4(\cpuregs[25][26] ), .Y(n3368) );
  AO22X1_RVT U8111 ( .A1(n4758), .A2(n6525), .A3(n4760), .A4(\cpuregs[25][31] ), .Y(n3373) );
  AO22X1_RVT U8112 ( .A1(n4759), .A2(n4083), .A3(n4762), .A4(\cpuregs[25][25] ), .Y(n3367) );
  AO22X1_RVT U8113 ( .A1(n4757), .A2(n4554), .A3(n4761), .A4(\cpuregs[25][22] ), .Y(n3364) );
  AOI22X1_RVT U8114 ( .A1(count_instr[44]), .A2(n7788), .A3(n7771), .A4(
        mem_rdata_word[12]), .Y(n6530) );
  OR2X1_RVT U8115 ( .A1(n6533), .A2(n6532), .Y(n6534) );
  INVX0_RVT U8116 ( .A(n6565), .Y(n6537) );
  AND2X1_RVT U8117 ( .A1(n6537), .A2(resetn), .Y(n6538) );
  OA21X1_RVT U8118 ( .A1(count_cycle[42]), .A2(n6536), .A3(n6538), .Y(N960) );
  FADDX1_RVT U8119 ( .A(decoded_imm[23]), .B(reg_pc[23]), .CI(n6539), .S(n6542) );
  AO22X1_RVT U8120 ( .A1(n4175), .A2(mem_rdata_word[23]), .A3(n4634), .A4(
        pcpi_rs1[23]), .Y(n6540) );
  OR2X1_RVT U8121 ( .A1(n4331), .A2(n6540), .Y(n6541) );
  NAND2X0_RVT U8122 ( .A1(n8093), .A2(pcpi_rs2[1]), .Y(n6543) );
  AO221X1_RVT U8123 ( .A1(n6544), .A2(n4246), .A3(n6543), .A4(n4245), .A5(
        n4244), .Y(n6549) );
  NAND2X0_RVT U8124 ( .A1(n8035), .A2(net16466), .Y(n6548) );
  FADDX1_RVT U8125 ( .A(n8093), .B(n6546), .CI(n6545), .CO(n7671), .S(n6547)
         );
  AO22X1_RVT U8126 ( .A1(n6549), .A2(n6548), .A3(n6547), .A4(n4529), .Y(
        alu_out[1]) );
  NAND2X0_RVT U8127 ( .A1(net30656), .A2(pcpi_rs2[7]), .Y(n6550) );
  AO221X1_RVT U8128 ( .A1(n6551), .A2(n4246), .A3(n6550), .A4(n4245), .A5(
        n4243), .Y(n6556) );
  NAND2X0_RVT U8129 ( .A1(n7986), .A2(net16363), .Y(n6555) );
  FADDX1_RVT U8130 ( .A(n8087), .B(n6553), .CI(n6552), .CO(n6385), .S(n6554)
         );
  AO22X1_RVT U8131 ( .A1(n6556), .A2(n6555), .A3(n6554), .A4(n4528), .Y(
        alu_out[7]) );
  AO221X1_RVT U8132 ( .A1(n6559), .A2(n6412), .A3(n6558), .A4(n4245), .A5(
        n4243), .Y(n6564) );
  FADDX1_RVT U8133 ( .A(n8080), .B(n6560), .CI(n6561), .CO(n7589), .S(n6562)
         );
  AO22X1_RVT U8134 ( .A1(n6564), .A2(n6563), .A3(n6562), .A4(n4528), .Y(
        alu_out[14]) );
  AND2X1_RVT U8135 ( .A1(n6565), .A2(count_cycle[43]), .Y(n6607) );
  INVX0_RVT U8136 ( .A(n6607), .Y(n6566) );
  AND2X1_RVT U8137 ( .A1(resetn), .A2(n6566), .Y(n6567) );
  AO22X1_RVT U8138 ( .A1(n4175), .A2(mem_rdata_word[22]), .A3(n4031), .A4(
        pcpi_rs1[22]), .Y(n6569) );
  OR2X1_RVT U8139 ( .A1(n4304), .A2(n6569), .Y(n6570) );
  AO22X1_RVT U8140 ( .A1(count_cycle[17]), .A2(n7762), .A3(count_instr[17]), 
        .A4(n4352), .Y(n6578) );
  AOI22X1_RVT U8141 ( .A1(count_instr[49]), .A2(n4311), .A3(n4633), .A4(
        pcpi_rs1[17]), .Y(n6576) );
  NAND2X0_RVT U8142 ( .A1(n6573), .A2(mem_rdata_word[17]), .Y(n6575) );
  NAND2X0_RVT U8143 ( .A1(count_cycle[49]), .A2(n4258), .Y(n6574) );
  NAND4X0_RVT U8144 ( .A1(n6817), .A2(n6576), .A3(n6575), .A4(n6574), .Y(n6577) );
  OR2X1_RVT U8145 ( .A1(n6578), .A2(n6577), .Y(n6579) );
  AO22X1_RVT U8146 ( .A1(n4383), .A2(\cpuregs[16][31] ), .A3(n4416), .A4(
        \cpuregs[28][31] ), .Y(n6583) );
  AO22X1_RVT U8147 ( .A1(n4344), .A2(\cpuregs[6][31] ), .A3(n4365), .A4(
        \cpuregs[8][31] ), .Y(n6582) );
  OR2X1_RVT U8148 ( .A1(n6583), .A2(n6582), .Y(n6584) );
  AO21X1_RVT U8149 ( .A1(n4409), .A2(\cpuregs[12][31] ), .A3(n6584), .Y(n6606)
         );
  AO22X1_RVT U8150 ( .A1(n4403), .A2(\cpuregs[14][31] ), .A3(n4423), .A4(
        \cpuregs[7][31] ), .Y(n6605) );
  AO22X1_RVT U8151 ( .A1(n4388), .A2(\cpuregs[23][31] ), .A3(n4435), .A4(
        \cpuregs[10][31] ), .Y(n6590) );
  AO22X1_RVT U8152 ( .A1(n4348), .A2(\cpuregs[20][31] ), .A3(n4359), .A4(
        \cpuregs[18][31] ), .Y(n6589) );
  AO22X1_RVT U8153 ( .A1(n4329), .A2(\cpuregs[22][31] ), .A3(n4374), .A4(
        \cpuregs[1][31] ), .Y(n6588) );
  AO22X1_RVT U8154 ( .A1(n4432), .A2(\cpuregs[13][31] ), .A3(n4451), .A4(
        \cpuregs[21][31] ), .Y(n6587) );
  NOR4X1_RVT U8155 ( .A1(n6590), .A2(n6589), .A3(n6588), .A4(n6587), .Y(n6603)
         );
  AO22X1_RVT U8156 ( .A1(n4368), .A2(\cpuregs[5][31] ), .A3(n4442), .A4(
        \cpuregs[4][31] ), .Y(n6596) );
  AO22X1_RVT U8157 ( .A1(n4334), .A2(\cpuregs[25][31] ), .A3(n4426), .A4(
        \cpuregs[17][31] ), .Y(n6595) );
  AO22X1_RVT U8158 ( .A1(n4338), .A2(\cpuregs[19][31] ), .A3(n4420), .A4(
        \cpuregs[30][31] ), .Y(n6594) );
  AO22X1_RVT U8159 ( .A1(n4350), .A2(\cpuregs[9][31] ), .A3(n4428), .A4(
        \cpuregs[3][31] ), .Y(n6593) );
  NOR4X1_RVT U8160 ( .A1(n6596), .A2(n6595), .A3(n6594), .A4(n6593), .Y(n6602)
         );
  AO22X1_RVT U8161 ( .A1(n4362), .A2(\cpuregs[11][31] ), .A3(n4413), .A4(
        \cpuregs[26][31] ), .Y(n6600) );
  AO22X1_RVT U8162 ( .A1(n4326), .A2(\cpuregs[27][31] ), .A3(n4390), .A4(
        \cpuregs[2][31] ), .Y(n6599) );
  AO22X1_RVT U8163 ( .A1(n4273), .A2(\cpuregs[15][31] ), .A3(n4393), .A4(
        \cpuregs[31][31] ), .Y(n6598) );
  AO22X1_RVT U8164 ( .A1(n4407), .A2(\cpuregs[29][31] ), .A3(n4487), .A4(
        \cpuregs[24][31] ), .Y(n6597) );
  NOR4X1_RVT U8165 ( .A1(n6600), .A2(n6599), .A3(n6598), .A4(n6597), .Y(n6601)
         );
  NAND3X0_RVT U8166 ( .A1(n6603), .A2(n6602), .A3(n6601), .Y(n6604) );
  AO222X1_RVT U8167 ( .A1(n5208), .A2(n6606), .A3(n4058), .A4(n6605), .A5(
        n4058), .A6(n6604), .Y(net24598) );
  AND2X1_RVT U8168 ( .A1(n6607), .A2(count_cycle[44]), .Y(n6614) );
  INVX0_RVT U8169 ( .A(n6614), .Y(n6608) );
  AND2X1_RVT U8170 ( .A1(resetn), .A2(n6608), .Y(n6609) );
  FADDX1_RVT U8171 ( .A(decoded_imm[24]), .B(reg_pc[24]), .CI(n6610), .S(n6613) );
  AO22X1_RVT U8172 ( .A1(n4175), .A2(mem_rdata_word[24]), .A3(n4633), .A4(
        pcpi_rs1[24]), .Y(n6611) );
  OR2X1_RVT U8173 ( .A1(n4260), .A2(n6611), .Y(n6612) );
  AND2X1_RVT U8174 ( .A1(n6614), .A2(count_cycle[45]), .Y(n6719) );
  INVX0_RVT U8175 ( .A(n6719), .Y(n6615) );
  AND2X1_RVT U8176 ( .A1(resetn), .A2(n6615), .Y(n6616) );
  OA21X1_RVT U8177 ( .A1(count_cycle[45]), .A2(n6614), .A3(n6616), .Y(N963) );
  AO22X1_RVT U8178 ( .A1(n6675), .A2(pcpi_rs1[23]), .A3(n4055), .A4(
        pcpi_rs1[27]), .Y(n6644) );
  AO22X1_RVT U8179 ( .A1(n4347), .A2(\cpuregs[20][27] ), .A3(n4421), .A4(
        \cpuregs[30][27] ), .Y(n6619) );
  AO22X1_RVT U8180 ( .A1(n4388), .A2(\cpuregs[23][27] ), .A3(n4488), .A4(
        \cpuregs[24][27] ), .Y(n6618) );
  OR2X1_RVT U8181 ( .A1(n6619), .A2(n6618), .Y(n6620) );
  AO21X1_RVT U8182 ( .A1(n4427), .A2(\cpuregs[3][27] ), .A3(n6620), .Y(n6638)
         );
  AO22X1_RVT U8183 ( .A1(n4359), .A2(\cpuregs[18][27] ), .A3(n4410), .A4(
        \cpuregs[12][27] ), .Y(n6637) );
  AO22X1_RVT U8184 ( .A1(n4327), .A2(\cpuregs[27][27] ), .A3(n4451), .A4(
        \cpuregs[21][27] ), .Y(n6624) );
  AO22X1_RVT U8185 ( .A1(n4329), .A2(\cpuregs[22][27] ), .A3(n4383), .A4(
        \cpuregs[16][27] ), .Y(n6623) );
  AO22X1_RVT U8186 ( .A1(n4368), .A2(\cpuregs[5][27] ), .A3(n4390), .A4(
        \cpuregs[2][27] ), .Y(n6622) );
  AO22X1_RVT U8187 ( .A1(n4349), .A2(\cpuregs[9][27] ), .A3(n4423), .A4(
        \cpuregs[7][27] ), .Y(n6621) );
  NOR4X1_RVT U8188 ( .A1(n6624), .A2(n6623), .A3(n6622), .A4(n6621), .Y(n6635)
         );
  AO22X1_RVT U8189 ( .A1(n4334), .A2(\cpuregs[25][27] ), .A3(n4432), .A4(
        \cpuregs[13][27] ), .Y(n6628) );
  AO22X1_RVT U8190 ( .A1(n4435), .A2(\cpuregs[10][27] ), .A3(n4417), .A4(
        \cpuregs[28][27] ), .Y(n6627) );
  AO22X1_RVT U8191 ( .A1(n4412), .A2(\cpuregs[26][27] ), .A3(n4403), .A4(
        \cpuregs[14][27] ), .Y(n6626) );
  AO22X1_RVT U8192 ( .A1(n4406), .A2(\cpuregs[29][27] ), .A3(n4363), .A4(
        \cpuregs[11][27] ), .Y(n6625) );
  NOR4X1_RVT U8193 ( .A1(n6628), .A2(n6627), .A3(n6626), .A4(n6625), .Y(n6634)
         );
  AO22X1_RVT U8194 ( .A1(n4344), .A2(\cpuregs[6][27] ), .A3(n4374), .A4(
        \cpuregs[1][27] ), .Y(n6632) );
  AO22X1_RVT U8195 ( .A1(n4425), .A2(\cpuregs[17][27] ), .A3(n4441), .A4(
        \cpuregs[4][27] ), .Y(n6631) );
  AO22X1_RVT U8196 ( .A1(n4273), .A2(\cpuregs[15][27] ), .A3(n4366), .A4(
        \cpuregs[8][27] ), .Y(n6630) );
  AO22X1_RVT U8197 ( .A1(n4338), .A2(\cpuregs[19][27] ), .A3(n4394), .A4(
        \cpuregs[31][27] ), .Y(n6629) );
  NOR4X1_RVT U8198 ( .A1(n6632), .A2(n6631), .A3(n6630), .A4(n6629), .Y(n6633)
         );
  NAND3X0_RVT U8199 ( .A1(n6635), .A2(n6634), .A3(n6633), .Y(n6636) );
  AO222X1_RVT U8200 ( .A1(n4061), .A2(n6638), .A3(n4063), .A4(n6637), .A5(
        n4062), .A6(n6636), .Y(n6642) );
  OR2X1_RVT U8201 ( .A1(net24543), .A2(n6639), .Y(n6640) );
  AO21X1_RVT U8202 ( .A1(net30309), .A2(reg_pc[27]), .A3(n6640), .Y(n6641) );
  OA21X1_RVT U8203 ( .A1(n6642), .A2(n6641), .A3(net26624), .Y(n6643) );
  OR2X1_RVT U8204 ( .A1(n6644), .A2(n6643), .Y(n3713) );
  AO22X1_RVT U8205 ( .A1(pcpi_rs1[4]), .A2(n6675), .A3(n4055), .A4(pcpi_rs1[8]), .Y(n6674) );
  AO22X1_RVT U8206 ( .A1(n4326), .A2(\cpuregs[27][8] ), .A3(n4334), .A4(
        \cpuregs[25][8] ), .Y(n6647) );
  AO22X1_RVT U8207 ( .A1(n4412), .A2(\cpuregs[26][8] ), .A3(n4488), .A4(
        \cpuregs[24][8] ), .Y(n6646) );
  OR2X1_RVT U8208 ( .A1(n6647), .A2(n6646), .Y(n6648) );
  AO21X1_RVT U8209 ( .A1(n4450), .A2(\cpuregs[21][8] ), .A3(n6648), .Y(n6668)
         );
  AO22X1_RVT U8210 ( .A1(n4424), .A2(\cpuregs[7][8] ), .A3(n4416), .A4(
        \cpuregs[28][8] ), .Y(n6667) );
  AO22X1_RVT U8211 ( .A1(n4365), .A2(\cpuregs[8][8] ), .A3(n4410), .A4(
        \cpuregs[12][8] ), .Y(n6653) );
  AO22X1_RVT U8212 ( .A1(n4390), .A2(\cpuregs[2][8] ), .A3(n4433), .A4(
        \cpuregs[13][8] ), .Y(n6652) );
  AO22X1_RVT U8213 ( .A1(n4330), .A2(\cpuregs[22][8] ), .A3(n4368), .A4(
        \cpuregs[5][8] ), .Y(n6650) );
  NOR4X1_RVT U8214 ( .A1(n6653), .A2(n6652), .A3(n6651), .A4(n6650), .Y(n6665)
         );
  AO22X1_RVT U8215 ( .A1(n4347), .A2(\cpuregs[20][8] ), .A3(n4442), .A4(
        \cpuregs[4][8] ), .Y(n6657) );
  AO22X1_RVT U8216 ( .A1(n4394), .A2(\cpuregs[31][8] ), .A3(n4436), .A4(
        \cpuregs[10][8] ), .Y(n6656) );
  AO22X1_RVT U8217 ( .A1(n4272), .A2(\cpuregs[15][8] ), .A3(n4360), .A4(
        \cpuregs[18][8] ), .Y(n6655) );
  AO22X1_RVT U8218 ( .A1(n4362), .A2(\cpuregs[11][8] ), .A3(n4420), .A4(
        \cpuregs[30][8] ), .Y(n6654) );
  NOR4X1_RVT U8219 ( .A1(n6657), .A2(n6656), .A3(n6655), .A4(n6654), .Y(n6664)
         );
  AO22X1_RVT U8220 ( .A1(n4345), .A2(\cpuregs[6][8] ), .A3(n4388), .A4(
        \cpuregs[23][8] ), .Y(n6662) );
  AO22X1_RVT U8221 ( .A1(n4375), .A2(\cpuregs[1][8] ), .A3(n4428), .A4(
        \cpuregs[3][8] ), .Y(n6661) );
  AO22X1_RVT U8222 ( .A1(n4349), .A2(\cpuregs[9][8] ), .A3(n4406), .A4(
        \cpuregs[29][8] ), .Y(n6660) );
  AO22X1_RVT U8223 ( .A1(n4403), .A2(\cpuregs[14][8] ), .A3(n4426), .A4(
        \cpuregs[17][8] ), .Y(n6659) );
  NOR4X1_RVT U8224 ( .A1(n6662), .A2(n6661), .A3(n6660), .A4(n6659), .Y(n6663)
         );
  NAND3X0_RVT U8225 ( .A1(n6665), .A2(n6664), .A3(n6663), .Y(n6666) );
  AO222X1_RVT U8226 ( .A1(n4060), .A2(n6668), .A3(n4058), .A4(n6667), .A5(
        n4063), .A6(n6666), .Y(n6672) );
  OR2X1_RVT U8227 ( .A1(net24498), .A2(n6669), .Y(n6670) );
  AO21X1_RVT U8228 ( .A1(net30309), .A2(reg_pc[8]), .A3(n6670), .Y(n6671) );
  OA21X1_RVT U8229 ( .A1(n6672), .A2(n6671), .A3(net29471), .Y(n6673) );
  OR2X1_RVT U8230 ( .A1(n6674), .A2(n6673), .Y(n3732) );
  AO22X1_RVT U8231 ( .A1(pcpi_rs1[8]), .A2(n6675), .A3(n4054), .A4(
        pcpi_rs1[12]), .Y(n6708) );
  AO22X1_RVT U8232 ( .A1(n4349), .A2(\cpuregs[9][12] ), .A3(n4421), .A4(
        \cpuregs[30][12] ), .Y(n6678) );
  AO22X1_RVT U8233 ( .A1(n4337), .A2(\cpuregs[19][12] ), .A3(n4366), .A4(
        \cpuregs[8][12] ), .Y(n6677) );
  OR2X1_RVT U8234 ( .A1(n6678), .A2(n6677), .Y(n6679) );
  AO21X1_RVT U8235 ( .A1(n4363), .A2(\cpuregs[11][12] ), .A3(n6679), .Y(n6702)
         );
  AO22X1_RVT U8236 ( .A1(n4326), .A2(\cpuregs[27][12] ), .A3(n4432), .A4(
        \cpuregs[13][12] ), .Y(n6701) );
  AO22X1_RVT U8237 ( .A1(n4347), .A2(\cpuregs[20][12] ), .A3(n4427), .A4(
        \cpuregs[3][12] ), .Y(n6685) );
  AO22X1_RVT U8238 ( .A1(n4404), .A2(\cpuregs[14][12] ), .A3(n4442), .A4(
        \cpuregs[4][12] ), .Y(n6684) );
  AO22X1_RVT U8239 ( .A1(n4360), .A2(\cpuregs[18][12] ), .A3(n4425), .A4(
        \cpuregs[17][12] ), .Y(n6683) );
  AO22X1_RVT U8240 ( .A1(n4394), .A2(\cpuregs[31][12] ), .A3(n4450), .A4(
        \cpuregs[21][12] ), .Y(n6682) );
  NOR4X1_RVT U8241 ( .A1(n6685), .A2(n6684), .A3(n6683), .A4(n6682), .Y(n6699)
         );
  AO22X1_RVT U8242 ( .A1(n4412), .A2(\cpuregs[26][12] ), .A3(n4424), .A4(
        \cpuregs[7][12] ), .Y(n6691) );
  AO22X1_RVT U8243 ( .A1(n4272), .A2(\cpuregs[15][12] ), .A3(n4435), .A4(
        \cpuregs[10][12] ), .Y(n6690) );
  AO22X1_RVT U8244 ( .A1(n4391), .A2(\cpuregs[2][12] ), .A3(n4384), .A4(
        \cpuregs[16][12] ), .Y(n6689) );
  AO22X1_RVT U8245 ( .A1(n4329), .A2(\cpuregs[22][12] ), .A3(n4375), .A4(
        \cpuregs[1][12] ), .Y(n6688) );
  NOR4X1_RVT U8246 ( .A1(n6691), .A2(n6690), .A3(n6689), .A4(n6688), .Y(n6698)
         );
  AO22X1_RVT U8247 ( .A1(n4369), .A2(\cpuregs[5][12] ), .A3(n4387), .A4(
        \cpuregs[23][12] ), .Y(n6696) );
  AO22X1_RVT U8248 ( .A1(n4410), .A2(\cpuregs[12][12] ), .A3(n4488), .A4(
        \cpuregs[24][12] ), .Y(n6694) );
  AO22X1_RVT U8249 ( .A1(n4345), .A2(\cpuregs[6][12] ), .A3(n4407), .A4(
        \cpuregs[29][12] ), .Y(n6693) );
  NOR4X1_RVT U8250 ( .A1(n6696), .A2(n6695), .A3(n6694), .A4(n6693), .Y(n6697)
         );
  NAND3X0_RVT U8251 ( .A1(n6699), .A2(n6698), .A3(n6697), .Y(n6700) );
  AO222X1_RVT U8252 ( .A1(n5208), .A2(n6702), .A3(n5208), .A4(n6701), .A5(
        n4060), .A6(n6700), .Y(n6706) );
  AO22X1_RVT U8253 ( .A1(n8081), .A2(net30608), .A3(n8083), .A4(net30625), .Y(
        n6703) );
  OR2X1_RVT U8254 ( .A1(net24444), .A2(n6703), .Y(n6704) );
  AO21X1_RVT U8255 ( .A1(net30310), .A2(reg_pc[12]), .A3(n6704), .Y(n6705) );
  OA21X1_RVT U8256 ( .A1(n6706), .A2(n6705), .A3(n4057), .Y(n6707) );
  OR2X1_RVT U8257 ( .A1(n6708), .A2(n6707), .Y(n3728) );
  AO22X1_RVT U8258 ( .A1(n4765), .A2(n4592), .A3(n4521), .A4(\cpuregs[20][20] ), .Y(n3202) );
  AO22X1_RVT U8259 ( .A1(n4090), .A2(n4593), .A3(n4626), .A4(\cpuregs[21][20] ), .Y(n3234) );
  AO22X1_RVT U8260 ( .A1(n4741), .A2(n7952), .A3(n4744), .A4(\cpuregs[3][20] ), 
        .Y(n2658) );
  AO22X1_RVT U8261 ( .A1(n4088), .A2(n4593), .A3(n4616), .A4(\cpuregs[29][20] ), .Y(n3490) );
  AO22X1_RVT U8262 ( .A1(n4091), .A2(n4559), .A3(n4525), .A4(\cpuregs[17][18] ), .Y(n3104) );
  AO22X1_RVT U8263 ( .A1(n4682), .A2(n4558), .A3(n4687), .A4(\cpuregs[9][18] ), 
        .Y(n2848) );
  AO22X1_RVT U8264 ( .A1(n4681), .A2(n4560), .A3(n4029), .A4(\cpuregs[11][18] ), .Y(n2912) );
  AO22X1_RVT U8265 ( .A1(n4739), .A2(n7953), .A3(n4743), .A4(\cpuregs[3][18] ), 
        .Y(n2656) );
  AO22X1_RVT U8266 ( .A1(n4089), .A2(n4574), .A3(n4618), .A4(\cpuregs[27][4] ), 
        .Y(n3410) );
  AO22X1_RVT U8267 ( .A1(n4735), .A2(n4575), .A3(n4738), .A4(\cpuregs[1][4] ), 
        .Y(n2578) );
  AO22X1_RVT U8268 ( .A1(n4740), .A2(n7961), .A3(n4743), .A4(\cpuregs[3][9] ), 
        .Y(n2647) );
  AO22X1_RVT U8269 ( .A1(n6462), .A2(n4558), .A3(n4623), .A4(\cpuregs[31][18] ), .Y(n3552) );
  AO22X1_RVT U8270 ( .A1(n4672), .A2(n4582), .A3(n4671), .A4(\cpuregs[15][8] ), 
        .Y(n3030) );
  AO22X1_RVT U8271 ( .A1(n4775), .A2(n4080), .A3(n4522), .A4(\cpuregs[18][8] ), 
        .Y(n3126) );
  AO22X1_RVT U8272 ( .A1(n6086), .A2(n4080), .A3(n4627), .A4(\cpuregs[19][8] ), 
        .Y(n3158) );
  AO22X1_RVT U8273 ( .A1(n4786), .A2(n7962), .A3(n4034), .A4(\cpuregs[23][8] ), 
        .Y(n3286) );
  AO22X1_RVT U8274 ( .A1(n4758), .A2(n4111), .A3(n4762), .A4(\cpuregs[25][8] ), 
        .Y(n3350) );
  AO22X1_RVT U8275 ( .A1(n4694), .A2(n4111), .A3(n4697), .A4(\cpuregs[26][8] ), 
        .Y(n3382) );
  AO22X1_RVT U8276 ( .A1(n4089), .A2(n4080), .A3(n4619), .A4(\cpuregs[27][8] ), 
        .Y(n3414) );
  AO22X1_RVT U8277 ( .A1(n4733), .A2(n4560), .A3(n4737), .A4(\cpuregs[1][18] ), 
        .Y(n2592) );
  AO22X1_RVT U8278 ( .A1(n4734), .A2(n7961), .A3(n4738), .A4(\cpuregs[1][9] ), 
        .Y(n2583) );
  AO22X1_RVT U8279 ( .A1(n4688), .A2(n4111), .A3(n4691), .A4(\cpuregs[28][8] ), 
        .Y(n3446) );
  AO22X1_RVT U8280 ( .A1(n4683), .A2(n4110), .A3(n4686), .A4(\cpuregs[9][9] ), 
        .Y(n2839) );
  AO22X1_RVT U8281 ( .A1(n4028), .A2(n7961), .A3(n4030), .A4(\cpuregs[11][9] ), 
        .Y(n2903) );
  AO22X1_RVT U8282 ( .A1(n4091), .A2(n4584), .A3(n6158), .A4(\cpuregs[17][9] ), 
        .Y(n3095) );
  AO22X1_RVT U8283 ( .A1(n4773), .A2(n4583), .A3(n4523), .A4(\cpuregs[18][9] ), 
        .Y(n3127) );
  AO22X1_RVT U8284 ( .A1(n4104), .A2(n4583), .A3(n4627), .A4(\cpuregs[19][9] ), 
        .Y(n3159) );
  AO22X1_RVT U8285 ( .A1(n4763), .A2(n4110), .A3(n4521), .A4(\cpuregs[20][9] ), 
        .Y(n3191) );
  AO22X1_RVT U8286 ( .A1(n4090), .A2(n4583), .A3(n4626), .A4(\cpuregs[21][9] ), 
        .Y(n3223) );
  AO22X1_RVT U8287 ( .A1(n4768), .A2(n4110), .A3(n4770), .A4(\cpuregs[22][9] ), 
        .Y(n3255) );
  AO22X1_RVT U8288 ( .A1(n4784), .A2(n4583), .A3(n4787), .A4(\cpuregs[23][9] ), 
        .Y(n3287) );
  AO22X1_RVT U8289 ( .A1(n4758), .A2(n4583), .A3(n4760), .A4(\cpuregs[25][9] ), 
        .Y(n3351) );
  AO22X1_RVT U8290 ( .A1(n4694), .A2(n4110), .A3(n4699), .A4(\cpuregs[26][9] ), 
        .Y(n3383) );
  AO22X1_RVT U8291 ( .A1(n4076), .A2(n4110), .A3(n4618), .A4(\cpuregs[27][9] ), 
        .Y(n3415) );
  AO22X1_RVT U8292 ( .A1(n4688), .A2(n4110), .A3(n4693), .A4(\cpuregs[28][9] ), 
        .Y(n3447) );
  AO22X1_RVT U8293 ( .A1(n4106), .A2(n4584), .A3(n4615), .A4(\cpuregs[29][9] ), 
        .Y(n3479) );
  AO22X1_RVT U8294 ( .A1(n4702), .A2(n7961), .A3(n4703), .A4(\cpuregs[30][9] ), 
        .Y(n3511) );
  AO22X1_RVT U8295 ( .A1(n4073), .A2(n4583), .A3(n4621), .A4(\cpuregs[31][9] ), 
        .Y(n3543) );
  AO22X1_RVT U8296 ( .A1(n4684), .A2(n7962), .A3(n4685), .A4(\cpuregs[9][8] ), 
        .Y(n2838) );
  AO22X1_RVT U8297 ( .A1(n4681), .A2(n4111), .A3(n4030), .A4(\cpuregs[11][8] ), 
        .Y(n2902) );
  AO22X1_RVT U8298 ( .A1(n4676), .A2(n4582), .A3(n4023), .A4(\cpuregs[13][8] ), 
        .Y(n2966) );
  AO22X1_RVT U8299 ( .A1(n4735), .A2(n7962), .A3(n4737), .A4(\cpuregs[1][8] ), 
        .Y(n2582) );
  AO22X1_RVT U8300 ( .A1(n4689), .A2(n4560), .A3(n4692), .A4(\cpuregs[28][18] ), .Y(n3456) );
  AO22X1_RVT U8301 ( .A1(n4079), .A2(n4558), .A3(n4620), .A4(\cpuregs[27][18] ), .Y(n3424) );
  AO22X1_RVT U8302 ( .A1(n4700), .A2(n7953), .A3(n4705), .A4(\cpuregs[30][18] ), .Y(n3520) );
  AO22X1_RVT U8303 ( .A1(n4107), .A2(n4559), .A3(n4624), .A4(\cpuregs[21][18] ), .Y(n3232) );
  AO22X1_RVT U8304 ( .A1(n4695), .A2(n4560), .A3(n4698), .A4(\cpuregs[26][18] ), .Y(n3392) );
  AO22X1_RVT U8305 ( .A1(n4759), .A2(n4558), .A3(n4762), .A4(\cpuregs[25][18] ), .Y(n3360) );
  AO22X1_RVT U8306 ( .A1(n4682), .A2(n4574), .A3(n4687), .A4(\cpuregs[9][4] ), 
        .Y(n2834) );
  AO22X1_RVT U8307 ( .A1(n4785), .A2(n4558), .A3(n6043), .A4(\cpuregs[23][18] ), .Y(n3296) );
  AO22X1_RVT U8308 ( .A1(n4071), .A2(n4575), .A3(n4627), .A4(\cpuregs[19][4] ), 
        .Y(n3154) );
  AO22X1_RVT U8309 ( .A1(n4768), .A2(n7953), .A3(n4771), .A4(\cpuregs[22][18] ), .Y(n3264) );
  AO22X1_RVT U8310 ( .A1(n4775), .A2(n4575), .A3(n4522), .A4(\cpuregs[18][4] ), 
        .Y(n3122) );
  AO22X1_RVT U8311 ( .A1(n4688), .A2(n4573), .A3(n4691), .A4(\cpuregs[28][4] ), 
        .Y(n3442) );
  AO22X1_RVT U8312 ( .A1(n4104), .A2(n4560), .A3(n4628), .A4(\cpuregs[19][18] ), .Y(n3168) );
  AO22X1_RVT U8313 ( .A1(n6460), .A2(n4558), .A3(n4615), .A4(\cpuregs[29][18] ), .Y(n3488) );
  AO22X1_RVT U8314 ( .A1(n4674), .A2(n4573), .A3(n4675), .A4(\cpuregs[15][4] ), 
        .Y(n3026) );
  AO22X1_RVT U8315 ( .A1(n4786), .A2(n7964), .A3(n4783), .A4(\cpuregs[23][4] ), 
        .Y(n3282) );
  AO22X1_RVT U8316 ( .A1(n4025), .A2(n4574), .A3(n4023), .A4(\cpuregs[13][4] ), 
        .Y(n2962) );
  AO22X1_RVT U8317 ( .A1(n4759), .A2(n4573), .A3(n4760), .A4(\cpuregs[25][4] ), 
        .Y(n3346) );
  AO22X1_RVT U8318 ( .A1(n4694), .A2(n7964), .A3(n4697), .A4(\cpuregs[26][4] ), 
        .Y(n3378) );
  AO22X1_RVT U8319 ( .A1(n6318), .A2(n4574), .A3(n4026), .A4(\cpuregs[11][4] ), 
        .Y(n2898) );
  AO22X1_RVT U8320 ( .A1(n4764), .A2(n4560), .A3(n4521), .A4(\cpuregs[20][18] ), .Y(n3200) );
  AO22X1_RVT U8321 ( .A1(n4774), .A2(n4559), .A3(n4523), .A4(\cpuregs[18][18] ), .Y(n3136) );
  AO22X1_RVT U8322 ( .A1(n4071), .A2(n4050), .A3(n4627), .A4(\cpuregs[19][13] ), .Y(n3163) );
  AO22X1_RVT U8323 ( .A1(n4673), .A2(n4049), .A3(n4675), .A4(\cpuregs[15][13] ), .Y(n3035) );
  AO22X1_RVT U8324 ( .A1(n6460), .A2(n7957), .A3(n4615), .A4(\cpuregs[29][13] ), .Y(n3483) );
  AO22X1_RVT U8325 ( .A1(n4733), .A2(n4051), .A3(n4738), .A4(\cpuregs[1][13] ), 
        .Y(n2587) );
  AO22X1_RVT U8326 ( .A1(n4773), .A2(n4051), .A3(n4776), .A4(\cpuregs[18][13] ), .Y(n3131) );
  AO22X1_RVT U8327 ( .A1(n4077), .A2(n4080), .A3(n6158), .A4(\cpuregs[17][8] ), 
        .Y(n3094) );
  AO22X1_RVT U8328 ( .A1(n4769), .A2(n7964), .A3(n4772), .A4(\cpuregs[22][4] ), 
        .Y(n3250) );
  AO22X1_RVT U8329 ( .A1(n4741), .A2(n4575), .A3(n4744), .A4(\cpuregs[3][4] ), 
        .Y(n2642) );
  AO22X1_RVT U8330 ( .A1(n4072), .A2(n4573), .A3(n4624), .A4(\cpuregs[21][4] ), 
        .Y(n3218) );
  AO22X1_RVT U8331 ( .A1(n4764), .A2(n7962), .A3(n4521), .A4(\cpuregs[20][8] ), 
        .Y(n3190) );
  AO22X1_RVT U8332 ( .A1(n4765), .A2(n4573), .A3(n6159), .A4(\cpuregs[20][4] ), 
        .Y(n3186) );
  AO22X1_RVT U8333 ( .A1(n4090), .A2(n7962), .A3(n4625), .A4(\cpuregs[21][8] ), 
        .Y(n3222) );
  AO22X1_RVT U8334 ( .A1(n4767), .A2(n4080), .A3(n4770), .A4(\cpuregs[22][8] ), 
        .Y(n3254) );
  AO22X1_RVT U8335 ( .A1(n4077), .A2(n4574), .A3(n4526), .A4(\cpuregs[17][4] ), 
        .Y(n3090) );
  AO22X1_RVT U8336 ( .A1(n4105), .A2(n4111), .A3(n4622), .A4(\cpuregs[31][8] ), 
        .Y(n3542) );
  AO22X1_RVT U8337 ( .A1(n4075), .A2(n7964), .A3(n4622), .A4(\cpuregs[31][4] ), 
        .Y(n3538) );
  AO22X1_RVT U8338 ( .A1(n4739), .A2(n4582), .A3(n4743), .A4(\cpuregs[3][8] ), 
        .Y(n2646) );
  AO22X1_RVT U8339 ( .A1(n6460), .A2(n7962), .A3(n4616), .A4(\cpuregs[29][8] ), 
        .Y(n3478) );
  AO22X1_RVT U8340 ( .A1(n4106), .A2(n4575), .A3(n4615), .A4(\cpuregs[29][4] ), 
        .Y(n3474) );
  AO22X1_RVT U8341 ( .A1(n4739), .A2(n7957), .A3(n4744), .A4(\cpuregs[3][13] ), 
        .Y(n2651) );
  AO22X1_RVT U8342 ( .A1(n6085), .A2(n7957), .A3(n4625), .A4(\cpuregs[21][13] ), .Y(n3227) );
  AO22X1_RVT U8343 ( .A1(n4688), .A2(n4562), .A3(n4692), .A4(\cpuregs[28][19] ), .Y(n3457) );
  AO22X1_RVT U8344 ( .A1(n4763), .A2(n4051), .A3(n4520), .A4(\cpuregs[20][13] ), .Y(n3195) );
  AO22X1_RVT U8345 ( .A1(n4077), .A2(n4051), .A3(n4527), .A4(\cpuregs[17][13] ), .Y(n3099) );
  AO22X1_RVT U8346 ( .A1(n4701), .A2(n4087), .A3(n4705), .A4(\cpuregs[30][19] ), .Y(n3521) );
  AO22X1_RVT U8347 ( .A1(n4106), .A2(n4561), .A3(n4617), .A4(\cpuregs[29][19] ), .Y(n3489) );
  AO22X1_RVT U8348 ( .A1(n4767), .A2(n4087), .A3(n4771), .A4(\cpuregs[22][19] ), .Y(n3265) );
  AO22X1_RVT U8349 ( .A1(n4072), .A2(n7956), .A3(n4626), .A4(\cpuregs[21][19] ), .Y(n3233) );
  AO22X1_RVT U8350 ( .A1(n4763), .A2(n4562), .A3(n4766), .A4(\cpuregs[20][19] ), .Y(n3201) );
  AO22X1_RVT U8351 ( .A1(n4071), .A2(n4561), .A3(n4627), .A4(\cpuregs[19][19] ), .Y(n3169) );
  AO22X1_RVT U8352 ( .A1(n4773), .A2(n4561), .A3(n4776), .A4(\cpuregs[18][19] ), .Y(n3137) );
  AO22X1_RVT U8353 ( .A1(n4646), .A2(n4561), .A3(n4526), .A4(\cpuregs[17][19] ), .Y(n3105) );
  AO22X1_RVT U8354 ( .A1(n4674), .A2(n4561), .A3(n6225), .A4(\cpuregs[15][19] ), .Y(n3041) );
  AO22X1_RVT U8355 ( .A1(n6461), .A2(n4562), .A3(n4618), .A4(\cpuregs[27][19] ), .Y(n3425) );
  AO22X1_RVT U8356 ( .A1(n4694), .A2(n4561), .A3(n4698), .A4(\cpuregs[26][19] ), .Y(n3393) );
  AO22X1_RVT U8357 ( .A1(n4712), .A2(n4562), .A3(n4716), .A4(\cpuregs[24][19] ), .Y(n3329) );
  AO22X1_RVT U8358 ( .A1(n4784), .A2(n4103), .A3(n4787), .A4(\cpuregs[23][19] ), .Y(n3297) );
  AO22X1_RVT U8359 ( .A1(n4757), .A2(n4577), .A3(n4762), .A4(\cpuregs[25][3] ), 
        .Y(n3345) );
  AO22X1_RVT U8360 ( .A1(n4646), .A2(n7965), .A3(n4526), .A4(\cpuregs[17][3] ), 
        .Y(n3089) );
  AO22X1_RVT U8361 ( .A1(n4784), .A2(n4050), .A3(n4783), .A4(\cpuregs[23][13] ), .Y(n3291) );
  AO22X1_RVT U8362 ( .A1(n4076), .A2(n4576), .A3(n4619), .A4(\cpuregs[27][3] ), 
        .Y(n3409) );
  AO22X1_RVT U8363 ( .A1(n4689), .A2(n7965), .A3(n4692), .A4(\cpuregs[28][3] ), 
        .Y(n3441) );
  AO22X1_RVT U8364 ( .A1(n4734), .A2(n4115), .A3(n4737), .A4(\cpuregs[1][3] ), 
        .Y(n2577) );
  AO22X1_RVT U8365 ( .A1(n6462), .A2(n4577), .A3(n4621), .A4(\cpuregs[31][3] ), 
        .Y(n3537) );
  AO22X1_RVT U8366 ( .A1(n4785), .A2(n4115), .A3(n4034), .A4(\cpuregs[23][3] ), 
        .Y(n3281) );
  AO22X1_RVT U8367 ( .A1(n4774), .A2(n4576), .A3(n4523), .A4(\cpuregs[18][3] ), 
        .Y(n3121) );
  AO22X1_RVT U8368 ( .A1(n4104), .A2(n4576), .A3(n4629), .A4(\cpuregs[19][3] ), 
        .Y(n3153) );
  AO22X1_RVT U8369 ( .A1(n4764), .A2(n4577), .A3(n4521), .A4(\cpuregs[20][3] ), 
        .Y(n3185) );
  AO22X1_RVT U8370 ( .A1(n4681), .A2(n4561), .A3(n4026), .A4(\cpuregs[11][19] ), .Y(n2913) );
  AO22X1_RVT U8371 ( .A1(n4740), .A2(n4576), .A3(n4743), .A4(\cpuregs[3][3] ), 
        .Y(n2641) );
  AO22X1_RVT U8372 ( .A1(n4683), .A2(n4576), .A3(n4685), .A4(\cpuregs[9][3] ), 
        .Y(n2833) );
  AO22X1_RVT U8373 ( .A1(n4673), .A2(n4576), .A3(n6225), .A4(\cpuregs[15][3] ), 
        .Y(n3025) );
  AO22X1_RVT U8374 ( .A1(n4681), .A2(n4577), .A3(n4029), .A4(\cpuregs[11][3] ), 
        .Y(n2897) );
  AO22X1_RVT U8375 ( .A1(n4739), .A2(n4103), .A3(n4744), .A4(\cpuregs[3][19] ), 
        .Y(n2657) );
  AO22X1_RVT U8376 ( .A1(n4074), .A2(n4577), .A3(n4617), .A4(\cpuregs[29][3] ), 
        .Y(n3473) );
  AO22X1_RVT U8377 ( .A1(n4695), .A2(n4577), .A3(n4698), .A4(\cpuregs[26][3] ), 
        .Y(n3377) );
  AO22X1_RVT U8378 ( .A1(n4689), .A2(n7957), .A3(n4692), .A4(\cpuregs[28][13] ), .Y(n3451) );
  AO22X1_RVT U8379 ( .A1(n4713), .A2(n4115), .A3(n4716), .A4(\cpuregs[24][3] ), 
        .Y(n3313) );
  AO22X1_RVT U8380 ( .A1(n6085), .A2(n4577), .A3(n4626), .A4(\cpuregs[21][3] ), 
        .Y(n3217) );
  AO22X1_RVT U8381 ( .A1(n4682), .A2(n4562), .A3(n4687), .A4(\cpuregs[9][19] ), 
        .Y(n2849) );
  AO22X1_RVT U8382 ( .A1(n4733), .A2(n4087), .A3(n4737), .A4(\cpuregs[1][19] ), 
        .Y(n2593) );
  AO22X1_RVT U8383 ( .A1(n4688), .A2(n4102), .A3(n4692), .A4(\cpuregs[28][20] ), .Y(n3458) );
  AO22X1_RVT U8384 ( .A1(n4714), .A2(n4102), .A3(n4716), .A4(\cpuregs[24][20] ), .Y(n3330) );
  AO22X1_RVT U8385 ( .A1(n4733), .A2(n4593), .A3(n4738), .A4(\cpuregs[1][20] ), 
        .Y(n2594) );
  AO22X1_RVT U8386 ( .A1(n4758), .A2(n4050), .A3(n4760), .A4(\cpuregs[25][13] ), .Y(n3355) );
  AO22X1_RVT U8387 ( .A1(n4683), .A2(n4050), .A3(n4686), .A4(\cpuregs[9][13] ), 
        .Y(n2843) );
  AO22X1_RVT U8388 ( .A1(n4682), .A2(n7952), .A3(n4686), .A4(\cpuregs[9][20] ), 
        .Y(n2850) );
  AO22X1_RVT U8389 ( .A1(n4075), .A2(n4051), .A3(n4623), .A4(\cpuregs[31][13] ), .Y(n3547) );
  AO22X1_RVT U8390 ( .A1(n4076), .A2(n7957), .A3(n4619), .A4(\cpuregs[27][13] ), .Y(n3419) );
  AO22X1_RVT U8391 ( .A1(n4789), .A2(n4102), .A3(n4629), .A4(\cpuregs[19][20] ), .Y(n3170) );
  AO22X1_RVT U8392 ( .A1(n4681), .A2(n4592), .A3(n4027), .A4(\cpuregs[11][20] ), .Y(n2914) );
  AO22X1_RVT U8393 ( .A1(n4774), .A2(n4592), .A3(n4523), .A4(\cpuregs[18][20] ), .Y(n3138) );
  AO22X1_RVT U8394 ( .A1(n4695), .A2(n4050), .A3(n4698), .A4(\cpuregs[26][13] ), .Y(n3387) );
  AO22X1_RVT U8395 ( .A1(n6461), .A2(n4102), .A3(n4618), .A4(\cpuregs[27][20] ), .Y(n3426) );
  AO22X1_RVT U8396 ( .A1(n4785), .A2(n4102), .A3(n4034), .A4(\cpuregs[23][20] ), .Y(n3298) );
  AO22X1_RVT U8397 ( .A1(n4694), .A2(n4593), .A3(n4698), .A4(\cpuregs[26][20] ), .Y(n3394) );
  AO22X1_RVT U8398 ( .A1(n4673), .A2(n4592), .A3(n4675), .A4(\cpuregs[15][20] ), .Y(n3042) );
  AO22X1_RVT U8399 ( .A1(n4769), .A2(n7957), .A3(n4770), .A4(\cpuregs[22][13] ), .Y(n3259) );
  AO22X1_RVT U8400 ( .A1(n4679), .A2(n4051), .A3(n4027), .A4(\cpuregs[11][13] ), .Y(n2907) );
  AO22X1_RVT U8401 ( .A1(n4700), .A2(n4102), .A3(n4704), .A4(\cpuregs[30][20] ), .Y(n3522) );
  AO22X1_RVT U8402 ( .A1(n4073), .A2(n4592), .A3(n4621), .A4(\cpuregs[31][20] ), .Y(n3554) );
  AO22X1_RVT U8403 ( .A1(n4768), .A2(n4102), .A3(n4771), .A4(\cpuregs[22][20] ), .Y(n3266) );
  AO22X1_RVT U8404 ( .A1(n4789), .A2(n4609), .A3(n4627), .A4(\cpuregs[19][1] ), 
        .Y(n3151) );
  AO22X1_RVT U8405 ( .A1(n4079), .A2(n7967), .A3(n4620), .A4(\cpuregs[27][1] ), 
        .Y(n3407) );
  AO22X1_RVT U8406 ( .A1(n4683), .A2(n4094), .A3(n4686), .A4(\cpuregs[9][1] ), 
        .Y(n2831) );
  AO22X1_RVT U8407 ( .A1(n4774), .A2(n4113), .A3(n4776), .A4(\cpuregs[18][1] ), 
        .Y(n3119) );
  AO22X1_RVT U8408 ( .A1(n4672), .A2(n7967), .A3(n4671), .A4(\cpuregs[15][1] ), 
        .Y(n3023) );
  AO22X1_RVT U8409 ( .A1(n4679), .A2(n7967), .A3(n4030), .A4(\cpuregs[11][1] ), 
        .Y(n2895) );
  AO22X1_RVT U8410 ( .A1(n4689), .A2(n4609), .A3(n4692), .A4(\cpuregs[28][1] ), 
        .Y(n3439) );
  AO22X1_RVT U8411 ( .A1(n4695), .A2(n4094), .A3(n4698), .A4(\cpuregs[26][1] ), 
        .Y(n3375) );
  AO22X1_RVT U8412 ( .A1(n4785), .A2(n4094), .A3(n4787), .A4(\cpuregs[23][1] ), 
        .Y(n3279) );
  AO22X1_RVT U8413 ( .A1(n4758), .A2(n4094), .A3(n4761), .A4(\cpuregs[25][1] ), 
        .Y(n3343) );
  AO22X1_RVT U8414 ( .A1(n4025), .A2(n4113), .A3(n4022), .A4(\cpuregs[13][1] ), 
        .Y(n2959) );
  AO22X1_RVT U8415 ( .A1(n4768), .A2(n7967), .A3(n4772), .A4(\cpuregs[22][1] ), 
        .Y(n3247) );
  AO22X1_RVT U8416 ( .A1(n6085), .A2(n4609), .A3(n4625), .A4(\cpuregs[21][1] ), 
        .Y(n3215) );
  AO22X1_RVT U8417 ( .A1(n4075), .A2(n4609), .A3(n4623), .A4(\cpuregs[31][1] ), 
        .Y(n3535) );
  AO22X1_RVT U8418 ( .A1(n4764), .A2(n4609), .A3(n4521), .A4(\cpuregs[20][1] ), 
        .Y(n3183) );
  AO22X1_RVT U8419 ( .A1(n4091), .A2(n4094), .A3(n4527), .A4(\cpuregs[17][1] ), 
        .Y(n3087) );
  AO22X1_RVT U8420 ( .A1(n6460), .A2(n4094), .A3(n4615), .A4(\cpuregs[29][1] ), 
        .Y(n3471) );
  AO22X1_RVT U8421 ( .A1(n4734), .A2(n7967), .A3(n4738), .A4(\cpuregs[1][1] ), 
        .Y(n2575) );
  AO22X1_RVT U8422 ( .A1(n4740), .A2(n4113), .A3(n4744), .A4(\cpuregs[3][1] ), 
        .Y(n2639) );
  AO22X1_RVT U8423 ( .A1(n4777), .A2(n4039), .A3(n4781), .A4(\cpuregs[16][14] ), .Y(n3068) );
  AO22X1_RVT U8424 ( .A1(n4777), .A2(n4011), .A3(n4780), .A4(\cpuregs[16][23] ), .Y(n3077) );
  AO22X1_RVT U8425 ( .A1(n4779), .A2(n4581), .A3(n4782), .A4(\cpuregs[16][7] ), 
        .Y(n3061) );
  AO22X1_RVT U8426 ( .A1(n4778), .A2(n4099), .A3(n4781), .A4(\cpuregs[16][25] ), .Y(n3079) );
  AO22X1_RVT U8427 ( .A1(n4752), .A2(n4084), .A3(n4756), .A4(\cpuregs[7][24] ), 
        .Y(n2790) );
  AO22X1_RVT U8428 ( .A1(n4684), .A2(n4594), .A3(n4686), .A4(\cpuregs[9][24] ), 
        .Y(n2854) );
  AO22X1_RVT U8429 ( .A1(n4696), .A2(n6709), .A3(n4699), .A4(\cpuregs[26][24] ), .Y(n3398) );
  AO22X1_RVT U8430 ( .A1(n4701), .A2(n4037), .A3(n4703), .A4(\cpuregs[30][14] ), .Y(n3516) );
  AO22X1_RVT U8431 ( .A1(n4073), .A2(n4011), .A3(n4622), .A4(\cpuregs[31][23] ), .Y(n3557) );
  AO22X1_RVT U8432 ( .A1(n4778), .A2(n4084), .A3(n4780), .A4(\cpuregs[16][24] ), .Y(n3078) );
  AO22X1_RVT U8433 ( .A1(n4769), .A2(n6709), .A3(n4770), .A4(\cpuregs[22][24] ), .Y(n3270) );
  AO22X1_RVT U8434 ( .A1(n4654), .A2(n6709), .A3(n4657), .A4(\cpuregs[12][24] ), .Y(n2950) );
  AO22X1_RVT U8435 ( .A1(n4674), .A2(n4084), .A3(n4671), .A4(\cpuregs[15][24] ), .Y(n3046) );
  AO22X1_RVT U8436 ( .A1(n4785), .A2(n4083), .A3(n4783), .A4(\cpuregs[23][25] ), .Y(n3303) );
  AO22X1_RVT U8437 ( .A1(n4680), .A2(n4084), .A3(n4027), .A4(\cpuregs[11][24] ), .Y(n2918) );
  AO22X1_RVT U8438 ( .A1(n4775), .A2(n4084), .A3(n4523), .A4(\cpuregs[18][24] ), .Y(n3142) );
  AO22X1_RVT U8439 ( .A1(n4660), .A2(n6709), .A3(n4664), .A4(\cpuregs[14][24] ), .Y(n3014) );
  AO22X1_RVT U8440 ( .A1(n4072), .A2(n4100), .A3(n4626), .A4(\cpuregs[21][24] ), .Y(n3238) );
  AO22X1_RVT U8441 ( .A1(n4788), .A2(n6709), .A3(n4629), .A4(\cpuregs[19][24] ), .Y(n3174) );
  AO22X1_RVT U8442 ( .A1(n4706), .A2(n6710), .A3(n4710), .A4(\cpuregs[6][23] ), 
        .Y(n2757) );
  AO22X1_RVT U8443 ( .A1(n4079), .A2(n6709), .A3(n4620), .A4(\cpuregs[27][24] ), .Y(n3430) );
  AO22X1_RVT U8444 ( .A1(n4786), .A2(n4100), .A3(n4787), .A4(\cpuregs[23][24] ), .Y(n3302) );
  AO22X1_RVT U8445 ( .A1(n4076), .A2(n4045), .A3(n4620), .A4(\cpuregs[27][30] ), .Y(n3436) );
  AO22X1_RVT U8446 ( .A1(n4690), .A2(n6709), .A3(n4693), .A4(\cpuregs[28][24] ), .Y(n3462) );
  AO22X1_RVT U8447 ( .A1(n4073), .A2(n4100), .A3(n4622), .A4(\cpuregs[31][24] ), .Y(n3558) );
  AO22X1_RVT U8448 ( .A1(n4733), .A2(n4013), .A3(n4737), .A4(\cpuregs[1][23] ), 
        .Y(n2597) );
  AO22X1_RVT U8449 ( .A1(n4768), .A2(n4099), .A3(n4772), .A4(\cpuregs[22][25] ), .Y(n3271) );
  AO22X1_RVT U8450 ( .A1(n4724), .A2(n4011), .A3(n4728), .A4(\cpuregs[2][23] ), 
        .Y(n2629) );
  AO22X1_RVT U8451 ( .A1(n4739), .A2(n4012), .A3(n4742), .A4(\cpuregs[3][23] ), 
        .Y(n2661) );
  AO22X1_RVT U8452 ( .A1(n4718), .A2(n4011), .A3(n4722), .A4(\cpuregs[4][23] ), 
        .Y(n2693) );
  AO22X1_RVT U8453 ( .A1(n4745), .A2(n4012), .A3(n4749), .A4(\cpuregs[5][23] ), 
        .Y(n2725) );
  AO22X1_RVT U8454 ( .A1(n4074), .A2(n4037), .A3(n4617), .A4(\cpuregs[29][14] ), .Y(n3484) );
  AO22X1_RVT U8455 ( .A1(n4689), .A2(n4013), .A3(n4691), .A4(\cpuregs[28][23] ), .Y(n3461) );
  AO22X1_RVT U8456 ( .A1(n4079), .A2(n4011), .A3(n4620), .A4(\cpuregs[27][23] ), .Y(n3429) );
  AO22X1_RVT U8457 ( .A1(n4695), .A2(n6710), .A3(n4697), .A4(\cpuregs[26][23] ), .Y(n3397) );
  AO22X1_RVT U8458 ( .A1(n4079), .A2(n4040), .A3(n4618), .A4(\cpuregs[27][14] ), .Y(n3420) );
  AO22X1_RVT U8459 ( .A1(n4759), .A2(n4041), .A3(n4761), .A4(\cpuregs[25][14] ), .Y(n3356) );
  AO22X1_RVT U8460 ( .A1(n4785), .A2(n6710), .A3(n4783), .A4(\cpuregs[23][23] ), .Y(n3301) );
  AO22X1_RVT U8461 ( .A1(n4784), .A2(n4043), .A3(n4787), .A4(\cpuregs[23][14] ), .Y(n3292) );
  AO22X1_RVT U8462 ( .A1(n4768), .A2(n4044), .A3(n4772), .A4(\cpuregs[22][14] ), .Y(n3260) );
  AO22X1_RVT U8463 ( .A1(n6085), .A2(n4042), .A3(n4625), .A4(\cpuregs[21][14] ), .Y(n3228) );
  AO22X1_RVT U8464 ( .A1(n4764), .A2(n4041), .A3(n4766), .A4(\cpuregs[20][14] ), .Y(n3196) );
  AO22X1_RVT U8465 ( .A1(n4104), .A2(n4040), .A3(n4628), .A4(\cpuregs[19][14] ), .Y(n3164) );
  AO22X1_RVT U8466 ( .A1(n4774), .A2(n4042), .A3(n4522), .A4(\cpuregs[18][14] ), .Y(n3132) );
  AO22X1_RVT U8467 ( .A1(n4646), .A2(n4043), .A3(n4526), .A4(\cpuregs[17][14] ), .Y(n3100) );
  AO22X1_RVT U8468 ( .A1(n4673), .A2(n4042), .A3(n4671), .A4(\cpuregs[15][14] ), .Y(n3036) );
  AO22X1_RVT U8469 ( .A1(n6317), .A2(n4040), .A3(n4023), .A4(\cpuregs[13][14] ), .Y(n2972) );
  AO22X1_RVT U8470 ( .A1(n4653), .A2(n4044), .A3(n4658), .A4(\cpuregs[12][14] ), .Y(n2940) );
  AO22X1_RVT U8471 ( .A1(n4769), .A2(n6710), .A3(n4771), .A4(\cpuregs[22][23] ), .Y(n3269) );
  AO22X1_RVT U8472 ( .A1(n4107), .A2(n4013), .A3(n4625), .A4(\cpuregs[21][23] ), .Y(n3237) );
  AO22X1_RVT U8473 ( .A1(n4763), .A2(n4011), .A3(n4520), .A4(\cpuregs[20][23] ), .Y(n3205) );
  AO22X1_RVT U8474 ( .A1(n6086), .A2(n4012), .A3(n4629), .A4(\cpuregs[19][23] ), .Y(n3173) );
  AO22X1_RVT U8475 ( .A1(n4773), .A2(n4011), .A3(n4522), .A4(\cpuregs[18][23] ), .Y(n3141) );
  AO22X1_RVT U8476 ( .A1(n4108), .A2(n4011), .A3(n4525), .A4(\cpuregs[17][23] ), .Y(n3109) );
  AO22X1_RVT U8477 ( .A1(n4674), .A2(n4011), .A3(n4671), .A4(\cpuregs[15][23] ), .Y(n3045) );
  AO22X1_RVT U8478 ( .A1(n4659), .A2(n6710), .A3(n4662), .A4(\cpuregs[14][23] ), .Y(n3013) );
  AO22X1_RVT U8479 ( .A1(n4679), .A2(n4039), .A3(n4026), .A4(\cpuregs[11][14] ), .Y(n2908) );
  AO22X1_RVT U8480 ( .A1(n4653), .A2(n6710), .A3(n4656), .A4(\cpuregs[12][23] ), .Y(n2949) );
  AO22X1_RVT U8481 ( .A1(n6318), .A2(n4012), .A3(n4026), .A4(\cpuregs[11][23] ), .Y(n2917) );
  AO22X1_RVT U8482 ( .A1(n4734), .A2(n4042), .A3(n4736), .A4(\cpuregs[1][14] ), 
        .Y(n2588) );
  AO22X1_RVT U8483 ( .A1(n4724), .A2(n4040), .A3(n4727), .A4(\cpuregs[2][14] ), 
        .Y(n2620) );
  AO22X1_RVT U8484 ( .A1(n4665), .A2(n4044), .A3(n4668), .A4(\cpuregs[10][14] ), .Y(n2876) );
  AO22X1_RVT U8485 ( .A1(n4682), .A2(n6710), .A3(n4686), .A4(\cpuregs[9][23] ), 
        .Y(n2853) );
  AO22X1_RVT U8486 ( .A1(n4683), .A2(n4041), .A3(n4687), .A4(\cpuregs[9][14] ), 
        .Y(n2844) );
  AO22X1_RVT U8487 ( .A1(n4740), .A2(n4044), .A3(n4742), .A4(\cpuregs[3][14] ), 
        .Y(n2652) );
  AO22X1_RVT U8488 ( .A1(n4751), .A2(n4012), .A3(n4754), .A4(\cpuregs[7][23] ), 
        .Y(n2789) );
  AO22X1_RVT U8489 ( .A1(n4718), .A2(n4036), .A3(n4721), .A4(\cpuregs[4][14] ), 
        .Y(n2684) );
  AO22X1_RVT U8490 ( .A1(n4745), .A2(n4039), .A3(n4748), .A4(\cpuregs[5][14] ), 
        .Y(n2716) );
  AO22X1_RVT U8491 ( .A1(n4706), .A2(n4042), .A3(n4709), .A4(\cpuregs[6][14] ), 
        .Y(n2748) );
  AO22X1_RVT U8492 ( .A1(n4077), .A2(n4084), .A3(n4527), .A4(\cpuregs[17][24] ), .Y(n3110) );
  AO22X1_RVT U8493 ( .A1(n4694), .A2(n6712), .A3(n4699), .A4(\cpuregs[26][30] ), .Y(n3404) );
  AO22X1_RVT U8494 ( .A1(n4073), .A2(n4046), .A3(n4623), .A4(\cpuregs[31][30] ), .Y(n3564) );
  AO22X1_RVT U8495 ( .A1(n4784), .A2(n4045), .A3(n4783), .A4(\cpuregs[23][30] ), .Y(n3308) );
  AO22X1_RVT U8496 ( .A1(n4767), .A2(n4046), .A3(n4771), .A4(\cpuregs[22][30] ), .Y(n3276) );
  AO22X1_RVT U8497 ( .A1(n4725), .A2(n6712), .A3(n4729), .A4(\cpuregs[2][30] ), 
        .Y(n2636) );
  AO22X1_RVT U8498 ( .A1(n4741), .A2(n6712), .A3(n4744), .A4(\cpuregs[3][30] ), 
        .Y(n2668) );
  AO22X1_RVT U8499 ( .A1(n4719), .A2(n4046), .A3(n4723), .A4(\cpuregs[4][30] ), 
        .Y(n2700) );
  AO22X1_RVT U8500 ( .A1(n6085), .A2(n4047), .A3(n4624), .A4(\cpuregs[21][30] ), .Y(n3244) );
  AO22X1_RVT U8501 ( .A1(n4746), .A2(n4046), .A3(n4750), .A4(\cpuregs[5][30] ), 
        .Y(n2732) );
  AO22X1_RVT U8502 ( .A1(n4707), .A2(n4045), .A3(n4711), .A4(\cpuregs[6][30] ), 
        .Y(n2764) );
  AO22X1_RVT U8503 ( .A1(n4765), .A2(n4045), .A3(n4520), .A4(\cpuregs[20][30] ), .Y(n3212) );
  AO22X1_RVT U8504 ( .A1(n4753), .A2(n4047), .A3(n4754), .A4(\cpuregs[7][30] ), 
        .Y(n2796) );
  AO22X1_RVT U8505 ( .A1(n4104), .A2(n4046), .A3(n4627), .A4(\cpuregs[19][30] ), .Y(n3180) );
  AO22X1_RVT U8506 ( .A1(n4773), .A2(n6712), .A3(n4523), .A4(\cpuregs[18][30] ), .Y(n3148) );
  AO22X1_RVT U8507 ( .A1(n4108), .A2(n4047), .A3(n4526), .A4(\cpuregs[17][30] ), .Y(n3116) );
  AO22X1_RVT U8508 ( .A1(n4779), .A2(n4047), .A3(n4782), .A4(\cpuregs[16][30] ), .Y(n3084) );
  AO22X1_RVT U8509 ( .A1(n4672), .A2(n4045), .A3(n4671), .A4(\cpuregs[15][30] ), .Y(n3052) );
  AO22X1_RVT U8510 ( .A1(n4661), .A2(n4047), .A3(n4662), .A4(\cpuregs[14][30] ), .Y(n3020) );
  AO22X1_RVT U8511 ( .A1(n4655), .A2(n4046), .A3(n4656), .A4(\cpuregs[12][30] ), .Y(n2956) );
  AO22X1_RVT U8512 ( .A1(n4680), .A2(n4046), .A3(n4029), .A4(\cpuregs[11][30] ), .Y(n2924) );
  AO22X1_RVT U8513 ( .A1(n4682), .A2(n4045), .A3(n4685), .A4(\cpuregs[9][30] ), 
        .Y(n2860) );
  AO22X1_RVT U8514 ( .A1(n4696), .A2(n4595), .A3(n4697), .A4(\cpuregs[26][25] ), .Y(n3399) );
  AO22X1_RVT U8515 ( .A1(n4763), .A2(n6709), .A3(n4520), .A4(\cpuregs[20][24] ), .Y(n3206) );
  AO22X1_RVT U8516 ( .A1(n4730), .A2(n4595), .A3(n4620), .A4(\cpuregs[27][25] ), .Y(n3431) );
  AO22X1_RVT U8517 ( .A1(n4690), .A2(n4597), .A3(n4691), .A4(\cpuregs[28][25] ), .Y(n3463) );
  AO22X1_RVT U8518 ( .A1(n4701), .A2(n4099), .A3(n4704), .A4(\cpuregs[30][25] ), .Y(n3527) );
  AO22X1_RVT U8519 ( .A1(n4702), .A2(n6714), .A3(n4703), .A4(\cpuregs[30][7] ), 
        .Y(n3509) );
  AO22X1_RVT U8520 ( .A1(n4106), .A2(n4095), .A3(n4615), .A4(\cpuregs[29][7] ), 
        .Y(n3477) );
  AO22X1_RVT U8521 ( .A1(n6461), .A2(n4581), .A3(n4618), .A4(\cpuregs[27][7] ), 
        .Y(n3413) );
  AO22X1_RVT U8522 ( .A1(n4757), .A2(n6714), .A3(n4761), .A4(\cpuregs[25][7] ), 
        .Y(n3349) );
  AO22X1_RVT U8523 ( .A1(n4786), .A2(n4581), .A3(n4787), .A4(\cpuregs[23][7] ), 
        .Y(n3285) );
  AO22X1_RVT U8524 ( .A1(n4767), .A2(n4581), .A3(n4770), .A4(\cpuregs[22][7] ), 
        .Y(n3253) );
  AO22X1_RVT U8525 ( .A1(n4090), .A2(n4081), .A3(n4625), .A4(\cpuregs[21][7] ), 
        .Y(n3221) );
  AO22X1_RVT U8526 ( .A1(n4764), .A2(n6714), .A3(n4766), .A4(\cpuregs[20][7] ), 
        .Y(n3189) );
  AO22X1_RVT U8527 ( .A1(n6086), .A2(n4081), .A3(n4628), .A4(\cpuregs[19][7] ), 
        .Y(n3157) );
  AO22X1_RVT U8528 ( .A1(n4774), .A2(n4095), .A3(n4776), .A4(\cpuregs[18][7] ), 
        .Y(n3125) );
  AO22X1_RVT U8529 ( .A1(n4108), .A2(n4581), .A3(n4527), .A4(\cpuregs[17][7] ), 
        .Y(n3093) );
  AO22X1_RVT U8530 ( .A1(n4672), .A2(n6714), .A3(n4675), .A4(\cpuregs[15][7] ), 
        .Y(n3029) );
  AO22X1_RVT U8531 ( .A1(n4025), .A2(n6714), .A3(n4024), .A4(\cpuregs[13][7] ), 
        .Y(n2965) );
  AO22X1_RVT U8532 ( .A1(n4655), .A2(n4095), .A3(n4658), .A4(\cpuregs[12][7] ), 
        .Y(n2933) );
  AO22X1_RVT U8533 ( .A1(n6318), .A2(n4095), .A3(n4030), .A4(\cpuregs[11][7] ), 
        .Y(n2901) );
  AO22X1_RVT U8534 ( .A1(n4666), .A2(n6714), .A3(n4669), .A4(\cpuregs[10][7] ), 
        .Y(n2869) );
  AO22X1_RVT U8535 ( .A1(n4684), .A2(n4581), .A3(n4685), .A4(\cpuregs[9][7] ), 
        .Y(n2837) );
  AO22X1_RVT U8536 ( .A1(n4708), .A2(n4581), .A3(n4711), .A4(\cpuregs[6][7] ), 
        .Y(n2741) );
  AO22X1_RVT U8537 ( .A1(n4735), .A2(n6709), .A3(n4737), .A4(\cpuregs[1][24] ), 
        .Y(n2598) );
  AO22X1_RVT U8538 ( .A1(n4726), .A2(n4100), .A3(n4727), .A4(\cpuregs[2][24] ), 
        .Y(n2630) );
  AO22X1_RVT U8539 ( .A1(n4688), .A2(n4046), .A3(n4693), .A4(\cpuregs[28][30] ), .Y(n3468) );
  AO22X1_RVT U8540 ( .A1(n4739), .A2(n6709), .A3(n4743), .A4(\cpuregs[3][24] ), 
        .Y(n2662) );
  AO22X1_RVT U8541 ( .A1(n4720), .A2(n4100), .A3(n4721), .A4(\cpuregs[4][24] ), 
        .Y(n2694) );
  AO22X1_RVT U8542 ( .A1(n4747), .A2(n4084), .A3(n4748), .A4(\cpuregs[5][24] ), 
        .Y(n2726) );
  AO22X1_RVT U8543 ( .A1(n4708), .A2(n4594), .A3(n4709), .A4(\cpuregs[6][24] ), 
        .Y(n2758) );
  AO22X1_RVT U8544 ( .A1(n4747), .A2(n4081), .A3(n4750), .A4(\cpuregs[5][7] ), 
        .Y(n2709) );
  AO22X1_RVT U8545 ( .A1(n4720), .A2(n4081), .A3(n4723), .A4(\cpuregs[4][7] ), 
        .Y(n2677) );
  AO22X1_RVT U8546 ( .A1(n4660), .A2(n4099), .A3(n4663), .A4(\cpuregs[14][25] ), .Y(n3015) );
  AO22X1_RVT U8547 ( .A1(n4654), .A2(n4597), .A3(n4657), .A4(\cpuregs[12][25] ), .Y(n2951) );
  AO22X1_RVT U8548 ( .A1(n4678), .A2(n4595), .A3(n4023), .A4(\cpuregs[13][25] ), .Y(n2983) );
  AO22X1_RVT U8549 ( .A1(n4719), .A2(n4083), .A3(n4722), .A4(\cpuregs[4][25] ), 
        .Y(n2695) );
  AO22X1_RVT U8550 ( .A1(n4726), .A2(n4081), .A3(n4729), .A4(\cpuregs[2][7] ), 
        .Y(n2613) );
  AO22X1_RVT U8551 ( .A1(n4790), .A2(n4597), .A3(n4624), .A4(\cpuregs[21][25] ), .Y(n3239) );
  AO22X1_RVT U8552 ( .A1(n4734), .A2(n6713), .A3(n4736), .A4(\cpuregs[1][25] ), 
        .Y(n2599) );
  AO22X1_RVT U8553 ( .A1(n4725), .A2(n4595), .A3(n4728), .A4(\cpuregs[2][25] ), 
        .Y(n2631) );
  AO22X1_RVT U8554 ( .A1(n4740), .A2(n4596), .A3(n4742), .A4(\cpuregs[3][25] ), 
        .Y(n2663) );
  AO22X1_RVT U8555 ( .A1(n4733), .A2(n4047), .A3(n4736), .A4(\cpuregs[1][30] ), 
        .Y(n2604) );
  AO22X1_RVT U8556 ( .A1(n4775), .A2(n6713), .A3(n4522), .A4(\cpuregs[18][25] ), .Y(n3143) );
  AO22X1_RVT U8557 ( .A1(n4746), .A2(n4083), .A3(n4749), .A4(\cpuregs[5][25] ), 
        .Y(n2727) );
  AO22X1_RVT U8558 ( .A1(n4707), .A2(n4597), .A3(n4710), .A4(\cpuregs[6][25] ), 
        .Y(n2759) );
  AO22X1_RVT U8559 ( .A1(n4673), .A2(n4596), .A3(n4671), .A4(\cpuregs[15][25] ), .Y(n3047) );
  AO22X1_RVT U8560 ( .A1(n4679), .A2(n4099), .A3(n4030), .A4(\cpuregs[11][25] ), .Y(n2919) );
  AO22X1_RVT U8561 ( .A1(n4788), .A2(n4595), .A3(n4627), .A4(\cpuregs[19][25] ), .Y(n3175) );
  AO22X1_RVT U8562 ( .A1(n4752), .A2(n4595), .A3(n4755), .A4(\cpuregs[7][25] ), 
        .Y(n2791) );
  AO22X1_RVT U8563 ( .A1(n4765), .A2(n4596), .A3(n4520), .A4(\cpuregs[20][25] ), .Y(n3207) );
  AO22X1_RVT U8564 ( .A1(n4077), .A2(n4595), .A3(n4527), .A4(\cpuregs[17][25] ), .Y(n3111) );
  AO22X1_RVT U8565 ( .A1(n4741), .A2(n4095), .A3(n4742), .A4(\cpuregs[3][7] ), 
        .Y(n2645) );
  AO22X1_RVT U8566 ( .A1(n4735), .A2(n4081), .A3(n4736), .A4(\cpuregs[1][7] ), 
        .Y(n2581) );
  AND2X1_RVT U8567 ( .A1(n6717), .A2(resetn), .Y(n6718) );
  OA21X1_RVT U8568 ( .A1(count_cycle[46]), .A2(n6719), .A3(n6718), .Y(N964) );
  AND2X1_RVT U8569 ( .A1(n4402), .A2(\cpuregs[14][21] ), .Y(n6724) );
  AO22X1_RVT U8570 ( .A1(n4411), .A2(\cpuregs[26][21] ), .A3(n4434), .A4(
        \cpuregs[10][21] ), .Y(n6723) );
  AO22X1_RVT U8571 ( .A1(n4364), .A2(\cpuregs[8][21] ), .A3(n4450), .A4(
        \cpuregs[21][21] ), .Y(n6722) );
  AO22X1_RVT U8572 ( .A1(n6581), .A2(\cpuregs[6][21] ), .A3(n4488), .A4(
        \cpuregs[24][21] ), .Y(n6721) );
  NOR4X1_RVT U8573 ( .A1(n6724), .A2(n6723), .A3(n6722), .A4(n6721), .Y(n6743)
         );
  AO22X1_RVT U8574 ( .A1(n5017), .A2(\cpuregs[22][21] ), .A3(n6725), .A4(
        \cpuregs[9][21] ), .Y(n6730) );
  AO22X1_RVT U8575 ( .A1(n4389), .A2(\cpuregs[2][21] ), .A3(n4431), .A4(
        \cpuregs[13][21] ), .Y(n6729) );
  AO22X1_RVT U8576 ( .A1(n4271), .A2(\cpuregs[15][21] ), .A3(n4374), .A4(
        \cpuregs[1][21] ), .Y(n6728) );
  AO22X1_RVT U8577 ( .A1(n4382), .A2(\cpuregs[16][21] ), .A3(n4442), .A4(
        \cpuregs[4][21] ), .Y(n6727) );
  NOR4X1_RVT U8578 ( .A1(n6730), .A2(n6729), .A3(n6727), .A4(n6728), .Y(n6742)
         );
  AO22X1_RVT U8579 ( .A1(n4392), .A2(\cpuregs[31][21] ), .A3(n6592), .A4(
        \cpuregs[3][21] ), .Y(n6734) );
  AO22X1_RVT U8580 ( .A1(n4337), .A2(\cpuregs[19][21] ), .A3(n4405), .A4(
        \cpuregs[29][21] ), .Y(n6733) );
  AO22X1_RVT U8581 ( .A1(n4425), .A2(\cpuregs[17][21] ), .A3(n4415), .A4(
        \cpuregs[28][21] ), .Y(n6732) );
  AO22X1_RVT U8582 ( .A1(n4346), .A2(\cpuregs[20][21] ), .A3(n4363), .A4(
        \cpuregs[11][21] ), .Y(n6731) );
  NOR4X1_RVT U8583 ( .A1(n6731), .A2(n6733), .A3(n6732), .A4(n6734), .Y(n6741)
         );
  AO22X1_RVT U8584 ( .A1(n4386), .A2(\cpuregs[23][21] ), .A3(n4422), .A4(
        \cpuregs[7][21] ), .Y(n6739) );
  AO22X1_RVT U8585 ( .A1(n4334), .A2(\cpuregs[25][21] ), .A3(n4419), .A4(
        \cpuregs[30][21] ), .Y(n6738) );
  AO22X1_RVT U8586 ( .A1(n4369), .A2(\cpuregs[5][21] ), .A3(n4408), .A4(
        \cpuregs[12][21] ), .Y(n6737) );
  AO22X1_RVT U8587 ( .A1(n4327), .A2(\cpuregs[27][21] ), .A3(n4359), .A4(
        \cpuregs[18][21] ), .Y(n6736) );
  NOR4X1_RVT U8588 ( .A1(n6739), .A2(n6738), .A3(n6737), .A4(n6736), .Y(n6740)
         );
  AO22X1_RVT U8589 ( .A1(n4423), .A2(\cpuregs[7][26] ), .A3(n4488), .A4(
        \cpuregs[24][26] ), .Y(n6749) );
  AO22X1_RVT U8590 ( .A1(n4393), .A2(\cpuregs[31][26] ), .A3(n4417), .A4(
        \cpuregs[28][26] ), .Y(n6748) );
  OR2X1_RVT U8591 ( .A1(n6749), .A2(n6748), .Y(n6750) );
  AO21X1_RVT U8592 ( .A1(n4404), .A2(\cpuregs[14][26] ), .A3(n6750), .Y(n6771)
         );
  AO22X1_RVT U8593 ( .A1(n4350), .A2(\cpuregs[9][26] ), .A3(n4428), .A4(
        \cpuregs[3][26] ), .Y(n6770) );
  AO22X1_RVT U8594 ( .A1(n4330), .A2(\cpuregs[22][26] ), .A3(n4432), .A4(
        \cpuregs[13][26] ), .Y(n6755) );
  AO22X1_RVT U8595 ( .A1(n4348), .A2(\cpuregs[20][26] ), .A3(n4409), .A4(
        \cpuregs[12][26] ), .Y(n6754) );
  AO22X1_RVT U8596 ( .A1(n4391), .A2(\cpuregs[2][26] ), .A3(n4441), .A4(
        \cpuregs[4][26] ), .Y(n6753) );
  AO22X1_RVT U8597 ( .A1(n4363), .A2(\cpuregs[11][26] ), .A3(n4436), .A4(
        \cpuregs[10][26] ), .Y(n6752) );
  NOR4X1_RVT U8598 ( .A1(n6755), .A2(n6754), .A3(n6753), .A4(n6752), .Y(n6768)
         );
  AO22X1_RVT U8599 ( .A1(n4366), .A2(\cpuregs[8][26] ), .A3(n4374), .A4(
        \cpuregs[1][26] ), .Y(n6760) );
  AO22X1_RVT U8600 ( .A1(n4413), .A2(\cpuregs[26][26] ), .A3(n4450), .A4(
        \cpuregs[21][26] ), .Y(n6759) );
  AO22X1_RVT U8601 ( .A1(n4337), .A2(\cpuregs[19][26] ), .A3(n4384), .A4(
        \cpuregs[16][26] ), .Y(n6758) );
  AO22X1_RVT U8602 ( .A1(n4273), .A2(\cpuregs[15][26] ), .A3(n4420), .A4(
        \cpuregs[30][26] ), .Y(n6757) );
  NOR4X1_RVT U8603 ( .A1(n6760), .A2(n6759), .A3(n6758), .A4(n6757), .Y(n6767)
         );
  AO22X1_RVT U8604 ( .A1(n4345), .A2(\cpuregs[6][26] ), .A3(n4359), .A4(
        \cpuregs[18][26] ), .Y(n6765) );
  AO22X1_RVT U8605 ( .A1(n4369), .A2(\cpuregs[5][26] ), .A3(n4387), .A4(
        \cpuregs[23][26] ), .Y(n6764) );
  AO22X1_RVT U8606 ( .A1(n4327), .A2(\cpuregs[27][26] ), .A3(n4425), .A4(
        \cpuregs[17][26] ), .Y(n6763) );
  AO22X1_RVT U8607 ( .A1(n4335), .A2(\cpuregs[25][26] ), .A3(n4406), .A4(
        \cpuregs[29][26] ), .Y(n6762) );
  NOR4X1_RVT U8608 ( .A1(n6765), .A2(n6764), .A3(n6763), .A4(n6762), .Y(n6766)
         );
  NAND3X0_RVT U8609 ( .A1(n6768), .A2(n6767), .A3(n6766), .Y(n6769) );
  AO222X1_RVT U8610 ( .A1(n4061), .A2(n6771), .A3(n4059), .A4(n6770), .A5(
        n5208), .A6(n6769), .Y(n6775) );
  OR2X1_RVT U8611 ( .A1(net24127), .A2(n6772), .Y(n6773) );
  AO21X1_RVT U8612 ( .A1(net30310), .A2(reg_pc[26]), .A3(n6773), .Y(n6774) );
  OA21X1_RVT U8613 ( .A1(n6775), .A2(n6774), .A3(net29471), .Y(n6778) );
  AO22X1_RVT U8614 ( .A1(n6776), .A2(pcpi_rs1[27]), .A3(n4054), .A4(
        pcpi_rs1[26]), .Y(n6777) );
  OR2X1_RVT U8615 ( .A1(n6778), .A2(n6777), .Y(n3714) );
  AND2X1_RVT U8616 ( .A1(n6779), .A2(count_cycle[47]), .Y(n6782) );
  AND2X1_RVT U8617 ( .A1(resetn), .A2(n6780), .Y(n6781) );
  OA21X1_RVT U8618 ( .A1(n6779), .A2(count_cycle[47]), .A3(n6781), .Y(N965) );
  AND2X1_RVT U8619 ( .A1(resetn), .A2(n6783), .Y(n6784) );
  OA21X1_RVT U8620 ( .A1(count_cycle[48]), .A2(n6782), .A3(n6784), .Y(N966) );
  AND2X1_RVT U8621 ( .A1(n6785), .A2(count_cycle[49]), .Y(n6788) );
  AND2X1_RVT U8622 ( .A1(resetn), .A2(n6786), .Y(n6787) );
  AND2X1_RVT U8623 ( .A1(n6788), .A2(count_cycle[50]), .Y(n6791) );
  AND2X1_RVT U8624 ( .A1(n6789), .A2(resetn), .Y(n6790) );
  OA21X1_RVT U8625 ( .A1(count_cycle[50]), .A2(n6788), .A3(n6790), .Y(N968) );
  AND2X1_RVT U8626 ( .A1(resetn), .A2(n6792), .Y(n6793) );
  OA21X1_RVT U8627 ( .A1(n6791), .A2(count_cycle[51]), .A3(n6793), .Y(N969) );
  FADDX1_RVT U8628 ( .A(reg_pc[29]), .B(decoded_imm[29]), .CI(n6794), .S(n6801) );
  AOI22X1_RVT U8629 ( .A1(count_instr[61]), .A2(n4310), .A3(n4634), .A4(
        pcpi_rs1[29]), .Y(n6797) );
  NAND2X0_RVT U8630 ( .A1(n6573), .A2(mem_rdata_word[29]), .Y(n6796) );
  NAND2X0_RVT U8631 ( .A1(count_instr[29]), .A2(n4351), .Y(n6795) );
  NAND4X0_RVT U8632 ( .A1(n6817), .A2(n6797), .A3(n6796), .A4(n6795), .Y(n6798) );
  OR2X1_RVT U8633 ( .A1(n6799), .A2(n6798), .Y(n6800) );
  AND2X1_RVT U8634 ( .A1(resetn), .A2(n6803), .Y(n6804) );
  OA21X1_RVT U8635 ( .A1(n6802), .A2(count_cycle[52]), .A3(n6804), .Y(N970) );
  AND2X1_RVT U8636 ( .A1(resetn), .A2(n6806), .Y(n6807) );
  OA21X1_RVT U8637 ( .A1(count_cycle[53]), .A2(n6805), .A3(n6807), .Y(N971) );
  INVX0_RVT U8638 ( .A(n6822), .Y(n6809) );
  AND2X1_RVT U8639 ( .A1(resetn), .A2(n6809), .Y(n6810) );
  OA21X1_RVT U8640 ( .A1(count_cycle[54]), .A2(n6808), .A3(n6810), .Y(N972) );
  AO22X1_RVT U8641 ( .A1(decoded_imm[30]), .A2(reg_pc[30]), .A3(n6812), .A4(
        n6811), .Y(n6813) );
  AO22X1_RVT U8642 ( .A1(count_cycle[31]), .A2(n4357), .A3(count_instr[31]), 
        .A4(n5718), .Y(n6819) );
  OA22X1_RVT U8643 ( .A1(n8057), .A2(n7703), .A3(n4241), .A4(net16372), .Y(
        n6816) );
  NAND2X0_RVT U8644 ( .A1(n6573), .A2(mem_rdata_word[31]), .Y(n6815) );
  NAND2X0_RVT U8645 ( .A1(count_cycle[63]), .A2(n4258), .Y(n6814) );
  NAND4X0_RVT U8646 ( .A1(n6817), .A2(n6816), .A3(n6815), .A4(n6814), .Y(n6818) );
  OR2X1_RVT U8647 ( .A1(n6819), .A2(n6818), .Y(n6820) );
  AND2X1_RVT U8648 ( .A1(n6822), .A2(count_cycle[55]), .Y(n6825) );
  AND2X1_RVT U8649 ( .A1(resetn), .A2(n6823), .Y(n6824) );
  OA21X1_RVT U8650 ( .A1(count_cycle[55]), .A2(n6822), .A3(n6824), .Y(N973) );
  AND2X1_RVT U8651 ( .A1(resetn), .A2(n4208), .Y(n6826) );
  OA21X1_RVT U8652 ( .A1(n6825), .A2(count_cycle[56]), .A3(n6826), .Y(N974) );
  AND2X1_RVT U8653 ( .A1(n4207), .A2(n6825), .Y(n6830) );
  INVX0_RVT U8654 ( .A(n6830), .Y(n6828) );
  AND2X1_RVT U8655 ( .A1(resetn), .A2(n6828), .Y(n6829) );
  OA21X1_RVT U8656 ( .A1(count_cycle[57]), .A2(n6827), .A3(n6829), .Y(N975) );
  AND2X1_RVT U8657 ( .A1(n6830), .A2(count_cycle[58]), .Y(n6833) );
  INVX0_RVT U8658 ( .A(n6833), .Y(n6831) );
  AND2X1_RVT U8659 ( .A1(resetn), .A2(n6831), .Y(n6832) );
  OA21X1_RVT U8660 ( .A1(n6830), .A2(count_cycle[58]), .A3(n6832), .Y(N976) );
  AND2X1_RVT U8661 ( .A1(resetn), .A2(n6834), .Y(n6835) );
  OA21X1_RVT U8662 ( .A1(n6833), .A2(count_cycle[59]), .A3(n6835), .Y(N977) );
  AND2X1_RVT U8663 ( .A1(resetn), .A2(n6837), .Y(n6838) );
  OA21X1_RVT U8664 ( .A1(count_cycle[60]), .A2(n6836), .A3(n6838), .Y(N978) );
  INVX1_RVT U8665 ( .A(n6842), .Y(n6840) );
  AND2X1_RVT U8666 ( .A1(n6840), .A2(resetn), .Y(n6841) );
  OA21X1_RVT U8667 ( .A1(n6839), .A2(count_cycle[61]), .A3(n6841), .Y(N979) );
  AND2X1_RVT U8668 ( .A1(\cpuregs[7][20] ), .A2(n4438), .Y(n6846) );
  AO22X1_RVT U8669 ( .A1(\cpuregs[1][20] ), .A2(n4485), .A3(\cpuregs[4][20] ), 
        .A4(n7467), .Y(n6845) );
  AO22X1_RVT U8670 ( .A1(\cpuregs[8][20] ), .A2(n4274), .A3(\cpuregs[27][20] ), 
        .A4(n4456), .Y(n6844) );
  AO22X1_RVT U8671 ( .A1(\cpuregs[13][20] ), .A2(n4453), .A3(\cpuregs[12][20] ), .A4(n4286), .Y(n6843) );
  NOR4X1_RVT U8672 ( .A1(n6846), .A2(n6845), .A3(n6844), .A4(n6843), .Y(n6863)
         );
  AO22X1_RVT U8673 ( .A1(\cpuregs[21][20] ), .A2(n4448), .A3(\cpuregs[19][20] ), .A4(n4499), .Y(n6850) );
  AO22X1_RVT U8674 ( .A1(\cpuregs[10][20] ), .A2(n4463), .A3(\cpuregs[31][20] ), .A4(n4466), .Y(n6849) );
  AO22X1_RVT U8675 ( .A1(\cpuregs[30][20] ), .A2(n4502), .A3(\cpuregs[3][20] ), 
        .A4(n4429), .Y(n6848) );
  AO22X1_RVT U8676 ( .A1(\cpuregs[25][20] ), .A2(n4482), .A3(\cpuregs[11][20] ), .A4(n4475), .Y(n6847) );
  NOR4X1_RVT U8677 ( .A1(n6850), .A2(n6849), .A3(n6848), .A4(n6847), .Y(n6862)
         );
  AO22X1_RVT U8678 ( .A1(\cpuregs[15][20] ), .A2(n4489), .A3(\cpuregs[18][20] ), .A4(n4506), .Y(n6854) );
  AO22X1_RVT U8679 ( .A1(\cpuregs[5][20] ), .A2(n4479), .A3(\cpuregs[23][20] ), 
        .A4(n4444), .Y(n6853) );
  AO22X1_RVT U8680 ( .A1(\cpuregs[16][20] ), .A2(n4288), .A3(\cpuregs[22][20] ), .A4(n4496), .Y(n6852) );
  AO22X1_RVT U8681 ( .A1(\cpuregs[24][20] ), .A2(n4284), .A3(\cpuregs[14][20] ), .A4(n4473), .Y(n6851) );
  NOR4X1_RVT U8682 ( .A1(n6854), .A2(n6853), .A3(n6852), .A4(n6851), .Y(n6861)
         );
  AO22X1_RVT U8683 ( .A1(\cpuregs[2][20] ), .A2(n4464), .A3(\cpuregs[17][20] ), 
        .A4(n4493), .Y(n6859) );
  AO22X1_RVT U8684 ( .A1(\cpuregs[20][20] ), .A2(n4277), .A3(\cpuregs[26][20] ), .A4(n4511), .Y(n6858) );
  AO22X1_RVT U8685 ( .A1(\cpuregs[28][20] ), .A2(n4281), .A3(\cpuregs[29][20] ), .A4(n4508), .Y(n6857) );
  AO22X1_RVT U8686 ( .A1(\cpuregs[6][20] ), .A2(n4460), .A3(\cpuregs[9][20] ), 
        .A4(n4469), .Y(n6856) );
  NOR4X1_RVT U8687 ( .A1(n6859), .A2(n6858), .A3(n6857), .A4(n6856), .Y(n6860)
         );
  NAND4X0_RVT U8688 ( .A1(n6863), .A2(n6862), .A3(n6861), .A4(n6860), .Y(n6864) );
  AND2X1_RVT U8689 ( .A1(\cpuregs[2][13] ), .A2(n7468), .Y(n6868) );
  AO22X1_RVT U8690 ( .A1(\cpuregs[25][13] ), .A2(n4480), .A3(\cpuregs[10][13] ), .A4(n4462), .Y(n6867) );
  AO22X1_RVT U8691 ( .A1(\cpuregs[12][13] ), .A2(n7473), .A3(\cpuregs[14][13] ), .A4(n4473), .Y(n6866) );
  AO22X1_RVT U8692 ( .A1(\cpuregs[23][13] ), .A2(n4445), .A3(\cpuregs[28][13] ), .A4(n4281), .Y(n6865) );
  NOR4X1_RVT U8693 ( .A1(n6868), .A2(n6867), .A3(n6866), .A4(n6865), .Y(n6884)
         );
  AO22X1_RVT U8694 ( .A1(\cpuregs[9][13] ), .A2(n4468), .A3(\cpuregs[22][13] ), 
        .A4(n4496), .Y(n6872) );
  AO22X1_RVT U8695 ( .A1(\cpuregs[31][13] ), .A2(n4465), .A3(\cpuregs[16][13] ), .A4(n4287), .Y(n6871) );
  AO22X1_RVT U8696 ( .A1(\cpuregs[21][13] ), .A2(n4446), .A3(\cpuregs[8][13] ), 
        .A4(n4274), .Y(n6870) );
  AO22X1_RVT U8697 ( .A1(\cpuregs[5][13] ), .A2(n4478), .A3(\cpuregs[29][13] ), 
        .A4(n4509), .Y(n6869) );
  NOR4X1_RVT U8698 ( .A1(n6872), .A2(n6871), .A3(n6870), .A4(n6869), .Y(n6883)
         );
  AO22X1_RVT U8699 ( .A1(\cpuregs[17][13] ), .A2(n4492), .A3(\cpuregs[15][13] ), .A4(n4491), .Y(n6876) );
  AO22X1_RVT U8700 ( .A1(\cpuregs[26][13] ), .A2(n4510), .A3(\cpuregs[19][13] ), .A4(n4499), .Y(n6875) );
  AO22X1_RVT U8701 ( .A1(\cpuregs[27][13] ), .A2(n4455), .A3(\cpuregs[7][13] ), 
        .A4(n4439), .Y(n6874) );
  AO22X1_RVT U8702 ( .A1(\cpuregs[24][13] ), .A2(n4283), .A3(\cpuregs[13][13] ), .A4(n4454), .Y(n6873) );
  NOR4X1_RVT U8703 ( .A1(n6876), .A2(n6875), .A3(n6874), .A4(n6873), .Y(n6882)
         );
  AO22X1_RVT U8704 ( .A1(\cpuregs[30][13] ), .A2(n4501), .A3(\cpuregs[18][13] ), .A4(n4504), .Y(n6880) );
  AO22X1_RVT U8705 ( .A1(\cpuregs[20][13] ), .A2(n4277), .A3(\cpuregs[11][13] ), .A4(n4475), .Y(n6879) );
  AO22X1_RVT U8706 ( .A1(\cpuregs[6][13] ), .A2(n4458), .A3(\cpuregs[1][13] ), 
        .A4(n4484), .Y(n6878) );
  AO22X1_RVT U8707 ( .A1(\cpuregs[3][13] ), .A2(n7376), .A3(\cpuregs[4][13] ), 
        .A4(n7467), .Y(n6877) );
  NOR4X1_RVT U8708 ( .A1(n6880), .A2(n6879), .A3(n6878), .A4(n6877), .Y(n6881)
         );
  NAND4X0_RVT U8709 ( .A1(n6884), .A2(n6883), .A3(n6882), .A4(n6881), .Y(n6885) );
  AO222X1_RVT U8710 ( .A1(net23989), .A2(decoded_imm[13]), .A3(net30424), .A4(
        n6885), .A5(net29439), .A6(pcpi_rs2[13]), .Y(n3917) );
  AND2X1_RVT U8711 ( .A1(\cpuregs[10][28] ), .A2(n4463), .Y(n6889) );
  AO22X1_RVT U8712 ( .A1(\cpuregs[24][28] ), .A2(n4284), .A3(\cpuregs[1][28] ), 
        .A4(n4485), .Y(n6888) );
  AO22X1_RVT U8713 ( .A1(\cpuregs[13][28] ), .A2(n4454), .A3(\cpuregs[4][28] ), 
        .A4(n7467), .Y(n6887) );
  AO22X1_RVT U8714 ( .A1(\cpuregs[3][28] ), .A2(n7376), .A3(\cpuregs[23][28] ), 
        .A4(n4444), .Y(n6886) );
  NOR4X1_RVT U8715 ( .A1(n6889), .A2(n6888), .A3(n6887), .A4(n6886), .Y(n6905)
         );
  AO22X1_RVT U8716 ( .A1(\cpuregs[19][28] ), .A2(n4500), .A3(\cpuregs[25][28] ), .A4(n4482), .Y(n6893) );
  AO22X1_RVT U8717 ( .A1(\cpuregs[9][28] ), .A2(n4469), .A3(\cpuregs[16][28] ), 
        .A4(n4289), .Y(n6892) );
  AO22X1_RVT U8718 ( .A1(\cpuregs[5][28] ), .A2(n4478), .A3(\cpuregs[29][28] ), 
        .A4(n4508), .Y(n6891) );
  AO22X1_RVT U8719 ( .A1(\cpuregs[12][28] ), .A2(n4286), .A3(\cpuregs[2][28] ), 
        .A4(n7468), .Y(n6890) );
  NOR4X1_RVT U8720 ( .A1(n6893), .A2(n6892), .A3(n6891), .A4(n6890), .Y(n6904)
         );
  AO22X1_RVT U8721 ( .A1(\cpuregs[17][28] ), .A2(n4493), .A3(\cpuregs[22][28] ), .A4(n4497), .Y(n6897) );
  AO22X1_RVT U8722 ( .A1(\cpuregs[11][28] ), .A2(n4476), .A3(\cpuregs[18][28] ), .A4(n4506), .Y(n6896) );
  AO22X1_RVT U8723 ( .A1(\cpuregs[21][28] ), .A2(n4448), .A3(\cpuregs[15][28] ), .A4(n4490), .Y(n6895) );
  AO22X1_RVT U8724 ( .A1(\cpuregs[20][28] ), .A2(n4278), .A3(\cpuregs[30][28] ), .A4(n4502), .Y(n6894) );
  NOR4X1_RVT U8725 ( .A1(n6897), .A2(n6896), .A3(n6895), .A4(n6894), .Y(n6903)
         );
  AO22X1_RVT U8726 ( .A1(\cpuregs[26][28] ), .A2(n4512), .A3(\cpuregs[6][28] ), 
        .A4(n4459), .Y(n6901) );
  AO22X1_RVT U8727 ( .A1(\cpuregs[27][28] ), .A2(n4456), .A3(\cpuregs[14][28] ), .A4(n4472), .Y(n6900) );
  AO22X1_RVT U8728 ( .A1(\cpuregs[7][28] ), .A2(n4439), .A3(\cpuregs[28][28] ), 
        .A4(n4281), .Y(n6899) );
  AO22X1_RVT U8729 ( .A1(\cpuregs[31][28] ), .A2(n4467), .A3(\cpuregs[8][28] ), 
        .A4(n7474), .Y(n6898) );
  NOR4X1_RVT U8730 ( .A1(n6901), .A2(n6900), .A3(n6899), .A4(n6898), .Y(n6902)
         );
  NAND4X0_RVT U8731 ( .A1(n6905), .A2(n6904), .A3(n6903), .A4(n6902), .Y(n6906) );
  AO222X1_RVT U8732 ( .A1(pcpi_rs2[28]), .A2(net29439), .A3(net30048), .A4(
        decoded_imm[28]), .A5(n6906), .A6(net30424), .Y(n3902) );
  AND2X1_RVT U8733 ( .A1(\cpuregs[17][11] ), .A2(n4494), .Y(n6910) );
  AO22X1_RVT U8734 ( .A1(\cpuregs[6][11] ), .A2(n4458), .A3(\cpuregs[29][11] ), 
        .A4(n4509), .Y(n6909) );
  AO22X1_RVT U8735 ( .A1(\cpuregs[9][11] ), .A2(n4470), .A3(\cpuregs[18][11] ), 
        .A4(n4505), .Y(n6908) );
  AO22X1_RVT U8736 ( .A1(\cpuregs[25][11] ), .A2(n4482), .A3(\cpuregs[13][11] ), .A4(n4454), .Y(n6907) );
  NOR4X1_RVT U8737 ( .A1(n6910), .A2(n6909), .A3(n6908), .A4(n6907), .Y(n6926)
         );
  AO22X1_RVT U8738 ( .A1(\cpuregs[26][11] ), .A2(n4510), .A3(\cpuregs[15][11] ), .A4(n4491), .Y(n6914) );
  AO22X1_RVT U8739 ( .A1(\cpuregs[19][11] ), .A2(n4498), .A3(\cpuregs[14][11] ), .A4(n4473), .Y(n6913) );
  AO22X1_RVT U8740 ( .A1(\cpuregs[24][11] ), .A2(n4283), .A3(\cpuregs[28][11] ), .A4(n4282), .Y(n6912) );
  AO22X1_RVT U8741 ( .A1(\cpuregs[20][11] ), .A2(n4278), .A3(\cpuregs[12][11] ), .A4(n4286), .Y(n6911) );
  NOR4X1_RVT U8742 ( .A1(n6914), .A2(n6913), .A3(n6912), .A4(n6911), .Y(n6925)
         );
  AO22X1_RVT U8743 ( .A1(\cpuregs[31][11] ), .A2(n4465), .A3(\cpuregs[3][11] ), 
        .A4(n7376), .Y(n6918) );
  AO22X1_RVT U8744 ( .A1(\cpuregs[22][11] ), .A2(n4495), .A3(\cpuregs[21][11] ), .A4(n4448), .Y(n6917) );
  AO22X1_RVT U8745 ( .A1(\cpuregs[2][11] ), .A2(n4464), .A3(\cpuregs[11][11] ), 
        .A4(n4475), .Y(n6916) );
  AO22X1_RVT U8746 ( .A1(\cpuregs[7][11] ), .A2(n4438), .A3(\cpuregs[10][11] ), 
        .A4(n4463), .Y(n6915) );
  NOR4X1_RVT U8747 ( .A1(n6918), .A2(n6917), .A3(n6916), .A4(n6915), .Y(n6924)
         );
  AO22X1_RVT U8748 ( .A1(\cpuregs[27][11] ), .A2(n4455), .A3(\cpuregs[8][11] ), 
        .A4(n7474), .Y(n6922) );
  AO22X1_RVT U8749 ( .A1(\cpuregs[1][11] ), .A2(n4483), .A3(\cpuregs[5][11] ), 
        .A4(n4479), .Y(n6921) );
  AO22X1_RVT U8750 ( .A1(\cpuregs[30][11] ), .A2(n4501), .A3(\cpuregs[4][11] ), 
        .A4(n4275), .Y(n6920) );
  AO22X1_RVT U8751 ( .A1(\cpuregs[16][11] ), .A2(n4287), .A3(\cpuregs[23][11] ), .A4(n4445), .Y(n6919) );
  NOR4X1_RVT U8752 ( .A1(n6922), .A2(n6921), .A3(n6920), .A4(n6919), .Y(n6923)
         );
  NAND4X0_RVT U8753 ( .A1(n6926), .A2(n6925), .A3(n6924), .A4(n6923), .Y(n6927) );
  AO222X1_RVT U8754 ( .A1(net30049), .A2(decoded_imm[11]), .A3(net30422), .A4(
        n6927), .A5(net27439), .A6(pcpi_rs2[11]), .Y(n3919) );
  AND2X1_RVT U8755 ( .A1(decoded_imm_j[16]), .A2(n4803), .Y(n7585) );
  AND2X1_RVT U8756 ( .A1(decoded_imm_j[15]), .A2(n4803), .Y(n7595) );
  AND2X1_RVT U8757 ( .A1(decoded_imm_j[14]), .A2(n4803), .Y(n7598) );
  AND2X1_RVT U8758 ( .A1(decoded_imm_j[13]), .A2(n4812), .Y(n7601) );
  AND2X1_RVT U8759 ( .A1(decoded_imm_j[12]), .A2(n4803), .Y(n7613) );
  AND2X1_RVT U8760 ( .A1(decoded_imm_j[11]), .A2(n4812), .Y(n7616) );
  AND2X1_RVT U8761 ( .A1(decoded_imm_j[10]), .A2(n4803), .Y(n7619) );
  AND2X1_RVT U8762 ( .A1(decoded_imm_j[9]), .A2(n4803), .Y(n7629) );
  AND2X1_RVT U8763 ( .A1(decoded_imm_j[8]), .A2(instr_jal), .Y(n7632) );
  AND2X1_RVT U8764 ( .A1(decoded_imm_j[7]), .A2(n4803), .Y(n7635) );
  AND2X1_RVT U8765 ( .A1(decoded_imm_j[6]), .A2(n4812), .Y(n7638) );
  AND2X1_RVT U8766 ( .A1(decoded_imm_j[5]), .A2(n4812), .Y(n7646) );
  NAND2X0_RVT U8767 ( .A1(n8017), .A2(instr_jal), .Y(n7677) );
  NAND2X0_RVT U8768 ( .A1(n4070), .A2(latched_stalu), .Y(n6932) );
  AO222X1_RVT U8769 ( .A1(n4797), .A2(reg_next_pc[1]), .A3(n4253), .A4(
        alu_out_q[1]), .A5(reg_out[1]), .A6(n4194), .Y(n7856) );
  AND2X1_RVT U8770 ( .A1(decoded_imm_j[1]), .A2(n4812), .Y(n7679) );
  AND2X1_RVT U8771 ( .A1(n7856), .A2(n7679), .Y(n7676) );
  AO222X1_RVT U8772 ( .A1(n4797), .A2(reg_next_pc[2]), .A3(n4253), .A4(
        alu_out_q[2]), .A5(reg_out[2]), .A6(n4194), .Y(n7857) );
  AO222X1_RVT U8773 ( .A1(n4797), .A2(reg_next_pc[3]), .A3(n4253), .A4(
        alu_out_q[3]), .A5(reg_out[3]), .A6(n4194), .Y(n7858) );
  MUX21X1_RVT U8774 ( .A1(alu_out_q[10]), .A2(n6935), .S0(n4801), .Y(n7865) );
  MUX21X1_RVT U8775 ( .A1(alu_out_q[14]), .A2(n6938), .S0(n4799), .Y(n7869) );
  AO222X1_RVT U8776 ( .A1(n4632), .A2(reg_next_pc[17]), .A3(n4254), .A4(
        alu_out_q[17]), .A5(reg_out[17]), .A6(n4195), .Y(n7872) );
  MUX21X1_RVT U8777 ( .A1(alu_out_q[20]), .A2(n6941), .S0(n4799), .Y(n7875) );
  MUX21X1_RVT U8778 ( .A1(alu_out_q[21]), .A2(n6942), .S0(n4800), .Y(n7876) );
  AO222X1_RVT U8779 ( .A1(n4632), .A2(reg_next_pc[22]), .A3(n4254), .A4(
        alu_out_q[22]), .A5(reg_out[22]), .A6(n4195), .Y(n7877) );
  AO222X1_RVT U8780 ( .A1(n4220), .A2(reg_next_pc[23]), .A3(n4254), .A4(
        alu_out_q[23]), .A5(reg_out[23]), .A6(n4195), .Y(n7878) );
  MUX21X1_RVT U8781 ( .A1(alu_out_q[25]), .A2(n6944), .S0(n4801), .Y(n7880) );
  MUX21X1_RVT U8782 ( .A1(alu_out_q[26]), .A2(n6945), .S0(n4800), .Y(n7881) );
  MUX21X1_RVT U8783 ( .A1(alu_out_q[27]), .A2(n6946), .S0(n4801), .Y(n7882) );
  AO222X1_RVT U8784 ( .A1(n4797), .A2(reg_next_pc[28]), .A3(n4254), .A4(
        alu_out_q[28]), .A5(reg_out[28]), .A6(n4195), .Y(n7883) );
  MUX21X1_RVT U8785 ( .A1(alu_out_q[29]), .A2(n6947), .S0(n4799), .Y(n7884) );
  AO222X1_RVT U8786 ( .A1(n4797), .A2(reg_next_pc[30]), .A3(n4254), .A4(
        alu_out_q[30]), .A5(reg_out[30]), .A6(n4195), .Y(n7885) );
  MUX21X1_RVT U8787 ( .A1(alu_out_q[31]), .A2(n6948), .S0(n4800), .Y(n7887) );
  AND2X1_RVT U8788 ( .A1(\cpuregs[20][30] ), .A2(n4278), .Y(n6954) );
  AO22X1_RVT U8789 ( .A1(\cpuregs[4][30] ), .A2(n4275), .A3(\cpuregs[19][30] ), 
        .A4(n4499), .Y(n6953) );
  AO22X1_RVT U8790 ( .A1(\cpuregs[3][30] ), .A2(n4429), .A3(\cpuregs[9][30] ), 
        .A4(n4470), .Y(n6952) );
  AO22X1_RVT U8791 ( .A1(\cpuregs[21][30] ), .A2(n4448), .A3(\cpuregs[22][30] ), .A4(n4497), .Y(n6951) );
  NOR4X1_RVT U8792 ( .A1(n6954), .A2(n6953), .A3(n6952), .A4(n6951), .Y(n6970)
         );
  AO22X1_RVT U8793 ( .A1(\cpuregs[5][30] ), .A2(n4478), .A3(\cpuregs[27][30] ), 
        .A4(n4457), .Y(n6958) );
  AO22X1_RVT U8794 ( .A1(\cpuregs[23][30] ), .A2(n4444), .A3(\cpuregs[2][30] ), 
        .A4(n7468), .Y(n6957) );
  AO22X1_RVT U8795 ( .A1(\cpuregs[13][30] ), .A2(n4453), .A3(\cpuregs[1][30] ), 
        .A4(n4484), .Y(n6956) );
  AO22X1_RVT U8796 ( .A1(\cpuregs[24][30] ), .A2(n4284), .A3(\cpuregs[25][30] ), .A4(n4482), .Y(n6955) );
  NOR4X1_RVT U8797 ( .A1(n6958), .A2(n6957), .A3(n6956), .A4(n6955), .Y(n6969)
         );
  AO22X1_RVT U8798 ( .A1(\cpuregs[31][30] ), .A2(n4467), .A3(\cpuregs[10][30] ), .A4(n4463), .Y(n6962) );
  AO22X1_RVT U8799 ( .A1(\cpuregs[28][30] ), .A2(n4282), .A3(\cpuregs[12][30] ), .A4(n4286), .Y(n6961) );
  AO22X1_RVT U8800 ( .A1(\cpuregs[14][30] ), .A2(n4473), .A3(\cpuregs[30][30] ), .A4(n4503), .Y(n6960) );
  AO22X1_RVT U8801 ( .A1(\cpuregs[18][30] ), .A2(n4505), .A3(\cpuregs[8][30] ), 
        .A4(n7474), .Y(n6959) );
  NOR4X1_RVT U8802 ( .A1(n6962), .A2(n6961), .A3(n6960), .A4(n6959), .Y(n6968)
         );
  AO22X1_RVT U8803 ( .A1(\cpuregs[29][30] ), .A2(n4507), .A3(\cpuregs[6][30] ), 
        .A4(n4460), .Y(n6966) );
  AO22X1_RVT U8804 ( .A1(\cpuregs[26][30] ), .A2(n4511), .A3(\cpuregs[17][30] ), .A4(n4494), .Y(n6965) );
  AO22X1_RVT U8805 ( .A1(\cpuregs[7][30] ), .A2(n4438), .A3(\cpuregs[16][30] ), 
        .A4(n4288), .Y(n6964) );
  AO22X1_RVT U8806 ( .A1(\cpuregs[11][30] ), .A2(n4475), .A3(\cpuregs[15][30] ), .A4(n4491), .Y(n6963) );
  NOR4X1_RVT U8807 ( .A1(n6966), .A2(n6965), .A3(n6964), .A4(n6963), .Y(n6967)
         );
  NAND4X0_RVT U8808 ( .A1(n6970), .A2(n6969), .A3(n6968), .A4(n6967), .Y(n6971) );
  AND2X1_RVT U8809 ( .A1(\cpuregs[24][31] ), .A2(n4285), .Y(n6975) );
  AO22X1_RVT U8810 ( .A1(\cpuregs[23][31] ), .A2(n4445), .A3(\cpuregs[25][31] ), .A4(n4481), .Y(n6974) );
  AO22X1_RVT U8811 ( .A1(\cpuregs[21][31] ), .A2(n4448), .A3(\cpuregs[11][31] ), .A4(n4475), .Y(n6973) );
  AO22X1_RVT U8812 ( .A1(\cpuregs[8][31] ), .A2(n7474), .A3(\cpuregs[26][31] ), 
        .A4(n4512), .Y(n6972) );
  NOR4X1_RVT U8813 ( .A1(n6975), .A2(n6974), .A3(n6973), .A4(n6972), .Y(n6991)
         );
  AO22X1_RVT U8814 ( .A1(\cpuregs[28][31] ), .A2(n4280), .A3(\cpuregs[18][31] ), .A4(n4506), .Y(n6979) );
  AO22X1_RVT U8815 ( .A1(\cpuregs[7][31] ), .A2(n4438), .A3(\cpuregs[31][31] ), 
        .A4(n4467), .Y(n6978) );
  AO22X1_RVT U8816 ( .A1(\cpuregs[20][31] ), .A2(n4278), .A3(\cpuregs[15][31] ), .A4(n4490), .Y(n6977) );
  AO22X1_RVT U8817 ( .A1(\cpuregs[14][31] ), .A2(n4473), .A3(\cpuregs[4][31] ), 
        .A4(n7467), .Y(n6976) );
  NOR4X1_RVT U8818 ( .A1(n6979), .A2(n6978), .A3(n6977), .A4(n6976), .Y(n6990)
         );
  AO22X1_RVT U8819 ( .A1(\cpuregs[12][31] ), .A2(n7473), .A3(\cpuregs[3][31] ), 
        .A4(n7376), .Y(n6983) );
  AO22X1_RVT U8820 ( .A1(\cpuregs[22][31] ), .A2(n4497), .A3(\cpuregs[1][31] ), 
        .A4(n4484), .Y(n6982) );
  AO22X1_RVT U8821 ( .A1(\cpuregs[6][31] ), .A2(n4460), .A3(\cpuregs[13][31] ), 
        .A4(n4453), .Y(n6981) );
  AO22X1_RVT U8822 ( .A1(\cpuregs[17][31] ), .A2(n4493), .A3(\cpuregs[2][31] ), 
        .A4(n3991), .Y(n6980) );
  NOR4X1_RVT U8823 ( .A1(n6983), .A2(n6982), .A3(n6981), .A4(n6980), .Y(n6989)
         );
  AO22X1_RVT U8824 ( .A1(\cpuregs[10][31] ), .A2(n4461), .A3(\cpuregs[30][31] ), .A4(n4503), .Y(n6987) );
  AO22X1_RVT U8825 ( .A1(\cpuregs[27][31] ), .A2(n4457), .A3(\cpuregs[29][31] ), .A4(n4509), .Y(n6986) );
  AO22X1_RVT U8826 ( .A1(\cpuregs[16][31] ), .A2(n4289), .A3(\cpuregs[9][31] ), 
        .A4(n4470), .Y(n6985) );
  NOR4X1_RVT U8827 ( .A1(n6987), .A2(n6986), .A3(n6985), .A4(n6984), .Y(n6988)
         );
  NAND4X0_RVT U8828 ( .A1(n6991), .A2(n6990), .A3(n6989), .A4(n6988), .Y(n6992) );
  AND2X1_RVT U8829 ( .A1(\cpuregs[12][24] ), .A2(n4286), .Y(n6996) );
  AO22X1_RVT U8830 ( .A1(\cpuregs[11][24] ), .A2(n4476), .A3(\cpuregs[27][24] ), .A4(n4456), .Y(n6995) );
  AO22X1_RVT U8831 ( .A1(\cpuregs[23][24] ), .A2(n4444), .A3(\cpuregs[1][24] ), 
        .A4(n4485), .Y(n6994) );
  AO22X1_RVT U8832 ( .A1(\cpuregs[13][24] ), .A2(n4453), .A3(\cpuregs[26][24] ), .A4(n4511), .Y(n6993) );
  NOR4X1_RVT U8833 ( .A1(n6996), .A2(n6995), .A3(n6994), .A4(n6993), .Y(n7012)
         );
  AO22X1_RVT U8834 ( .A1(\cpuregs[25][24] ), .A2(n4480), .A3(\cpuregs[15][24] ), .A4(n4491), .Y(n7000) );
  AO22X1_RVT U8835 ( .A1(\cpuregs[22][24] ), .A2(n4497), .A3(\cpuregs[31][24] ), .A4(n4466), .Y(n6999) );
  AO22X1_RVT U8836 ( .A1(\cpuregs[21][24] ), .A2(n4448), .A3(\cpuregs[2][24] ), 
        .A4(n7468), .Y(n6998) );
  AO22X1_RVT U8837 ( .A1(\cpuregs[9][24] ), .A2(n4469), .A3(\cpuregs[5][24] ), 
        .A4(n4478), .Y(n6997) );
  NOR4X1_RVT U8838 ( .A1(n7000), .A2(n6999), .A3(n6998), .A4(n6997), .Y(n7011)
         );
  AO22X1_RVT U8839 ( .A1(\cpuregs[19][24] ), .A2(n4498), .A3(\cpuregs[30][24] ), .A4(n4503), .Y(n7004) );
  AO22X1_RVT U8840 ( .A1(\cpuregs[29][24] ), .A2(n4509), .A3(\cpuregs[8][24] ), 
        .A4(n4274), .Y(n7003) );
  AO22X1_RVT U8841 ( .A1(\cpuregs[3][24] ), .A2(n4429), .A3(\cpuregs[24][24] ), 
        .A4(n4285), .Y(n7002) );
  AO22X1_RVT U8842 ( .A1(\cpuregs[14][24] ), .A2(n4473), .A3(\cpuregs[10][24] ), .A4(n4462), .Y(n7001) );
  NOR4X1_RVT U8843 ( .A1(n7004), .A2(n7003), .A3(n7002), .A4(n7001), .Y(n7010)
         );
  AO22X1_RVT U8844 ( .A1(\cpuregs[7][24] ), .A2(n4437), .A3(\cpuregs[18][24] ), 
        .A4(n4505), .Y(n7008) );
  AO22X1_RVT U8845 ( .A1(\cpuregs[28][24] ), .A2(n4280), .A3(\cpuregs[6][24] ), 
        .A4(n4459), .Y(n7007) );
  AO22X1_RVT U8846 ( .A1(\cpuregs[16][24] ), .A2(n4288), .A3(\cpuregs[17][24] ), .A4(n4493), .Y(n7006) );
  AO22X1_RVT U8847 ( .A1(\cpuregs[20][24] ), .A2(n4279), .A3(\cpuregs[4][24] ), 
        .A4(n4275), .Y(n7005) );
  NOR4X1_RVT U8848 ( .A1(n7008), .A2(n7007), .A3(n7006), .A4(n7005), .Y(n7009)
         );
  NAND4X0_RVT U8849 ( .A1(n7012), .A2(n7011), .A3(n7010), .A4(n7009), .Y(n7013) );
  AND2X1_RVT U8850 ( .A1(\cpuregs[16][9] ), .A2(n4288), .Y(n7017) );
  AO22X1_RVT U8851 ( .A1(\cpuregs[15][9] ), .A2(n4491), .A3(\cpuregs[21][9] ), 
        .A4(n4447), .Y(n7016) );
  AO22X1_RVT U8852 ( .A1(\cpuregs[8][9] ), .A2(n7474), .A3(\cpuregs[17][9] ), 
        .A4(n4493), .Y(n7015) );
  AO22X1_RVT U8853 ( .A1(\cpuregs[18][9] ), .A2(n4506), .A3(\cpuregs[28][9] ), 
        .A4(n4281), .Y(n7014) );
  NOR4X1_RVT U8854 ( .A1(n7017), .A2(n7016), .A3(n7015), .A4(n7014), .Y(n7033)
         );
  AO22X1_RVT U8855 ( .A1(\cpuregs[19][9] ), .A2(n4500), .A3(\cpuregs[12][9] ), 
        .A4(n4286), .Y(n7021) );
  AO22X1_RVT U8856 ( .A1(\cpuregs[10][9] ), .A2(n4463), .A3(\cpuregs[13][9] ), 
        .A4(n4453), .Y(n7020) );
  AO22X1_RVT U8857 ( .A1(\cpuregs[26][9] ), .A2(n4511), .A3(\cpuregs[27][9] ), 
        .A4(n4457), .Y(n7019) );
  AO22X1_RVT U8858 ( .A1(\cpuregs[31][9] ), .A2(n4467), .A3(\cpuregs[5][9] ), 
        .A4(n4479), .Y(n7018) );
  NOR4X1_RVT U8859 ( .A1(n7021), .A2(n7020), .A3(n7019), .A4(n7018), .Y(n7032)
         );
  AO22X1_RVT U8860 ( .A1(\cpuregs[23][9] ), .A2(n4445), .A3(\cpuregs[29][9] ), 
        .A4(n4509), .Y(n7025) );
  AO22X1_RVT U8861 ( .A1(\cpuregs[2][9] ), .A2(n7468), .A3(\cpuregs[20][9] ), 
        .A4(n4279), .Y(n7024) );
  AO22X1_RVT U8862 ( .A1(\cpuregs[25][9] ), .A2(n4481), .A3(\cpuregs[24][9] ), 
        .A4(n4284), .Y(n7023) );
  AO22X1_RVT U8863 ( .A1(\cpuregs[11][9] ), .A2(n4476), .A3(\cpuregs[6][9] ), 
        .A4(n4460), .Y(n7022) );
  NOR4X1_RVT U8864 ( .A1(n7025), .A2(n7024), .A3(n7023), .A4(n7022), .Y(n7031)
         );
  AO22X1_RVT U8865 ( .A1(\cpuregs[14][9] ), .A2(n4471), .A3(\cpuregs[22][9] ), 
        .A4(n4496), .Y(n7029) );
  AO22X1_RVT U8866 ( .A1(\cpuregs[7][9] ), .A2(n4439), .A3(\cpuregs[1][9] ), 
        .A4(n4485), .Y(n7028) );
  AO22X1_RVT U8867 ( .A1(\cpuregs[9][9] ), .A2(n4470), .A3(\cpuregs[30][9] ), 
        .A4(n4503), .Y(n7027) );
  AO22X1_RVT U8868 ( .A1(\cpuregs[4][9] ), .A2(n4275), .A3(\cpuregs[3][9] ), 
        .A4(n7376), .Y(n7026) );
  NOR4X1_RVT U8869 ( .A1(n7029), .A2(n7028), .A3(n7027), .A4(n7026), .Y(n7030)
         );
  NAND4X0_RVT U8870 ( .A1(n7033), .A2(n7032), .A3(n7031), .A4(n7030), .Y(n7034) );
  AO222X1_RVT U8871 ( .A1(pcpi_rs2[9]), .A2(net27439), .A3(net30049), .A4(
        decoded_imm[9]), .A5(n7034), .A6(net30423), .Y(n3921) );
  AND2X1_RVT U8872 ( .A1(\cpuregs[11][14] ), .A2(n4476), .Y(n7038) );
  AO22X1_RVT U8873 ( .A1(\cpuregs[23][14] ), .A2(n4444), .A3(\cpuregs[24][14] ), .A4(n4284), .Y(n7037) );
  AO22X1_RVT U8874 ( .A1(\cpuregs[29][14] ), .A2(n4508), .A3(\cpuregs[28][14] ), .A4(n4282), .Y(n7036) );
  AO22X1_RVT U8875 ( .A1(\cpuregs[21][14] ), .A2(n4448), .A3(\cpuregs[31][14] ), .A4(n4467), .Y(n7035) );
  NOR4X1_RVT U8876 ( .A1(n7038), .A2(n7037), .A3(n7036), .A4(n7035), .Y(n7054)
         );
  AO22X1_RVT U8877 ( .A1(\cpuregs[19][14] ), .A2(n4499), .A3(\cpuregs[25][14] ), .A4(n4481), .Y(n7042) );
  AO22X1_RVT U8878 ( .A1(\cpuregs[30][14] ), .A2(n4503), .A3(\cpuregs[17][14] ), .A4(n4494), .Y(n7041) );
  AO22X1_RVT U8879 ( .A1(\cpuregs[10][14] ), .A2(n4462), .A3(\cpuregs[5][14] ), 
        .A4(n4478), .Y(n7040) );
  AO22X1_RVT U8880 ( .A1(\cpuregs[15][14] ), .A2(n4490), .A3(\cpuregs[7][14] ), 
        .A4(n4439), .Y(n7039) );
  NOR4X1_RVT U8881 ( .A1(n7042), .A2(n7041), .A3(n7040), .A4(n7039), .Y(n7053)
         );
  AO22X1_RVT U8882 ( .A1(\cpuregs[4][14] ), .A2(n7467), .A3(\cpuregs[8][14] ), 
        .A4(n7474), .Y(n7046) );
  AO22X1_RVT U8883 ( .A1(\cpuregs[12][14] ), .A2(n7473), .A3(\cpuregs[14][14] ), .A4(n4472), .Y(n7045) );
  AO22X1_RVT U8884 ( .A1(\cpuregs[13][14] ), .A2(n4454), .A3(\cpuregs[20][14] ), .A4(n4279), .Y(n7044) );
  AO22X1_RVT U8885 ( .A1(\cpuregs[3][14] ), .A2(n7376), .A3(\cpuregs[26][14] ), 
        .A4(n4512), .Y(n7043) );
  NOR4X1_RVT U8886 ( .A1(n7046), .A2(n7045), .A3(n7044), .A4(n7043), .Y(n7052)
         );
  AO22X1_RVT U8887 ( .A1(\cpuregs[1][14] ), .A2(n4483), .A3(\cpuregs[18][14] ), 
        .A4(n4506), .Y(n7050) );
  AO22X1_RVT U8888 ( .A1(\cpuregs[16][14] ), .A2(n4287), .A3(\cpuregs[9][14] ), 
        .A4(n4470), .Y(n7049) );
  AO22X1_RVT U8889 ( .A1(\cpuregs[6][14] ), .A2(n4460), .A3(\cpuregs[2][14] ), 
        .A4(n3991), .Y(n7048) );
  AO22X1_RVT U8890 ( .A1(\cpuregs[27][14] ), .A2(n4457), .A3(\cpuregs[22][14] ), .A4(n4497), .Y(n7047) );
  NOR4X1_RVT U8891 ( .A1(n7050), .A2(n7049), .A3(n7048), .A4(n7047), .Y(n7051)
         );
  NAND4X0_RVT U8892 ( .A1(n7054), .A2(n7053), .A3(n7052), .A4(n7051), .Y(n7055) );
  AO222X1_RVT U8893 ( .A1(pcpi_rs2[14]), .A2(net29439), .A3(net30048), .A4(
        decoded_imm[14]), .A5(n7055), .A6(net30424), .Y(n3916) );
  AND2X1_RVT U8894 ( .A1(\cpuregs[2][18] ), .A2(n3991), .Y(n7059) );
  AO22X1_RVT U8895 ( .A1(\cpuregs[23][18] ), .A2(n4443), .A3(\cpuregs[27][18] ), .A4(n4456), .Y(n7058) );
  AO22X1_RVT U8896 ( .A1(\cpuregs[1][18] ), .A2(n4483), .A3(\cpuregs[5][18] ), 
        .A4(n4479), .Y(n7057) );
  AO22X1_RVT U8897 ( .A1(\cpuregs[11][18] ), .A2(n4476), .A3(\cpuregs[24][18] ), .A4(n4285), .Y(n7056) );
  NOR4X1_RVT U8898 ( .A1(n7059), .A2(n7058), .A3(n7057), .A4(n7056), .Y(n7075)
         );
  AO22X1_RVT U8899 ( .A1(\cpuregs[18][18] ), .A2(n4504), .A3(\cpuregs[26][18] ), .A4(n4512), .Y(n7063) );
  AO22X1_RVT U8900 ( .A1(\cpuregs[12][18] ), .A2(n7473), .A3(\cpuregs[21][18] ), .A4(n4448), .Y(n7062) );
  AO22X1_RVT U8901 ( .A1(\cpuregs[29][18] ), .A2(n4509), .A3(\cpuregs[20][18] ), .A4(n4279), .Y(n7061) );
  AO22X1_RVT U8902 ( .A1(\cpuregs[22][18] ), .A2(n4497), .A3(\cpuregs[14][18] ), .A4(n4473), .Y(n7060) );
  NOR4X1_RVT U8903 ( .A1(n7063), .A2(n7062), .A3(n7061), .A4(n7060), .Y(n7074)
         );
  AO22X1_RVT U8904 ( .A1(\cpuregs[3][18] ), .A2(n4430), .A3(\cpuregs[19][18] ), 
        .A4(n4498), .Y(n7067) );
  AO22X1_RVT U8905 ( .A1(\cpuregs[17][18] ), .A2(n4492), .A3(\cpuregs[13][18] ), .A4(n4452), .Y(n7066) );
  AO22X1_RVT U8906 ( .A1(\cpuregs[8][18] ), .A2(n7474), .A3(\cpuregs[31][18] ), 
        .A4(n4467), .Y(n7065) );
  AO22X1_RVT U8907 ( .A1(\cpuregs[7][18] ), .A2(n4439), .A3(\cpuregs[30][18] ), 
        .A4(n4502), .Y(n7064) );
  NOR4X1_RVT U8908 ( .A1(n7067), .A2(n7066), .A3(n7065), .A4(n7064), .Y(n7073)
         );
  AO22X1_RVT U8909 ( .A1(\cpuregs[16][18] ), .A2(n4287), .A3(\cpuregs[25][18] ), .A4(n4480), .Y(n7071) );
  AO22X1_RVT U8910 ( .A1(\cpuregs[28][18] ), .A2(n4280), .A3(\cpuregs[6][18] ), 
        .A4(n4459), .Y(n7070) );
  AO22X1_RVT U8911 ( .A1(\cpuregs[15][18] ), .A2(n4489), .A3(\cpuregs[4][18] ), 
        .A4(n7467), .Y(n7069) );
  AO22X1_RVT U8912 ( .A1(\cpuregs[10][18] ), .A2(n4463), .A3(\cpuregs[9][18] ), 
        .A4(n4470), .Y(n7068) );
  NOR4X1_RVT U8913 ( .A1(n7071), .A2(n7070), .A3(n7069), .A4(n7068), .Y(n7072)
         );
  AND2X1_RVT U8914 ( .A1(\cpuregs[20][16] ), .A2(n4277), .Y(n7080) );
  AO22X1_RVT U8915 ( .A1(\cpuregs[31][16] ), .A2(n4465), .A3(\cpuregs[2][16] ), 
        .A4(n3991), .Y(n7079) );
  AO22X1_RVT U8916 ( .A1(\cpuregs[11][16] ), .A2(n4474), .A3(\cpuregs[16][16] ), .A4(n4289), .Y(n7078) );
  AO22X1_RVT U8917 ( .A1(\cpuregs[13][16] ), .A2(n4454), .A3(\cpuregs[17][16] ), .A4(n4494), .Y(n7077) );
  NOR4X1_RVT U8918 ( .A1(n7080), .A2(n7079), .A3(n7078), .A4(n7077), .Y(n7096)
         );
  AO22X1_RVT U8919 ( .A1(\cpuregs[3][16] ), .A2(n7376), .A3(\cpuregs[24][16] ), 
        .A4(n4283), .Y(n7084) );
  AO22X1_RVT U8920 ( .A1(\cpuregs[10][16] ), .A2(n4461), .A3(\cpuregs[22][16] ), .A4(n4496), .Y(n7083) );
  AO22X1_RVT U8921 ( .A1(\cpuregs[26][16] ), .A2(n4510), .A3(\cpuregs[21][16] ), .A4(n4447), .Y(n7082) );
  AO22X1_RVT U8922 ( .A1(\cpuregs[25][16] ), .A2(n4481), .A3(\cpuregs[8][16] ), 
        .A4(n7474), .Y(n7081) );
  NOR4X1_RVT U8923 ( .A1(n7084), .A2(n7083), .A3(n7082), .A4(n7081), .Y(n7095)
         );
  AO22X1_RVT U8924 ( .A1(\cpuregs[15][16] ), .A2(n4489), .A3(\cpuregs[1][16] ), 
        .A4(n4483), .Y(n7088) );
  AO22X1_RVT U8925 ( .A1(\cpuregs[27][16] ), .A2(n4455), .A3(\cpuregs[23][16] ), .A4(n4444), .Y(n7087) );
  AO22X1_RVT U8926 ( .A1(\cpuregs[12][16] ), .A2(n7473), .A3(\cpuregs[7][16] ), 
        .A4(n4438), .Y(n7086) );
  AO22X1_RVT U8927 ( .A1(\cpuregs[9][16] ), .A2(n4470), .A3(\cpuregs[18][16] ), 
        .A4(n4506), .Y(n7085) );
  NOR4X1_RVT U8928 ( .A1(n7088), .A2(n7087), .A3(n7086), .A4(n7085), .Y(n7094)
         );
  AO22X1_RVT U8929 ( .A1(\cpuregs[4][16] ), .A2(n7467), .A3(\cpuregs[28][16] ), 
        .A4(n4280), .Y(n7092) );
  AO22X1_RVT U8930 ( .A1(\cpuregs[29][16] ), .A2(n4507), .A3(\cpuregs[14][16] ), .A4(n4472), .Y(n7091) );
  AO22X1_RVT U8931 ( .A1(\cpuregs[30][16] ), .A2(n4501), .A3(\cpuregs[6][16] ), 
        .A4(n4460), .Y(n7090) );
  AO22X1_RVT U8932 ( .A1(\cpuregs[19][16] ), .A2(n4500), .A3(\cpuregs[5][16] ), 
        .A4(n4479), .Y(n7089) );
  NOR4X1_RVT U8933 ( .A1(n7092), .A2(n7091), .A3(n7090), .A4(n7089), .Y(n7093)
         );
  NAND4X0_RVT U8934 ( .A1(n7096), .A2(n7095), .A3(n7094), .A4(n7093), .Y(n7097) );
  AO222X1_RVT U8935 ( .A1(net30048), .A2(decoded_imm[16]), .A3(net30422), .A4(
        n7097), .A5(net29438), .A6(pcpi_rs2[16]), .Y(n3914) );
  AND2X1_RVT U8936 ( .A1(\cpuregs[25][12] ), .A2(n4481), .Y(n7101) );
  AO22X1_RVT U8937 ( .A1(\cpuregs[10][12] ), .A2(n4463), .A3(\cpuregs[28][12] ), .A4(n4282), .Y(n7100) );
  AO22X1_RVT U8938 ( .A1(\cpuregs[21][12] ), .A2(n4447), .A3(\cpuregs[16][12] ), .A4(n4289), .Y(n7099) );
  AO22X1_RVT U8939 ( .A1(\cpuregs[14][12] ), .A2(n4472), .A3(\cpuregs[29][12] ), .A4(n4508), .Y(n7098) );
  NOR4X1_RVT U8940 ( .A1(n7101), .A2(n7100), .A3(n7099), .A4(n7098), .Y(n7117)
         );
  AO22X1_RVT U8941 ( .A1(\cpuregs[8][12] ), .A2(n4274), .A3(\cpuregs[4][12] ), 
        .A4(n7467), .Y(n7105) );
  AO22X1_RVT U8942 ( .A1(\cpuregs[2][12] ), .A2(n4464), .A3(\cpuregs[1][12] ), 
        .A4(n4484), .Y(n7104) );
  AO22X1_RVT U8943 ( .A1(\cpuregs[20][12] ), .A2(n4279), .A3(\cpuregs[26][12] ), .A4(n4512), .Y(n7103) );
  AO22X1_RVT U8944 ( .A1(\cpuregs[27][12] ), .A2(n4457), .A3(\cpuregs[7][12] ), 
        .A4(n4438), .Y(n7102) );
  NOR4X1_RVT U8945 ( .A1(n7105), .A2(n7104), .A3(n7103), .A4(n7102), .Y(n7116)
         );
  AO22X1_RVT U8946 ( .A1(\cpuregs[31][12] ), .A2(n4467), .A3(\cpuregs[12][12] ), .A4(n4286), .Y(n7109) );
  AO22X1_RVT U8947 ( .A1(\cpuregs[9][12] ), .A2(n4469), .A3(\cpuregs[15][12] ), 
        .A4(n4491), .Y(n7108) );
  AO22X1_RVT U8948 ( .A1(\cpuregs[5][12] ), .A2(n4479), .A3(\cpuregs[6][12] ), 
        .A4(n4460), .Y(n7107) );
  AO22X1_RVT U8949 ( .A1(\cpuregs[19][12] ), .A2(n4499), .A3(\cpuregs[24][12] ), .A4(n4284), .Y(n7106) );
  NOR4X1_RVT U8950 ( .A1(n7109), .A2(n7108), .A3(n7107), .A4(n7106), .Y(n7115)
         );
  AO22X1_RVT U8951 ( .A1(\cpuregs[17][12] ), .A2(n4494), .A3(\cpuregs[23][12] ), .A4(n4445), .Y(n7113) );
  AO22X1_RVT U8952 ( .A1(\cpuregs[30][12] ), .A2(n4502), .A3(\cpuregs[22][12] ), .A4(n4496), .Y(n7112) );
  AO22X1_RVT U8953 ( .A1(\cpuregs[3][12] ), .A2(n7376), .A3(\cpuregs[18][12] ), 
        .A4(n4506), .Y(n7111) );
  AO22X1_RVT U8954 ( .A1(\cpuregs[11][12] ), .A2(n4475), .A3(\cpuregs[13][12] ), .A4(n4454), .Y(n7110) );
  NOR4X1_RVT U8955 ( .A1(n7113), .A2(n7112), .A3(n7111), .A4(n7110), .Y(n7114)
         );
  NAND4X0_RVT U8956 ( .A1(n7117), .A2(n7116), .A3(n7115), .A4(n7114), .Y(n7118) );
  AO222X1_RVT U8957 ( .A1(pcpi_rs2[12]), .A2(net27439), .A3(net30048), .A4(
        decoded_imm[12]), .A5(n7118), .A6(net30424), .Y(n3918) );
  AND2X1_RVT U8958 ( .A1(\cpuregs[16][10] ), .A2(n4287), .Y(n7122) );
  AO22X1_RVT U8959 ( .A1(\cpuregs[31][10] ), .A2(n4465), .A3(\cpuregs[2][10] ), 
        .A4(n7468), .Y(n7121) );
  AO22X1_RVT U8960 ( .A1(\cpuregs[3][10] ), .A2(n4429), .A3(\cpuregs[11][10] ), 
        .A4(n4476), .Y(n7120) );
  AO22X1_RVT U8961 ( .A1(\cpuregs[20][10] ), .A2(n4279), .A3(\cpuregs[26][10] ), .A4(n4511), .Y(n7119) );
  NOR4X1_RVT U8962 ( .A1(n7122), .A2(n7121), .A3(n7120), .A4(n7119), .Y(n7138)
         );
  AO22X1_RVT U8963 ( .A1(\cpuregs[6][10] ), .A2(n4458), .A3(\cpuregs[15][10] ), 
        .A4(n4490), .Y(n7126) );
  AO22X1_RVT U8964 ( .A1(\cpuregs[7][10] ), .A2(n4437), .A3(\cpuregs[4][10] ), 
        .A4(n4275), .Y(n7125) );
  AO22X1_RVT U8965 ( .A1(\cpuregs[24][10] ), .A2(n4283), .A3(\cpuregs[19][10] ), .A4(n4499), .Y(n7124) );
  AO22X1_RVT U8966 ( .A1(\cpuregs[8][10] ), .A2(n7474), .A3(\cpuregs[12][10] ), 
        .A4(n4286), .Y(n7123) );
  NOR4X1_RVT U8967 ( .A1(n7126), .A2(n7125), .A3(n7124), .A4(n7123), .Y(n7137)
         );
  AO22X1_RVT U8968 ( .A1(\cpuregs[18][10] ), .A2(n4504), .A3(\cpuregs[21][10] ), .A4(n4447), .Y(n7130) );
  AO22X1_RVT U8969 ( .A1(\cpuregs[9][10] ), .A2(n4468), .A3(\cpuregs[10][10] ), 
        .A4(n4462), .Y(n7129) );
  AO22X1_RVT U8970 ( .A1(\cpuregs[28][10] ), .A2(n4280), .A3(\cpuregs[22][10] ), .A4(n4497), .Y(n7128) );
  AO22X1_RVT U8971 ( .A1(\cpuregs[1][10] ), .A2(n4484), .A3(\cpuregs[13][10] ), 
        .A4(n4453), .Y(n7127) );
  NOR4X1_RVT U8972 ( .A1(n7130), .A2(n7129), .A3(n7128), .A4(n7127), .Y(n7136)
         );
  AO22X1_RVT U8973 ( .A1(\cpuregs[30][10] ), .A2(n4501), .A3(\cpuregs[5][10] ), 
        .A4(n4477), .Y(n7134) );
  AO22X1_RVT U8974 ( .A1(\cpuregs[17][10] ), .A2(n4492), .A3(\cpuregs[23][10] ), .A4(n4445), .Y(n7133) );
  AO22X1_RVT U8975 ( .A1(\cpuregs[29][10] ), .A2(n4507), .A3(\cpuregs[25][10] ), .A4(n4482), .Y(n7132) );
  AO22X1_RVT U8976 ( .A1(\cpuregs[14][10] ), .A2(n4473), .A3(\cpuregs[27][10] ), .A4(n4457), .Y(n7131) );
  NOR4X1_RVT U8977 ( .A1(n7134), .A2(n7133), .A3(n7132), .A4(n7131), .Y(n7135)
         );
  NAND4X0_RVT U8978 ( .A1(n7138), .A2(n7137), .A3(n7136), .A4(n7135), .Y(n7139) );
  AO222X1_RVT U8979 ( .A1(net23989), .A2(decoded_imm[10]), .A3(net30422), .A4(
        n7139), .A5(net29439), .A6(pcpi_rs2[10]), .Y(n3920) );
  AND2X1_RVT U8980 ( .A1(\cpuregs[12][8] ), .A2(n7473), .Y(n7143) );
  AO22X1_RVT U8981 ( .A1(\cpuregs[24][8] ), .A2(n4283), .A3(\cpuregs[11][8] ), 
        .A4(n4476), .Y(n7142) );
  AO22X1_RVT U8982 ( .A1(\cpuregs[23][8] ), .A2(n4444), .A3(\cpuregs[29][8] ), 
        .A4(n4508), .Y(n7141) );
  AO22X1_RVT U8983 ( .A1(\cpuregs[31][8] ), .A2(n4467), .A3(\cpuregs[3][8] ), 
        .A4(n4429), .Y(n7140) );
  NOR4X1_RVT U8984 ( .A1(n7143), .A2(n7142), .A3(n7141), .A4(n7140), .Y(n7159)
         );
  AO22X1_RVT U8985 ( .A1(\cpuregs[21][8] ), .A2(n4446), .A3(\cpuregs[4][8] ), 
        .A4(n4275), .Y(n7147) );
  AO22X1_RVT U8986 ( .A1(\cpuregs[16][8] ), .A2(n4287), .A3(\cpuregs[20][8] ), 
        .A4(n4277), .Y(n7146) );
  AO22X1_RVT U8987 ( .A1(\cpuregs[8][8] ), .A2(n4274), .A3(\cpuregs[1][8] ), 
        .A4(n4484), .Y(n7145) );
  AO22X1_RVT U8988 ( .A1(\cpuregs[19][8] ), .A2(n4499), .A3(\cpuregs[5][8] ), 
        .A4(n4478), .Y(n7144) );
  NOR4X1_RVT U8989 ( .A1(n7147), .A2(n7146), .A3(n7145), .A4(n7144), .Y(n7158)
         );
  AO22X1_RVT U8990 ( .A1(\cpuregs[27][8] ), .A2(n4455), .A3(\cpuregs[15][8] ), 
        .A4(n4490), .Y(n7151) );
  AO22X1_RVT U8991 ( .A1(\cpuregs[13][8] ), .A2(n4452), .A3(\cpuregs[17][8] ), 
        .A4(n4493), .Y(n7150) );
  AO22X1_RVT U8992 ( .A1(\cpuregs[7][8] ), .A2(n4437), .A3(\cpuregs[9][8] ), 
        .A4(n4470), .Y(n7149) );
  AO22X1_RVT U8993 ( .A1(\cpuregs[28][8] ), .A2(n4281), .A3(\cpuregs[10][8] ), 
        .A4(n4462), .Y(n7148) );
  NOR4X1_RVT U8994 ( .A1(n7151), .A2(n7150), .A3(n7149), .A4(n7148), .Y(n7157)
         );
  AO22X1_RVT U8995 ( .A1(\cpuregs[2][8] ), .A2(n4464), .A3(\cpuregs[30][8] ), 
        .A4(n4501), .Y(n7155) );
  AO22X1_RVT U8996 ( .A1(\cpuregs[6][8] ), .A2(n4458), .A3(\cpuregs[14][8] ), 
        .A4(n4473), .Y(n7154) );
  AO22X1_RVT U8997 ( .A1(\cpuregs[22][8] ), .A2(n4495), .A3(\cpuregs[18][8] ), 
        .A4(n4505), .Y(n7153) );
  AO22X1_RVT U8998 ( .A1(\cpuregs[25][8] ), .A2(n4481), .A3(\cpuregs[26][8] ), 
        .A4(n4511), .Y(n7152) );
  NOR4X1_RVT U8999 ( .A1(n7155), .A2(n7154), .A3(n7153), .A4(n7152), .Y(n7156)
         );
  NAND4X0_RVT U9000 ( .A1(n7159), .A2(n7158), .A3(n7157), .A4(n7156), .Y(n7160) );
  AO222X1_RVT U9001 ( .A1(net30049), .A2(decoded_imm[8]), .A3(net30422), .A4(
        n7160), .A5(net27439), .A6(pcpi_rs2[8]), .Y(n3922) );
  AND2X1_RVT U9002 ( .A1(\cpuregs[16][7] ), .A2(n4287), .Y(n7164) );
  AO22X1_RVT U9003 ( .A1(\cpuregs[20][7] ), .A2(n4277), .A3(\cpuregs[6][7] ), 
        .A4(n4459), .Y(n7163) );
  AO22X1_RVT U9004 ( .A1(\cpuregs[18][7] ), .A2(n4506), .A3(\cpuregs[15][7] ), 
        .A4(n4491), .Y(n7162) );
  AO22X1_RVT U9005 ( .A1(\cpuregs[28][7] ), .A2(n4281), .A3(\cpuregs[3][7] ), 
        .A4(n4430), .Y(n7161) );
  NOR4X1_RVT U9006 ( .A1(n7164), .A2(n7163), .A3(n7162), .A4(n7161), .Y(n7180)
         );
  AO22X1_RVT U9007 ( .A1(\cpuregs[1][7] ), .A2(n4483), .A3(\cpuregs[17][7] ), 
        .A4(n4493), .Y(n7168) );
  AO22X1_RVT U9008 ( .A1(\cpuregs[4][7] ), .A2(n4275), .A3(\cpuregs[13][7] ), 
        .A4(n4454), .Y(n7167) );
  AO22X1_RVT U9009 ( .A1(\cpuregs[9][7] ), .A2(n4468), .A3(\cpuregs[12][7] ), 
        .A4(n7473), .Y(n7166) );
  AO22X1_RVT U9010 ( .A1(\cpuregs[27][7] ), .A2(n4456), .A3(\cpuregs[29][7] ), 
        .A4(n4509), .Y(n7165) );
  NOR4X1_RVT U9011 ( .A1(n7168), .A2(n7167), .A3(n7166), .A4(n7165), .Y(n7179)
         );
  AO22X1_RVT U9012 ( .A1(\cpuregs[14][7] ), .A2(n4471), .A3(\cpuregs[30][7] ), 
        .A4(n4502), .Y(n7172) );
  AO22X1_RVT U9013 ( .A1(\cpuregs[21][7] ), .A2(n4446), .A3(\cpuregs[31][7] ), 
        .A4(n4466), .Y(n7171) );
  AO22X1_RVT U9014 ( .A1(\cpuregs[23][7] ), .A2(n4443), .A3(\cpuregs[5][7] ), 
        .A4(n4478), .Y(n7170) );
  AO22X1_RVT U9015 ( .A1(\cpuregs[7][7] ), .A2(n4439), .A3(\cpuregs[2][7] ), 
        .A4(n3991), .Y(n7169) );
  NOR4X1_RVT U9016 ( .A1(n7172), .A2(n7171), .A3(n7170), .A4(n7169), .Y(n7178)
         );
  AO22X1_RVT U9017 ( .A1(\cpuregs[25][7] ), .A2(n4480), .A3(\cpuregs[26][7] ), 
        .A4(n4511), .Y(n7176) );
  AO22X1_RVT U9018 ( .A1(\cpuregs[10][7] ), .A2(n4461), .A3(\cpuregs[24][7] ), 
        .A4(n4283), .Y(n7175) );
  AO22X1_RVT U9019 ( .A1(\cpuregs[22][7] ), .A2(n4495), .A3(\cpuregs[8][7] ), 
        .A4(n4274), .Y(n7174) );
  AO22X1_RVT U9020 ( .A1(\cpuregs[11][7] ), .A2(n4475), .A3(\cpuregs[19][7] ), 
        .A4(n4500), .Y(n7173) );
  NOR4X1_RVT U9021 ( .A1(n7176), .A2(n7175), .A3(n7174), .A4(n7173), .Y(n7177)
         );
  NAND4X0_RVT U9022 ( .A1(n7180), .A2(n7179), .A3(n7178), .A4(n7177), .Y(n7181) );
  AO222X1_RVT U9023 ( .A1(net30048), .A2(decoded_imm[7]), .A3(net30422), .A4(
        n7181), .A5(net29439), .A6(pcpi_rs2[7]), .Y(n3923) );
  AND2X1_RVT U9024 ( .A1(\cpuregs[22][5] ), .A2(n4497), .Y(n7185) );
  AO22X1_RVT U9025 ( .A1(\cpuregs[18][5] ), .A2(n4505), .A3(\cpuregs[2][5] ), 
        .A4(n3991), .Y(n7184) );
  AO22X1_RVT U9026 ( .A1(\cpuregs[16][5] ), .A2(n4288), .A3(\cpuregs[30][5] ), 
        .A4(n4503), .Y(n7183) );
  AO22X1_RVT U9027 ( .A1(\cpuregs[26][5] ), .A2(n4511), .A3(\cpuregs[31][5] ), 
        .A4(n4466), .Y(n7182) );
  NOR4X1_RVT U9028 ( .A1(n7185), .A2(n7184), .A3(n7183), .A4(n7182), .Y(n7201)
         );
  AO22X1_RVT U9029 ( .A1(\cpuregs[11][5] ), .A2(n4474), .A3(\cpuregs[9][5] ), 
        .A4(n4469), .Y(n7189) );
  AO22X1_RVT U9030 ( .A1(\cpuregs[10][5] ), .A2(n4462), .A3(\cpuregs[14][5] ), 
        .A4(n4472), .Y(n7188) );
  AO22X1_RVT U9031 ( .A1(\cpuregs[13][5] ), .A2(n4454), .A3(\cpuregs[29][5] ), 
        .A4(n4509), .Y(n7187) );
  AO22X1_RVT U9032 ( .A1(\cpuregs[3][5] ), .A2(n4429), .A3(\cpuregs[25][5] ), 
        .A4(n4481), .Y(n7186) );
  NOR4X1_RVT U9033 ( .A1(n7189), .A2(n7188), .A3(n7187), .A4(n7186), .Y(n7200)
         );
  AO22X1_RVT U9034 ( .A1(\cpuregs[23][5] ), .A2(n4444), .A3(\cpuregs[27][5] ), 
        .A4(n4457), .Y(n7193) );
  AO22X1_RVT U9035 ( .A1(\cpuregs[7][5] ), .A2(n4438), .A3(\cpuregs[24][5] ), 
        .A4(n4285), .Y(n7192) );
  AO22X1_RVT U9036 ( .A1(\cpuregs[8][5] ), .A2(n7474), .A3(\cpuregs[15][5] ), 
        .A4(n4491), .Y(n7191) );
  AO22X1_RVT U9037 ( .A1(\cpuregs[20][5] ), .A2(n4278), .A3(\cpuregs[19][5] ), 
        .A4(n4500), .Y(n7190) );
  NOR4X1_RVT U9038 ( .A1(n7193), .A2(n7192), .A3(n7191), .A4(n7190), .Y(n7199)
         );
  AO22X1_RVT U9039 ( .A1(\cpuregs[17][5] ), .A2(n4492), .A3(\cpuregs[5][5] ), 
        .A4(n4479), .Y(n7197) );
  AO22X1_RVT U9040 ( .A1(\cpuregs[28][5] ), .A2(n4280), .A3(\cpuregs[12][5] ), 
        .A4(n4286), .Y(n7196) );
  AO22X1_RVT U9041 ( .A1(\cpuregs[21][5] ), .A2(n4447), .A3(\cpuregs[4][5] ), 
        .A4(n4275), .Y(n7195) );
  AO22X1_RVT U9042 ( .A1(\cpuregs[6][5] ), .A2(n4460), .A3(\cpuregs[1][5] ), 
        .A4(n4485), .Y(n7194) );
  NOR4X1_RVT U9043 ( .A1(n7197), .A2(n7196), .A3(n7195), .A4(n7194), .Y(n7198)
         );
  NAND4X0_RVT U9044 ( .A1(n7201), .A2(n7200), .A3(n7199), .A4(n7198), .Y(n7202) );
  AND2X1_RVT U9045 ( .A1(\cpuregs[9][6] ), .A2(n4469), .Y(n7209) );
  AO22X1_RVT U9046 ( .A1(\cpuregs[24][6] ), .A2(n4284), .A3(\cpuregs[8][6] ), 
        .A4(n4274), .Y(n7208) );
  AO22X1_RVT U9047 ( .A1(\cpuregs[21][6] ), .A2(n4448), .A3(\cpuregs[2][6] ), 
        .A4(n7468), .Y(n7207) );
  AO22X1_RVT U9048 ( .A1(\cpuregs[5][6] ), .A2(n4478), .A3(\cpuregs[22][6] ), 
        .A4(n4497), .Y(n7206) );
  NOR4X1_RVT U9049 ( .A1(n7209), .A2(n7208), .A3(n7207), .A4(n7206), .Y(n7225)
         );
  AO22X1_RVT U9050 ( .A1(\cpuregs[17][6] ), .A2(n4493), .A3(\cpuregs[28][6] ), 
        .A4(n4281), .Y(n7213) );
  AO22X1_RVT U9051 ( .A1(\cpuregs[23][6] ), .A2(n4445), .A3(\cpuregs[20][6] ), 
        .A4(n4278), .Y(n7212) );
  AO22X1_RVT U9052 ( .A1(\cpuregs[11][6] ), .A2(n4475), .A3(\cpuregs[26][6] ), 
        .A4(n4511), .Y(n7211) );
  AO22X1_RVT U9053 ( .A1(\cpuregs[4][6] ), .A2(n4275), .A3(\cpuregs[10][6] ), 
        .A4(n4462), .Y(n7210) );
  NOR4X1_RVT U9054 ( .A1(n7213), .A2(n7212), .A3(n7211), .A4(n7210), .Y(n7224)
         );
  AO22X1_RVT U9055 ( .A1(\cpuregs[14][6] ), .A2(n4471), .A3(\cpuregs[12][6] ), 
        .A4(n4286), .Y(n7217) );
  AO22X1_RVT U9056 ( .A1(\cpuregs[19][6] ), .A2(n4499), .A3(\cpuregs[18][6] ), 
        .A4(n4505), .Y(n7216) );
  AO22X1_RVT U9057 ( .A1(\cpuregs[25][6] ), .A2(n4482), .A3(\cpuregs[16][6] ), 
        .A4(n4289), .Y(n7215) );
  AO22X1_RVT U9058 ( .A1(\cpuregs[7][6] ), .A2(n4439), .A3(\cpuregs[3][6] ), 
        .A4(n4429), .Y(n7214) );
  NOR4X1_RVT U9059 ( .A1(n7217), .A2(n7216), .A3(n7215), .A4(n7214), .Y(n7223)
         );
  AO22X1_RVT U9060 ( .A1(\cpuregs[13][6] ), .A2(n4452), .A3(\cpuregs[29][6] ), 
        .A4(n4508), .Y(n7221) );
  AO22X1_RVT U9061 ( .A1(\cpuregs[31][6] ), .A2(n4466), .A3(\cpuregs[27][6] ), 
        .A4(n4456), .Y(n7220) );
  AO22X1_RVT U9062 ( .A1(\cpuregs[1][6] ), .A2(n4485), .A3(\cpuregs[15][6] ), 
        .A4(n4490), .Y(n7218) );
  NOR4X1_RVT U9063 ( .A1(n7221), .A2(n7220), .A3(n7219), .A4(n7218), .Y(n7222)
         );
  NAND4X0_RVT U9064 ( .A1(n7225), .A2(n7224), .A3(n7223), .A4(n7222), .Y(
        net23610) );
  AO22X1_RVT U9065 ( .A1(\cpuregs[12][2] ), .A2(n4829), .A3(\cpuregs[8][2] ), 
        .A4(n7226), .Y(n7251) );
  AO22X1_RVT U9066 ( .A1(\cpuregs[24][2] ), .A2(n7228), .A3(\cpuregs[16][2] ), 
        .A4(n7227), .Y(n7231) );
  AO22X1_RVT U9067 ( .A1(\cpuregs[4][2] ), .A2(n4838), .A3(\cpuregs[28][2] ), 
        .A4(n7229), .Y(n7230) );
  OR2X1_RVT U9068 ( .A1(n7231), .A2(n7230), .Y(n7232) );
  AO22X1_RVT U9069 ( .A1(\cpuregs[5][2] ), .A2(n4477), .A3(\cpuregs[10][2] ), 
        .A4(n4461), .Y(n7237) );
  AO22X1_RVT U9070 ( .A1(\cpuregs[21][2] ), .A2(n4446), .A3(\cpuregs[30][2] ), 
        .A4(n4501), .Y(n7236) );
  AO22X1_RVT U9071 ( .A1(\cpuregs[7][2] ), .A2(n4437), .A3(\cpuregs[2][2] ), 
        .A4(n4464), .Y(n7235) );
  AO22X1_RVT U9072 ( .A1(\cpuregs[29][2] ), .A2(n4507), .A3(\cpuregs[17][2] ), 
        .A4(n4492), .Y(n7234) );
  NOR4X1_RVT U9073 ( .A1(n7237), .A2(n7236), .A3(n7235), .A4(n7234), .Y(n7248)
         );
  AO22X1_RVT U9074 ( .A1(\cpuregs[13][2] ), .A2(n4452), .A3(\cpuregs[11][2] ), 
        .A4(n4474), .Y(n7241) );
  AO22X1_RVT U9075 ( .A1(\cpuregs[25][2] ), .A2(n4480), .A3(\cpuregs[9][2] ), 
        .A4(n4468), .Y(n7240) );
  AO22X1_RVT U9076 ( .A1(\cpuregs[31][2] ), .A2(n4465), .A3(\cpuregs[26][2] ), 
        .A4(n4510), .Y(n7239) );
  AO22X1_RVT U9077 ( .A1(\cpuregs[1][2] ), .A2(n4483), .A3(\cpuregs[14][2] ), 
        .A4(n4471), .Y(n7238) );
  NOR4X1_RVT U9078 ( .A1(n7241), .A2(n7240), .A3(n7239), .A4(n7238), .Y(n7247)
         );
  AO22X1_RVT U9079 ( .A1(\cpuregs[23][2] ), .A2(n4443), .A3(\cpuregs[15][2] ), 
        .A4(n4489), .Y(n7245) );
  AO22X1_RVT U9080 ( .A1(\cpuregs[19][2] ), .A2(n4498), .A3(\cpuregs[6][2] ), 
        .A4(n4458), .Y(n7244) );
  AO22X1_RVT U9081 ( .A1(\cpuregs[18][2] ), .A2(n4504), .A3(\cpuregs[22][2] ), 
        .A4(n4495), .Y(n7243) );
  AO22X1_RVT U9082 ( .A1(\cpuregs[3][2] ), .A2(n4429), .A3(\cpuregs[27][2] ), 
        .A4(n4455), .Y(n7242) );
  NOR4X1_RVT U9083 ( .A1(n7245), .A2(n7244), .A3(n7243), .A4(n7242), .Y(n7246)
         );
  NAND3X0_RVT U9084 ( .A1(n7248), .A2(n7247), .A3(n7246), .Y(n7249) );
  AO221X1_RVT U9085 ( .A1(n6855), .A2(n7251), .A3(n6855), .A4(n7250), .A5(
        n7249), .Y(n7252) );
  NAND2X0_RVT U9086 ( .A1(n7253), .A2(n7252), .Y(n7802) );
  AND2X1_RVT U9087 ( .A1(\cpuregs[16][22] ), .A2(n4289), .Y(n7258) );
  AO22X1_RVT U9088 ( .A1(\cpuregs[10][22] ), .A2(n4463), .A3(\cpuregs[5][22] ), 
        .A4(n4479), .Y(n7257) );
  AO22X1_RVT U9089 ( .A1(\cpuregs[15][22] ), .A2(n4490), .A3(\cpuregs[11][22] ), .A4(n4476), .Y(n7256) );
  AO22X1_RVT U9090 ( .A1(\cpuregs[31][22] ), .A2(n4466), .A3(\cpuregs[18][22] ), .A4(n4505), .Y(n7255) );
  NOR4X1_RVT U9091 ( .A1(n7258), .A2(n7257), .A3(n7256), .A4(n7255), .Y(n7274)
         );
  AO22X1_RVT U9092 ( .A1(\cpuregs[30][22] ), .A2(n4503), .A3(\cpuregs[7][22] ), 
        .A4(n4439), .Y(n7262) );
  AO22X1_RVT U9093 ( .A1(\cpuregs[26][22] ), .A2(n4512), .A3(\cpuregs[21][22] ), .A4(n4447), .Y(n7261) );
  AO22X1_RVT U9094 ( .A1(\cpuregs[28][22] ), .A2(n4282), .A3(\cpuregs[3][22] ), 
        .A4(n7376), .Y(n7260) );
  AO22X1_RVT U9095 ( .A1(\cpuregs[4][22] ), .A2(n7467), .A3(\cpuregs[19][22] ), 
        .A4(n4499), .Y(n7259) );
  NOR4X1_RVT U9096 ( .A1(n7262), .A2(n7261), .A3(n7260), .A4(n7259), .Y(n7273)
         );
  AO22X1_RVT U9097 ( .A1(\cpuregs[12][22] ), .A2(n7473), .A3(\cpuregs[2][22] ), 
        .A4(n3991), .Y(n7266) );
  AO22X1_RVT U9098 ( .A1(\cpuregs[8][22] ), .A2(n7474), .A3(\cpuregs[13][22] ), 
        .A4(n4453), .Y(n7265) );
  AO22X1_RVT U9099 ( .A1(\cpuregs[24][22] ), .A2(n4284), .A3(\cpuregs[22][22] ), .A4(n4497), .Y(n7264) );
  AO22X1_RVT U9100 ( .A1(\cpuregs[1][22] ), .A2(n4484), .A3(\cpuregs[6][22] ), 
        .A4(n4460), .Y(n7263) );
  NOR4X1_RVT U9101 ( .A1(n7266), .A2(n7265), .A3(n7264), .A4(n7263), .Y(n7272)
         );
  AO22X1_RVT U9102 ( .A1(\cpuregs[27][22] ), .A2(n4457), .A3(\cpuregs[17][22] ), .A4(n4494), .Y(n7270) );
  AO22X1_RVT U9103 ( .A1(\cpuregs[25][22] ), .A2(n4480), .A3(\cpuregs[20][22] ), .A4(n4279), .Y(n7269) );
  AO22X1_RVT U9104 ( .A1(\cpuregs[14][22] ), .A2(n4473), .A3(\cpuregs[9][22] ), 
        .A4(n4469), .Y(n7268) );
  AO22X1_RVT U9105 ( .A1(\cpuregs[23][22] ), .A2(n4445), .A3(\cpuregs[29][22] ), .A4(n4508), .Y(n7267) );
  NOR4X1_RVT U9106 ( .A1(n7270), .A2(n7269), .A3(n7268), .A4(n7267), .Y(n7271)
         );
  NAND4X0_RVT U9107 ( .A1(n7274), .A2(n7273), .A3(n7272), .A4(n7271), .Y(n7275) );
  AND2X1_RVT U9108 ( .A1(\cpuregs[2][26] ), .A2(n3991), .Y(n7279) );
  AO22X1_RVT U9109 ( .A1(\cpuregs[12][26] ), .A2(n7473), .A3(\cpuregs[11][26] ), .A4(n4475), .Y(n7278) );
  AO22X1_RVT U9110 ( .A1(\cpuregs[22][26] ), .A2(n4496), .A3(\cpuregs[6][26] ), 
        .A4(n4459), .Y(n7277) );
  AO22X1_RVT U9111 ( .A1(\cpuregs[3][26] ), .A2(n4430), .A3(\cpuregs[16][26] ), 
        .A4(n4288), .Y(n7276) );
  NOR4X1_RVT U9112 ( .A1(n7279), .A2(n7278), .A3(n7277), .A4(n7276), .Y(n7295)
         );
  AO22X1_RVT U9113 ( .A1(\cpuregs[9][26] ), .A2(n4468), .A3(\cpuregs[30][26] ), 
        .A4(n4503), .Y(n7283) );
  AO22X1_RVT U9114 ( .A1(\cpuregs[7][26] ), .A2(n4437), .A3(\cpuregs[4][26] ), 
        .A4(n7467), .Y(n7282) );
  AO22X1_RVT U9115 ( .A1(\cpuregs[26][26] ), .A2(n4510), .A3(\cpuregs[25][26] ), .A4(n4481), .Y(n7281) );
  AO22X1_RVT U9116 ( .A1(\cpuregs[14][26] ), .A2(n4472), .A3(\cpuregs[29][26] ), .A4(n4508), .Y(n7280) );
  NOR4X1_RVT U9117 ( .A1(n7283), .A2(n7282), .A3(n7281), .A4(n7280), .Y(n7294)
         );
  AO22X1_RVT U9118 ( .A1(\cpuregs[10][26] ), .A2(n4461), .A3(\cpuregs[27][26] ), .A4(n4457), .Y(n7286) );
  AO22X1_RVT U9119 ( .A1(\cpuregs[31][26] ), .A2(n4466), .A3(\cpuregs[1][26] ), 
        .A4(n4484), .Y(n7285) );
  AO22X1_RVT U9120 ( .A1(\cpuregs[19][26] ), .A2(n4500), .A3(\cpuregs[18][26] ), .A4(n4505), .Y(n7284) );
  AO22X1_RVT U9121 ( .A1(\cpuregs[13][26] ), .A2(n4452), .A3(\cpuregs[15][26] ), .A4(n4489), .Y(n7291) );
  AO22X1_RVT U9122 ( .A1(\cpuregs[20][26] ), .A2(n4277), .A3(\cpuregs[17][26] ), .A4(n4494), .Y(n7290) );
  AO22X1_RVT U9123 ( .A1(\cpuregs[24][26] ), .A2(n4283), .A3(\cpuregs[5][26] ), 
        .A4(n4479), .Y(n7289) );
  AO22X1_RVT U9124 ( .A1(\cpuregs[28][26] ), .A2(n4282), .A3(\cpuregs[21][26] ), .A4(n4447), .Y(n7288) );
  NOR4X1_RVT U9125 ( .A1(n7291), .A2(n7290), .A3(n7289), .A4(n7288), .Y(n7292)
         );
  NAND4X0_RVT U9126 ( .A1(n7295), .A2(n7294), .A3(n7293), .A4(n7292), .Y(n7296) );
  AO222X1_RVT U9127 ( .A1(net30049), .A2(decoded_imm[26]), .A3(n7296), .A4(
        net30423), .A5(net29438), .A6(pcpi_rs2[26]), .Y(n3904) );
  AND2X1_RVT U9128 ( .A1(\cpuregs[14][25] ), .A2(n4472), .Y(n7300) );
  AO22X1_RVT U9129 ( .A1(\cpuregs[2][25] ), .A2(n4464), .A3(\cpuregs[7][25] ), 
        .A4(n4439), .Y(n7299) );
  AO22X1_RVT U9130 ( .A1(\cpuregs[9][25] ), .A2(n4469), .A3(\cpuregs[12][25] ), 
        .A4(n4286), .Y(n7298) );
  AO22X1_RVT U9131 ( .A1(\cpuregs[13][25] ), .A2(n4453), .A3(\cpuregs[31][25] ), .A4(n4467), .Y(n7297) );
  NOR4X1_RVT U9132 ( .A1(n7300), .A2(n7299), .A3(n7298), .A4(n7297), .Y(n7316)
         );
  AO22X1_RVT U9133 ( .A1(\cpuregs[11][25] ), .A2(n4474), .A3(\cpuregs[24][25] ), .A4(n4283), .Y(n7304) );
  AO22X1_RVT U9134 ( .A1(\cpuregs[8][25] ), .A2(n4274), .A3(\cpuregs[10][25] ), 
        .A4(n4462), .Y(n7303) );
  AO22X1_RVT U9135 ( .A1(\cpuregs[5][25] ), .A2(n4477), .A3(\cpuregs[1][25] ), 
        .A4(n4485), .Y(n7302) );
  AO22X1_RVT U9136 ( .A1(\cpuregs[4][25] ), .A2(n7467), .A3(\cpuregs[26][25] ), 
        .A4(n4512), .Y(n7301) );
  NOR4X1_RVT U9137 ( .A1(n7304), .A2(n7303), .A3(n7302), .A4(n7301), .Y(n7315)
         );
  AO22X1_RVT U9138 ( .A1(\cpuregs[18][25] ), .A2(n4504), .A3(\cpuregs[3][25] ), 
        .A4(n4430), .Y(n7308) );
  AO22X1_RVT U9139 ( .A1(\cpuregs[20][25] ), .A2(n4277), .A3(\cpuregs[29][25] ), .A4(n4508), .Y(n7307) );
  AO22X1_RVT U9140 ( .A1(\cpuregs[27][25] ), .A2(n4455), .A3(\cpuregs[30][25] ), .A4(n4502), .Y(n7306) );
  AO22X1_RVT U9141 ( .A1(\cpuregs[15][25] ), .A2(n4491), .A3(\cpuregs[17][25] ), .A4(n4493), .Y(n7305) );
  NOR4X1_RVT U9142 ( .A1(n7308), .A2(n7307), .A3(n7306), .A4(n7305), .Y(n7314)
         );
  AO22X1_RVT U9143 ( .A1(\cpuregs[22][25] ), .A2(n4495), .A3(\cpuregs[23][25] ), .A4(n4443), .Y(n7312) );
  AO22X1_RVT U9144 ( .A1(\cpuregs[6][25] ), .A2(n4458), .A3(\cpuregs[19][25] ), 
        .A4(n4498), .Y(n7311) );
  AO22X1_RVT U9145 ( .A1(\cpuregs[28][25] ), .A2(n4280), .A3(\cpuregs[21][25] ), .A4(n4447), .Y(n7310) );
  AO22X1_RVT U9146 ( .A1(\cpuregs[25][25] ), .A2(n4482), .A3(\cpuregs[16][25] ), .A4(n4288), .Y(n7309) );
  NOR4X1_RVT U9147 ( .A1(n7312), .A2(n7311), .A3(n7310), .A4(n7309), .Y(n7313)
         );
  NAND4X0_RVT U9148 ( .A1(n7316), .A2(n7315), .A3(n7314), .A4(n7313), .Y(n7317) );
  AO222X1_RVT U9149 ( .A1(net30048), .A2(decoded_imm[25]), .A3(net30422), .A4(
        n7317), .A5(net29438), .A6(pcpi_rs2[25]), .Y(n3905) );
  AND2X1_RVT U9150 ( .A1(\cpuregs[6][19] ), .A2(n4459), .Y(n7321) );
  AO22X1_RVT U9151 ( .A1(\cpuregs[8][19] ), .A2(n7474), .A3(\cpuregs[20][19] ), 
        .A4(n4277), .Y(n7320) );
  AO22X1_RVT U9152 ( .A1(\cpuregs[10][19] ), .A2(n4462), .A3(\cpuregs[15][19] ), .A4(n4490), .Y(n7319) );
  AO22X1_RVT U9153 ( .A1(\cpuregs[9][19] ), .A2(n4469), .A3(\cpuregs[21][19] ), 
        .A4(n4448), .Y(n7318) );
  NOR4X1_RVT U9154 ( .A1(n7321), .A2(n7320), .A3(n7319), .A4(n7318), .Y(n7337)
         );
  AO22X1_RVT U9155 ( .A1(\cpuregs[22][19] ), .A2(n4495), .A3(\cpuregs[16][19] ), .A4(n4287), .Y(n7325) );
  AO22X1_RVT U9156 ( .A1(\cpuregs[23][19] ), .A2(n4443), .A3(\cpuregs[12][19] ), .A4(n7473), .Y(n7324) );
  AO22X1_RVT U9157 ( .A1(\cpuregs[11][19] ), .A2(n4474), .A3(\cpuregs[28][19] ), .A4(n4281), .Y(n7323) );
  AO22X1_RVT U9158 ( .A1(\cpuregs[3][19] ), .A2(n4429), .A3(\cpuregs[13][19] ), 
        .A4(n4454), .Y(n7322) );
  NOR4X1_RVT U9159 ( .A1(n7325), .A2(n7324), .A3(n7323), .A4(n7322), .Y(n7336)
         );
  AO22X1_RVT U9160 ( .A1(\cpuregs[31][19] ), .A2(n4465), .A3(\cpuregs[5][19] ), 
        .A4(n4477), .Y(n7329) );
  AO22X1_RVT U9161 ( .A1(\cpuregs[19][19] ), .A2(n4498), .A3(\cpuregs[1][19] ), 
        .A4(n4485), .Y(n7328) );
  AO22X1_RVT U9162 ( .A1(\cpuregs[26][19] ), .A2(n4510), .A3(\cpuregs[24][19] ), .A4(n4283), .Y(n7327) );
  AO22X1_RVT U9163 ( .A1(\cpuregs[30][19] ), .A2(n4502), .A3(\cpuregs[25][19] ), .A4(n4481), .Y(n7326) );
  NOR4X1_RVT U9164 ( .A1(n7329), .A2(n7328), .A3(n7327), .A4(n7326), .Y(n7335)
         );
  AO22X1_RVT U9165 ( .A1(\cpuregs[14][19] ), .A2(n4471), .A3(\cpuregs[2][19] ), 
        .A4(n7468), .Y(n7333) );
  AO22X1_RVT U9166 ( .A1(\cpuregs[29][19] ), .A2(n4507), .A3(\cpuregs[17][19] ), .A4(n4494), .Y(n7332) );
  AO22X1_RVT U9167 ( .A1(\cpuregs[7][19] ), .A2(n4437), .A3(\cpuregs[18][19] ), 
        .A4(n4506), .Y(n7331) );
  AO22X1_RVT U9168 ( .A1(\cpuregs[4][19] ), .A2(n7467), .A3(\cpuregs[27][19] ), 
        .A4(n4456), .Y(n7330) );
  NOR4X1_RVT U9169 ( .A1(n7333), .A2(n7332), .A3(n7331), .A4(n7330), .Y(n7334)
         );
  AND2X1_RVT U9170 ( .A1(\cpuregs[8][29] ), .A2(n7474), .Y(n7342) );
  AO22X1_RVT U9171 ( .A1(\cpuregs[19][29] ), .A2(n4500), .A3(\cpuregs[25][29] ), .A4(n4482), .Y(n7341) );
  AO22X1_RVT U9172 ( .A1(\cpuregs[24][29] ), .A2(n4285), .A3(\cpuregs[6][29] ), 
        .A4(n4459), .Y(n7340) );
  AO22X1_RVT U9173 ( .A1(\cpuregs[13][29] ), .A2(n4454), .A3(\cpuregs[23][29] ), .A4(n4445), .Y(n7339) );
  NOR4X1_RVT U9174 ( .A1(n7342), .A2(n7341), .A3(n7340), .A4(n7339), .Y(n7360)
         );
  AO22X1_RVT U9175 ( .A1(\cpuregs[29][29] ), .A2(n4508), .A3(\cpuregs[28][29] ), .A4(n4282), .Y(n7346) );
  AO22X1_RVT U9176 ( .A1(\cpuregs[16][29] ), .A2(n4288), .A3(\cpuregs[7][29] ), 
        .A4(n4438), .Y(n7345) );
  AO22X1_RVT U9177 ( .A1(\cpuregs[3][29] ), .A2(n4430), .A3(\cpuregs[14][29] ), 
        .A4(n4472), .Y(n7344) );
  NOR4X1_RVT U9178 ( .A1(n7347), .A2(n7346), .A3(n7345), .A4(n7344), .Y(n7359)
         );
  AO22X1_RVT U9179 ( .A1(\cpuregs[2][29] ), .A2(n3991), .A3(\cpuregs[9][29] ), 
        .A4(n4470), .Y(n7351) );
  AO22X1_RVT U9180 ( .A1(\cpuregs[18][29] ), .A2(n4506), .A3(\cpuregs[1][29] ), 
        .A4(n4485), .Y(n7350) );
  AO22X1_RVT U9181 ( .A1(\cpuregs[15][29] ), .A2(n4490), .A3(\cpuregs[5][29] ), 
        .A4(n4479), .Y(n7349) );
  AO22X1_RVT U9182 ( .A1(\cpuregs[10][29] ), .A2(n4463), .A3(\cpuregs[11][29] ), .A4(n4476), .Y(n7348) );
  NOR4X1_RVT U9183 ( .A1(n7351), .A2(n7350), .A3(n7349), .A4(n7348), .Y(n7358)
         );
  AO22X1_RVT U9184 ( .A1(\cpuregs[22][29] ), .A2(n4497), .A3(\cpuregs[31][29] ), .A4(n4467), .Y(n7356) );
  AO22X1_RVT U9185 ( .A1(\cpuregs[12][29] ), .A2(n7473), .A3(\cpuregs[20][29] ), .A4(n4278), .Y(n7355) );
  AO22X1_RVT U9186 ( .A1(\cpuregs[4][29] ), .A2(n4275), .A3(\cpuregs[26][29] ), 
        .A4(n4511), .Y(n7354) );
  AO22X1_RVT U9187 ( .A1(\cpuregs[27][29] ), .A2(n4456), .A3(\cpuregs[30][29] ), .A4(n4503), .Y(n7353) );
  NOR4X1_RVT U9188 ( .A1(n7356), .A2(n7355), .A3(n7354), .A4(n7353), .Y(n7357)
         );
  NAND4X0_RVT U9189 ( .A1(n7360), .A2(n7359), .A3(n7358), .A4(n7357), .Y(n7361) );
  AND2X1_RVT U9190 ( .A1(\cpuregs[6][15] ), .A2(n4459), .Y(n7365) );
  AO22X1_RVT U9191 ( .A1(\cpuregs[17][15] ), .A2(n4494), .A3(\cpuregs[12][15] ), .A4(n4286), .Y(n7364) );
  AO22X1_RVT U9192 ( .A1(\cpuregs[23][15] ), .A2(n4444), .A3(\cpuregs[11][15] ), .A4(n4475), .Y(n7363) );
  AO22X1_RVT U9193 ( .A1(\cpuregs[9][15] ), .A2(n4469), .A3(\cpuregs[24][15] ), 
        .A4(n4285), .Y(n7362) );
  NOR4X1_RVT U9194 ( .A1(n7365), .A2(n7364), .A3(n7363), .A4(n7362), .Y(n7384)
         );
  AO22X1_RVT U9195 ( .A1(\cpuregs[2][15] ), .A2(n3991), .A3(\cpuregs[31][15] ), 
        .A4(n4466), .Y(n7369) );
  AO22X1_RVT U9196 ( .A1(\cpuregs[26][15] ), .A2(n4511), .A3(\cpuregs[13][15] ), .A4(n4454), .Y(n7368) );
  AO22X1_RVT U9197 ( .A1(\cpuregs[5][15] ), .A2(n4479), .A3(\cpuregs[4][15] ), 
        .A4(n4275), .Y(n7367) );
  AO22X1_RVT U9198 ( .A1(\cpuregs[21][15] ), .A2(n4448), .A3(\cpuregs[10][15] ), .A4(n4463), .Y(n7366) );
  NOR4X1_RVT U9199 ( .A1(n7369), .A2(n7368), .A3(n7367), .A4(n7366), .Y(n7383)
         );
  AO22X1_RVT U9200 ( .A1(\cpuregs[27][15] ), .A2(n4456), .A3(\cpuregs[30][15] ), .A4(n4502), .Y(n7375) );
  AO22X1_RVT U9201 ( .A1(\cpuregs[28][15] ), .A2(n4281), .A3(\cpuregs[1][15] ), 
        .A4(n4485), .Y(n7374) );
  AO22X1_RVT U9202 ( .A1(\cpuregs[22][15] ), .A2(n4496), .A3(\cpuregs[18][15] ), .A4(n4506), .Y(n7373) );
  AO22X1_RVT U9203 ( .A1(\cpuregs[29][15] ), .A2(n4508), .A3(\cpuregs[8][15] ), 
        .A4(n4274), .Y(n7372) );
  NOR4X1_RVT U9204 ( .A1(n7375), .A2(n7374), .A3(n7373), .A4(n7372), .Y(n7382)
         );
  AO22X1_RVT U9205 ( .A1(\cpuregs[3][15] ), .A2(n4429), .A3(\cpuregs[16][15] ), 
        .A4(n4289), .Y(n7380) );
  AO22X1_RVT U9206 ( .A1(\cpuregs[15][15] ), .A2(n4490), .A3(\cpuregs[19][15] ), .A4(n4500), .Y(n7379) );
  AO22X1_RVT U9207 ( .A1(\cpuregs[14][15] ), .A2(n4472), .A3(\cpuregs[25][15] ), .A4(n4482), .Y(n7378) );
  AO22X1_RVT U9208 ( .A1(\cpuregs[20][15] ), .A2(n4279), .A3(\cpuregs[7][15] ), 
        .A4(n4439), .Y(n7377) );
  NOR4X1_RVT U9209 ( .A1(n7380), .A2(n7379), .A3(n7378), .A4(n7377), .Y(n7381)
         );
  NAND4X0_RVT U9210 ( .A1(n7384), .A2(n7383), .A3(n7382), .A4(n7381), .Y(n7385) );
  AO222X1_RVT U9211 ( .A1(pcpi_rs2[15]), .A2(net27439), .A3(net30048), .A4(
        decoded_imm[15]), .A5(n7385), .A6(net30423), .Y(n3915) );
  AND2X1_RVT U9212 ( .A1(\cpuregs[1][23] ), .A2(n4484), .Y(n7392) );
  AO22X1_RVT U9213 ( .A1(\cpuregs[20][23] ), .A2(n4279), .A3(\cpuregs[26][23] ), .A4(n4512), .Y(n7391) );
  AO22X1_RVT U9214 ( .A1(\cpuregs[27][23] ), .A2(n4456), .A3(\cpuregs[2][23] ), 
        .A4(n3991), .Y(n7390) );
  AO22X1_RVT U9215 ( .A1(\cpuregs[24][23] ), .A2(n4285), .A3(\cpuregs[21][23] ), .A4(n4447), .Y(n7389) );
  NOR4X1_RVT U9216 ( .A1(n7392), .A2(n7391), .A3(n7390), .A4(n7389), .Y(n7408)
         );
  AO22X1_RVT U9217 ( .A1(\cpuregs[11][23] ), .A2(n4474), .A3(\cpuregs[3][23] ), 
        .A4(n4430), .Y(n7396) );
  AO22X1_RVT U9218 ( .A1(\cpuregs[17][23] ), .A2(n4493), .A3(\cpuregs[8][23] ), 
        .A4(n4274), .Y(n7395) );
  AO22X1_RVT U9219 ( .A1(\cpuregs[28][23] ), .A2(n4282), .A3(\cpuregs[13][23] ), .A4(n4453), .Y(n7394) );
  AO22X1_RVT U9220 ( .A1(\cpuregs[14][23] ), .A2(n4472), .A3(\cpuregs[29][23] ), .A4(n4509), .Y(n7393) );
  NOR4X1_RVT U9221 ( .A1(n7396), .A2(n7395), .A3(n7394), .A4(n7393), .Y(n7407)
         );
  AO22X1_RVT U9222 ( .A1(\cpuregs[23][23] ), .A2(n4443), .A3(\cpuregs[5][23] ), 
        .A4(n4478), .Y(n7400) );
  AO22X1_RVT U9223 ( .A1(\cpuregs[4][23] ), .A2(n4275), .A3(\cpuregs[7][23] ), 
        .A4(n4438), .Y(n7399) );
  AO22X1_RVT U9224 ( .A1(\cpuregs[6][23] ), .A2(n4459), .A3(\cpuregs[19][23] ), 
        .A4(n4500), .Y(n7398) );
  AO22X1_RVT U9225 ( .A1(\cpuregs[16][23] ), .A2(n4288), .A3(\cpuregs[12][23] ), .A4(n4286), .Y(n7397) );
  NOR4X1_RVT U9226 ( .A1(n7400), .A2(n7399), .A3(n7398), .A4(n7397), .Y(n7406)
         );
  AO22X1_RVT U9227 ( .A1(\cpuregs[22][23] ), .A2(n4496), .A3(\cpuregs[9][23] ), 
        .A4(n4469), .Y(n7404) );
  AO22X1_RVT U9228 ( .A1(\cpuregs[18][23] ), .A2(n4505), .A3(\cpuregs[15][23] ), .A4(n4490), .Y(n7403) );
  AO22X1_RVT U9229 ( .A1(\cpuregs[31][23] ), .A2(n4466), .A3(\cpuregs[25][23] ), .A4(n4481), .Y(n7402) );
  AO22X1_RVT U9230 ( .A1(\cpuregs[10][23] ), .A2(n4462), .A3(\cpuregs[30][23] ), .A4(n4502), .Y(n7401) );
  NOR4X1_RVT U9231 ( .A1(n7404), .A2(n7403), .A3(n7402), .A4(n7401), .Y(n7405)
         );
  NAND4X0_RVT U9232 ( .A1(n7408), .A2(n7407), .A3(n7406), .A4(n7405), .Y(n7409) );
  AND2X1_RVT U9233 ( .A1(\cpuregs[11][21] ), .A2(n4476), .Y(n7414) );
  AO22X1_RVT U9234 ( .A1(\cpuregs[8][21] ), .A2(n4274), .A3(\cpuregs[4][21] ), 
        .A4(n7467), .Y(n7413) );
  AO22X1_RVT U9235 ( .A1(\cpuregs[26][21] ), .A2(n4512), .A3(\cpuregs[25][21] ), .A4(n4482), .Y(n7412) );
  AO22X1_RVT U9236 ( .A1(\cpuregs[23][21] ), .A2(n4444), .A3(\cpuregs[30][21] ), .A4(n4502), .Y(n7411) );
  NOR4X1_RVT U9237 ( .A1(n7414), .A2(n7413), .A3(n7412), .A4(n7411), .Y(n7437)
         );
  AO22X1_RVT U9238 ( .A1(\cpuregs[9][21] ), .A2(n4468), .A3(\cpuregs[28][21] ), 
        .A4(n4280), .Y(n7419) );
  AO22X1_RVT U9239 ( .A1(\cpuregs[21][21] ), .A2(n4446), .A3(\cpuregs[3][21] ), 
        .A4(n4430), .Y(n7418) );
  AO22X1_RVT U9240 ( .A1(\cpuregs[16][21] ), .A2(n4287), .A3(\cpuregs[31][21] ), .A4(n4466), .Y(n7417) );
  AO22X1_RVT U9241 ( .A1(\cpuregs[24][21] ), .A2(n4285), .A3(\cpuregs[7][21] ), 
        .A4(n4439), .Y(n7416) );
  NOR4X1_RVT U9242 ( .A1(n7419), .A2(n7418), .A3(n7417), .A4(n7416), .Y(n7436)
         );
  AO22X1_RVT U9243 ( .A1(\cpuregs[20][21] ), .A2(n4277), .A3(\cpuregs[5][21] ), 
        .A4(n4477), .Y(n7425) );
  AO22X1_RVT U9244 ( .A1(\cpuregs[2][21] ), .A2(n4464), .A3(\cpuregs[12][21] ), 
        .A4(n7473), .Y(n7424) );
  AO22X1_RVT U9245 ( .A1(\cpuregs[29][21] ), .A2(n4507), .A3(\cpuregs[27][21] ), .A4(n4457), .Y(n7423) );
  AO22X1_RVT U9246 ( .A1(\cpuregs[6][21] ), .A2(n4460), .A3(\cpuregs[22][21] ), 
        .A4(n4496), .Y(n7422) );
  NOR4X1_RVT U9247 ( .A1(n7425), .A2(n7424), .A3(n7423), .A4(n7422), .Y(n7435)
         );
  AO22X1_RVT U9248 ( .A1(\cpuregs[10][21] ), .A2(n4461), .A3(\cpuregs[15][21] ), .A4(n4491), .Y(n7433) );
  AO22X1_RVT U9249 ( .A1(\cpuregs[17][21] ), .A2(n4492), .A3(\cpuregs[18][21] ), .A4(n4504), .Y(n7432) );
  AO22X1_RVT U9250 ( .A1(\cpuregs[14][21] ), .A2(n4471), .A3(\cpuregs[1][21] ), 
        .A4(n4485), .Y(n7431) );
  AO22X1_RVT U9251 ( .A1(\cpuregs[13][21] ), .A2(n4452), .A3(\cpuregs[19][21] ), .A4(n4499), .Y(n7430) );
  NOR4X1_RVT U9252 ( .A1(n7433), .A2(n7432), .A3(n7431), .A4(n7430), .Y(n7434)
         );
  NAND4X0_RVT U9253 ( .A1(n7437), .A2(n7436), .A3(n7435), .A4(n7434), .Y(n7438) );
  AO222X1_RVT U9254 ( .A1(net30049), .A2(decoded_imm[21]), .A3(net30422), .A4(
        n7438), .A5(net29438), .A6(pcpi_rs2[21]), .Y(n3909) );
  AND2X1_RVT U9255 ( .A1(\cpuregs[26][17] ), .A2(n4512), .Y(n7444) );
  AO22X1_RVT U9256 ( .A1(\cpuregs[17][17] ), .A2(n4494), .A3(\cpuregs[11][17] ), .A4(n4476), .Y(n7443) );
  AO22X1_RVT U9257 ( .A1(\cpuregs[14][17] ), .A2(n4472), .A3(\cpuregs[3][17] ), 
        .A4(n4430), .Y(n7442) );
  AO22X1_RVT U9258 ( .A1(\cpuregs[27][17] ), .A2(n4457), .A3(\cpuregs[22][17] ), .A4(n4496), .Y(n7441) );
  NOR4X1_RVT U9259 ( .A1(n7444), .A2(n7443), .A3(n7442), .A4(n7441), .Y(n7465)
         );
  AO22X1_RVT U9260 ( .A1(\cpuregs[25][17] ), .A2(n4481), .A3(\cpuregs[1][17] ), 
        .A4(n4484), .Y(n7451) );
  AO22X1_RVT U9261 ( .A1(\cpuregs[30][17] ), .A2(n4503), .A3(\cpuregs[29][17] ), .A4(n4509), .Y(n7450) );
  AO22X1_RVT U9262 ( .A1(\cpuregs[13][17] ), .A2(n4453), .A3(\cpuregs[23][17] ), .A4(n4444), .Y(n7449) );
  AO22X1_RVT U9263 ( .A1(\cpuregs[18][17] ), .A2(n4505), .A3(\cpuregs[9][17] ), 
        .A4(n4470), .Y(n7448) );
  NOR4X1_RVT U9264 ( .A1(n7451), .A2(n7450), .A3(n7449), .A4(n7448), .Y(n7464)
         );
  AO22X1_RVT U9265 ( .A1(\cpuregs[28][17] ), .A2(n4280), .A3(\cpuregs[20][17] ), .A4(n4278), .Y(n7456) );
  AO22X1_RVT U9266 ( .A1(\cpuregs[8][17] ), .A2(n4274), .A3(\cpuregs[10][17] ), 
        .A4(n4462), .Y(n7455) );
  AO22X1_RVT U9267 ( .A1(\cpuregs[5][17] ), .A2(n4478), .A3(\cpuregs[31][17] ), 
        .A4(n4466), .Y(n7454) );
  AO22X1_RVT U9268 ( .A1(\cpuregs[4][17] ), .A2(n4275), .A3(\cpuregs[6][17] ), 
        .A4(n4459), .Y(n7453) );
  NOR4X1_RVT U9269 ( .A1(n7456), .A2(n7455), .A3(n7454), .A4(n7453), .Y(n7463)
         );
  AO22X1_RVT U9270 ( .A1(\cpuregs[15][17] ), .A2(n4489), .A3(\cpuregs[7][17] ), 
        .A4(n4438), .Y(n7461) );
  AO22X1_RVT U9271 ( .A1(\cpuregs[12][17] ), .A2(n7473), .A3(\cpuregs[16][17] ), .A4(n4289), .Y(n7460) );
  AO22X1_RVT U9272 ( .A1(\cpuregs[21][17] ), .A2(n4447), .A3(\cpuregs[24][17] ), .A4(n4284), .Y(n7459) );
  AO22X1_RVT U9273 ( .A1(\cpuregs[2][17] ), .A2(n7468), .A3(\cpuregs[19][17] ), 
        .A4(n4500), .Y(n7458) );
  NOR4X1_RVT U9274 ( .A1(n7461), .A2(n7460), .A3(n7459), .A4(n7458), .Y(n7462)
         );
  NAND4X0_RVT U9275 ( .A1(n7465), .A2(n7464), .A3(n7463), .A4(n7462), .Y(n7466) );
  AO222X1_RVT U9276 ( .A1(pcpi_rs2[17]), .A2(net29438), .A3(net23989), .A4(
        decoded_imm[17]), .A5(n7466), .A6(net30423), .Y(n3913) );
  AND2X1_RVT U9277 ( .A1(\cpuregs[4][27] ), .A2(n7467), .Y(n7472) );
  AO22X1_RVT U9278 ( .A1(\cpuregs[27][27] ), .A2(n4456), .A3(\cpuregs[29][27] ), .A4(n4509), .Y(n7471) );
  AO22X1_RVT U9279 ( .A1(\cpuregs[30][27] ), .A2(n4503), .A3(\cpuregs[23][27] ), .A4(n4445), .Y(n7470) );
  AO22X1_RVT U9280 ( .A1(\cpuregs[2][27] ), .A2(n7468), .A3(\cpuregs[10][27] ), 
        .A4(n4463), .Y(n7469) );
  NOR4X1_RVT U9281 ( .A1(n7472), .A2(n7471), .A3(n7470), .A4(n7469), .Y(n7493)
         );
  AO22X1_RVT U9282 ( .A1(\cpuregs[12][27] ), .A2(n7473), .A3(\cpuregs[19][27] ), .A4(n4500), .Y(n7478) );
  AO22X1_RVT U9283 ( .A1(\cpuregs[13][27] ), .A2(n4453), .A3(\cpuregs[14][27] ), .A4(n4473), .Y(n7477) );
  AO22X1_RVT U9284 ( .A1(\cpuregs[6][27] ), .A2(n4460), .A3(\cpuregs[8][27] ), 
        .A4(n4274), .Y(n7476) );
  AO22X1_RVT U9285 ( .A1(\cpuregs[18][27] ), .A2(n4505), .A3(\cpuregs[22][27] ), .A4(n4496), .Y(n7475) );
  NOR4X1_RVT U9286 ( .A1(n7478), .A2(n7477), .A3(n7476), .A4(n7475), .Y(n7492)
         );
  AO22X1_RVT U9287 ( .A1(\cpuregs[9][27] ), .A2(n4470), .A3(\cpuregs[28][27] ), 
        .A4(n4282), .Y(n7483) );
  AO22X1_RVT U9288 ( .A1(\cpuregs[5][27] ), .A2(n4477), .A3(\cpuregs[31][27] ), 
        .A4(n4467), .Y(n7482) );
  AO22X1_RVT U9289 ( .A1(\cpuregs[24][27] ), .A2(n4285), .A3(\cpuregs[11][27] ), .A4(n4475), .Y(n7481) );
  AO22X1_RVT U9290 ( .A1(\cpuregs[25][27] ), .A2(n4482), .A3(\cpuregs[17][27] ), .A4(n4494), .Y(n7480) );
  NOR4X1_RVT U9291 ( .A1(n7483), .A2(n7482), .A3(n7481), .A4(n7480), .Y(n7491)
         );
  AO22X1_RVT U9292 ( .A1(\cpuregs[21][27] ), .A2(n4446), .A3(\cpuregs[26][27] ), .A4(n4512), .Y(n7489) );
  AO22X1_RVT U9293 ( .A1(\cpuregs[3][27] ), .A2(n4430), .A3(\cpuregs[20][27] ), 
        .A4(n4278), .Y(n7488) );
  AO22X1_RVT U9294 ( .A1(\cpuregs[7][27] ), .A2(n4438), .A3(\cpuregs[15][27] ), 
        .A4(n4491), .Y(n7487) );
  AO22X1_RVT U9295 ( .A1(\cpuregs[16][27] ), .A2(n4289), .A3(\cpuregs[1][27] ), 
        .A4(n4484), .Y(n7486) );
  NOR4X1_RVT U9296 ( .A1(n7489), .A2(n7488), .A3(n7487), .A4(n7486), .Y(n7490)
         );
  NAND4X0_RVT U9297 ( .A1(n7493), .A2(n7492), .A3(n7491), .A4(n7490), .Y(n7494) );
  AO222X1_RVT U9298 ( .A1(pcpi_rs2[27]), .A2(net27439), .A3(net23989), .A4(
        decoded_imm[27]), .A5(n7494), .A6(net30424), .Y(n3903) );
  NAND2X0_RVT U9299 ( .A1(n8024), .A2(net16452), .Y(n7501) );
  NAND2X0_RVT U9300 ( .A1(pcpi_rs2[30]), .A2(pcpi_rs1[30]), .Y(n7495) );
  AO21X1_RVT U9301 ( .A1(n4245), .A2(n7495), .A3(n4243), .Y(n7500) );
  FADDX1_RVT U9302 ( .A(pcpi_rs1[30]), .B(n7497), .CI(n7496), .CO(n5132), .S(
        n7498) );
  AO222X1_RVT U9303 ( .A1(n7501), .A2(n7500), .A3(n7499), .A4(n4246), .A5(
        n4528), .A6(n7498), .Y(alu_out[30]) );
  AO222X1_RVT U9304 ( .A1(n7885), .A2(n4353), .A3(n4068), .A4(reg_next_pc[30]), 
        .A5(n4537), .A6(n7503), .Y(n3799) );
  NAND2X0_RVT U9305 ( .A1(n8031), .A2(net16540), .Y(n7510) );
  NAND2X0_RVT U9306 ( .A1(pcpi_rs2[29]), .A2(pcpi_rs1[29]), .Y(n7504) );
  AO21X1_RVT U9307 ( .A1(n6557), .A2(n7504), .A3(n4243), .Y(n7509) );
  AO222X1_RVT U9308 ( .A1(n7510), .A2(n7509), .A3(n4246), .A4(n7508), .A5(
        n4529), .A6(n7507), .Y(alu_out[29]) );
  AO222X1_RVT U9309 ( .A1(n7640), .A2(n7512), .A3(n4068), .A4(reg_next_pc[29]), 
        .A5(n4354), .A6(n7884), .Y(n3800) );
  FADDX1_RVT U9310 ( .A(n4237), .B(n7883), .CI(n7513), .CO(n7511), .S(n7514)
         );
  AO222X1_RVT U9311 ( .A1(n7883), .A2(n4353), .A3(n4067), .A4(reg_next_pc[28]), 
        .A5(n4537), .A6(n7514), .Y(n3801) );
  NAND2X0_RVT U9312 ( .A1(n8032), .A2(net16338), .Y(n7521) );
  NAND2X0_RVT U9313 ( .A1(pcpi_rs2[27]), .A2(pcpi_rs1[27]), .Y(n7515) );
  AO21X1_RVT U9314 ( .A1(n6557), .A2(n7515), .A3(n4243), .Y(n7520) );
  FADDX1_RVT U9315 ( .A(pcpi_rs1[27]), .B(n7516), .CI(n7517), .CO(n6401), .S(
        n7518) );
  AO222X1_RVT U9316 ( .A1(n7521), .A2(n7520), .A3(n4246), .A4(n7519), .A5(
        n4529), .A6(n7518), .Y(alu_out[27]) );
  FADDX1_RVT U9317 ( .A(n7882), .B(n7522), .CI(n4238), .CO(n7513), .S(n7523)
         );
  AO222X1_RVT U9318 ( .A1(n7640), .A2(n7523), .A3(n4064), .A4(reg_next_pc[27]), 
        .A5(n4355), .A6(n7882), .Y(n3802) );
  AO222X1_RVT U9319 ( .A1(n7640), .A2(n7526), .A3(n7886), .A4(reg_next_pc[26]), 
        .A5(n4354), .A6(n7881), .Y(n3803) );
  AO222X1_RVT U9320 ( .A1(n4536), .A2(n7528), .A3(n7886), .A4(reg_next_pc[25]), 
        .A5(n4355), .A6(n7880), .Y(n3804) );
  NAND2X0_RVT U9321 ( .A1(n8036), .A2(net16451), .Y(n7535) );
  NAND2X0_RVT U9322 ( .A1(pcpi_rs2[24]), .A2(pcpi_rs1[24]), .Y(n7529) );
  AO21X1_RVT U9323 ( .A1(n4245), .A2(n7529), .A3(n4244), .Y(n7534) );
  FADDX1_RVT U9324 ( .A(n8073), .B(n7530), .CI(n7531), .CO(n6269), .S(n7532)
         );
  AO222X1_RVT U9325 ( .A1(n7535), .A2(n7534), .A3(n6412), .A4(n7533), .A5(
        n4528), .A6(n7532), .Y(alu_out[24]) );
  FADDX1_RVT U9326 ( .A(n4237), .B(n7879), .CI(n7536), .CO(n7527), .S(n7537)
         );
  AO222X1_RVT U9327 ( .A1(n4537), .A2(n7537), .A3(n4068), .A4(reg_next_pc[24]), 
        .A5(n4355), .A6(n7879), .Y(n3805) );
  NAND2X0_RVT U9328 ( .A1(n7994), .A2(net16360), .Y(n7544) );
  NAND2X0_RVT U9329 ( .A1(pcpi_rs2[23]), .A2(pcpi_rs1[23]), .Y(n7538) );
  AO21X1_RVT U9330 ( .A1(n6557), .A2(n7538), .A3(n4244), .Y(n7543) );
  FADDX1_RVT U9331 ( .A(pcpi_rs1[23]), .B(n7540), .CI(n7539), .CO(n7531), .S(
        n7541) );
  FADDX1_RVT U9332 ( .A(n4238), .B(n7878), .CI(n7545), .CO(n7536), .S(n7546)
         );
  AO222X1_RVT U9333 ( .A1(n7878), .A2(n4353), .A3(n4065), .A4(reg_next_pc[23]), 
        .A5(n4536), .A6(n7546), .Y(n3806) );
  AO21X1_RVT U9334 ( .A1(n6557), .A2(n7547), .A3(n4244), .Y(n7552) );
  FADDX1_RVT U9335 ( .A(n7877), .B(n7554), .CI(n4237), .CO(n7545), .S(n7556)
         );
  AO222X1_RVT U9336 ( .A1(n7877), .A2(n4353), .A3(n4067), .A4(reg_next_pc[22]), 
        .A5(n4536), .A6(n7556), .Y(n3807) );
  FADDX1_RVT U9337 ( .A(n4238), .B(n7876), .CI(n7557), .CO(n7554), .S(n7558)
         );
  AO222X1_RVT U9338 ( .A1(n4537), .A2(n7558), .A3(n4065), .A4(reg_next_pc[21]), 
        .A5(n4354), .A6(n7876), .Y(n3808) );
  AO21X1_RVT U9339 ( .A1(n4245), .A2(n7559), .A3(n4244), .Y(n7564) );
  FADDX1_RVT U9340 ( .A(pcpi_rs1[20]), .B(n7560), .CI(n7561), .CO(n6377), .S(
        n7562) );
  FADDX1_RVT U9341 ( .A(n4237), .B(n7566), .CI(n7875), .CO(n7557), .S(n7567)
         );
  AO222X1_RVT U9342 ( .A1(n7640), .A2(n7567), .A3(n4068), .A4(reg_next_pc[20]), 
        .A5(n4355), .A6(n7875), .Y(n3809) );
  FADDX1_RVT U9343 ( .A(n7569), .B(n7874), .CI(n7568), .CO(n7566), .S(n7570)
         );
  AO222X1_RVT U9344 ( .A1(n7874), .A2(n4353), .A3(n4064), .A4(reg_next_pc[19]), 
        .A5(n4536), .A6(n7570), .Y(n3810) );
  FADDX1_RVT U9345 ( .A(n7572), .B(n7571), .CI(n7873), .CO(n7568), .S(n7573)
         );
  AO222X1_RVT U9346 ( .A1(n7640), .A2(n7573), .A3(n4067), .A4(reg_next_pc[18]), 
        .A5(n4354), .A6(n7873), .Y(n3811) );
  NAND2X0_RVT U9347 ( .A1(n8028), .A2(net16361), .Y(n7580) );
  NAND2X0_RVT U9348 ( .A1(pcpi_rs2[17]), .A2(pcpi_rs1[17]), .Y(n7574) );
  AO21X1_RVT U9349 ( .A1(n6557), .A2(n7574), .A3(n4243), .Y(n7579) );
  AO222X1_RVT U9350 ( .A1(n7580), .A2(n7579), .A3(n4246), .A4(n7578), .A5(
        n4529), .A6(n7577), .Y(alu_out[17]) );
  FADDX1_RVT U9351 ( .A(n7582), .B(n7581), .CI(n7872), .CO(n7571), .S(n7583)
         );
  AO222X1_RVT U9352 ( .A1(n7872), .A2(n4353), .A3(n4065), .A4(reg_next_pc[17]), 
        .A5(n4537), .A6(n7583), .Y(n3812) );
  FADDX1_RVT U9353 ( .A(n7585), .B(n7871), .CI(n7584), .CO(n7581), .S(n7586)
         );
  AO222X1_RVT U9354 ( .A1(n7871), .A2(n4353), .A3(n4067), .A4(reg_next_pc[16]), 
        .A5(n4537), .A6(n7586), .Y(n3813) );
  AO21X1_RVT U9355 ( .A1(n6557), .A2(n7587), .A3(n4243), .Y(n7592) );
  FADDX1_RVT U9356 ( .A(n8079), .B(n7588), .CI(n7589), .CO(n6227), .S(n7590)
         );
  AO222X1_RVT U9357 ( .A1(n7593), .A2(n7592), .A3(n6412), .A4(n7591), .A5(
        n4528), .A6(n7590), .Y(alu_out[15]) );
  FADDX1_RVT U9358 ( .A(n7595), .B(n7870), .CI(n7594), .CO(n7584), .S(n7596)
         );
  AO222X1_RVT U9359 ( .A1(n7640), .A2(n7596), .A3(n4067), .A4(reg_next_pc[15]), 
        .A5(n4354), .A6(n7870), .Y(n3814) );
  FADDX1_RVT U9360 ( .A(n7598), .B(n7597), .CI(n7869), .CO(n7594), .S(n7599)
         );
  AO222X1_RVT U9361 ( .A1(n7640), .A2(n7599), .A3(n4066), .A4(reg_next_pc[14]), 
        .A5(n4355), .A6(n7869), .Y(n3815) );
  FADDX1_RVT U9362 ( .A(n7601), .B(n7600), .CI(n7868), .CO(n7597), .S(n7602)
         );
  AO222X1_RVT U9363 ( .A1(n4536), .A2(n7602), .A3(n4065), .A4(reg_next_pc[13]), 
        .A5(n4355), .A6(n7868), .Y(n3816) );
  NAND2X0_RVT U9364 ( .A1(n8001), .A2(net16303), .Y(n7611) );
  NAND3X0_RVT U9365 ( .A1(n6412), .A2(pcpi_rs1[12]), .A3(pcpi_rs2[12]), .Y(
        n7604) );
  NAND2X0_RVT U9366 ( .A1(n7604), .A2(n7658), .Y(n7610) );
  FADDX1_RVT U9367 ( .A(pcpi_rs1[12]), .B(n7606), .CI(n7607), .CO(n6259), .S(
        n7608) );
  AO222X1_RVT U9368 ( .A1(n7611), .A2(n7610), .A3(n7609), .A4(n4245), .A5(
        n4528), .A6(n7608), .Y(alu_out[12]) );
  FADDX1_RVT U9369 ( .A(n7613), .B(n7867), .CI(n7612), .CO(n7600), .S(n7614)
         );
  AO222X1_RVT U9370 ( .A1(n7867), .A2(n4355), .A3(n4066), .A4(reg_next_pc[12]), 
        .A5(n4536), .A6(n7614), .Y(n3817) );
  FADDX1_RVT U9371 ( .A(n7616), .B(n7866), .CI(n7615), .CO(n7612), .S(n7617)
         );
  AO222X1_RVT U9372 ( .A1(n7640), .A2(n7617), .A3(n4066), .A4(reg_next_pc[11]), 
        .A5(n4355), .A6(n7866), .Y(n3818) );
  FADDX1_RVT U9373 ( .A(n7619), .B(n7618), .CI(n7865), .CO(n7615), .S(n7620)
         );
  AO222X1_RVT U9374 ( .A1(n4536), .A2(n7620), .A3(n4066), .A4(reg_next_pc[10]), 
        .A5(n4355), .A6(n7865), .Y(n3819) );
  NAND2X0_RVT U9375 ( .A1(n8029), .A2(net13612), .Y(n7627) );
  NAND2X0_RVT U9376 ( .A1(pcpi_rs2[9]), .A2(pcpi_rs1[9]), .Y(n7621) );
  AO21X1_RVT U9377 ( .A1(n4245), .A2(n7621), .A3(n4243), .Y(n7626) );
  FADDX1_RVT U9378 ( .A(n8085), .B(n7622), .CI(n7623), .CO(n6235), .S(n7624)
         );
  AO222X1_RVT U9379 ( .A1(n7627), .A2(n7626), .A3(n4246), .A4(n7625), .A5(
        n4528), .A6(n7624), .Y(alu_out[9]) );
  FADDX1_RVT U9380 ( .A(n7629), .B(n7864), .CI(n7628), .CO(n7618), .S(n7630)
         );
  AO222X1_RVT U9381 ( .A1(n7640), .A2(n7630), .A3(n7886), .A4(reg_next_pc[9]), 
        .A5(n4355), .A6(n7864), .Y(n3820) );
  FADDX1_RVT U9382 ( .A(n7632), .B(n7863), .CI(n7631), .CO(n7628), .S(n7633)
         );
  AO222X1_RVT U9383 ( .A1(n7640), .A2(n7633), .A3(n4068), .A4(reg_next_pc[8]), 
        .A5(n4354), .A6(n7863), .Y(n3821) );
  FADDX1_RVT U9384 ( .A(n7635), .B(n7862), .CI(n7634), .CO(n7631), .S(n7636)
         );
  AO222X1_RVT U9385 ( .A1(n4537), .A2(n7636), .A3(n4065), .A4(reg_next_pc[7]), 
        .A5(n4354), .A6(n7862), .Y(n3822) );
  FADDX1_RVT U9386 ( .A(n7638), .B(n7637), .CI(n7861), .CO(n7634), .S(n7639)
         );
  AO222X1_RVT U9387 ( .A1(n4536), .A2(n7639), .A3(n4068), .A4(reg_next_pc[6]), 
        .A5(n4354), .A6(n7861), .Y(n3823) );
  NAND2X0_RVT U9388 ( .A1(n8021), .A2(net16448), .Y(n7644) );
  NAND2X0_RVT U9389 ( .A1(pcpi_rs2[5]), .A2(net30690), .Y(n7641) );
  AO21X1_RVT U9390 ( .A1(n6557), .A2(n7641), .A3(n4243), .Y(n7643) );
  AO222X1_RVT U9391 ( .A1(n7644), .A2(n7643), .A3(n4246), .A4(n7642), .A5(
        n4529), .A6(net23069), .Y(alu_out[5]) );
  FADDX1_RVT U9392 ( .A(n7646), .B(n7860), .CI(n7645), .CO(n7637), .S(n7647)
         );
  AO222X1_RVT U9393 ( .A1(n4537), .A2(n7647), .A3(n7886), .A4(reg_next_pc[5]), 
        .A5(n4354), .A6(n4192), .Y(n3824) );
  AO21X1_RVT U9394 ( .A1(n6557), .A2(n7648), .A3(n4244), .Y(n7653) );
  FADDX1_RVT U9395 ( .A(n8090), .B(n7650), .CI(n7649), .CO(net23072), .S(n7651) );
  AO222X1_RVT U9396 ( .A1(n7654), .A2(n7653), .A3(n4246), .A4(n7652), .A5(
        n4529), .A6(n7651), .Y(alu_out[4]) );
  FADDX1_RVT U9397 ( .A(n7656), .B(n7655), .CI(n7859), .CO(n7645), .S(n7657)
         );
  AO222X1_RVT U9398 ( .A1(n7859), .A2(n4353), .A3(n4066), .A4(reg_next_pc[4]), 
        .A5(n4536), .A6(n7657), .Y(n3825) );
  NAND2X0_RVT U9399 ( .A1(n7987), .A2(net16367), .Y(n7665) );
  NAND2X0_RVT U9400 ( .A1(pcpi_rs2[3]), .A2(net30659), .Y(n7659) );
  AO21X1_RVT U9401 ( .A1(n4245), .A2(n7659), .A3(n4244), .Y(n7664) );
  FADDX1_RVT U9402 ( .A(n8091), .B(n7661), .CI(n7660), .CO(n7650), .S(n7662)
         );
  AO222X1_RVT U9403 ( .A1(n7665), .A2(n7664), .A3(n6412), .A4(n7663), .A5(
        n4529), .A6(n7662), .Y(alu_out[3]) );
  FADDX1_RVT U9404 ( .A(n7667), .B(n7666), .CI(n7858), .CO(n7655), .S(n7668)
         );
  AO222X1_RVT U9405 ( .A1(n7858), .A2(n4353), .A3(n4068), .A4(reg_next_pc[3]), 
        .A5(n4536), .A6(n7668), .Y(n3826) );
  NAND2X0_RVT U9406 ( .A1(n7985), .A2(net16336), .Y(n7675) );
  NAND2X0_RVT U9407 ( .A1(pcpi_rs2[2]), .A2(net30713), .Y(n7669) );
  AO21X1_RVT U9408 ( .A1(n6557), .A2(n7669), .A3(n4244), .Y(n7674) );
  FADDX1_RVT U9409 ( .A(n8092), .B(n7671), .CI(n7670), .CO(n7661), .S(n7672)
         );
  FADDX1_RVT U9410 ( .A(n7677), .B(n7676), .CI(n7857), .CO(n7666), .S(n7678)
         );
  AO222X1_RVT U9411 ( .A1(n7857), .A2(n4353), .A3(n4067), .A4(reg_next_pc[2]), 
        .A5(n4537), .A6(n7678), .Y(n3827) );
  AO222X1_RVT U9412 ( .A1(n7856), .A2(n4353), .A3(n4064), .A4(reg_next_pc[1]), 
        .A5(n4537), .A6(n7681), .Y(n3828) );
  NAND2X0_RVT U9414 ( .A1(n7686), .A2(n7685), .Y(N1941) );
  NOR4X1_RVT U9415 ( .A1(mem_do_prefetch), .A2(net22708), .A3(n4855), .A4(
        net29419), .Y(N2107) );
  AO221X1_RVT U9416 ( .A1(n7687), .A2(n6354), .A3(n6354), .A4(n7818), .A5(
        N2107), .Y(N2106) );
  AO222X1_RVT U9417 ( .A1(n6192), .A2(is_beq_bne_blt_bge_bltu_bgeu), .A3(n4096), .A4(n7690), .A5(n4096), .A6(n7689), .Y(N379) );
  AOI22X1_RVT U9418 ( .A1(count_cycle[32]), .A2(n4259), .A3(count_instr[0]), 
        .A4(n5718), .Y(n7694) );
  AOI22X1_RVT U9419 ( .A1(n4538), .A2(mem_rdata_word[0]), .A3(n4634), .A4(
        n8094), .Y(n7693) );
  NAND4X0_RVT U9420 ( .A1(n7694), .A2(n7693), .A3(n7692), .A4(n7691), .Y(N1906) );
  AOI22X1_RVT U9421 ( .A1(n4538), .A2(mem_rdata_word[1]), .A3(n4031), .A4(
        net30596), .Y(n7700) );
  AOI22X1_RVT U9422 ( .A1(count_cycle[1]), .A2(n4356), .A3(count_instr[1]), 
        .A4(n4351), .Y(n7698) );
  NAND2X0_RVT U9423 ( .A1(count_instr[33]), .A2(n7788), .Y(n7697) );
  NAND4X0_RVT U9424 ( .A1(n7700), .A2(n7699), .A3(n7698), .A4(n7697), .Y(N1907) );
  AOI22X1_RVT U9425 ( .A1(count_cycle[34]), .A2(n4258), .A3(count_instr[2]), 
        .A4(n5718), .Y(n7707) );
  AOI22X1_RVT U9426 ( .A1(count_cycle[2]), .A2(n7762), .A3(n4634), .A4(
        net30713), .Y(n7706) );
  FADDX1_RVT U9427 ( .A(n4121), .B(n7701), .CI(n8039), .S(n7702) );
  NAND2X0_RVT U9428 ( .A1(n4538), .A2(mem_rdata_word[2]), .Y(n7704) );
  NAND4X0_RVT U9429 ( .A1(n7707), .A2(n7706), .A3(n7705), .A4(n7704), .Y(N1908) );
  AOI22X1_RVT U9430 ( .A1(count_cycle[3]), .A2(n7762), .A3(count_instr[3]), 
        .A4(n4351), .Y(n7713) );
  AOI22X1_RVT U9431 ( .A1(count_cycle[35]), .A2(n4259), .A3(n4535), .A4(
        net30659), .Y(n7712) );
  AOI22X1_RVT U9432 ( .A1(count_instr[35]), .A2(n4310), .A3(n4320), .A4(n7709), 
        .Y(n7711) );
  NAND2X0_RVT U9433 ( .A1(n4538), .A2(mem_rdata_word[3]), .Y(n7710) );
  NAND4X0_RVT U9434 ( .A1(n7713), .A2(n7712), .A3(n7711), .A4(n7710), .Y(N1909) );
  AOI22X1_RVT U9435 ( .A1(count_cycle[4]), .A2(n4357), .A3(count_instr[4]), 
        .A4(n4352), .Y(n7719) );
  AOI22X1_RVT U9436 ( .A1(count_cycle[36]), .A2(n4259), .A3(n4633), .A4(
        pcpi_rs1[4]), .Y(n7718) );
  AOI22X1_RVT U9437 ( .A1(count_instr[36]), .A2(n4311), .A3(n4316), .A4(n7715), 
        .Y(n7717) );
  NAND2X0_RVT U9438 ( .A1(n4538), .A2(mem_rdata_word[4]), .Y(n7716) );
  NAND4X0_RVT U9439 ( .A1(n7719), .A2(n7718), .A3(n7717), .A4(n7716), .Y(N1910) );
  OR2X1_RVT U9440 ( .A1(n7721), .A2(n7720), .Y(n7722) );
  AO22X1_RVT U9441 ( .A1(count_instr[37]), .A2(n4311), .A3(n4316), .A4(n7725), 
        .Y(n7726) );
  OR2X1_RVT U9442 ( .A1(n7727), .A2(n7726), .Y(N1911) );
  AOI22X1_RVT U9443 ( .A1(count_instr[6]), .A2(n4352), .A3(count_instr[38]), 
        .A4(n7788), .Y(n7729) );
  NAND2X0_RVT U9444 ( .A1(n4316), .A2(net22947), .Y(n7728) );
  NAND4X0_RVT U9445 ( .A1(n7731), .A2(n7730), .A3(n7729), .A4(n7728), .Y(N1912) );
  AO22X1_RVT U9446 ( .A1(count_cycle[8]), .A2(n4357), .A3(n7771), .A4(
        mem_rdata_word[8]), .Y(n7739) );
  AO22X1_RVT U9447 ( .A1(count_cycle[40]), .A2(n4259), .A3(count_instr[8]), 
        .A4(n5718), .Y(n7738) );
  AO22X1_RVT U9448 ( .A1(count_instr[40]), .A2(n7788), .A3(n4535), .A4(n8086), 
        .Y(n7734) );
  OR2X1_RVT U9449 ( .A1(n7775), .A2(n7734), .Y(n7735) );
  AO22X1_RVT U9450 ( .A1(count_cycle[41]), .A2(n4258), .A3(n7771), .A4(
        mem_rdata_word[9]), .Y(n7747) );
  AO22X1_RVT U9451 ( .A1(count_cycle[9]), .A2(n4357), .A3(count_instr[9]), 
        .A4(n4351), .Y(n7746) );
  OR2X1_RVT U9452 ( .A1(n7775), .A2(n7742), .Y(n7743) );
  AO22X1_RVT U9453 ( .A1(n4633), .A2(pcpi_rs1[10]), .A3(n7771), .A4(
        mem_rdata_word[10]), .Y(n7754) );
  AO22X1_RVT U9454 ( .A1(count_cycle[10]), .A2(n7762), .A3(count_instr[10]), 
        .A4(n4352), .Y(n7753) );
  AO22X1_RVT U9455 ( .A1(count_cycle[42]), .A2(n4258), .A3(n4320), .A4(n7749), 
        .Y(n7750) );
  OR2X1_RVT U9456 ( .A1(n7775), .A2(n7750), .Y(n7751) );
  AO21X1_RVT U9457 ( .A1(count_instr[42]), .A2(n4311), .A3(n7751), .Y(n7752)
         );
  AO22X1_RVT U9458 ( .A1(n4031), .A2(net30668), .A3(n7771), .A4(
        mem_rdata_word[11]), .Y(n7761) );
  FADDX1_RVT U9459 ( .A(reg_pc[11]), .B(decoded_imm[11]), .CI(n7755), .S(n7756) );
  OR2X1_RVT U9460 ( .A1(n7775), .A2(n7757), .Y(n7758) );
  AO21X1_RVT U9461 ( .A1(count_instr[43]), .A2(n7788), .A3(n7758), .Y(n7759)
         );
  AO22X1_RVT U9462 ( .A1(count_cycle[45]), .A2(n4259), .A3(n4535), .A4(
        pcpi_rs1[13]), .Y(n7770) );
  AO22X1_RVT U9463 ( .A1(count_cycle[13]), .A2(n4357), .A3(count_instr[13]), 
        .A4(n5718), .Y(n7769) );
  HADDX1_RVT U9464 ( .A0(reg_pc[13]), .B0(n7764), .SO(n7767) );
  AO22X1_RVT U9465 ( .A1(count_instr[45]), .A2(n4311), .A3(n7771), .A4(
        mem_rdata_word[13]), .Y(n7765) );
  OR2X1_RVT U9466 ( .A1(n7775), .A2(n7765), .Y(n7766) );
  AO22X1_RVT U9467 ( .A1(n4634), .A2(pcpi_rs1[14]), .A3(n7771), .A4(
        mem_rdata_word[14]), .Y(n7779) );
  AO22X1_RVT U9468 ( .A1(count_cycle[14]), .A2(n7762), .A3(count_instr[14]), 
        .A4(n4352), .Y(n7778) );
  FADDX1_RVT U9469 ( .A(reg_pc[14]), .B(decoded_imm[14]), .CI(n7772), .CO(
        n5726), .S(n7773) );
  AO22X1_RVT U9470 ( .A1(count_cycle[46]), .A2(n4259), .A3(n4320), .A4(n7773), 
        .Y(n7774) );
  OR2X1_RVT U9471 ( .A1(n7775), .A2(n7774), .Y(n7776) );
  AO21X1_RVT U9472 ( .A1(count_instr[46]), .A2(n4310), .A3(n7776), .Y(n7777)
         );
  AO22X1_RVT U9473 ( .A1(count_cycle[50]), .A2(n4258), .A3(count_instr[18]), 
        .A4(n4351), .Y(n7782) );
  AO22X1_RVT U9474 ( .A1(n4175), .A2(mem_rdata_word[18]), .A3(n4031), .A4(
        pcpi_rs1[18]), .Y(n7781) );
  OR2X1_RVT U9475 ( .A1(n7782), .A2(n7781), .Y(n7783) );
  AO22X1_RVT U9476 ( .A1(n4175), .A2(mem_rdata_word[19]), .A3(n4633), .A4(
        pcpi_rs1[19]), .Y(n7786) );
  OR2X1_RVT U9477 ( .A1(n4268), .A2(n7786), .Y(n7787) );
  AO21X1_RVT U9478 ( .A1(count_instr[51]), .A2(n7788), .A3(n7787), .Y(n7789)
         );
  OR2X1_RVT U9479 ( .A1(n7797), .A2(n7789), .Y(n7790) );
  AO21X1_RVT U9480 ( .A1(count_cycle[19]), .A2(n7762), .A3(n7790), .Y(n7791)
         );
  AO21X1_RVT U9481 ( .A1(count_instr[52]), .A2(n4310), .A3(n7795), .Y(n7796)
         );
  OR2X1_RVT U9482 ( .A1(n7797), .A2(n7796), .Y(n7798) );
  AO21X1_RVT U9483 ( .A1(count_instr[20]), .A2(n4352), .A3(n7798), .Y(n7799)
         );
  NAND2X0_RVT U9484 ( .A1(n7803), .A2(n7802), .Y(N1940) );
  INVX0_RVT U9485 ( .A(n7804), .Y(n7805) );
  OA221X1_RVT U9486 ( .A1(count_cycle[63]), .A2(n7805), .A3(n8067), .A4(n7804), 
        .A5(resetn), .Y(N981) );
  AND2X1_RVT U9487 ( .A1(n8070), .A2(n7809), .Y(n7807) );
  AND3X1_RVT U9488 ( .A1(mem_wordsize[0]), .A2(net30596), .A3(n8070), .Y(n7806) );
  AO22X1_RVT U9489 ( .A1(mem_rdata[8]), .A2(n7807), .A3(mem_rdata[24]), .A4(
        n7806), .Y(n3978) );
  AO22X1_RVT U9490 ( .A1(mem_rdata[9]), .A2(n7807), .A3(mem_rdata[25]), .A4(
        n7806), .Y(n3977) );
  AO22X1_RVT U9491 ( .A1(mem_rdata[10]), .A2(n7807), .A3(mem_rdata[26]), .A4(
        n7806), .Y(n3976) );
  AO22X1_RVT U9492 ( .A1(mem_rdata[11]), .A2(n7807), .A3(mem_rdata[27]), .A4(
        n7806), .Y(n3975) );
  AO22X1_RVT U9493 ( .A1(mem_rdata[12]), .A2(n7807), .A3(mem_rdata[28]), .A4(
        n7806), .Y(n3974) );
  AO22X1_RVT U9494 ( .A1(mem_rdata[13]), .A2(n7807), .A3(mem_rdata[29]), .A4(
        n7806), .Y(n3973) );
  AO22X1_RVT U9495 ( .A1(mem_rdata[14]), .A2(n7807), .A3(mem_rdata[30]), .A4(
        n7806), .Y(n3972) );
  AO22X1_RVT U9496 ( .A1(mem_rdata[15]), .A2(n7807), .A3(mem_rdata[31]), .A4(
        n7806), .Y(n3971) );
  OA221X1_RVT U9497 ( .A1(n8070), .A2(pcpi_rs1[0]), .A3(n8070), .A4(n7971), 
        .A5(n7808), .Y(n3962) );
  OA221X1_RVT U9498 ( .A1(n8070), .A2(pcpi_rs1[0]), .A3(n8070), .A4(n7971), 
        .A5(n7809), .Y(n3960) );
  AO22X1_RVT U9499 ( .A1(pcpi_rs2[1]), .A2(n7810), .A3(pcpi_rs2[9]), .A4(n8070), .Y(n3957) );
  AO22X1_RVT U9500 ( .A1(pcpi_rs2[2]), .A2(n7810), .A3(pcpi_rs2[10]), .A4(
        n8070), .Y(n3956) );
  AO22X1_RVT U9501 ( .A1(pcpi_rs2[1]), .A2(n7811), .A3(pcpi_rs2[17]), .A4(
        n7813), .Y(n3949) );
  AO22X1_RVT U9502 ( .A1(pcpi_rs2[2]), .A2(n7811), .A3(pcpi_rs2[18]), .A4(
        n7813), .Y(n3948) );
  AO22X1_RVT U9503 ( .A1(pcpi_rs2[3]), .A2(n7811), .A3(pcpi_rs2[19]), .A4(
        n7813), .Y(n3947) );
  AO22X1_RVT U9504 ( .A1(pcpi_rs2[4]), .A2(n7811), .A3(pcpi_rs2[20]), .A4(
        n7813), .Y(n3946) );
  AO22X1_RVT U9505 ( .A1(pcpi_rs2[5]), .A2(n7811), .A3(pcpi_rs2[21]), .A4(
        n7813), .Y(n3945) );
  AO22X1_RVT U9506 ( .A1(n7813), .A2(pcpi_rs2[24]), .A3(n7812), .A4(n3958), 
        .Y(n3942) );
  AO22X1_RVT U9507 ( .A1(n7813), .A2(pcpi_rs2[25]), .A3(n7812), .A4(n3957), 
        .Y(n3941) );
  AO22X1_RVT U9508 ( .A1(n7813), .A2(pcpi_rs2[26]), .A3(n7812), .A4(n3956), 
        .Y(n3940) );
  AO22X1_RVT U9509 ( .A1(n7813), .A2(pcpi_rs2[27]), .A3(n7812), .A4(n3955), 
        .Y(n3939) );
  AO22X1_RVT U9510 ( .A1(n7813), .A2(pcpi_rs2[28]), .A3(n7812), .A4(n3954), 
        .Y(n3938) );
  AO22X1_RVT U9511 ( .A1(n7813), .A2(pcpi_rs2[29]), .A3(n7812), .A4(n3953), 
        .Y(n3937) );
  AO22X1_RVT U9512 ( .A1(n7813), .A2(pcpi_rs2[30]), .A3(n7812), .A4(n3952), 
        .Y(n3936) );
  AO22X1_RVT U9513 ( .A1(n7813), .A2(pcpi_rs2[31]), .A3(n7812), .A4(n3951), 
        .Y(n3935) );
  AND2X1_RVT U9514 ( .A1(n4064), .A2(n7814), .Y(n7816) );
  AO22X1_RVT U9515 ( .A1(latched_is_lb), .A2(n7816), .A3(instr_lb), .A4(n7905), 
        .Y(n3898) );
  AO22X1_RVT U9516 ( .A1(latched_is_lh), .A2(n7816), .A3(instr_lh), .A4(n7905), 
        .Y(n3897) );
  AO22X1_RVT U9517 ( .A1(latched_is_lu), .A2(n7816), .A3(n7905), .A4(
        is_lbu_lhu_lw), .Y(n3896) );
  OA21X1_RVT U9518 ( .A1(n7817), .A2(latched_stalu), .A3(n7886), .Y(n3895) );
  OA21X1_RVT U9519 ( .A1(n7819), .A2(n7818), .A3(resetn), .Y(n7825) );
  AND2X1_RVT U9520 ( .A1(n4515), .A2(n4241), .Y(n7822) );
  NAND2X0_RVT U9521 ( .A1(n7934), .A2(n7823), .Y(n7824) );
  MUX21X1_RVT U9522 ( .A1(latched_store), .A2(n7825), .S0(n7824), .Y(n3894) );
  AND2X1_RVT U9523 ( .A1(resetn), .A2(n7826), .Y(n7835) );
  AO22X1_RVT U9524 ( .A1(count_instr[0]), .A2(n7835), .A3(n8002), .A4(n4537), 
        .Y(n3893) );
  AO22X1_RVT U9525 ( .A1(count_instr[1]), .A2(n8002), .A3(n8056), .A4(
        count_instr[0]), .Y(n7827) );
  AO22X1_RVT U9526 ( .A1(count_instr[1]), .A2(n7835), .A3(n4536), .A4(n7827), 
        .Y(n3892) );
  OA221X1_RVT U9527 ( .A1(count_instr[2]), .A2(count_instr[1]), .A3(
        count_instr[2]), .A4(count_instr[0]), .A5(n7640), .Y(n7828) );
  NAND3X0_RVT U9528 ( .A1(count_instr[1]), .A2(count_instr[0]), .A3(
        count_instr[2]), .Y(n7829) );
  AO22X1_RVT U9529 ( .A1(count_instr[2]), .A2(n7835), .A3(n7828), .A4(n7829), 
        .Y(n3891) );
  AO22X1_RVT U9530 ( .A1(count_instr[3]), .A2(n7835), .A3(n4537), .A4(n7831), 
        .Y(n3890) );
  OA21X1_RVT U9531 ( .A1(n7832), .A2(count_instr[4]), .A3(n4537), .Y(n7834) );
  AO22X1_RVT U9532 ( .A1(count_instr[4]), .A2(n7835), .A3(n7834), .A4(n7833), 
        .Y(n3889) );
  OA221X1_RVT U9533 ( .A1(count_instr[6]), .A2(n7837), .A3(n8060), .A4(n7836), 
        .A5(resetn), .Y(n3887) );
  OA221X1_RVT U9534 ( .A1(count_instr[12]), .A2(n7839), .A3(n8003), .A4(n7838), 
        .A5(resetn), .Y(n3881) );
  OA221X1_RVT U9535 ( .A1(count_instr[18]), .A2(n7841), .A3(n8062), .A4(n7840), 
        .A5(resetn), .Y(n3875) );
  OA221X1_RVT U9536 ( .A1(count_instr[21]), .A2(n7843), .A3(n8064), .A4(n7842), 
        .A5(resetn), .Y(n3872) );
  OA221X1_RVT U9537 ( .A1(count_instr[23]), .A2(n7845), .A3(n8058), .A4(n7844), 
        .A5(resetn), .Y(n3870) );
  OA21X1_RVT U9538 ( .A1(n8059), .A2(n7847), .A3(resetn), .Y(n7849) );
  OA221X1_RVT U9539 ( .A1(count_instr[33]), .A2(n7848), .A3(count_instr[33]), 
        .A4(n4536), .A5(n7849), .Y(n3860) );
  AO22X1_RVT U9540 ( .A1(count_instr[34]), .A2(n7849), .A3(n8054), .A4(n7850), 
        .Y(n3859) );
  AO21X1_RVT U9541 ( .A1(count_instr[34]), .A2(n7850), .A3(count_instr[35]), 
        .Y(n7851) );
  OA221X1_RVT U9542 ( .A1(count_instr[63]), .A2(n7854), .A3(n8057), .A4(n7853), 
        .A5(resetn), .Y(n3830) );
  AO22X1_RVT U9543 ( .A1(reg_pc[1]), .A2(n4065), .A3(n4811), .A4(n7856), .Y(
        n3796) );
  AO22X1_RVT U9544 ( .A1(reg_pc[2]), .A2(n4065), .A3(n7855), .A4(n7857), .Y(
        n3795) );
  AO22X1_RVT U9545 ( .A1(reg_pc[3]), .A2(n7886), .A3(n4093), .A4(n7858), .Y(
        n3794) );
  AO22X1_RVT U9546 ( .A1(reg_pc[4]), .A2(n4066), .A3(n7855), .A4(n7859), .Y(
        n3793) );
  AO22X1_RVT U9547 ( .A1(n4065), .A2(reg_pc[6]), .A3(n4093), .A4(n7861), .Y(
        n3791) );
  AO22X1_RVT U9548 ( .A1(n4068), .A2(reg_pc[7]), .A3(n4112), .A4(n7862), .Y(
        n3790) );
  AO22X1_RVT U9549 ( .A1(n4064), .A2(reg_pc[8]), .A3(n4093), .A4(n7863), .Y(
        n3789) );
  AO22X1_RVT U9550 ( .A1(n4066), .A2(reg_pc[9]), .A3(n7855), .A4(n7864), .Y(
        n3788) );
  AO22X1_RVT U9551 ( .A1(n4067), .A2(reg_pc[10]), .A3(n4112), .A4(n7865), .Y(
        n3787) );
  AO22X1_RVT U9552 ( .A1(n4064), .A2(reg_pc[11]), .A3(n4112), .A4(n7866), .Y(
        n3786) );
  AO22X1_RVT U9553 ( .A1(n4067), .A2(reg_pc[12]), .A3(n4811), .A4(n7867), .Y(
        n3785) );
  AO22X1_RVT U9554 ( .A1(n4066), .A2(reg_pc[14]), .A3(n4112), .A4(n7869), .Y(
        n3783) );
  AO22X1_RVT U9555 ( .A1(reg_pc[16]), .A2(n4067), .A3(n4811), .A4(n7871), .Y(
        n3781) );
  AO22X1_RVT U9556 ( .A1(reg_pc[18]), .A2(n4067), .A3(n4112), .A4(n7873), .Y(
        n3779) );
  AO22X1_RVT U9557 ( .A1(reg_pc[19]), .A2(n4065), .A3(n4112), .A4(n7874), .Y(
        n3778) );
  AO22X1_RVT U9558 ( .A1(reg_pc[20]), .A2(n4065), .A3(n7855), .A4(n7875), .Y(
        n3777) );
  AO22X1_RVT U9559 ( .A1(reg_pc[21]), .A2(n4066), .A3(n4112), .A4(n7876), .Y(
        n3776) );
  AO22X1_RVT U9560 ( .A1(reg_pc[22]), .A2(n4067), .A3(n4811), .A4(n7877), .Y(
        n3775) );
  AO22X1_RVT U9561 ( .A1(reg_pc[23]), .A2(n4064), .A3(n4093), .A4(n7878), .Y(
        n3774) );
  AO22X1_RVT U9562 ( .A1(reg_pc[24]), .A2(n4066), .A3(n7855), .A4(n7879), .Y(
        n3773) );
  AO22X1_RVT U9563 ( .A1(reg_pc[25]), .A2(n4068), .A3(n4811), .A4(n7880), .Y(
        n3772) );
  AO22X1_RVT U9564 ( .A1(n4066), .A2(reg_pc[26]), .A3(n4811), .A4(n7881), .Y(
        n3771) );
  AO22X1_RVT U9565 ( .A1(n4065), .A2(reg_pc[27]), .A3(n4811), .A4(n7882), .Y(
        n3770) );
  AO22X1_RVT U9566 ( .A1(n4065), .A2(reg_pc[28]), .A3(n4811), .A4(n7883), .Y(
        n3769) );
  AO22X1_RVT U9567 ( .A1(n7886), .A2(reg_pc[29]), .A3(n4093), .A4(n7884), .Y(
        n3768) );
  AO22X1_RVT U9568 ( .A1(n4064), .A2(reg_pc[30]), .A3(n7855), .A4(n7885), .Y(
        n3767) );
  AO22X1_RVT U9569 ( .A1(n4068), .A2(reg_pc[31]), .A3(n4112), .A4(n7887), .Y(
        n3766) );
  NAND2X0_RVT U9570 ( .A1(n7888), .A2(n8042), .Y(n7916) );
  OA221X1_RVT U9571 ( .A1(n7889), .A2(mem_do_prefetch), .A3(n7916), .A4(n7969), 
        .A5(n7920), .Y(n3707) );
  AO22X1_RVT U9572 ( .A1(mem_instr), .A2(n6222), .A3(n7899), .A4(n7891), .Y(
        n3706) );
  NAND2X0_RVT U9573 ( .A1(mem_ready), .A2(trap), .Y(n7894) );
  AND2X1_RVT U9574 ( .A1(mem_state[1]), .A2(mem_state[0]), .Y(n7893) );
  NAND2X0_RVT U9575 ( .A1(n4795), .A2(n7895), .Y(n3704) );
  AND2X1_RVT U9576 ( .A1(n4791), .A2(n7896), .Y(n7897) );
  OA21X1_RVT U9577 ( .A1(n7898), .A2(trap), .A3(n7897), .Y(n7901) );
  AND4X1_RVT U9578 ( .A1(resetn), .A2(mem_state[0]), .A3(n8008), .A4(n7980), 
        .Y(n7902) );
  AO221X1_RVT U9579 ( .A1(n7901), .A2(mem_state[0]), .A3(n7903), .A4(n7899), 
        .A5(n7902), .Y(n3703) );
  AO222X1_RVT U9580 ( .A1(n7903), .A2(n7902), .A3(n7903), .A4(n4612), .A5(
        mem_state[1]), .A6(n7901), .Y(n3702) );
  AO21X1_RVT U9581 ( .A1(n7920), .A2(mem_do_rdata), .A3(n7905), .Y(n3700) );
  OAI22X1_RVT U9582 ( .A1(n7906), .A2(n4515), .A3(n8066), .A4(n7933), .Y(n7908) );
  AO22X1_RVT U9583 ( .A1(n7909), .A2(n7908), .A3(n7907), .A4(mem_wordsize[1]), 
        .Y(n3673) );
  AND2X1_RVT U9584 ( .A1(n4020), .A2(resetn), .Y(n7911) );
  NAND2X0_RVT U9585 ( .A1(n8093), .A2(n7971), .Y(n7914) );
  AO21X1_RVT U9586 ( .A1(net16449), .A2(n7914), .A3(n7913), .Y(n7915) );
  AO22X1_RVT U9587 ( .A1(n7980), .A2(n7915), .A3(n8040), .A4(n7915), .Y(n7922)
         );
  OA21X1_RVT U9588 ( .A1(n7922), .A2(net29419), .A3(n4513), .Y(n7939) );
  AND2X1_RVT U9589 ( .A1(n7939), .A2(net26648), .Y(n7932) );
  AO22X1_RVT U9590 ( .A1(cpu_state[0]), .A2(n7937), .A3(n7923), .A4(n7932), 
        .Y(n3672) );
  AND2X1_RVT U9591 ( .A1(is_sb_sh_sw), .A2(n7925), .Y(n7924) );
  AO22X1_RVT U9592 ( .A1(cpu_state[1]), .A2(n7937), .A3(n7924), .A4(n7932), 
        .Y(n3671) );
  AO22X1_RVT U9593 ( .A1(n7927), .A2(n7926), .A3(is_sll_srl_sra), .A4(n7930), 
        .Y(n7928) );
  AO22X1_RVT U9594 ( .A1(n4639), .A2(n7937), .A3(n7932), .A4(n7928), .Y(n3670)
         );
  AO22X1_RVT U9595 ( .A1(cpu_state[3]), .A2(n7937), .A3(n7932), .A4(n7931), 
        .Y(n3669) );
  AO22X1_RVT U9596 ( .A1(cpu_state[5]), .A2(n7937), .A3(n7939), .A4(n7855), 
        .Y(n3668) );
  NAND2X0_RVT U9597 ( .A1(n7934), .A2(n7933), .Y(n7935) );
  AO22X1_RVT U9598 ( .A1(cpu_state[6]), .A2(n7937), .A3(n4524), .A4(n7935), 
        .Y(n3667) );
  AO22X1_RVT U9599 ( .A1(n4612), .A2(mem_la_wdata[0]), .A3(n4613), .A4(
        mem_wdata[0]), .Y(n3665) );
  AO22X1_RVT U9600 ( .A1(n4612), .A2(mem_la_wdata[7]), .A3(n4614), .A4(
        mem_wdata[7]), .Y(n3664) );
  AO22X1_RVT U9601 ( .A1(n4611), .A2(mem_la_wdata[6]), .A3(n4613), .A4(
        mem_wdata[6]), .Y(n3663) );
  AO22X1_RVT U9602 ( .A1(n4611), .A2(mem_la_wdata[5]), .A3(n4614), .A4(
        mem_wdata[5]), .Y(n3662) );
  AO22X1_RVT U9603 ( .A1(n7940), .A2(mem_la_wdata[4]), .A3(n4613), .A4(
        mem_wdata[4]), .Y(n3661) );
  AO22X1_RVT U9604 ( .A1(n4612), .A2(mem_la_wdata[3]), .A3(n4614), .A4(
        mem_wdata[3]), .Y(n3660) );
  AO22X1_RVT U9605 ( .A1(n7940), .A2(mem_la_wdata[2]), .A3(n4614), .A4(
        mem_wdata[2]), .Y(n3659) );
  AO22X1_RVT U9606 ( .A1(n4611), .A2(mem_la_wdata[1]), .A3(n4613), .A4(
        mem_wdata[1]), .Y(n3658) );
  AO22X1_RVT U9607 ( .A1(n4611), .A2(mem_la_wdata[16]), .A3(n4613), .A4(
        mem_wdata[16]), .Y(n3657) );
  AO22X1_RVT U9608 ( .A1(n4612), .A2(mem_la_wdata[17]), .A3(n4614), .A4(
        mem_wdata[17]), .Y(n3656) );
  AO22X1_RVT U9609 ( .A1(n7940), .A2(mem_la_wdata[18]), .A3(n4613), .A4(
        mem_wdata[18]), .Y(n3655) );
  AO22X1_RVT U9610 ( .A1(n4612), .A2(mem_la_wdata[19]), .A3(n4613), .A4(
        mem_wdata[19]), .Y(n3654) );
  AO22X1_RVT U9611 ( .A1(n4611), .A2(mem_la_wdata[20]), .A3(n7941), .A4(
        mem_wdata[20]), .Y(n3653) );
  AO22X1_RVT U9612 ( .A1(n4611), .A2(mem_la_wdata[21]), .A3(n4614), .A4(
        mem_wdata[21]), .Y(n3652) );
  AO22X1_RVT U9613 ( .A1(n7940), .A2(mem_la_wdata[22]), .A3(n4614), .A4(
        mem_wdata[22]), .Y(n3651) );
  AO22X1_RVT U9614 ( .A1(n4611), .A2(mem_la_wdata[23]), .A3(n4614), .A4(
        mem_wdata[23]), .Y(n3650) );
  AO22X1_RVT U9615 ( .A1(n4612), .A2(mem_la_wdata[8]), .A3(n4614), .A4(
        mem_wdata[8]), .Y(n3649) );
  AO22X1_RVT U9616 ( .A1(n7940), .A2(mem_la_wdata[24]), .A3(n4613), .A4(
        mem_wdata[24]), .Y(n3648) );
  AO22X1_RVT U9617 ( .A1(n7940), .A2(mem_la_wdata[9]), .A3(n4614), .A4(
        mem_wdata[9]), .Y(n3647) );
  AO22X1_RVT U9618 ( .A1(n4612), .A2(mem_la_wdata[25]), .A3(n4613), .A4(
        mem_wdata[25]), .Y(n3646) );
  AO22X1_RVT U9619 ( .A1(n4611), .A2(mem_la_wdata[10]), .A3(n4614), .A4(
        mem_wdata[10]), .Y(n3645) );
  AO22X1_RVT U9620 ( .A1(n7940), .A2(mem_la_wdata[26]), .A3(n4613), .A4(
        mem_wdata[26]), .Y(n3644) );
  AO22X1_RVT U9621 ( .A1(n4611), .A2(mem_la_wdata[11]), .A3(n4614), .A4(
        mem_wdata[11]), .Y(n3643) );
  AO22X1_RVT U9622 ( .A1(n4611), .A2(mem_la_wdata[27]), .A3(n7941), .A4(
        mem_wdata[27]), .Y(n3642) );
  AO22X1_RVT U9623 ( .A1(n4612), .A2(mem_la_wdata[12]), .A3(n4613), .A4(
        mem_wdata[12]), .Y(n3641) );
  AO22X1_RVT U9624 ( .A1(n4612), .A2(mem_la_wdata[28]), .A3(n4614), .A4(
        mem_wdata[28]), .Y(n3640) );
  AO22X1_RVT U9625 ( .A1(n4612), .A2(mem_la_wdata[13]), .A3(n4613), .A4(
        mem_wdata[13]), .Y(n3639) );
  AO22X1_RVT U9626 ( .A1(n4612), .A2(mem_la_wdata[29]), .A3(n4613), .A4(
        mem_wdata[29]), .Y(n3638) );
  AO22X1_RVT U9627 ( .A1(n7940), .A2(mem_la_wdata[14]), .A3(n4613), .A4(
        mem_wdata[14]), .Y(n3637) );
  AO22X1_RVT U9628 ( .A1(n4612), .A2(mem_la_wdata[30]), .A3(n4614), .A4(
        mem_wdata[30]), .Y(n3636) );
  AO22X1_RVT U9629 ( .A1(n4611), .A2(mem_la_wdata[15]), .A3(n4614), .A4(
        mem_wdata[15]), .Y(n3635) );
  AO222X1_RVT U9630 ( .A1(n4266), .A2(instr_jalr), .A3(n4266), .A4(n7943), 
        .A5(is_jalr_addi_slti_sltiu_xori_ori_andi), .A6(net30494), .Y(n3629)
         );
  AO222X1_RVT U9631 ( .A1(net30495), .A2(decoded_imm[5]), .A3(net22659), .A4(
        mem_rdata_q[25]), .A5(decoded_imm_j[5]), .A6(net30578), .Y(n3602) );
  AO222X1_RVT U9632 ( .A1(net30495), .A2(decoded_imm[7]), .A3(net22659), .A4(
        mem_rdata_q[27]), .A5(decoded_imm_j[7]), .A6(net30578), .Y(n3600) );
  AO222X1_RVT U9633 ( .A1(net30494), .A2(decoded_imm[8]), .A3(net22659), .A4(
        mem_rdata_q[28]), .A5(decoded_imm_j[8]), .A6(net30578), .Y(n3599) );
  AO222X1_RVT U9634 ( .A1(net30497), .A2(decoded_imm[9]), .A3(net22659), .A4(
        mem_rdata_q[29]), .A5(decoded_imm_j[9]), .A6(net30578), .Y(n3598) );
  AO222X1_RVT U9635 ( .A1(net30497), .A2(decoded_imm[10]), .A3(net22659), .A4(
        mem_rdata_q[30]), .A5(decoded_imm_j[10]), .A6(net30578), .Y(n3597) );
  AND2X1_RVT U9636 ( .A1(n7945), .A2(n4611), .Y(n7946) );
  AO22X1_RVT U9637 ( .A1(mem_la_wstrb[0]), .A2(n7946), .A3(mem_wstrb[0]), .A4(
        n4796), .Y(n3575) );
  AO22X1_RVT U9638 ( .A1(mem_la_wstrb[1]), .A2(n7946), .A3(mem_wstrb[1]), .A4(
        n4795), .Y(n3574) );
  AO22X1_RVT U9639 ( .A1(mem_la_wstrb[2]), .A2(n7946), .A3(mem_wstrb[2]), .A4(
        n4791), .Y(n3573) );
  AO22X1_RVT U9640 ( .A1(mem_la_wstrb[3]), .A2(n7946), .A3(mem_wstrb[3]), .A4(
        n4796), .Y(n3572) );
  AOI21X1_RVT U9641 ( .A1(is_beq_bne_blt_bge_bltu_bgeu), .A2(n7947), .A3(n4093), .Y(n7948) );
  AO22X1_RVT U9642 ( .A1(n4093), .A2(decoded_rd[0]), .A3(latched_rd[0]), .A4(
        n7948), .Y(n3571) );
  AO22X1_RVT U9643 ( .A1(n4093), .A2(decoded_rd[1]), .A3(latched_rd[1]), .A4(
        n7948), .Y(n3570) );
  AO22X1_RVT U9644 ( .A1(n4112), .A2(decoded_rd[2]), .A3(latched_rd[2]), .A4(
        n7948), .Y(n3569) );
  AO22X1_RVT U9645 ( .A1(n4811), .A2(decoded_rd[3]), .A3(latched_rd[3]), .A4(
        n7948), .Y(n3568) );
  AO22X1_RVT U9646 ( .A1(n4093), .A2(decoded_rd[4]), .A3(latched_rd[4]), .A4(
        n7948), .Y(n3567) );
  AO22X1_RVT U9647 ( .A1(n4713), .A2(n4600), .A3(n4716), .A4(\cpuregs[24][27] ), .Y(n3337) );
  AO22X1_RVT U9648 ( .A1(n4714), .A2(n4559), .A3(n4717), .A4(\cpuregs[24][18] ), .Y(n3328) );
  AO22X1_RVT U9649 ( .A1(n4712), .A2(n4583), .A3(n4715), .A4(\cpuregs[24][9] ), 
        .Y(n3319) );
  AO22X1_RVT U9650 ( .A1(n4779), .A2(n4397), .A3(n4782), .A4(\cpuregs[16][0] ), 
        .Y(n3086) );
  AO22X1_RVT U9651 ( .A1(n4778), .A2(n4604), .A3(n4782), .A4(\cpuregs[16][29] ), .Y(n3083) );
  AO22X1_RVT U9652 ( .A1(n4779), .A2(n4601), .A3(n4781), .A4(\cpuregs[16][28] ), .Y(n3082) );
  AO22X1_RVT U9653 ( .A1(n4777), .A2(n4598), .A3(n4780), .A4(\cpuregs[16][27] ), .Y(n3081) );
  AO22X1_RVT U9654 ( .A1(n4779), .A2(n4564), .A3(n4780), .A4(\cpuregs[16][26] ), .Y(n3080) );
  AO22X1_RVT U9655 ( .A1(n4777), .A2(n4569), .A3(n4782), .A4(\cpuregs[16][21] ), .Y(n3075) );
  AO22X1_RVT U9656 ( .A1(n4777), .A2(n4592), .A3(n4780), .A4(\cpuregs[16][20] ), .Y(n3074) );
  AO22X1_RVT U9657 ( .A1(n4777), .A2(n7956), .A3(n4782), .A4(\cpuregs[16][19] ), .Y(n3073) );
  AO22X1_RVT U9658 ( .A1(n4778), .A2(n4559), .A3(n4781), .A4(\cpuregs[16][18] ), .Y(n3072) );
  AO22X1_RVT U9659 ( .A1(n4777), .A2(n4051), .A3(n4781), .A4(\cpuregs[16][13] ), .Y(n3067) );
  AO22X1_RVT U9660 ( .A1(n4778), .A2(n4587), .A3(n4782), .A4(\cpuregs[16][12] ), .Y(n3066) );
  AO22X1_RVT U9661 ( .A1(n4779), .A2(n4109), .A3(n4781), .A4(\cpuregs[16][11] ), .Y(n3065) );
  AO22X1_RVT U9662 ( .A1(n4778), .A2(n4556), .A3(n4780), .A4(\cpuregs[16][10] ), .Y(n3064) );
  AO22X1_RVT U9663 ( .A1(n4779), .A2(n7961), .A3(n4782), .A4(\cpuregs[16][9] ), 
        .Y(n3063) );
  AO22X1_RVT U9664 ( .A1(n4778), .A2(n4080), .A3(n4780), .A4(\cpuregs[16][8] ), 
        .Y(n3062) );
  AO22X1_RVT U9665 ( .A1(n4778), .A2(n4008), .A3(n4782), .A4(\cpuregs[16][5] ), 
        .Y(n3059) );
  AO22X1_RVT U9666 ( .A1(n4778), .A2(n4575), .A3(n4780), .A4(\cpuregs[16][4] ), 
        .Y(n3058) );
  AO22X1_RVT U9667 ( .A1(n4777), .A2(n4115), .A3(n4781), .A4(\cpuregs[16][3] ), 
        .Y(n3057) );
  AO22X1_RVT U9668 ( .A1(n4777), .A2(n4608), .A3(n4780), .A4(\cpuregs[16][2] ), 
        .Y(n3056) );
  AO22X1_RVT U9669 ( .A1(n4779), .A2(n4609), .A3(n4781), .A4(\cpuregs[16][1] ), 
        .Y(n3055) );
  AO22X1_RVT U9670 ( .A1(n4661), .A2(n4398), .A3(n4664), .A4(\cpuregs[14][0] ), 
        .Y(n3022) );
  AO22X1_RVT U9671 ( .A1(n4660), .A2(n4605), .A3(n4664), .A4(\cpuregs[14][29] ), .Y(n3019) );
  AO22X1_RVT U9672 ( .A1(n4661), .A2(n7950), .A3(n4663), .A4(\cpuregs[14][28] ), .Y(n3018) );
  AO22X1_RVT U9673 ( .A1(n4659), .A2(n4599), .A3(n4662), .A4(\cpuregs[14][27] ), .Y(n3017) );
  AO22X1_RVT U9674 ( .A1(n4661), .A2(n4565), .A3(n4662), .A4(\cpuregs[14][26] ), .Y(n3016) );
  AO22X1_RVT U9675 ( .A1(n4659), .A2(n7955), .A3(n4664), .A4(\cpuregs[14][21] ), .Y(n3011) );
  AO22X1_RVT U9676 ( .A1(n4659), .A2(n4593), .A3(n4662), .A4(\cpuregs[14][20] ), .Y(n3010) );
  AO22X1_RVT U9677 ( .A1(n4659), .A2(n7956), .A3(n4664), .A4(\cpuregs[14][19] ), .Y(n3009) );
  AO22X1_RVT U9678 ( .A1(n4660), .A2(n7953), .A3(n4663), .A4(\cpuregs[14][18] ), .Y(n3008) );
  AO22X1_RVT U9679 ( .A1(n4659), .A2(n4051), .A3(n4663), .A4(\cpuregs[14][13] ), .Y(n3003) );
  AO22X1_RVT U9680 ( .A1(n4660), .A2(n4588), .A3(n4664), .A4(\cpuregs[14][12] ), .Y(n3002) );
  AO22X1_RVT U9681 ( .A1(n4661), .A2(n4109), .A3(n4663), .A4(\cpuregs[14][11] ), .Y(n3001) );
  AO22X1_RVT U9682 ( .A1(n4660), .A2(n4556), .A3(n4662), .A4(\cpuregs[14][10] ), .Y(n3000) );
  AO22X1_RVT U9683 ( .A1(n4661), .A2(n7961), .A3(n4664), .A4(\cpuregs[14][9] ), 
        .Y(n2999) );
  AO22X1_RVT U9684 ( .A1(n4660), .A2(n4582), .A3(n4662), .A4(\cpuregs[14][8] ), 
        .Y(n2998) );
  AO22X1_RVT U9685 ( .A1(n4660), .A2(n4114), .A3(n4662), .A4(\cpuregs[14][5] ), 
        .Y(n2995) );
  AO22X1_RVT U9686 ( .A1(n4660), .A2(n7964), .A3(n4664), .A4(\cpuregs[14][4] ), 
        .Y(n2994) );
  AO22X1_RVT U9687 ( .A1(n4659), .A2(n4115), .A3(n4663), .A4(\cpuregs[14][3] ), 
        .Y(n2993) );
  AO22X1_RVT U9688 ( .A1(n4659), .A2(n4608), .A3(n4662), .A4(\cpuregs[14][2] ), 
        .Y(n2992) );
  AO22X1_RVT U9689 ( .A1(n4661), .A2(n7967), .A3(n4663), .A4(\cpuregs[14][1] ), 
        .Y(n2991) );
  AO22X1_RVT U9690 ( .A1(n4655), .A2(n4398), .A3(n4658), .A4(\cpuregs[12][0] ), 
        .Y(n2958) );
  AO22X1_RVT U9691 ( .A1(n4654), .A2(n7949), .A3(n4658), .A4(\cpuregs[12][29] ), .Y(n2955) );
  AO22X1_RVT U9692 ( .A1(n4655), .A2(n4601), .A3(n4657), .A4(\cpuregs[12][28] ), .Y(n2954) );
  AO22X1_RVT U9693 ( .A1(n4653), .A2(n7951), .A3(n4656), .A4(\cpuregs[12][27] ), .Y(n2953) );
  AO22X1_RVT U9694 ( .A1(n4655), .A2(n4564), .A3(n4656), .A4(\cpuregs[12][26] ), .Y(n2952) );
  AO22X1_RVT U9695 ( .A1(n4653), .A2(n4101), .A3(n4658), .A4(\cpuregs[12][21] ), .Y(n2947) );
  AO22X1_RVT U9696 ( .A1(n4653), .A2(n4593), .A3(n4656), .A4(\cpuregs[12][20] ), .Y(n2946) );
  AO22X1_RVT U9697 ( .A1(n4653), .A2(n7956), .A3(n4658), .A4(\cpuregs[12][19] ), .Y(n2945) );
  AO22X1_RVT U9698 ( .A1(n4654), .A2(n7953), .A3(n4657), .A4(\cpuregs[12][18] ), .Y(n2944) );
  AO22X1_RVT U9699 ( .A1(n4653), .A2(n4049), .A3(n4657), .A4(\cpuregs[12][13] ), .Y(n2939) );
  AO22X1_RVT U9700 ( .A1(n4654), .A2(n4587), .A3(n4658), .A4(\cpuregs[12][12] ), .Y(n2938) );
  AO22X1_RVT U9701 ( .A1(n4655), .A2(n4009), .A3(n4657), .A4(\cpuregs[12][11] ), .Y(n2937) );
  AO22X1_RVT U9702 ( .A1(n4654), .A2(n7960), .A3(n4656), .A4(\cpuregs[12][10] ), .Y(n2936) );
  AO22X1_RVT U9703 ( .A1(n4655), .A2(n4584), .A3(n4658), .A4(\cpuregs[12][9] ), 
        .Y(n2935) );
  AO22X1_RVT U9704 ( .A1(n4654), .A2(n4111), .A3(n4656), .A4(\cpuregs[12][8] ), 
        .Y(n2934) );
  AO22X1_RVT U9705 ( .A1(n4654), .A2(n7963), .A3(n4656), .A4(\cpuregs[12][5] ), 
        .Y(n2931) );
  AO22X1_RVT U9706 ( .A1(n4654), .A2(n4574), .A3(n4658), .A4(\cpuregs[12][4] ), 
        .Y(n2930) );
  AO22X1_RVT U9707 ( .A1(n4653), .A2(n4115), .A3(n4657), .A4(\cpuregs[12][3] ), 
        .Y(n2929) );
  AO22X1_RVT U9708 ( .A1(n4653), .A2(n4606), .A3(n4656), .A4(\cpuregs[12][2] ), 
        .Y(n2928) );
  AO22X1_RVT U9709 ( .A1(n4655), .A2(n7967), .A3(n4657), .A4(\cpuregs[12][1] ), 
        .Y(n2927) );
  AO22X1_RVT U9710 ( .A1(n4667), .A2(n4397), .A3(n4670), .A4(\cpuregs[10][0] ), 
        .Y(n2894) );
  AO22X1_RVT U9711 ( .A1(n4666), .A2(n4605), .A3(n4670), .A4(\cpuregs[10][29] ), .Y(n2891) );
  AO22X1_RVT U9712 ( .A1(n4667), .A2(n4603), .A3(n4669), .A4(\cpuregs[10][28] ), .Y(n2890) );
  AO22X1_RVT U9713 ( .A1(n4665), .A2(n4599), .A3(n4668), .A4(\cpuregs[10][27] ), .Y(n2889) );
  AO22X1_RVT U9714 ( .A1(n4667), .A2(n4563), .A3(n4668), .A4(\cpuregs[10][26] ), .Y(n2888) );
  AO22X1_RVT U9715 ( .A1(n4665), .A2(n4086), .A3(n4670), .A4(\cpuregs[10][21] ), .Y(n2883) );
  AO22X1_RVT U9716 ( .A1(n4665), .A2(n7952), .A3(n4668), .A4(\cpuregs[10][20] ), .Y(n2882) );
  AO22X1_RVT U9717 ( .A1(n4665), .A2(n4562), .A3(n4670), .A4(\cpuregs[10][19] ), .Y(n2881) );
  AO22X1_RVT U9718 ( .A1(n4666), .A2(n4560), .A3(n4669), .A4(\cpuregs[10][18] ), .Y(n2880) );
  AO22X1_RVT U9719 ( .A1(n4667), .A2(n4049), .A3(n4669), .A4(\cpuregs[10][13] ), .Y(n2875) );
  AO22X1_RVT U9720 ( .A1(n4666), .A2(n4588), .A3(n4670), .A4(\cpuregs[10][12] ), .Y(n2874) );
  AO22X1_RVT U9721 ( .A1(n4665), .A2(n4009), .A3(n4669), .A4(\cpuregs[10][11] ), .Y(n2873) );
  AO22X1_RVT U9722 ( .A1(n4666), .A2(n7960), .A3(n4668), .A4(\cpuregs[10][10] ), .Y(n2872) );
  AO22X1_RVT U9723 ( .A1(n4667), .A2(n7961), .A3(n4670), .A4(\cpuregs[10][9] ), 
        .Y(n2871) );
  AO22X1_RVT U9724 ( .A1(n4666), .A2(n4582), .A3(n4668), .A4(\cpuregs[10][8] ), 
        .Y(n2870) );
  AO22X1_RVT U9725 ( .A1(n4666), .A2(n4550), .A3(n4668), .A4(\cpuregs[10][5] ), 
        .Y(n2867) );
  AO22X1_RVT U9726 ( .A1(n4666), .A2(n7964), .A3(n4670), .A4(\cpuregs[10][4] ), 
        .Y(n2866) );
  AO22X1_RVT U9727 ( .A1(n4665), .A2(n4115), .A3(n4669), .A4(\cpuregs[10][3] ), 
        .Y(n2865) );
  AO22X1_RVT U9728 ( .A1(n4667), .A2(n4607), .A3(n4668), .A4(\cpuregs[10][2] ), 
        .Y(n2864) );
  AO22X1_RVT U9729 ( .A1(n4665), .A2(n4094), .A3(n4669), .A4(\cpuregs[10][1] ), 
        .Y(n2863) );
  AO22X1_RVT U9730 ( .A1(n4649), .A2(n4547), .A3(n4652), .A4(\cpuregs[8][0] ), 
        .Y(n2830) );
  AO22X1_RVT U9731 ( .A1(n4648), .A2(n4605), .A3(n4652), .A4(\cpuregs[8][29] ), 
        .Y(n2827) );
  AO22X1_RVT U9732 ( .A1(n4649), .A2(n4603), .A3(n4651), .A4(\cpuregs[8][28] ), 
        .Y(n2826) );
  AO22X1_RVT U9733 ( .A1(n4647), .A2(n4599), .A3(n4650), .A4(\cpuregs[8][27] ), 
        .Y(n2825) );
  AO22X1_RVT U9734 ( .A1(n4649), .A2(n4385), .A3(n4650), .A4(\cpuregs[8][26] ), 
        .Y(n2824) );
  AO22X1_RVT U9735 ( .A1(n4647), .A2(n7955), .A3(n4652), .A4(\cpuregs[8][21] ), 
        .Y(n2819) );
  AO22X1_RVT U9736 ( .A1(n4647), .A2(n4593), .A3(n4650), .A4(\cpuregs[8][20] ), 
        .Y(n2818) );
  AO22X1_RVT U9737 ( .A1(n4647), .A2(n7956), .A3(n4652), .A4(\cpuregs[8][19] ), 
        .Y(n2817) );
  AO22X1_RVT U9738 ( .A1(n4648), .A2(n4558), .A3(n4651), .A4(\cpuregs[8][18] ), 
        .Y(n2816) );
  AO22X1_RVT U9739 ( .A1(n4647), .A2(n7957), .A3(n4651), .A4(\cpuregs[8][13] ), 
        .Y(n2811) );
  AO22X1_RVT U9740 ( .A1(n4648), .A2(n4587), .A3(n4652), .A4(\cpuregs[8][12] ), 
        .Y(n2810) );
  AO22X1_RVT U9741 ( .A1(n4649), .A2(n7959), .A3(n4651), .A4(\cpuregs[8][11] ), 
        .Y(n2809) );
  AO22X1_RVT U9742 ( .A1(n4648), .A2(n4557), .A3(n4650), .A4(\cpuregs[8][10] ), 
        .Y(n2808) );
  AO22X1_RVT U9743 ( .A1(n4649), .A2(n4583), .A3(n4652), .A4(\cpuregs[8][9] ), 
        .Y(n2807) );
  AO22X1_RVT U9744 ( .A1(n4648), .A2(n4582), .A3(n4650), .A4(\cpuregs[8][8] ), 
        .Y(n2806) );
  AO22X1_RVT U9745 ( .A1(n4648), .A2(n4550), .A3(n4650), .A4(\cpuregs[8][5] ), 
        .Y(n2803) );
  AO22X1_RVT U9746 ( .A1(n4648), .A2(n4575), .A3(n4652), .A4(\cpuregs[8][4] ), 
        .Y(n2802) );
  AO22X1_RVT U9747 ( .A1(n4647), .A2(n4576), .A3(n4651), .A4(\cpuregs[8][3] ), 
        .Y(n2801) );
  AO22X1_RVT U9748 ( .A1(n4647), .A2(n4607), .A3(n4650), .A4(\cpuregs[8][2] ), 
        .Y(n2800) );
  AO22X1_RVT U9749 ( .A1(n4649), .A2(n4609), .A3(n4651), .A4(\cpuregs[8][1] ), 
        .Y(n2799) );
  AO22X1_RVT U9750 ( .A1(n4753), .A2(n4398), .A3(n4756), .A4(\cpuregs[7][0] ), 
        .Y(n2798) );
  AO22X1_RVT U9751 ( .A1(n4752), .A2(n4604), .A3(n4756), .A4(\cpuregs[7][29] ), 
        .Y(n2795) );
  AO22X1_RVT U9752 ( .A1(n4753), .A2(n4602), .A3(n4755), .A4(\cpuregs[7][28] ), 
        .Y(n2794) );
  AO22X1_RVT U9753 ( .A1(n4751), .A2(n7951), .A3(n4754), .A4(\cpuregs[7][27] ), 
        .Y(n2793) );
  AO22X1_RVT U9754 ( .A1(n4753), .A2(n4564), .A3(n4754), .A4(\cpuregs[7][26] ), 
        .Y(n2792) );
  AO22X1_RVT U9755 ( .A1(n4751), .A2(n4101), .A3(n4756), .A4(\cpuregs[7][21] ), 
        .Y(n2787) );
  AO22X1_RVT U9756 ( .A1(n4751), .A2(n7952), .A3(n4754), .A4(\cpuregs[7][20] ), 
        .Y(n2786) );
  AO22X1_RVT U9757 ( .A1(n4751), .A2(n4103), .A3(n4756), .A4(\cpuregs[7][19] ), 
        .Y(n2785) );
  AO22X1_RVT U9758 ( .A1(n4752), .A2(n4560), .A3(n4755), .A4(\cpuregs[7][18] ), 
        .Y(n2784) );
  AO22X1_RVT U9759 ( .A1(n4753), .A2(n4049), .A3(n4755), .A4(\cpuregs[7][13] ), 
        .Y(n2779) );
  AO22X1_RVT U9760 ( .A1(n4752), .A2(n4588), .A3(n4756), .A4(\cpuregs[7][12] ), 
        .Y(n2778) );
  AO22X1_RVT U9761 ( .A1(n4751), .A2(n4009), .A3(n4755), .A4(\cpuregs[7][11] ), 
        .Y(n2777) );
  AO22X1_RVT U9762 ( .A1(n4752), .A2(n4557), .A3(n4754), .A4(\cpuregs[7][10] ), 
        .Y(n2776) );
  AO22X1_RVT U9763 ( .A1(n4753), .A2(n4584), .A3(n4756), .A4(\cpuregs[7][9] ), 
        .Y(n2775) );
  AO22X1_RVT U9764 ( .A1(n4752), .A2(n4111), .A3(n4754), .A4(\cpuregs[7][8] ), 
        .Y(n2774) );
  AO22X1_RVT U9765 ( .A1(n4752), .A2(n4114), .A3(n4754), .A4(\cpuregs[7][5] ), 
        .Y(n2771) );
  AO22X1_RVT U9766 ( .A1(n4752), .A2(n4574), .A3(n4756), .A4(\cpuregs[7][4] ), 
        .Y(n2770) );
  AO22X1_RVT U9767 ( .A1(n4751), .A2(n4577), .A3(n4755), .A4(\cpuregs[7][3] ), 
        .Y(n2769) );
  AO22X1_RVT U9768 ( .A1(n4753), .A2(n4608), .A3(n4754), .A4(\cpuregs[7][2] ), 
        .Y(n2768) );
  AO22X1_RVT U9769 ( .A1(n4751), .A2(n7967), .A3(n4755), .A4(\cpuregs[7][1] ), 
        .Y(n2767) );
  AO22X1_RVT U9770 ( .A1(n4708), .A2(n4547), .A3(n4711), .A4(\cpuregs[6][0] ), 
        .Y(n2766) );
  AO22X1_RVT U9771 ( .A1(n4707), .A2(n4604), .A3(n4711), .A4(\cpuregs[6][29] ), 
        .Y(n2763) );
  AO22X1_RVT U9772 ( .A1(n4708), .A2(n4603), .A3(n4710), .A4(\cpuregs[6][28] ), 
        .Y(n2762) );
  AO22X1_RVT U9773 ( .A1(n4706), .A2(n4600), .A3(n4709), .A4(\cpuregs[6][27] ), 
        .Y(n2761) );
  AO22X1_RVT U9774 ( .A1(n4708), .A2(n4563), .A3(n4709), .A4(\cpuregs[6][26] ), 
        .Y(n2760) );
  AO22X1_RVT U9775 ( .A1(n4706), .A2(n4569), .A3(n4711), .A4(\cpuregs[6][21] ), 
        .Y(n2755) );
  AO22X1_RVT U9776 ( .A1(n4706), .A2(n7952), .A3(n4709), .A4(\cpuregs[6][20] ), 
        .Y(n2754) );
  AO22X1_RVT U9777 ( .A1(n4706), .A2(n7956), .A3(n4711), .A4(\cpuregs[6][19] ), 
        .Y(n2753) );
  AO22X1_RVT U9778 ( .A1(n4707), .A2(n4559), .A3(n4710), .A4(\cpuregs[6][18] ), 
        .Y(n2752) );
  AO22X1_RVT U9779 ( .A1(n4706), .A2(n4049), .A3(n4710), .A4(\cpuregs[6][13] ), 
        .Y(n2747) );
  AO22X1_RVT U9780 ( .A1(n4707), .A2(n7958), .A3(n4711), .A4(\cpuregs[6][12] ), 
        .Y(n2746) );
  AO22X1_RVT U9781 ( .A1(n4708), .A2(n7959), .A3(n4710), .A4(\cpuregs[6][11] ), 
        .Y(n2745) );
  AO22X1_RVT U9782 ( .A1(n4707), .A2(n7960), .A3(n4709), .A4(\cpuregs[6][10] ), 
        .Y(n2744) );
  AO22X1_RVT U9783 ( .A1(n4708), .A2(n4584), .A3(n4711), .A4(\cpuregs[6][9] ), 
        .Y(n2743) );
  AO22X1_RVT U9784 ( .A1(n4707), .A2(n7962), .A3(n4709), .A4(\cpuregs[6][8] ), 
        .Y(n2742) );
  AO22X1_RVT U9785 ( .A1(n4707), .A2(n4550), .A3(n4711), .A4(\cpuregs[6][5] ), 
        .Y(n2739) );
  AO22X1_RVT U9786 ( .A1(n4707), .A2(n4573), .A3(n4709), .A4(\cpuregs[6][4] ), 
        .Y(n2738) );
  AO22X1_RVT U9787 ( .A1(n4706), .A2(n4115), .A3(n4710), .A4(\cpuregs[6][3] ), 
        .Y(n2737) );
  AO22X1_RVT U9788 ( .A1(n4706), .A2(n4608), .A3(n4709), .A4(\cpuregs[6][2] ), 
        .Y(n2736) );
  AO22X1_RVT U9789 ( .A1(n4708), .A2(n4113), .A3(n4710), .A4(\cpuregs[6][1] ), 
        .Y(n2735) );
  AO22X1_RVT U9790 ( .A1(n4747), .A2(n4547), .A3(n4750), .A4(\cpuregs[5][0] ), 
        .Y(n2734) );
  AO22X1_RVT U9791 ( .A1(n4746), .A2(n4605), .A3(n4750), .A4(\cpuregs[5][29] ), 
        .Y(n2731) );
  AO22X1_RVT U9792 ( .A1(n4747), .A2(n4602), .A3(n4749), .A4(\cpuregs[5][28] ), 
        .Y(n2730) );
  AO22X1_RVT U9793 ( .A1(n4745), .A2(n4598), .A3(n4748), .A4(\cpuregs[5][27] ), 
        .Y(n2729) );
  AO22X1_RVT U9794 ( .A1(n4747), .A2(n4564), .A3(n4748), .A4(\cpuregs[5][26] ), 
        .Y(n2728) );
  AO22X1_RVT U9795 ( .A1(n4745), .A2(n4086), .A3(n4750), .A4(\cpuregs[5][21] ), 
        .Y(n2723) );
  AO22X1_RVT U9796 ( .A1(n4745), .A2(n4593), .A3(n4748), .A4(\cpuregs[5][20] ), 
        .Y(n2722) );
  AO22X1_RVT U9797 ( .A1(n4745), .A2(n4087), .A3(n4750), .A4(\cpuregs[5][19] ), 
        .Y(n2721) );
  AO22X1_RVT U9798 ( .A1(n4746), .A2(n4559), .A3(n4749), .A4(\cpuregs[5][18] ), 
        .Y(n2720) );
  AO22X1_RVT U9799 ( .A1(n4745), .A2(n7957), .A3(n4749), .A4(\cpuregs[5][13] ), 
        .Y(n2715) );
  AO22X1_RVT U9800 ( .A1(n4746), .A2(n4588), .A3(n4750), .A4(\cpuregs[5][12] ), 
        .Y(n2714) );
  AO22X1_RVT U9801 ( .A1(n4747), .A2(n4092), .A3(n4749), .A4(\cpuregs[5][11] ), 
        .Y(n2713) );
  AO22X1_RVT U9802 ( .A1(n4746), .A2(n4556), .A3(n4748), .A4(\cpuregs[5][10] ), 
        .Y(n2712) );
  AO22X1_RVT U9803 ( .A1(n4747), .A2(n4584), .A3(n4750), .A4(\cpuregs[5][9] ), 
        .Y(n2711) );
  AO22X1_RVT U9804 ( .A1(n4746), .A2(n4080), .A3(n4748), .A4(\cpuregs[5][8] ), 
        .Y(n2710) );
  AO22X1_RVT U9805 ( .A1(n4746), .A2(n7963), .A3(n4750), .A4(\cpuregs[5][5] ), 
        .Y(n2707) );
  AO22X1_RVT U9806 ( .A1(n4746), .A2(n4573), .A3(n4748), .A4(\cpuregs[5][4] ), 
        .Y(n2706) );
  AO22X1_RVT U9807 ( .A1(n4745), .A2(n4577), .A3(n4749), .A4(\cpuregs[5][3] ), 
        .Y(n2705) );
  AO22X1_RVT U9808 ( .A1(n4745), .A2(n4607), .A3(n4748), .A4(\cpuregs[5][2] ), 
        .Y(n2704) );
  AO22X1_RVT U9809 ( .A1(n4747), .A2(n4113), .A3(n4749), .A4(\cpuregs[5][1] ), 
        .Y(n2703) );
  AO22X1_RVT U9810 ( .A1(n4720), .A2(n4397), .A3(n4723), .A4(\cpuregs[4][0] ), 
        .Y(n2702) );
  AO22X1_RVT U9811 ( .A1(n4719), .A2(n4605), .A3(n4723), .A4(\cpuregs[4][29] ), 
        .Y(n2699) );
  AO22X1_RVT U9812 ( .A1(n4720), .A2(n4602), .A3(n4722), .A4(\cpuregs[4][28] ), 
        .Y(n2698) );
  AO22X1_RVT U9813 ( .A1(n4718), .A2(n4599), .A3(n4721), .A4(\cpuregs[4][27] ), 
        .Y(n2697) );
  AO22X1_RVT U9814 ( .A1(n4720), .A2(n4565), .A3(n4721), .A4(\cpuregs[4][26] ), 
        .Y(n2696) );
  AO22X1_RVT U9815 ( .A1(n4718), .A2(n4101), .A3(n4723), .A4(\cpuregs[4][21] ), 
        .Y(n2691) );
  AO22X1_RVT U9816 ( .A1(n4718), .A2(n4102), .A3(n4721), .A4(\cpuregs[4][20] ), 
        .Y(n2690) );
  AO22X1_RVT U9817 ( .A1(n4718), .A2(n4561), .A3(n4723), .A4(\cpuregs[4][19] ), 
        .Y(n2689) );
  AO22X1_RVT U9818 ( .A1(n4719), .A2(n7953), .A3(n4722), .A4(\cpuregs[4][18] ), 
        .Y(n2688) );
  AO22X1_RVT U9819 ( .A1(n4718), .A2(n4050), .A3(n4722), .A4(\cpuregs[4][13] ), 
        .Y(n2683) );
  AO22X1_RVT U9820 ( .A1(n4719), .A2(n4588), .A3(n4723), .A4(\cpuregs[4][12] ), 
        .Y(n2682) );
  AO22X1_RVT U9821 ( .A1(n4720), .A2(n7959), .A3(n4722), .A4(\cpuregs[4][11] ), 
        .Y(n2681) );
  AO22X1_RVT U9822 ( .A1(n4719), .A2(n4555), .A3(n4721), .A4(\cpuregs[4][10] ), 
        .Y(n2680) );
  AO22X1_RVT U9823 ( .A1(n4720), .A2(n4584), .A3(n4723), .A4(\cpuregs[4][9] ), 
        .Y(n2679) );
  AO22X1_RVT U9824 ( .A1(n4719), .A2(n4080), .A3(n4721), .A4(\cpuregs[4][8] ), 
        .Y(n2678) );
  AO22X1_RVT U9825 ( .A1(n4719), .A2(n7963), .A3(n4723), .A4(\cpuregs[4][5] ), 
        .Y(n2675) );
  AO22X1_RVT U9826 ( .A1(n4719), .A2(n4574), .A3(n4721), .A4(\cpuregs[4][4] ), 
        .Y(n2674) );
  AO22X1_RVT U9827 ( .A1(n4718), .A2(n7965), .A3(n4722), .A4(\cpuregs[4][3] ), 
        .Y(n2673) );
  AO22X1_RVT U9828 ( .A1(n4718), .A2(n4606), .A3(n4721), .A4(\cpuregs[4][2] ), 
        .Y(n2672) );
  AO22X1_RVT U9829 ( .A1(n4720), .A2(n4113), .A3(n4722), .A4(\cpuregs[4][1] ), 
        .Y(n2671) );
  AO22X1_RVT U9830 ( .A1(n4726), .A2(n4397), .A3(n4729), .A4(\cpuregs[2][0] ), 
        .Y(n2638) );
  AO22X1_RVT U9831 ( .A1(n4725), .A2(n4604), .A3(n4729), .A4(\cpuregs[2][29] ), 
        .Y(n2635) );
  AO22X1_RVT U9832 ( .A1(n4726), .A2(n4603), .A3(n4728), .A4(\cpuregs[2][28] ), 
        .Y(n2634) );
  AO22X1_RVT U9833 ( .A1(n4724), .A2(n7951), .A3(n4727), .A4(\cpuregs[2][27] ), 
        .Y(n2633) );
  AO22X1_RVT U9834 ( .A1(n4726), .A2(n4563), .A3(n4727), .A4(\cpuregs[2][26] ), 
        .Y(n2632) );
  AO22X1_RVT U9835 ( .A1(n4724), .A2(n4569), .A3(n4729), .A4(\cpuregs[2][21] ), 
        .Y(n2627) );
  AO22X1_RVT U9836 ( .A1(n4724), .A2(n7952), .A3(n4727), .A4(\cpuregs[2][20] ), 
        .Y(n2626) );
  AO22X1_RVT U9837 ( .A1(n4724), .A2(n7956), .A3(n4729), .A4(\cpuregs[2][19] ), 
        .Y(n2625) );
  AO22X1_RVT U9838 ( .A1(n4725), .A2(n7953), .A3(n4728), .A4(\cpuregs[2][18] ), 
        .Y(n2624) );
  AO22X1_RVT U9839 ( .A1(n4724), .A2(n7957), .A3(n4728), .A4(\cpuregs[2][13] ), 
        .Y(n2619) );
  AO22X1_RVT U9840 ( .A1(n4725), .A2(n4587), .A3(n4729), .A4(\cpuregs[2][12] ), 
        .Y(n2618) );
  AO22X1_RVT U9841 ( .A1(n4726), .A2(n7959), .A3(n4728), .A4(\cpuregs[2][11] ), 
        .Y(n2617) );
  AO22X1_RVT U9842 ( .A1(n4725), .A2(n4557), .A3(n4727), .A4(\cpuregs[2][10] ), 
        .Y(n2616) );
  AO22X1_RVT U9843 ( .A1(n4726), .A2(n4110), .A3(n4729), .A4(\cpuregs[2][9] ), 
        .Y(n2615) );
  AO22X1_RVT U9844 ( .A1(n4725), .A2(n4080), .A3(n4727), .A4(\cpuregs[2][8] ), 
        .Y(n2614) );
  AO22X1_RVT U9845 ( .A1(n4725), .A2(n7963), .A3(n4729), .A4(\cpuregs[2][5] ), 
        .Y(n2611) );
  AO22X1_RVT U9846 ( .A1(n4725), .A2(n7964), .A3(n4727), .A4(\cpuregs[2][4] ), 
        .Y(n2610) );
  AO22X1_RVT U9847 ( .A1(n4724), .A2(n4576), .A3(n4728), .A4(\cpuregs[2][3] ), 
        .Y(n2609) );
  AO22X1_RVT U9848 ( .A1(n4724), .A2(n7966), .A3(n4727), .A4(\cpuregs[2][2] ), 
        .Y(n2608) );
  AO22X1_RVT U9849 ( .A1(n4726), .A2(n7967), .A3(n4728), .A4(\cpuregs[2][1] ), 
        .Y(n2607) );
  AO22X1_RVT U9850 ( .A1(n4611), .A2(mem_la_wdata[31]), .A3(n4613), .A4(
        mem_wdata[31]), .Y(n2543) );
endmodule








module misr_32bit_saed32 (
    input clk, misr_reset, enable,
    input [31:0] misr_data_in,
    output [31:0] signature
);

  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  wire _124_;
  wire _125_;
  wire _126_;
  wire _127_;
  
 
  wire resetb;
  wire feedback_bit;
  wire [31:0] misr_reg;
  wire [31:0] osignature;
  
  assign feedback_bit = misr_reg[31];
  assign osignature = misr_reg;
  assign signature = osignature;
  
  INVX1_RVT FI ( .A(misr_reset), .Y(resetb) );
  XOR2X1_RVT _128_ (
    .A1(misr_reg[31]),
    .A2(misr_data_in[0]),
    .Y(_033_)
  );
  MUX21X1_RVT _129_ (
    .A1(misr_reg[0]),
    .A2(_033_),
    .Y(_034_),
    .S0(enable)
  );
  AND2X1_RVT _130_ (
    .A1(_034_),
    .A2(resetb),
    .Y(_001_)
  );
  XNOR3X1_RVT _131_ (
    .A1(misr_reg[0]),
    .A2(_000_),
    .A3(misr_data_in[1]),
    .Y(_035_)
  );
  MUX21X1_RVT _132_ (
    .A1(misr_reg[1]),
    .A2(_035_),
    .Y(_036_),
    .S0(enable)
  );
  AND2X1_RVT _133_ (
    .A1(_036_),
    .A2(resetb),
    .Y(_002_)
  );
  XOR2X1_RVT _134_ (
    .A1(misr_reg[1]),
    .A2(misr_data_in[2]),
    .Y(_037_)
  );
  MUX21X1_RVT _135_ (
    .A1(misr_reg[2]),
    .A2(_037_),
    .Y(_038_),
    .S0(enable)
  );
  AND2X1_RVT _136_ (
    .A1(_038_),
    .A2(resetb),
    .Y(_003_)
  );
  XOR2X1_RVT _137_ (
    .A1(misr_reg[2]),
    .A2(misr_data_in[3]),
    .Y(_039_)
  );
  MUX21X1_RVT _138_ (
    .A1(misr_reg[3]),
    .A2(_039_),
    .Y(_040_),
    .S0(enable)
  );
  AND2X1_RVT _139_ (
    .A1(_040_),
    .A2(resetb),
    .Y(_004_)
  );
  XOR2X1_RVT _140_ (
    .A1(misr_reg[3]),
    .A2(misr_data_in[4]),
    .Y(_041_)
  );
  MUX21X1_RVT _141_ (
    .A1(misr_reg[4]),
    .A2(_041_),
    .Y(_042_),
    .S0(enable)
  );
  AND2X1_RVT _142_ (
    .A1(_042_),
    .A2(resetb),
    .Y(_005_)
  );
  XOR2X1_RVT _143_ (
    .A1(misr_reg[4]),
    .A2(misr_data_in[5]),
    .Y(_043_)
  );
  MUX21X1_RVT _144_ (
    .A1(misr_reg[5]),
    .A2(_043_),
    .Y(_044_),
    .S0(enable)
  );
  AND2X1_RVT _145_ (
    .A1(_044_),
    .A2(resetb),
    .Y(_006_)
  );
  XOR2X1_RVT _146_ (
    .A1(misr_reg[5]),
    .A2(misr_data_in[6]),
    .Y(_045_)
  );
  MUX21X1_RVT _147_ (
    .A1(misr_reg[6]),
    .A2(_045_),
    .Y(_046_),
    .S0(enable)
  );
  AND2X1_RVT _148_ (
    .A1(_046_),
    .A2(resetb),
    .Y(_007_)
  );
  XOR2X1_RVT _149_ (
    .A1(misr_reg[6]),
    .A2(misr_data_in[7]),
    .Y(_047_)
  );
  MUX21X1_RVT _150_ (
    .A1(misr_reg[7]),
    .A2(_047_),
    .Y(_048_),
    .S0(enable)
  );
  AND2X1_RVT _151_ (
    .A1(_048_),
    .A2(resetb),
    .Y(_008_)
  );
  XOR2X1_RVT _152_ (
    .A1(misr_reg[7]),
    .A2(misr_data_in[8]),
    .Y(_049_)
  );
  MUX21X1_RVT _153_ (
    .A1(misr_reg[8]),
    .A2(_049_),
    .Y(_050_),
    .S0(enable)
  );
  AND2X1_RVT _154_ (
    .A1(_050_),
    .A2(resetb),
    .Y(_009_)
  );
  XOR2X1_RVT _155_ (
    .A1(misr_reg[8]),
    .A2(misr_data_in[9]),
    .Y(_051_)
  );
  MUX21X1_RVT _156_ (
    .A1(misr_reg[9]),
    .A2(_051_),
    .Y(_052_),
    .S0(enable)
  );
  AND2X1_RVT _157_ (
    .A1(_052_),
    .A2(resetb),
    .Y(_010_)
  );
  XOR2X1_RVT _158_ (
    .A1(misr_reg[9]),
    .A2(misr_data_in[10]),
    .Y(_053_)
  );
  MUX21X1_RVT _159_ (
    .A1(misr_reg[10]),
    .A2(_053_),
    .Y(_054_),
    .S0(enable)
  );
  AND2X1_RVT _160_ (
    .A1(_054_),
    .A2(resetb),
    .Y(_011_)
  );
  XOR2X1_RVT _161_ (
    .A1(misr_reg[10]),
    .A2(misr_data_in[11]),
    .Y(_055_)
  );
  MUX21X1_RVT _162_ (
    .A1(misr_reg[11]),
    .A2(_055_),
    .Y(_056_),
    .S0(enable)
  );
  AND2X1_RVT _163_ (
    .A1(_056_),
    .A2(resetb),
    .Y(_012_)
  );
  XOR2X1_RVT _164_ (
    .A1(misr_reg[11]),
    .A2(misr_data_in[12]),
    .Y(_057_)
  );
  MUX21X1_RVT _165_ (
    .A1(misr_reg[12]),
    .A2(_057_),
    .Y(_058_),
    .S0(enable)
  );
  AND2X1_RVT _166_ (
    .A1(_058_),
    .A2(resetb),
    .Y(_013_)
  );
  XOR2X1_RVT _167_ (
    .A1(misr_reg[12]),
    .A2(misr_data_in[13]),
    .Y(_059_)
  );
  MUX21X1_RVT _168_ (
    .A1(misr_reg[13]),
    .A2(_059_),
    .Y(_060_),
    .S0(enable)
  );
  AND2X1_RVT _169_ (
    .A1(_060_),
    .A2(resetb),
    .Y(_014_)
  );
  XOR2X1_RVT _170_ (
    .A1(misr_reg[13]),
    .A2(misr_data_in[14]),
    .Y(_061_)
  );
  MUX21X1_RVT _171_ (
    .A1(misr_reg[14]),
    .A2(_061_),
    .Y(_062_),
    .S0(enable)
  );
  AND2X1_RVT _172_ (
    .A1(_062_),
    .A2(resetb),
    .Y(_015_)
  );
  XOR2X1_RVT _173_ (
    .A1(misr_reg[14]),
    .A2(misr_data_in[15]),
    .Y(_063_)
  );
  MUX21X1_RVT _174_ (
    .A1(misr_reg[15]),
    .A2(_063_),
    .Y(_064_),
    .S0(enable)
  );
  AND2X1_RVT _175_ (
    .A1(_064_),
    .A2(resetb),
    .Y(_016_)
  );
  XOR2X1_RVT _176_ (
    .A1(misr_reg[15]),
    .A2(misr_data_in[16]),
    .Y(_065_)
  );
  MUX21X1_RVT _177_ (
    .A1(misr_reg[16]),
    .A2(_065_),
    .Y(_066_),
    .S0(enable)
  );
  AND2X1_RVT _178_ (
    .A1(_066_),
    .A2(resetb),
    .Y(_017_)
  );
  XOR2X1_RVT _179_ (
    .A1(misr_reg[16]),
    .A2(misr_data_in[17]),
    .Y(_067_)
  );
  MUX21X1_RVT _180_ (
    .A1(misr_reg[17]),
    .A2(_067_),
    .Y(_068_),
    .S0(enable)
  );
  AND2X1_RVT _181_ (
    .A1(_068_),
    .A2(resetb),
    .Y(_018_)
  );
  XOR2X1_RVT _182_ (
    .A1(misr_reg[17]),
    .A2(misr_data_in[18]),
    .Y(_069_)
  );
  MUX21X1_RVT _183_ (
    .A1(misr_reg[18]),
    .A2(_069_),
    .Y(_070_),
    .S0(enable)
  );
  AND2X1_RVT _184_ (
    .A1(_070_),
    .A2(resetb),
    .Y(_019_)
  );
  XOR2X1_RVT _185_ (
    .A1(misr_reg[18]),
    .A2(misr_data_in[19]),
    .Y(_071_)
  );
  MUX21X1_RVT _186_ (
    .A1(misr_reg[19]),
    .A2(_071_),
    .Y(_072_),
    .S0(enable)
  );
  AND2X1_RVT _187_ (
    .A1(_072_),
    .A2(resetb),
    .Y(_020_)
  );
  XOR2X1_RVT _188_ (
    .A1(misr_reg[19]),
    .A2(misr_data_in[20]),
    .Y(_073_)
  );
  MUX21X1_RVT _189_ (
    .A1(misr_reg[20]),
    .A2(_073_),
    .Y(_074_),
    .S0(enable)
  );
  AND2X1_RVT _190_ (
    .A1(_074_),
    .A2(resetb),
    .Y(_021_)
  );
  XNOR3X1_RVT _191_ (
    .A1(misr_reg[20]),
    .A2(misr_data_in[21]),
    .A3(_000_),
    .Y(_075_)
  );
  MUX21X1_RVT _192_ (
    .A1(misr_reg[21]),
    .A2(_075_),
    .Y(_076_),
    .S0(enable)
  );
  AND2X1_RVT _193_ (
    .A1(_076_),
    .A2(resetb),
    .Y(_022_)
  );
  XOR2X1_RVT _194_ (
    .A1(misr_reg[21]),
    .A2(misr_data_in[22]),
    .Y(_077_)
  );
  MUX21X1_RVT _195_ (
    .A1(misr_reg[22]),
    .A2(_077_),
    .Y(_078_),
    .S0(enable)
  );
  AND2X1_RVT _196_ (
    .A1(_078_),
    .A2(resetb),
    .Y(_023_)
  );
  XOR2X1_RVT _197_ (
    .A1(misr_reg[22]),
    .A2(misr_data_in[23]),
    .Y(_079_)
  );
  MUX21X1_RVT _198_ (
    .A1(misr_reg[23]),
    .A2(_079_),
    .Y(_080_),
    .S0(enable)
  );
  AND2X1_RVT _199_ (
    .A1(_080_),
    .A2(resetb),
    .Y(_024_)
  );
  XOR2X1_RVT _200_ (
    .A1(misr_reg[23]),
    .A2(misr_data_in[24]),
    .Y(_081_)
  );
  MUX21X1_RVT _201_ (
    .A1(misr_reg[24]),
    .A2(_081_),
    .Y(_082_),
    .S0(enable)
  );
  AND2X1_RVT _202_ (
    .A1(_082_),
    .A2(resetb),
    .Y(_025_)
  );
  XOR2X1_RVT _203_ (
    .A1(misr_reg[24]),
    .A2(misr_data_in[25]),
    .Y(_083_)
  );
  MUX21X1_RVT _204_ (
    .A1(misr_reg[25]),
    .A2(_083_),
    .Y(_084_),
    .S0(enable)
  );
  AND2X1_RVT _205_ (
    .A1(_084_),
    .A2(resetb),
    .Y(_026_)
  );
  XOR2X1_RVT _206_ (
    .A1(misr_reg[25]),
    .A2(misr_data_in[26]),
    .Y(_085_)
  );
  MUX21X1_RVT _207_ (
    .A1(misr_reg[26]),
    .A2(_085_),
    .Y(_086_),
    .S0(enable)
  );
  AND2X1_RVT _208_ (
    .A1(_086_),
    .A2(resetb),
    .Y(_027_)
  );
  XOR2X1_RVT _209_ (
    .A1(misr_reg[26]),
    .A2(misr_data_in[27]),
    .Y(_087_)
  );
  MUX21X1_RVT _210_ (
    .A1(misr_reg[27]),
    .A2(_087_),
    .Y(_088_),
    .S0(enable)
  );
  AND2X1_RVT _211_ (
    .A1(_088_),
    .A2(resetb),
    .Y(_028_)
  );
  XOR2X1_RVT _212_ (
    .A1(misr_reg[27]),
    .A2(misr_data_in[28]),
    .Y(_089_)
  );
  MUX21X1_RVT _213_ (
    .A1(misr_reg[28]),
    .A2(_089_),
    .Y(_090_),
    .S0(enable)
  );
  AND2X1_RVT _214_ (
    .A1(_090_),
    .A2(resetb),
    .Y(_029_)
  );
  XOR2X1_RVT _215_ (
    .A1(misr_reg[28]),
    .A2(misr_data_in[29]),
    .Y(_091_)
  );
  MUX21X1_RVT _216_ (
    .A1(misr_reg[29]),
    .A2(_091_),
    .Y(_092_),
    .S0(enable)
  );
  AND2X1_RVT _217_ (
    .A1(_092_),
    .A2(resetb),
    .Y(_030_)
  );
  XOR2X1_RVT _218_ (
    .A1(misr_reg[29]),
    .A2(misr_data_in[30]),
    .Y(_093_)
  );
  MUX21X1_RVT _219_ (
    .A1(misr_reg[30]),
    .A2(_093_),
    .Y(_094_),
    .S0(enable)
  );
  AND2X1_RVT _220_ (
    .A1(_094_),
    .A2(resetb),
    .Y(_031_)
  );
  XOR2X1_RVT _221_ (
    .A1(misr_reg[30]),
    .A2(misr_data_in[31]),
    .Y(_095_)
  );
  MUX21X1_RVT _222_ (
    .A1(misr_reg[31]),
    .A2(_095_),
    .Y(_096_),
    .S0(enable)
  );
  AND2X1_RVT _223_ (
    .A1(_096_),
    .A2(resetb),
    .Y(_032_)
  );
  
  DFFX1_RVT _224_ (
    .CLK(clk),
    .D(_001_),
    .Q(misr_reg[0]),
    .QN(_127_)
  );
  
  DFFX1_RVT _225_ (
    .CLK(clk),
    .D(_002_),
    .Q(misr_reg[1]),
    .QN(_126_)
  );
  
  DFFX1_RVT _226_ (
    .CLK(clk),
    .D(_003_),
    .Q(misr_reg[2]),
    .QN(_125_)
  );
  
  DFFX1_RVT _227_ (
    .CLK(clk),
    .D(_004_),
    .Q(misr_reg[3]),
    .QN(_124_)
  );
 
  DFFX1_RVT _228_ (
    .CLK(clk),
    .D(_005_),
    .Q(misr_reg[4]),
    .QN(_123_)
  );
  
  DFFX1_RVT _229_ (
    .CLK(clk),
    .D(_006_),
    .Q(misr_reg[5]),
    .QN(_122_)
  );
  
  DFFX1_RVT _230_ (
    .CLK(clk),
    .D(_007_),
    .Q(misr_reg[6]),
    .QN(_121_)
  );
  
  DFFX1_RVT _231_ (
    .CLK(clk),
    .D(_008_),
    .Q(misr_reg[7]),
    .QN(_120_)
  );
  
  DFFX1_RVT _232_ (
    .CLK(clk),
    .D(_009_),
    .Q(misr_reg[8]),
    .QN(_119_)
  );
  
  DFFX1_RVT _233_ (
    .CLK(clk),
    .D(_010_),
    .Q(misr_reg[9]),
    .QN(_118_)
  );
  
  DFFX1_RVT _234_ (
    .CLK(clk),
    .D(_011_),
    .Q(misr_reg[10]),
    .QN(_117_)
  );
  
  DFFX1_RVT _235_ (
    .CLK(clk),
    .D(_012_),
    .Q(misr_reg[11]),
    .QN(_116_)
  );
  
  DFFX1_RVT _236_ (
    .CLK(clk),
    .D(_013_),
    .Q(misr_reg[12]),
    .QN(_115_)
  );
  
  DFFX1_RVT _237_ (
    .CLK(clk),
    .D(_014_),
    .Q(misr_reg[13]),
    .QN(_114_)
  );

  DFFX1_RVT _238_ (
    .CLK(clk),
    .D(_015_),
    .Q(misr_reg[14]),
    .QN(_113_)
  );

  DFFX1_RVT _239_ (
    .CLK(clk),
    .D(_016_),
    .Q(misr_reg[15]),
    .QN(_112_)
  );

  DFFX1_RVT _240_ (
    .CLK(clk),
    .D(_017_),
    .Q(misr_reg[16]),
    .QN(_111_)
  );
  
  DFFX1_RVT _241_ (
    .CLK(clk),
    .D(_018_),
    .Q(misr_reg[17]),
    .QN(_110_)
  );
 
  DFFX1_RVT _242_ (
    .CLK(clk),
    .D(_019_),
    .Q(misr_reg[18]),
    .QN(_109_)
  );
  
  DFFX1_RVT _243_ (
    .CLK(clk),
    .D(_020_),
    .Q(misr_reg[19]),
    .QN(_108_)
  );

  DFFX1_RVT _244_ (
    .CLK(clk),
    .D(_021_),
    .Q(misr_reg[20]),
    .QN(_107_)
  );

  DFFX1_RVT _245_ (
    .CLK(clk),
    .D(_022_),
    .Q(misr_reg[21]),
    .QN(_106_)
  );

  DFFX1_RVT _246_ (
    .CLK(clk),
    .D(_023_),
    .Q(misr_reg[22]),
    .QN(_105_)
  );

  DFFX1_RVT _247_ (
    .CLK(clk),
    .D(_024_),
    .Q(misr_reg[23]),
    .QN(_104_)
  );

  DFFX1_RVT _248_ (
    .CLK(clk),
    .D(_025_),
    .Q(misr_reg[24]),
    .QN(_103_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _249_ (
    .CLK(clk),
    .D(_026_),
    .Q(misr_reg[25]),
    .QN(_102_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _250_ (
    .CLK(clk),
    .D(_027_),
    .Q(misr_reg[26]),
    .QN(_101_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _251_ (
    .CLK(clk),
    .D(_028_),
    .Q(misr_reg[27]),
    .QN(_100_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _252_ (
    .CLK(clk),
    .D(_029_),
    .Q(misr_reg[28]),
    .QN(_099_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _253_ (
    .CLK(clk),
    .D(_030_),
    .Q(misr_reg[29]),
    .QN(_098_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _254_ (
    .CLK(clk),
    .D(_031_),
    .Q(misr_reg[30]),
    .QN(_097_)
  );
  (* src = "misr_32bit.v:47.5-53.8" *)
  DFFX1_RVT _255_ (
    .CLK(clk),
    .D(_032_),
    .Q(misr_reg[31]),
    .QN(_000_)
  );
endmodule
