/**
 * @file writeback.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 根据写回选择的不同，输出写回的内容是来自于存储还是alu
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module writeback(
    input wire [`MEM_BUS]mem_i,       // 读取的数据
    input wire [`RegBus]alu_i,
    input wire [`InstAddrBus]pcadd4_i,
    input wire [`WBSEL_BUS]WBSel_i,
    output wire [`RegBus]wb_o
    );

    assign wb_o =   (WBSel_i == `WBSEL_ALU)?alu_i: 
                    (WBSel_i == `WBSEL_PCADD4)?(pcadd4_i + 32'h4):mem_i;
endmodule
