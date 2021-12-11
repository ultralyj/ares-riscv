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

    /* 控制通路输入 */
    input wire RegWEn_ei,
    input wire MemRW_ei,
    input wire [`WBSEL_BUS]WBSel_ei,
    /* alu输入 */
    input wire [`RegBus]alu_ei,
    input wire [`RegBus]RegDataB_ei,
    input wire [`RegAddrBus]AddrD_ei,
    /* pc输入 */
    input wire [`InstAddrBus]pc_ei,
    

    /*__________________输出部分________________*/
    /* 控制通路输出 */
    output reg RegWEn_eo,
    output reg MemRW_eo,
    output reg [`WBSEL_BUS]WBSel_eo,
    /* alu输出 */
    output reg [`RegBus]alu_eo,
    output reg [`RegBus]RegDataB_eo,
    output reg [`RegAddrBus]AddrD_eo,
    /* pc输出 */
    output reg [`InstAddrBus] pc_eo
    );

    always @(posedge clk_i) 
    begin
        RegWEn_eo = RegWEn_ei;
        MemRW_eo = MemRW_ei;
        WBSel_eo = WBSel_ei;
        alu_eo = alu_ei;
        RegDataB_eo = RegDataB_ei;
        AddrD_eo = AddrD_ei;
        pc_eo = pc_ei;
    end
endmodule


