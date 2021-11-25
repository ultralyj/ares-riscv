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
        regs[0]  = 0;   regs[1]  = 1;   regs[2]  = 5;   regs[3]  = 8;  
        regs[4]  = 12;  regs[5]  = 17;  regs[6]  = 0;  regs[7]  = 30;
        regs[8]  = 38;  regs[9]  = 47;  regs[10] = 57;  regs[11] = 68;
        regs[12] = 5;   regs[13] = 8;   regs[14] = 12;  regs[15] = 17;
        regs[16] = 23;  regs[17] = 30;  regs[18] = 38;  regs[19] = 47;
        regs[20] = 57;  regs[21] = 68;  regs[22] = 5;   regs[23] = 8;
        regs[24] = 12;  regs[25] = 17;  regs[26] = 23;  regs[27] = 30;
        regs[28] = 38;  regs[29] = 47;  regs[30] = 57;  regs[31] = 57;
        DataA_o  = regs[0];
        DataB_o  = regs[0];
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
    always @(posedge clk_i) 
    begin
        if ((RegWEn_i == `REGWEN_ENABLE) && (AddrD_i != `ZeroReg)) 
        begin
            regs[AddrD_i] <= DataD_i;
        end 
    end
endmodule
