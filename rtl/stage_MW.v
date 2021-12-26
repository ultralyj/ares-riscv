/**
 * @file stage_MW.v
 * @author ares team(ultralyj, Amy, zz16, sunshine, Candyaner)
 * @brief 访存和写回之间的流水线延迟寄存器(通过寄存器达到延迟效果)
 * @version 0.2
 * @date 2021-12-10
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module stage_MW(
    input wire clk_i,
    input wire rst_i,
    /*______输入部分________*/
    input wire RegWEn_mi,
    input wire [`RegAddrBus]AddrD_mi,
    input wire [`RegBus]DataD_mi,
    /*______输出部分________*/
    output reg RegWEn_mo,
    output reg [`RegAddrBus]AddrD_mo,
    output reg [`RegBus]DataD_mo
    );

    always @(posedge clk_i or negedge rst_i) 
    begin
        if (rst_i == `RESET_ENABLE) 
        begin
            RegWEn_mo <= `REGWEN_DEFAULT;
            AddrD_mo <= `ZeroReg;
            DataD_mo <= `ZeroWord;
        end
        else
        begin
            RegWEn_mo <= RegWEn_mi;
            AddrD_mo <= AddrD_mi;
            DataD_mo <= DataD_mi;
        end
    end
endmodule
