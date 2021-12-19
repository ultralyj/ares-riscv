/**
 * @file stage_EM.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 执行和访存之间的流水线延迟寄存器(通过寄存器达到延迟效果)
 * @version 0.2
 * @date 2021-12-10
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module stage_EM(
    input wire clk_i,
    input wire rst_i,
    /*__________________输入部分________________*/
    /* 控制通路输入 */
    input wire RegWEn_ei,
    input wire [`WBSEL_BUS]WBSel_ei,
    input wire MemRW_ei,
    /* alu输入 */
    input wire [`RegBus]alu_ei,
    input wire [`RegAddrBus]AddrD_ei,
    input wire [`RegBus]RegDataB_ei,
    /* pc输入 */
    input wire [`InstAddrBus]pc_ei,
    
    /*__________________输出部分________________*/
    /* 控制通路输出 */
    output reg RegWEn_eo,
    output reg [`WBSEL_BUS]WBSel_eo,
    output reg MemRW_eo,
    /* alu输出 */
    output reg [`RegBus]alu_eo,
    output reg [`RegAddrBus]AddrD_eo,
    output reg [`RegBus]RegDataB_eo,
    /* pc输出 */
    output reg [`InstAddrBus] pc_eo
    );

    always @(posedge clk_i) 
    begin
        if(rst_i == `RESET_ENABLE)
        begin
            RegWEn_eo <= `REGWEN_DEFAULT;
            WBSel_eo <= `WBSEL_DEFAULT;
            alu_eo <= `ZeroWord;
            AddrD_eo <= `ZeroReg;
            pc_eo <= `ZeroWord;
            RegDataB_eo <= `ZeroWord;
            MemRW_eo <= `MEMRW_DEFAULT;
        end
        else
        begin
            RegWEn_eo <= RegWEn_ei;
            WBSel_eo <= WBSel_ei;
            alu_eo <= alu_ei;
            AddrD_eo <= AddrD_ei;
            pc_eo <= pc_ei;
            RegDataB_eo <= RegDataB_ei;
            MemRW_eo <= MemRW_ei;
        end
        
    end
endmodule


