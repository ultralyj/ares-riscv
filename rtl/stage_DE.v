/**
 * @file stage_DE.v
 * @author ares team(ultralyj, Amy, zz16, sunshine, Candyaner)
 * @brief 译码和执行之间的流水线延迟寄存器(通过寄存器达到延迟效果)
 * @version 0.2
 * @date 2021-12-10
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module stage_DE(
    input wire clk_i,
    input wire rst_i,
    input wire pipeline_flush_i,
    input wire pipeline_nop_i,
    /*____________输入部分________________*/
    /* 控制通路输入 */
    input wire PCSel_di,
    input wire BrUn_di,
    input wire ASel_di,
    input wire BSel_di,
    input wire [`IMMSEL_BUS]ImmSel_di,
    input wire [`ALUSEL_BUS]ALUSel_di,
    input wire RegWEn_di,
    input wire MemRW_di,
    input wire [`WBSEL_BUS]WBSel_di,
    /* 通用寄存器输入 */
    input wire [`RegBus]DataA_di,
    input wire [`RegBus]DataB_di,
    /* 指令输入 */
    input wire [`InstAddrBus]inst_di,   
    /* pc输入 */
    input wire [`InstAddrBus] pc_di,
    /* 立即数输入 */
    input wire [`RegBus]imm_di,
    /*__________________输出部分________________*/
    /* 控制通路输出 */
    output reg PCSel_do,
    output reg BrUn_do,
    output reg ASel_do,
    output reg BSel_do,
    output reg [`IMMSEL_BUS]ImmSel_do,
    output reg [`ALUSEL_BUS]ALUSel_do,
    output reg RegWEn_do,
    output reg MemRW_do,
    output reg [`WBSEL_BUS]WBSel_do,
    /* 通用寄存器输出 */
    output reg [`RegBus]DataA_do,
    output reg [`RegBus]DataB_do,
    /* 指令输出 */
    output reg [`InstAddrBus]inst_do,
    /* pc输出 */
    output reg [`InstAddrBus] pc_do,
    /* 立即数输出 */
    output reg [`RegBus]imm_do
    );

    always @(posedge clk_i) 
    begin
        if( rst_i == `RESET_ENABLE || 
            pipeline_flush_i == `PLFLUSH_ENABLE || 
            pipeline_nop_i == `PC_STOP_ENABLE)
        begin
            PCSel_do <= `PCSEL_DEFAULT;
            BrUn_do <= `BRUN_DEFAULT;
            ASel_do <= `ASEL_DEFAULT;
            BSel_do <= `BSEL_DEFAULT;
            ImmSel_do <= `IMMSEL_DEFAULT;
            ALUSel_do <= `ALUSEL_DEFAULT;
            RegWEn_do <= `REGWEN_DEFAULT;
            MemRW_do <= `MEMRW_DEFAULT;
            WBSel_do <= `WBSEL_DEFAULT;
            DataA_do <= `ZeroWord;
            DataB_do <= `ZeroWord;
            inst_do <= `ZeroWord;
            pc_do <= `ZeroWord;
            imm_do <= `ZeroWord;
        end
        else
        begin
            PCSel_do <= PCSel_di;
            BrUn_do <= BrUn_di;
            ASel_do <= ASel_di;
            BSel_do <= BSel_di;
            ImmSel_do <= ImmSel_di;
            ALUSel_do <= ALUSel_di;
            RegWEn_do <= RegWEn_di;
            MemRW_do <= MemRW_di;
            WBSel_do <= WBSel_di;
            DataA_do <= DataA_di;
            DataB_do <= DataB_di;
            inst_do <= inst_di;
            pc_do <= pc_di;
            imm_do <= imm_di;
        end
        
    end
endmodule