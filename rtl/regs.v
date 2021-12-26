/**
 * @file regs.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risc-v内核的32个32位寄存器的基本读写
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module regs(
    input wire clk_i,
    input wire rst_i,

    input wire RegWEn_i,
    /* 来自控制通路的使能 */
    input wire [`RegAddrBus]AddrD_i,
    input wire [`RegBus]DataD_i,

    /* 寄存器的地址输入 */
    input wire [`RegAddrBus]AddrA_i, 
    input wire [`RegAddrBus]AddrB_i,

    /* 寄存器的输出(1条指令可能涉及两个寄存器的输出) */
    //output wire [`RegBus]debugReg_o,
    output wire [`RegBus]DataA_o,
    output wire [`RegBus]DataB_o
);
    
    /* 通用寄存器  32个32位寄存器 */
    reg[`RegBus] regs[1:`RegNum - 1];
    
    /* 读寄存器A */
    assign DataA_o =    (AddrA_i!=`ZeroReg)?
                        ((AddrD_i == AddrA_i && RegWEn_i == `REGWEN_ENABLE)?
                        DataD_i:regs[AddrA_i]):`ZeroWord;

    /* 读寄存器B */
    assign DataB_o =    (AddrB_i!=`ZeroReg)?
                        ((AddrD_i == AddrB_i && RegWEn_i == `REGWEN_ENABLE)?
                        DataD_i:regs[AddrB_i]):`ZeroWord;
                        
    /* 写寄存器（优先） */
    always @(posedge clk_i) 
    begin
        if ((RegWEn_i == `REGWEN_ENABLE) && (AddrD_i != `ZeroReg)) 
        begin
            regs[AddrD_i] <= DataD_i;
        end 
    end     
endmodule
