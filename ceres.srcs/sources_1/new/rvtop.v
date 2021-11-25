/**
 * @file rvtop.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risv-v处理器最高顶层文件，包含内核和dram和irom
 * @version 0.1
 * @date 2021-11-25
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module rvtop(
    input wire clk_i
    );

    /* risc-v内核与存储器交互的总线 */
    wire [`InstAddrBus]pc;
    wire [`InstAddrBus]inst;
    wire [`RegBus]DataW;
    wire [`RegBus]alu;
    wire [`MEM_BUS]mem;
    wire MemRW;

    /* 实例化DMEM模块（IP核） */
    dmem dmem_inst (
        .clka(clk),                 // 时钟输入
        .wea(MemRW),                // 写入使能
        .addra(alu[7:0]),           // 8bit地址输入
        .dina(DataW),               // 32位数据写入
        .douta(mem)                 // 32位数据读出
    );

    /* 实例化IMEM模块（IP核） */
    /* 注意：IMEM存储在/ceres.srcs/imem_inst/*.coe文件中，更改文件中的指令就可以更新输入的指令
    （需要再次综合来更新ROM中存储的值） */
    imem imem_inst (
        .clka(clk_i),               // 时钟输入
        /* 注意：此处需要位移2位，因为存储器定义的字长为32位，
            即可地址只需要位移1位即可，而PC输出的是4的倍数，所以需要除以4，
            也就是舍弃pc的低2位（因为定义的rom只有256x32bit因此地址只需要取8位即可） */
        .addra(pc[9:2]),            // 地址输入
        .douta(inst)                // 对应地址的指令
    );

    /* 实例化risc-v内核模块 */ 
    rv_core rv_core_inst(
        .clk_i(clk_i),
        .mem_i(mem),
        .pc_o(pc),
        .inst_i(inst),
        .DataW_o(DataW),
        .alu_o(alu),
        .MemRW_o(MemRW)
        );
endmodule
