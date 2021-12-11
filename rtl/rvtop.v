/**
 * @file rvtop.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risv-v处理器最高顶层文件，包含内核和dram和irom
 * @version 0.1
 * @date 2021-12-06
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"
/**
 * 如何运行c语言代码
 * 1. 写一个简单的c程序（只包含main函数的那种，具体就修改riscv_test.c文件就好了）
 * 2. 运行complier.bat批处理脚本（1包含.c文件编译2生成反汇编3生产指令bin文件4用coeGen.exe把bin文件转换成coe文件）
 * 3. 把coe文件放入imem模块中，再次预综合更新一下
 * 4. 注意反汇编文件中的main函数起始地址，注意修改参数PC_START_ADDR，这对于cpu迈出第一步十分关键
 * 5. 注意对 dmem 大小的控制，默认为1k（起始完全可以在小一些）
 */
module rvtop(
    input wire clk_i,
    input wire rst_i,
    output wire dmem_o
    );

    /* risc-v内核与存储器交互的总线 */
    wire [`InstAddrBus]pc;
    wire [`InstAddrBus]inst;
    wire [`RegBus]DataW;
    wire [`RegBus]alu;
    wire [`MEM_BUS]mem;
    wire MemRW;
    /* 注意：输入指令存储器的地址，需要先减去起始地址偏移（编译器决定，看反汇编）
            再位移2位，因为存储器定义的字长为32位，
            即实际地址只需要位移1位即可，而PC输出的是4的倍数，所以需要除以4，
            也就是舍弃pc的低2位（因为定义的rom只有256x32bit因此地址只需要取8位即可） */
    wire [`InstAddrBus]imemAddr;
    wire [15:0]dmemAddr;

    /* 对dmem地址重映射到0-256地址中 */
    assign dmemAddr = alu[17:2] + `DMEM_SIZE- `PC_START_ADDR /4;
    assign imemAddr = pc-`PC_START_ADDR;
    assign dmem_o = mem[0];
    
    /* 实例化DMEM模块（IP核） */
    dmem dmem_inst (
        .clk(clk_i),                 // 时钟输入
        .we(MemRW),                // 写入使能
        .a(dmemAddr[7:0]),           // 8bit地址输入
        .d(DataW),               // 32位数据写入
        .spo(mem)                 // 32位数据读出
    );

    /* 实例化IMEM模块（IP核） */
    /* 注意：IMEM存储在/ceres.srcs/imem_inst/*.coe文件中，更改文件中的指令就可以更新输入的指令
    （需要再次综合来更新ROM中存储的值） */
    imem imem_inst (   
        .a(imemAddr[9:2]),            // 地址输入
        .spo(inst)                // 对应地址的指令
    );

    /* 实例化risc-v内核模块 */ 
    rv_core rv_core_inst(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .mem_i(mem),
        .pc_o(pc),
        .inst_i(inst),
        .DataW_o(DataW),
        .alu_o(alu),
        .MemRW_o(MemRW)
        );
endmodule
