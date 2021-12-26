/**
 * @file stage_FD.v
 * @author ares team(ultralyj, Amy, zz16, sunshine, Candyaner)
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
    input wire rst_i,

    input wire pipeline_flush_i,
    input wire pipeline_nop_i,
    /*______输入部分________*/
    input wire [`InstAddrBus]pc_fi,
    input wire [`InstAddrBus]inst_fi,
    /*______输出部分________*/
    output reg [`InstAddrBus]pc_fo,
    output reg [`InstAddrBus]inst_fo
    );

    always @(posedge clk_i or negedge rst_i) 
    begin
        if(rst_i == `RESET_ENABLE)
        begin
            /* 进行流水线冲刷 */
            inst_fo <= `ZeroWord;
            pc_fo <= `ZeroWord;
        end
        else
        begin
            if(pipeline_flush_i == `PLFLUSH_ENABLE)
            begin
                /* 进行流水线冲刷 */
                pc_fo <= `ZeroWord;
                inst_fo <= `ZeroWord;
            end
            else 
            begin
                if(pipeline_nop_i == `PC_STOP_ENABLE)
                begin
                    /* 流水线保持，再生成一条原指令 */
                    pc_fo <= pc_fo;
                    inst_fo <= inst_fo;
                end
                else
                begin
                    pc_fo <= pc_fi;
                    inst_fo <= inst_fi;
                end
            end
        end
        
        
    end
endmodule

