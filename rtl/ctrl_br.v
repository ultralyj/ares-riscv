/**
 * @file ctrl.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 控制通路的精简版，主要是为了在E即配合branchComp生成pcsel，进行分支跳转
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"
`include "riscv_codetable.v"

module ctrl_br(
    /* 指令输入 */
    input wire[`INST_CTRL_BUS2] inst_i,              
    /* 控制输入 */
    input wire PCSel_i,
    input wire BrEq_i,                      //branch equal(input)
    input wire BrLt_i,                      //branch less-than(input)
    /* 控制输出 */
    output wire PCSel_o
    );
    /* 分割指令的各部分 */
    /* 运算指令由下面三部分确定 */
    wire[4:0]   opcode = inst_i[4:0];
    wire[2:0]   funct3 = inst_i[7:5];
    assign PCSel_o = (opcode == `INST_TYPE_B)?
                    ((  (funct3 == `INST_BEQ && BrEq_i == `BREQ_BNE)||
                        (funct3 == `INST_BNE && BrEq_i == `BREQ_BEQ)||
                        ((funct3 == `INST_BLT || funct3 == `INST_BLTU) && BrLt_i == `BRLT_BGE_BGEU)||
                        ((funct3 == `INST_BGE || funct3 == `INST_BGEU) && BrLt_i == `BRLT_BLT_BLTU))?
                        `PCSEL_ADD4:`PCSEL_ALU):(PCSel_i);
endmodule
