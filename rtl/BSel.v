/**
 * @file ImmGen.v
 * @author ARES Team.
 * @brief 根据指令类型的不同，选择输出是立即数还是reg数据
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module BSel(
    input wire BSel_i,              // 配置通路选择的输入

    input wire [`RegBus]DataB_i,    // 数据B输入
    input wire [`RegBus]Imm_i,      // 立即数输入
    
    output wire [`RegBus]DataB_o     // 选择输出
    );

    assign DataB_o = (BSel_i == `BSEL_IMM)?Imm_i:DataB_i;


endmodule
