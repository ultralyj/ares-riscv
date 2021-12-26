/**
 * @file rv_core.v
 * @author ares team(ultralyj, Amy, zz16, sunshine, Candyaner)
 * @brief risv-v内核的顶层连接文件（不包括imem,dmem）
 * 包含fetch, decode, excute, memory, writeback五级流水线和其中的模块
 * @version 0.2
 * @date 2021-12-11
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

/**
 *  @brief 代码按照五级流水线展开
 *  ┌─────┬───────┬───────┬───────┬──────────┐
 *  │fetch│►decode│►excute│►memory│►writeback│
 *  └─────┴───────┴───────┴───────┴──────────┘
 * 连线命名方式，xxx_X,最后的字母代表所在的流水线级数（FDEMW），还有特殊的FX表示前馈
 */

/*---------------------连线定义部分-------------------------*/

    /* xxxxxxxxxxxxxxxF取指级连线组xxxxxxxxxxxxxxx */
    /* ◄──────────────Fetch line────────────────► */
    /* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx */
    /* pc连线 */
    wire [`InstAddrBus]pc_F;
    /* 指令连线 */
    wire [`InstAddrBus]inst_F;

    /*________________D译码级连线组_________________*/
    /* ◄──────────────Decode line────────────────► */
    /* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx */
    /* 控制通路连线 */
    wire PCSel_D;
    wire BrUn_D;
    wire RegWEn_D;
    wire ASel_D;
    wire BSel_D;
    wire MemRW_D;
    wire [`IMMSEL_BUS]ImmSel_D;
    wire [`ALUSEL_BUS]ALUSel_D;
    wire [`WBSEL_BUS]WBSel_D;
    /* 通用寄存器数据输出连线 */
    wire [`RegBus]RegDataA_D;
    wire [`RegBus]RegDataB_D;
    wire [`RegBus]RegDataA_FD;
    wire [`RegBus]RegDataB_FD;
    /* 指令连线 */
    wire [`InstAddrBus]inst_D;
    /* pc连线 */
    wire [`InstAddrBus]pc_D;
    wire pc_stopFlag;
    /* 立即数连线 */
    wire [`RegBus]imm_D;

    /*________________E执行级连线组_________________*/
    /* ◄──────────────Excute line────────────────► */
    /* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx */
    /* 控制通路连线 */
    wire PCSel_E;
    wire PCSel_FE;
    wire BrEq_E;
    wire BrLt_E;
    wire BrUn_E;
    wire RegWEn_E;
    wire ASel_E;
    wire BSel_E;
    wire MemRW_E;
    wire [`IMMSEL_BUS]ImmSel_E;
    wire [`ALUSEL_BUS]ALUSel_E;
    wire [`WBSEL_BUS]WBSel_E;
    /* 通用寄存器数据输出连线 */
    wire [`RegBus]RegDataA_E;
    wire [`RegBus]RegDataB_E;
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

    /*________________M访存级连线组_________________*/
    /* ◄──────────────Memory line────────────────► */
    /* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx */
    /* 控制通路连线 */
    wire RegWEn_M;
    wire [`WBSEL_BUS]WBSel_M;
    wire MemRW_M;
   
    /* pc连线 */
    wire [`InstAddrBus]pc_M;
    /* alu */
    wire [`RegBus]alu_M;
    wire [`RegAddrBus]AddrD_M;
    wire [`RegBus]DataD_M;
    wire [`RegBus]RegDataB_M;
    /* dmem */
    wire [`MEM_BUS]mem_M;
    
    /*________________W写回级连线组_________________*/
    /* ◄─────────────WriteBack line──────────────► */
    /* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx */
    /* 控制通路连线 */
    wire RegWEn_W;
    /* 通用寄存器连线 */
    wire [`RegAddrBus]AddrD_W;
    wire [`RegBus]DataD_W; 

/*---------------------模块与接口部分-------------------------*/
    /*
            ↓↓↓↓↓↓↓↓↓ 流水线第一级:取指 ↓↓↓↓↓↓↓↓↓
            ┌─────┬─────┬──────┬──────┬────────┐
            │Fetch│     │      │      │        │
            └─────┴─────┴──────┴──────┴────────┘
    */
    /* 实例化pc模块 */
    pc pc_inst(
        /* 时钟和复位信号 */
        .clk_i(clk_i),
        .rst_i(rst_i),
        /* PC控制通路 */
        .PCSel_i(PCSel_FE),
        .pc_stopFlag_i(pc_stopFlag),
        /* 跳转和pc输出 */
        .jump_addr_i(alu_E),
        .pc_o(pc_F)
    );

    /* imem接口 */
    assign inst_F = inst_i;
    assign pc_o = pc_F;

    /* ____________________流水线寄存器组F->D___________________ */  
    stage_FD stage_FD_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .pipeline_flush_i(pipeline_Flush_E),
        .pipeline_nop_i(pc_stopFlag),
        /*______输入部分________*/
        .pc_fi(pc_F),
        .inst_fi(inst_F),
        /*______输出部分________*/
        .pc_fo(pc_D),
        .inst_fo(inst_D)
    );

    /*
            ↓↓↓↓↓↓↓↓↓ 流水线第二级:译码 ↓↓↓↓↓↓↓↓↓
            ┌──────┬───────┬──────┬─────┬──────┐
            │      │decode │      │     │      │
            └──────┴───────┴──────┴─────┴──────┘
    */
    /* 实例化ctrl模块，实现控制通路配置 */
    ctrl ctrl_inst(
        /* 控制输入 */
        .inst_i({inst_D[25],inst_D[30],inst_D[14:12],inst_D[6:2]}),
        /* 控制输出 */
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

    /* 实例化ImmGen模块 */
    ImmGen ImmGen_inst(
        .inst_i(inst_D[31:7]),
        .ImmSel_i(ImmSel_D),
        .imm_o(imm_D)
    );

    /* 实例化regs模块 */
    regs regs_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        /* 通用寄存器读取输出 */
        .AddrA_i(inst_D[19:15]),
        .AddrB_i(inst_D[24:20]),
        .DataA_o(RegDataA_D),
        .DataB_o(RegDataB_D),
        /* 通用寄存器写回输入 */
        .RegWEn_i(RegWEn_W),
        .AddrD_i(AddrD_W),
        .DataD_i(DataD_W)
    );

    /* 流水线前馈控制单元 */
    forwarding forwarding_inst(
        .AddrA_di(inst_D[19:15]),
        .AddrB_di(inst_D[24:20]),
        /* 来自E,M级的AddrD和RegWEn输入 */
        .AddrD_ei(inst_E[11:7]),
        .RegWEn_mi(RegWEn_M),
        .AddrD_mi(AddrD_M),
        .RegWEn_ei(RegWEn_E),
        /* 本级DataA,DataB和可能将它们代换的DataD(来自E,M)数据输入 */
        .DataD_ei(alu_E),
        .DataD_mi(DataD_M),
        .DataA_di(RegDataA_D),
        .DataB_di(RegDataB_D),
        /* 前馈完成数据输出 */
        .DataA_do(RegDataA_FD),
        .DataB_do(RegDataB_FD),
        /* 写回控制线输入（用于判断l-type指令冲突）和流水线停止标志输出 */
        .WBSel_ei(WBSel_E),
        .pc_stopFlag_o(pc_stopFlag)
    );

    /* ____________________流水线寄存器组D->E___________________ */  
    stage_DE stage_DE_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .pipeline_flush_i(pipeline_Flush_E),
        .pipeline_nop_i(pc_stopFlag),
        /* 控制通路输入 */
        .PCSel_di(PCSel_D),
        .BrUn_di(BrUn_D),
        .ASel_di(ASel_D),
        .BSel_di(BSel_D),
        .ImmSel_di(ImmSel_D),
        .ALUSel_di(ALUSel_D),
        .RegWEn_di(RegWEn_D),
        .MemRW_di(MemRW_D),
        .WBSel_di(WBSel_D),
        /* 通用寄存器输入 */
        .DataA_di(RegDataA_FD),
        .DataB_di(RegDataB_FD),
        /* 立即数生成器输入 */
        .inst_di(inst_D),   
        /* pc输入 */
        .pc_di(pc_D),
        .imm_di(imm_D),
        /*__________________输出部分________________*/
        /* 控制通路输出 */
        .PCSel_do(PCSel_E),
        .BrUn_do(BrUn_E),
        .ASel_do(ASel_E),
        .BSel_do(BSel_E),
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
        .pc_do(pc_E),
        .imm_do(imm_E)
    );

    /*
            ↓↓↓↓↓↓↓↓↓ 流水线第三级:执行 ↓↓↓↓↓↓↓↓↓
            ┌────┬───────┬───────┬─────┬───────┐
            │    │       │excute │     │       │
            └────┴───────┴───────┴─────┴───────┘
    */
    /* 简化的控制模块（只用于配合branchComp产生对应的PCSel（PCSel在本级写回）） */
    ctrl_br ctrl_br_inst(
        .inst_i({inst_E[14:12],inst_E[6:2]}),              
        .PCSel_i(PCSel_E),
        .BrEq_i(BrEq_E),                    
        .BrLt_i(BrLt_E),                    
        .PCSel_o(PCSel_FE)      // <----最终输入到PC的改进型PCSel                              
    );

    /* 实例化分支模块 */
    BranchComp BranchComp_inst(
        .BrUn_i(BrUn_E),
        .DataA_i(RegDataA_E),
        .DataB_i(RegDataB_E),
        .BrEq_o(BrEq_E),
        .BrLt_o(BrLt_E)
    );

    /* 实例化ASel模块 */
    ASel ASel_inst(
        .ASel_i(ASel_E),
        .DataA_i(RegDataA_E),
        .pc_i(pc_E),
        .DataA_o(DataA_E)
    );

    /* 实例化BSel模块 */
    BSel BSel_inst(
        .BSel_i(BSel_E),
        .DataB_i(RegDataB_E),
        .Imm_i(imm_E),
        .DataB_o(DataB_E)
    );

    /* 实例化alu模块，用于基本的计算 */
    alu alu_inst(
        .DataA_i(DataA_E),
        .DataB_i(DataB_E),
        .ALUSel_i(ALUSel_E),
        .alu_o(alu_E)
    );

    /* 流水线冲刷控制模块 */
    assign pipeline_Flush_E = PCSel_FE;

    /* ____________________流水线寄存器组E->M___________________ */ 
    stage_EM stage_EM_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        /* 控制通路输入 */
        .RegWEn_ei(RegWEn_E),
        .WBSel_ei(WBSel_E),
        .MemRW_ei(MemRW_E),
        /* alu输入 */
        .alu_ei(alu_E),
        .AddrD_ei(inst_E[11:7]),
        .RegDataB_ei(RegDataB_E),
        /* pc输入 */
        .pc_ei(pc_E),
        /* 控制通路输出 */
        .RegWEn_eo(RegWEn_M),
        .WBSel_eo(WBSel_M),
        .MemRW_eo(MemRW_M),
        /* alu输出 */
        .alu_eo(alu_M),
        .AddrD_eo(AddrD_M),
        .RegDataB_eo(RegDataB_M),
        /* pc输出 */
        .pc_eo(pc_M)
    );

    /*
            ↓↓↓↓↓↓↓↓↓ 流水线第四级:访存 ↓↓↓↓↓↓↓↓↓
            ┌─────┬─────┬─────┬────────┬───────┐
            │     │     │     │ memory │       │
            └─────┴─────┴─────┴────────┴───────┘
    */
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
        .rst_i(rst_i),
        /*______输入部分________*/
        .RegWEn_mi(RegWEn_M),
        .AddrD_mi(AddrD_M),
        .DataD_mi(DataD_M),
        /*______输出部分________*/
        .RegWEn_mo(RegWEn_W),
        .AddrD_mo(AddrD_W),
        .DataD_mo(DataD_W)
    );
    /*
            ↓↓↓↓↓↓↓↓↓ 流水线第五级:写回 ↓↓↓↓↓↓↓↓↓
            ┌─────┬─────┬─────┬────┬───────────┐
            │     │     │     │    │ writeback │
            └─────┴─────┴─────┴────┴───────────┘
    */
    /* 直接写回到regs里了，不需要其他模块 */

// wire [`InstAddrBus]JalNPC_E;
// wire [`InstAddrBus]BrNPC; 
// wire Branch_E;
// //for BTB
// wire BrPd_F; 
// wire BrPd_D;
// wire BrPd_E;
// wire [`InstAddrBus] BrPd_PC_F;
// //count
// reg [31:0] all_instr_count;
// reg [31:0] branch_instr_count;
// reg [31:0] right_predict_count;
// reg [31:0] error_predict_count;
// //wire values assignments
// assign JalNPC_E = imm_E + pc_E;

// assign Branch_E = BrEq_E | BrLt_E;

// BTB BTB_inst(
//     .clk_i(clk_i),
//     .rst_i(rst_i),
//     .rd_PC(pc_F),     
//     .rd_predicted_PC(BrPd_PC_F), 
//     .rd_predicted(BrPd_F), 
//     .btb_en(PCSel_E), 
//     .wr_PC(pc_E),     
//     .wr_predicted_PC(alu_E) 
// );
endmodule
