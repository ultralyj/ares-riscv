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
    input wire clk_i,                   // 时钟输入
    input wire MemRW_i,                 // 存储读写配置输入
    input wire [`MEM_BUS]mem_i,       // 读取的数据
    input wire [`RegBus]alu_i,
    input wire [`InstAddrBus]pcadd4_i,
    input wire [`WBSEL_BUS]WBSel_i,
    output reg [`RegBus]wb_o
    );


    always @(*) 
    begin
        case (WBSel_i)
            `WBSEL_MEM:
            begin
                wb_o = mem_i;
            end
            `WBSEL_ALU:
            begin
                wb_o = alu_i;
            end
            `WBSEL_PCADD4: 
            begin
                wb_o = pcadd4_i;
            end
            default: 
            begin
                wb_o = mem_i;
            end
        endcase
    end
endmodule
