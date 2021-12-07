/**
 * @file rv_core.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risv-v内核的顶层连接文件（不包括imem,dmem）
 * 包含pc, ex, wb, ctrl四个模块
 * @version 0.1
 * @date 2021-11-25
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module rv_core(
    input wire clk_i,
    input wire rst_i,
    /* 取指，imem(rom)相关 */
    input wire [`InstAddrBus]inst_i,
    output wire [`InstAddrBus]pc_o,
    /* 数据，dmem(ram)相关 */
    input wire [`MEM_BUS]mem_i,
    output wire [`RegBus]DataW_o,
    output wire [`RegBus]alu_o,
    output wire MemRW_o
    );

    /* pc连线 */
    wire [`InstAddrBus]pc;
    /* 指令连线 */
    wire [`InstAddrBus]inst;  

    /* 控制通路连线 */
    wire BrEq;
    wire BrLt;
    wire PCSel;
    wire BrUn;
    wire RegWEn;
    wire ASel;
    wire BSel;
    wire [`IMMSEL_BUS]ImmSel;
    wire [`ALUSEL_BUS]ALUSel;
    wire [`WBSEL_BUS]WBSel;

    /* 寄存器数据连线 */
    wire [`RegBus]DataB;
    wire [`RegBus]alu;
    wire [`RegBus]mem;
    wire [`RegBus]DataD;

    /* 配置各路输出连线 */
    assign inst = inst_i;
    assign pc_o = pc;
    assign alu_o = alu;
    assign DataW_o = DataB;

    /* 实例化pc模块 */
    pc pc_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .PCSel_i(PCSel),
        .jump_addr_i(alu),
        .pc_o(pc)
    );

    /* 实例化ex模块，包括了br,immGen,regs,alu等重要模块 */
    ex ex_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .pc_i(pc),
        .inst_i(inst),   
        .DataD_i(DataD),

        .RegWEn_i(RegWEn),
        .ImmSel_i(ImmSel),
        .BrUn_i(BrUn),                      // 无符号有符号标志位
        .ASel_i(ASel),                      // 配置A通路选择的输入
        .BSel_i(BSel),                      // 配置B通路选择的输入
        .ALUSel_i(ALUSel),                  // 运算方式选择[3:0]

        .BrEq_o(BrEq),                      // 等于标志位
        .BrLt_o(BrLt),                      // 小于标志位
        .DataB_o(DataB),
        .alu_o(alu)                         // 运算结果[31:0]
        );

    /* 实例化写回模块 */
    writeback writeback_inst(
        .mem_i(mem_i),
        .MemRW_i(MemRW_o),
        .alu_i(alu),
        .pcadd4_i(pc),
        .WBSel_i(WBSel),
        .wb_o(DataD)
    );

    /* 实例化ctrl模块，实现控制通路配置 */
    ctrl ctrl_inst(
        .inst_i({inst[30],inst[14:12],inst[6:2]}),
        .BrEq_i(BrEq),
        .BrLt_i(BrLt),
        .PCSel_o(PCSel),
        .ImmSel_o(ImmSel),
        .BrUn_o(BrUn),
        .ASel_o(ASel),
        .BSel_o(BSel),
        .ALUSel_o(ALUSel),
        .RegWEn_o(RegWEn),
        .WBSel_o(WBSel),
        .MemRW_o(MemRW_o)
    );

endmodule
