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
    output reg [`RegBus]DataA_o,
    output reg [`RegBus]DataB_o
);
    
    /* 通用寄存器  32个32位寄存器 */
    reg[`RegBus] regs[0:`RegNum - 1];

    initial 
    begin
        /* 给寄存器赋随机的初始值 */
        regs[0]  = `ZeroWord;   regs[1]  = `ZeroWord;   regs[2]  = `PC_START_ADDR;   regs[3]  = `ZeroWord;  
        regs[4]  = `ZeroWord;  regs[5]  = `ZeroWord;  regs[6]  = `ZeroWord;  regs[7]  = `ZeroWord;
        regs[8]  = `PC_START_ADDR;  regs[9]  = `ZeroWord;  regs[10] = `ZeroWord;  regs[11] = `ZeroWord;
        regs[12] = `ZeroWord;   regs[13] = `ZeroWord;   regs[14] = `ZeroWord;  regs[15] = `ZeroWord;
        regs[16] = `ZeroWord;  regs[17] = `ZeroWord;  regs[18] = `ZeroWord;  regs[19] = `ZeroWord;
        regs[20] = `ZeroWord;  regs[21] = `ZeroWord;  regs[22] = `ZeroWord;   regs[23] = `ZeroWord;
        regs[24] = `ZeroWord;  regs[25] = `ZeroWord;  regs[26] = `ZeroWord;  regs[27] = `ZeroWord;
        regs[28] = `ZeroWord;  regs[29] = `ZeroWord;  regs[30] = `ZeroWord;  regs[31] = `ZeroWord;
        DataA_o  = `ZeroWord;
        DataB_o  = `ZeroWord;
    end
    
    /* 读寄存器1 */
    always @ (*) 
    begin
        if (AddrA_i == `ZeroReg) 
        begin
            DataA_o = `ZeroWord;
        end 
        /* 读取寄存器 */
        else 
        begin
            DataA_o = regs[AddrA_i];
        end
    end

    /* 读寄存器2 */
    always @ (*) 
    begin
        if (AddrB_i == `ZeroReg) 
        begin
            DataB_o = `ZeroWord;
        end 
        /* 读取寄存器 */
        else 
        begin
            DataB_o = regs[AddrB_i];
        end
    end

    /* 写寄存器（优先） */
    always @(posedge clk_i or negedge rst_i) 
    begin
        if(rst_i == `RESET_ENABLE)
        begin
            regs[2]  = `PC_START_ADDR;
            regs[8]  = `PC_START_ADDR;
        end
        else
        begin
            if ((RegWEn_i == `REGWEN_ENABLE) && (AddrD_i != `ZeroReg)) 
            begin
                regs[AddrD_i] <= DataD_i;
            end 
        end     
    end
endmodule
