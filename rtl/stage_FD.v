/**
 * @file stage_FD.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 取值和译码之间的流水线延迟寄存器(通过寄存器达到延迟效果)
 * @version 0.2
 * @date 2021-12-10
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module stage_FD(
    input wire clk_i,
    input wire pipeline_flush_i,
    input wire pipeline_nop_i,
    /*______输入部分________*/
    input wire [`InstAddrBus]inst_fi,
    input wire [`InstAddrBus]pc_fi,
    /*______输出部分________*/
    output reg [`InstAddrBus]inst_fo,
    output reg [`InstAddrBus]pc_fo
   
    );

    always @(posedge clk_i) 
    begin
        if(pipeline_flush_i == `PLFLUSH_ENABLE)
        begin
            /* 进行流水线冲刷 */
            inst_fo = inst_fi;
            pc_fo = pc_fi;
        end
        else 
        begin
            if(pipeline_nop_i == `PC_STOP_ENABLE)
            begin
                /* 流水线保持，再生成一条原指令 */
                inst_fo = inst_fo;
                pc_fo = pc_fo;
            end
            else
            begin
                inst_fo = inst_fi;
                pc_fo = pc_fi;
            end
        end
        
    end
endmodule

