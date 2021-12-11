/**
 * @file risc_v_codetable.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risc-v内核指令一些部分的宏定义
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`define INST_JAL        5'b11011
`define INST_JALR       5'b11001

`define INST_LUI        5'b01101
`define INST_AUIPC      5'b00101

`define INST_NOP_OP     5'b00000
`define INST_FENCE      5'b00011

`define INST_TYPE_R_M   5'b01100
`define INST_TYPE_I     5'b00100
`define INST_TYPE_L     5'b00000
`define INST_TYPE_S     5'b01000
`define INST_TYPE_B     5'b11000
`define INST_CSR        5'b11100

/* R-type 指令 funct3 */
`define INST_ADD_SUB    3'b000
`define INST_SLL        3'b001
`define INST_SLT        3'b010
`define INST_SLTU       3'b011
`define INST_XOR        3'b100
`define INST_SR         3'b101
`define INST_OR         3'b110
`define INST_AND        3'b111   

/* I-type 指令 funct3 */
`define INST_ADDI       3'b000
`define INST_SLTI       3'b010
`define INST_SLTIU      3'b011
`define INST_XORI       3'b100
`define INST_ORI        3'b110
`define INST_ANDI       3'b111
`define INST_SLLI       3'b001
`define INST_SRI        3'b101

/* L-type 指令 funct3 */
`define INST_LB         3'b000
`define INST_LH         3'b001
`define INST_LW         3'b010
`define INST_LBU        3'b100
`define INST_LHU        3'b101

/* S-type 指令 funct3 */
`define INST_SB         3'b000
`define INST_SH         3'b001
`define INST_SW         3'b010

/* B-type 指令 funct3 */
`define INST_BEQ        3'b000
`define INST_BNE        3'b001
`define INST_BLT        3'b100
`define INST_BGE        3'b101
`define INST_BLTU       3'b110
`define INST_BGEU       3'b111

/* csr 指令 funct3 */
`define INST_CSRRW      3'b001
`define INST_CSRRS      3'b010
`define INST_CSRRC      3'b011
`define INST_CSRRWI     3'b101
`define INST_CSRRSI     3'b110
`define INST_CSRRCI     3'b111