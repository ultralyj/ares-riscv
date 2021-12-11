/**
 * @file ctrlHazard.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 当出现跳转指令时，即pcsel=alu时，冲刷F->D,D->E两个流水线寄存器组
 * @version 0.2
 * @date 2021-12-11
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"
module ctrlHazard(
    input wire PCSel_ei,
    output reg pipeline_Flush_o            // 流水线冲刷指令（当发生跳转的时候，清空当时）
    );

    initial 
    begin
        pipeline_Flush_o = `PLFLUSH_DISABLE;    
    end
    always @(*) 
    begin
        if(PCSel_ei == `PCSEL_ALU) 
            pipeline_Flush_o = `PLFLUSH_ENABLE;  
        else
             pipeline_Flush_o = `PLFLUSH_DISABLE;
    end
endmodule
