/**
 * @file ImmGen.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 根据指令类型的不同，选择输出是pc地址还是reg数据
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module ASel(
    input wire ASel_i,              // 配置通路选择的输入
  
    input wire [`RegBus]DataA_i,    // 数据A输入
    input wire [`RegBus]pc_i,       // pc地址输入

    output wire [`RegBus]DataA_o     // 选择输出
    );

    assign DataA_o = (ASel_i == `ASEL_PC)?pc_i:DataA_i;

endmodule
