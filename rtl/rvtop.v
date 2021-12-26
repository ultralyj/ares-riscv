/**
 * @file rvtop.v
 * @author ares team(ultralyj, Amy, zz16, sunshine, Candyaner)
 * @brief risv-v处理器最高顶层文件，包含内核和dram和irom
 * @version 0.4
 * @date 2021-12-19
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"
/**
 * 如何运行c语言代码
 * 1. 写一个简单的c程序（修改riscv_test.c文件就好了）
 * 2. 运行complier.bat批处理脚本（1包含.c文件编译2生成反汇编3生产指令bin文件4用coeGen.exe把bin文件转换成coe文件）
 * 3. 把coe文件放入imem模块中，再次预综合更新一下
 * 4. 注意反汇编文件中的main函数起始地址，注意修改参数PC_START_ADDR，这对于cpu迈出第一步十分关键
 * 5. 注意对 dmem 大小的控制，默认为1k（起始完全可以在小一些）
 */
module rvtop(
    input wire clk_i,
    input wire rst_i,

    output wire tmds_clk_p,    // TMDS 时钟通道
    output wire tmds_clk_n,
    output wire [2:0]tmds_data_p,   // TMDS 数据通道
    output wire [2:0]tmds_data_n,

    output wire uart_txd
    );

    /* 时钟复位信号线 */
    wire sys_clk;
    wire pixel_clock;
    wire pixel_clockx5;
    wire sys_rst;
    wire locked;
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
    /* bootloader信号线 */
    wire [5:0]blAddr;
    wire [`MEM_BUS]blDout;
    /* imem信号线 */
    wire [`InstAddrBus]imemAddr;
    wire [`MEM_BUS]imemDout;
    /* dmem信号线 */
    wire dmemEn;
    wire dmemWea;
    wire [9:0]dmemAddr;
    wire [`MEM_BUS]dmemDin;
    wire [`MEM_BUS]dmemDout;
    /* gmem信号线 */
    wire gmemEn;
    wire gmemWea;
    wire [14:0]gmemAddr;
    wire [15:0]gmemWData;
    /* uart信号线 */
    wire uartEn;
    wire uartWea;
    wire [7:0]uartWData;

    /* 对dmem地址重映射到0-256地址中 */
    assign imemAddr = pc-32'h00010000;
    assign blAddr = pc[7:2];
    assign inst = (pc>32'h00010000)?imemDout:blDout;
    assign sys_rst = locked & rst_i;

    hcc hcc_init(
        .resetn(rst_i),
        .clk_i(clk_i),
        // Clock out ports
        .systick(sys_clk),     // output systick
        .pixel_clock(pixel_clock),     // output pixel_clock
        .pixel_clockx5(pixel_clockx5),     // output pixel_clockx5

        .locked(locked)       // output locked
    );   

    /* 实例化risc-v总线 */
    rbus rbus_inst(
        .rst_i(sys_rst),
        .m_addr_i(alu),                 // 主设备的读写地址
        .m_data_i(DataW),               // 主设备的写数据
        .m_data_o(mem),                 // 主设备读取到的数据
        .m_writeFlag_i(MemRW),          // 主设备写标志
    //从设备 
        .s1_en_o(dmemEn), 
        .s1_addr_o(dmemAddr),           // 从设备1的片选信号
        .s1_data_o(dmemDin),            // 从设备1的写数据
        .s1_data_i(dmemDout),           // 从设备1读取到的数据
        .s1_writeFlag_o(dmemWea),       // 从设备1写标志
 
        .s2_en_o(gmemEn),               // 从设备2的片选信号
        .s2_addr_o(gmemAddr),           // 从设备2的读写地址
        .s2_data_o(gmemWData),          // 从设备2的写数据
        .s2_writeFlag_o(gmemWea),       // 从设备2写标志
 
        .s3_en_o(uartEn),               // 从设备2的片选信号
        .s3_data_o(uartWData),          // 从设备2的写数据
        .s3_writeFlag_o(uartWea)        // 从设备2写标志
    );

    
    /* bootloader：将程序起始地址（10054）写入sp0寄存器中，并跳转到起始地址 */
    bootloader bootloader_inst(
        .a(blAddr),
        .spo(blDout)
    );

    /* 将imem和dmem的存储器合二为一，实现与编译器无缝衔接 */
    memory memory_4kB (
        .clk(sys_clk),    
        /* dmem端口 */
        .a(dmemAddr),      
        .d(dmemDin),       
        .we(dmemWea&dmemEn),     
        .spo(dmemDout),    
        /* imem端口 */
        .dpra(imemAddr[11:2]),  // input wire [9 : 0] dpra
        .dpo(imemDout)    // output wire [31 : 0] dpo
    );

    /* 外设1：hdmi接口 */
    hdmi_top hdmi0(
        /* 时钟复位信号输入端口 */
        .sys_clk_i(sys_clk),
        .pixel_clk(pixel_clock),
        .pixel_clk_5x(pixel_clockx5),
        .rst_i(sys_rst),
        /* 显存写入端口 */
        .gmemEn_i(gmemEn),
        .gmemWEn_i(gmemWea),
        .gmemAddr_i(gmemAddr),
        .gmemWData_i(gmemWData),
        /* hdmi信号输出端口 */
        .tmds_clk_p(tmds_clk_p),    
        .tmds_clk_n(tmds_clk_n),
        .tmds_data_p(tmds_data_p),   
        .tmds_data_n(tmds_data_n)
    );

    /* 外设2：uart串口 */
    uart_top uart0(
        /* 时钟复位信号输入端口 */
        .clk_i(sys_clk),
        .sys_rst_n(sys_rst),
        /* 串口写入端口 */
        .uartWData(uartWData),
        .uart_start(uartEn),
        .uartWen(uartWea),
        /* 串口信号输出 */
        .uart_txd(uart_txd)
    );

    /* 实例化risc-v内核模块 */ 
    rv_core rv_core_inst(
        .clk_i(sys_clk),
        .rst_i(sys_rst),

        .pc_o(pc),
        .inst_i(inst),
        
        .mem_i(mem),
        .DataW_o(DataW),
        .alu_o(alu),
        .MemRW_o(MemRW)
    );
endmodule
