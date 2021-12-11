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

/**
 * @brief 后缀D表示译码级的连线
 */
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

    
    /*________________F取指级连线组____________*/
    /* 指令连线 */
    wire [`InstAddrBus]inst_F;
    /* pc连线 */
    wire [`InstAddrBus]pc_F;
    /*________________D译码级连线组____________*/
    /* 控制通路连线 */
    wire PCSel_D;
    wire BrUn_D;
    wire RegWEn_D;
    wire [`ASEL_BUS]ASel_D;
    wire [`ASEL_BUS]ASel_Forward_D;
    wire [`BSEL_BUS]BSel_D;
    wire [`BSEL_BUS]BSel_Forward_D;
    wire [`BSEL_BUS]REGBSel_Forward_D;
    wire MemRW_D;
    wire [`IMMSEL_BUS]ImmSel_D;
    wire [`ALUSEL_BUS]ALUSel_D;
    wire [`WBSEL_BUS]WBSel_D;
    /* 通用寄存器数据输出连线 */
    wire [`RegBus]RegDataA_D;
    wire [`RegBus]RegDataB_D;
    /* 指令连线 */
    wire [`InstAddrBus]inst_D;
    /* pc连线 */
    wire [`InstAddrBus]pc_D;
    wire pc_stopFlag;
    /*______________E执行级连线组_______________*/
    /* 控制通路连线 */
    wire PCSel_E;
    wire BrEq_E;
    wire BrLt_E;
    wire BrUn_E;
    wire RegWEn_E;
    wire [`ASEL_BUS]ASel_E;
    wire [`BSEL_BUS]BSel_E;
    wire [`BSEL_BUS]REGBSel_E;
    wire MemRW_E;
    wire [`IMMSEL_BUS]ImmSel_E;
    wire [`ALUSEL_BUS]ALUSel_E;
    wire [`WBSEL_BUS]WBSel_E;
    /* 通用寄存器数据输出连线 */
    wire [`RegBus]RegDataA_E;
    wire [`RegBus]RegDataB_E;
    wire [`RegBus]RegDataB_FE;
    /* 指令连线 */
    wire [`InstAddrBus]inst_E;
    /* pc连线 */
    wire [`InstAddrBus]pc_E;
    /* 输入alu的两个操作数 */
    wire [`RegBus]DataA_E;
    wire [`RegBus]DataB_E;
    /* 立即数连线 */
    wire [`RegBus]imm_E;
    /* alu输出 */
    wire [`RegBus]alu_E;
    /* 流水线冲刷控制连线 */
    wire pipeline_Flush_E;

    /*______________M访存级连线组_______________*/
    /* 控制通路连线 */
    wire PCSel_M;
    wire RegWEn_M;
    wire MemRW_M;
    wire [`WBSEL_BUS]WBSel_M;
    /* 通用寄存器数据输出连线 */
    wire [`RegBus]RegDataB_M;
    /* pc连线 */
    wire [`InstAddrBus]pc_M;
    /* alu */
    wire [`RegBus]alu_M;
    wire [`RegAddrBus]AddrD_M;
    wire [`RegBus]DataD_M;
    /* dmem */
    wire [`MEM_BUS]mem_M;
    
    /*______________W写回级连线组_______________*/
    /* 控制通路连线 */
    wire RegWEn_W;
    /* 通用寄存器连线 */
    wire [`RegAddrBus]AddrD_W;
    wire [`RegBus]DataD_W; 

    /* 实例化pc模块 */
    pc pc_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .PCSel_i(PCSel_E),
        .pc_stopFlag_i(pc_stopFlag),
        .jump_addr_i(alu_E),
        .pc_o(pc_F)
    );

    /* imem接口 */
    assign inst_F = inst_i;
    assign pc_o = pc_F;

    /* ____________________流水线寄存器组F->D___________________ */  
    stage_FD stage_FD_inst(
        .clk_i(clk_i),
        .pipeline_flush_i(pipeline_Flush_E),
        .pipeline_nop_i(pc_stopFlag),
        /*______输入部分________*/
        .inst_fi(inst_F),
        .pc_fi(pc_F),
        /*______输出部分________*/
        .inst_fo(inst_D),
        .pc_fo(pc_D)
    );
    /*___________流水线第二级:译码_______________*/
    /* 实例化ctrl模块，实现控制通路配置 */
    ctrl ctrl_inst(
        .inst_i({inst_D[30],inst_D[14:12],inst_D[6:2]}),
        .BrEq_i(BrEq_E),
        .BrLt_i(BrLt_E),
        .PCSel_o(PCSel_D),
        .ImmSel_o(ImmSel_D),
        .BrUn_o(BrUn_D),
        .ASel_o(ASel_D),
        .BSel_o(BSel_D),
        .ALUSel_o(ALUSel_D),
        .RegWEn_o(RegWEn_D),
        .WBSel_o(WBSel_D),
        .MemRW_o(MemRW_D)
    );

    forwarding forwarding_inst(
        .inst_di(inst_D),
        .ASel_di(ASel_D),
        .BSel_di(BSel_D),
        .RegWEn_ei(RegWEn_E),
        .WBSel_ei(WBSel_E),
        .AddrD_ei(inst_E[11:7]),
        .RegWEn_mi(RegWEn_M),
        .AddrD_mi(AddrD_M),
        .ASel_o(ASel_Forward_D),
        .BSel_o(BSel_Forward_D),
        .REGBSel_o(REGBSel_Forward_D),
        .pc_stopFlag_o(pc_stopFlag)
    );

    /* 实例化regs模块 */
    regs regs_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .RegWEn_i(RegWEn_W),
        .AddrD_i(AddrD_W),
        .DataD_i(DataD_W),
        .AddrA_i(inst_D[19:15]),
        .AddrB_i(inst_D[24:20]),
        .DataA_o(RegDataA_D),
        .DataB_o(RegDataB_D)
    );

    /* ____________________流水线寄存器组D->E___________________ */  
    stage_DE stage_DE_inst(
        .clk_i(clk_i),
        .pipeline_flush_i(pipeline_Flush_E),
        .pipeline_nop_i(pc_stopFlag),
        /* 控制通路输入 */
        .PCSel_di(PCSel_D),
        .BrUn_di(BrUn_D),
        .ASel_di(ASel_Forward_D),
        .BSel_di(BSel_Forward_D),
        .REGBSel_di(REGBSel_Forward_D),
        .ImmSel_di(ImmSel_D),
        .ALUSel_di(ALUSel_D),
        .RegWEn_di(RegWEn_D),
        .MemRW_di(MemRW_D),
        .WBSel_di(WBSel_D),
        /* 通用寄存器输入 */
        .DataA_di(RegDataA_D),
        .DataB_di(RegDataB_D),
        /* 立即数生成器输入 */
        .inst_di(inst_D),   
        /* pc输入 */
        .pc_di(pc_D),
        /*__________________输出部分________________*/
        /* 控制通路输出 */
        .PCSel_do(PCSel_E),
        .BrUn_do(BrUn_E),
        .ASel_do(ASel_E),
        .BSel_do(BSel_E),
        .REGBSel_do(REGBSel_E),
        .ImmSel_do(ImmSel_E),
        .ALUSel_do(ALUSel_E),
        .RegWEn_do(RegWEn_E),
        .MemRW_do(MemRW_E),
        .WBSel_do(WBSel_E),
        /* 通用寄存器输出 */
        .DataA_do(RegDataA_E),
        .DataB_do(RegDataB_E),
        /* 立即数生成器输出 */
        .inst_do(inst_E),  
        /* pc输出 */ 
        .pc_do(pc_E)
    );

    /*___________流水线第三级:执行_______________*/
    /*__________________________________________*/
    /* 实例化分支模块 */
    BranchComp BranchComp_inst(
        .BrUn_i(BrUn_E),
        .DataA_i(RegDataA_E),
        .DataB_i(RegDataB_E),
        .BrEq_o(BrEq_E),
        .BrLt_o(BrLt_E)
    );

    /* 实例化ImmGen模块 */
    ImmGen ImmGen_inst(
        .inst_i(inst_E),
        .ImmSel_i(ImmSel_E),
        .imm_o(imm_E)
    );

    /* 实例化ASel模块 */
    ASel ASel_inst(
        .ASel_i(ASel_E),
        .DataD_i(DataD_W),
        .alu_i(alu_M),
        .DataA_i(RegDataA_E),
        .pc_i(pc_E),
        .DataA_o(DataA_E)
    );

    /* 实例化BSel模块 */
    BSel BSel_inst(
        .BSel_i(BSel_E),
        .REGBSel_i(REGBSel_E),
        .DataD_i(DataD_W),
        .alu_i(alu_M),
        .DataB_i(RegDataB_E),
        .Imm_i(imm_E),
        .DataB_o(DataB_E),
        .RegDataB_o(RegDataB_FE)
    );

    /* 实例化alu模块，用于基本的计算 */
    alu alu_inst(
        .DataA_i(DataA_E),
        .DataB_i(DataB_E),
        .ALUSel_i(ALUSel_E),
        .alu_o(alu_E)
    );

    /* 流水线冲刷控制模块 */
    ctrlHazard ctrlHazard_inst(
        .PCSel_ei(PCSel_E),
        .pipeline_Flush_o(pipeline_Flush_E)
    );

    /* ____________________流水线寄存器组E->M___________________ */ 
    stage_EM stage_EM_inst(
        /* 控制通路输入 */
        .clk_i(clk_i),
        .RegWEn_ei(RegWEn_E),
        .MemRW_ei(MemRW_E),
        .WBSel_ei(WBSel_E),
        /* alu输入 */
        .alu_ei(alu_E),
        .RegDataB_ei(RegDataB_FE),
        .AddrD_ei(inst_E[11:7]),
        /* pc输入 */
        .pc_ei(pc_E),
        /* 控制通路输出 */
        .RegWEn_eo(RegWEn_M),
        .MemRW_eo(MemRW_M),
        .WBSel_eo(WBSel_M),
        /* alu输出 */
        .alu_eo(alu_M),
        .RegDataB_eo(RegDataB_M),
        .AddrD_eo(AddrD_M),
        /* pc输出 */
        .pc_eo(pc_M)
    );

    /*___________流水线第四级:访存_______________*/
    /*__________________________________________*/
    /* dmem接口 */
    assign mem_M = mem_i;
    assign DataW_o = RegDataB_M;
    assign alu_o = alu_M;
    assign MemRW_o = MemRW_M;

    /* 实例化写回模块 */
    writeback writeback_inst(
        .mem_i(mem_M),
        .alu_i(alu_M),
        .pcadd4_i(pc_M),
        .WBSel_i(WBSel_M),
        .wb_o(DataD_M)
    );

    /* ____________________流水线寄存器组M->W___________________ */ 
    stage_MW stage_MW_inst(
        .clk_i(clk_i),
        /*______输入部分________*/
        .RegWEn_mi(RegWEn_M),
        .AddrD_mi(AddrD_M),
        .DataD_mi(DataD_M),
        /*______输出部分________*/
        .RegWEn_mo(RegWEn_W),
        .AddrD_mo(AddrD_W),
        .DataD_mo(DataD_W)
    );
    

endmodule
