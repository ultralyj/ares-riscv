/**
 * @file ex.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risv-v内核的执行器
 *  将一些模块打包在一起了，包含regs,alu,branchcomp,immgen四个功能模块，和ASel和BSel等选通器
 * @version 0.1
 * @date 2021-11-25
 * 
 * @copyright Copyright (c) 2021
 * 
 */
`include "core_param.v"

module ex(
    
    input wire clk_i,                       // 时钟输入 
    
    input wire [`RegBus]pc_i,               // pc指针输入
    input wire[`InstAddrBus]inst_i,         // 指令输入
    input wire [`RegBus]DataD_i,            // 写回数据输入

    input wire RegWEn_i,                    // 控制通路，寄存器写使能
    input wire [`IMMSEL_BUS]ImmSel_i,       // 立即数生成器的模式选择标志位
    input wire BrUn_i,                      // 无符号有符号标志位
    input wire ASel_i,                      // 配置A通路选择的输入
    input wire BSel_i,                      // 配置B通路选择的输入
    input wire [`ALUSEL_BUS]ALUSel_i,       // 运算方式选择[3:0]

    output wire BrEq_o,                     // 等于标志位
    output wire BrLt_o,                     // 小于标志位
    output wire [`RegBus]DataB_o,           // DataB的数据输出（用来写入DMEM）
    output wire [`RegBus]alu_o              // 运算结果[31:0]
    );

    /* 寄存器数据输出连线 */
    wire [`RegBus]RegDataA;
    wire [`RegBus]RegDataB;

    /* alu输入数据连线 */
    wire [`RegBus]DataA;
    wire [`RegBus]DataB;

    /* 立即数连线 */
    wire [`RegBus]imm;

    /* 配置输出连线 */
    assign DataB_o = DataB;

    /* 实例化regs模块 */
    regs regs_inst(
        .clk_i(clk_i),
        .RegWEn_i(RegWEn_i),
        .AddrD_i(inst_i[11:7]),
        .DataD_i(DataD_i),
        .AddrA_i(inst_i[19:15]),
        .AddrB_i(inst_i[24:20]),
        .DataA_o(RegDataA),
        .DataB_o(RegDataB)
    );

    /* 实例化ImmGen模块 */
    ImmGen ImmGen_inst(
        .inst_i(inst_i),
        .ImmSel_i(ImmSel_i),
        .imm_o(imm)
    );

    /* 实例化分支模块 */
    BranchComp BranchComp_inst(
        .BrUn_i(BrUn_i),
        .DataA_i(RegDataA),
        .DataB_i(RegDataB),
        .BrEq_o(BrEq_o),
        .BrLt_o(BrLt_o)
    );

    /* 实例化ASel模块 */
    ASel ASel_inst(
        .ASel_i(ASel_i),
        .DataA_i(RegDataA),
        .pc_i(pc_i),
        .DataA_o(DataA)
    );

    /* 实例化BSel模块 */
    BSel BSel_inst(
        .BSel_i(BSel_i),
        .DataB_i(RegDataB),
        .Imm_i(imm),
        .DataB_o(DataB)
    );

    /* 实例化alu模块，用于基本的计算 */
    alu alu_inst(
        .DataA_i(DataA),
        .DataB_i(DataB),
        .ALUSel_i(ALUSel_i),
        .alu_o(alu_o)
    );

endmodule
