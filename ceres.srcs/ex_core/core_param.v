/**
 * @file core_param.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risc-v内核参数的宏定义包含文件
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

/* 重要配置参数，可修改 */
`define PC_START_ADDR   32'h00010054         
`define DMEM_SIZE       128

/* BUS length */
`define RegAddrBus      4:0
`define RegBus          31:0
`define MEM_BUS         31:0
`define MEMAddrBus      31:0
`define InstAddrBus     31:0
`define IMEM_BUS        7:0 
`define IMM_BUS         11:0
`define INST_BUS        8:0
`define IMMSEL_BUS      2:0
`define ALUSEL_BUS      3:0
`define WBSEL_BUS       1:0

/* PC-Register options */
`define JumpEnable      1'b1
`define JumpDisable     1'b0
`define HoldEnable      1'b1
`define HoldDisable     1'b0
`define ZeroReg         5'b00000
`define ZeroWord        32'h00000000

`define RegWidth        32          // 寄存器数据长度
`define MemWidth        32          // 存储器数据长度
`define MemAddrWidth    32          // 存储器地址长度     
`define InstWidth       32          // risc-v标准指令长度
`define ImmWidth        12          // I-type立即数的长度
`define RegNum          32

/* 1. branch equal(input) options */
`define BREQ_BNE        1'b0
`define BREQ_BEQ        1'b1

/* 2. branch less-than(input) options */
`define BRLT_BGE_BGEU   1'b0
`define BRLT_BLT_BLTU   1'b1

/* 3. program counter register select(output) options */
`define PCSEL_ADD4      1'b0
`define PCSEL_ALU       1'b1
`define PCSEL_DEFAULT   1'b0

/* 4. immidiate number select(output) options */
`define IMMSEL_I_TYPE   3'b000 
`define IMMSEL_S_TYPE   3'b001
`define IMMSEL_B_TYPE   3'b010
`define IMMSEL_J_TYPE   3'b011
`define IMMSEL_R_TYPE   3'b100
`define IMMSEL_U_TYPE   3'b101
`define IMMSEL_DEFAULT  3'b000

/* 5. branch unisgned(output) options */
`define BRUN_SIGNED     1'b0
`define BRUN_UNSIGNED   1'b1
`define BRUN_DEFAULT    1'b0

/* 6. register1 select(output) options */
`define ASEL_REG        1'b0
`define ASEL_PC         1'b1
`define ASEL_DEFAULT    1'b0

/* 7. register2 select(output) options */
`define BSEL_REG        1'b0
`define BSEL_IMM        1'b1
`define BSEL_DEFAULT    1'b0

/* 8. ALU function select(output) options */
`define ALUSEL_ADD      4'b0000
`define ALUSEL_SUB      4'b0001
`define ALUSEL_XOR      4'b0010
`define ALUSEL_OR       4'b0011
`define ALUSEL_AND      4'b0100
`define ALUSEL_SLL      4'b0101
`define ALUSEL_SRL      4'b0110
`define ALUSEL_SRA      4'b0111
`define ALUSEL_SLT      4'b1001
`define ALUSEL_SLTU     4'b1010
`define ALUSEL_DEFAULT  4'b0000

/* 9. memory read/write(output) options */
`define MEMRW_LOAD      1'b0
`define MEMRW_STORE     1'b1
`define MEMRW_DEFAULT   1'b0

/* 10. register write enable(output) options */
`define REGWEN_ENABLE   1'b1
`define REGWEN_DISABLE  1'b0
`define REGWEN_DEFAULT  1'b0

/* 11. write back select(output) options */
`define WBSEL_MEM       2'b00
`define WBSEL_ALU       2'b01
`define WBSEL_PCADD4    2'b10
`define WBSEL_DEFAULT   2'b00

/* others */
`define FUNCT7_LOW      1'b0
`define FUNCT7_HIGH     1'b1
`define RESET_ENABLE    1'b0


