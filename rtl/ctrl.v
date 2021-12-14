/**
 * @file ctrl.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief risc-v根据命令，配置各个模块的控制通路
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"
`include "riscv_codetable.v"

module ctrl(
    /* 指令输入 */
    input wire[`INST_CTRL_BUS] inst_i,              
    /* 控制输出 */
    output wire PCSel_o,                     //program counter register select(output)
    output wire [`IMMSEL_BUS]ImmSel_o,       //immidiate number select(output)
    output wire BrUn_o,                      //branch unisgned(output)
    output wire ASel_o,                      //register1 select(output)
    output wire BSel_o,                      //register2 select(output)
    output wire [`ALUSEL_BUS]ALUSel_o,       //ALU function select(output)
    output wire MemRW_o,                     //memory read/write(output)
    output wire RegWEn_o,                    //register write enable(output)
    output wire [`WBSEL_BUS]WBSel_o          //write back select(output)
    );
    /* 分割指令的各部分 */
    /* 运算指令由下面三部分确定 */
    wire[4:0]   opcode = inst_i[4:0];
    wire[2:0]   funct3 = inst_i[7:5];
    wire        funct7 = inst_i[8];
    
    assign PCSel_o =    (opcode == `INST_JAL||opcode == `INST_JALR)?`PCSEL_ALU:`PCSEL_ADD4;
    assign ImmSel_o =   (opcode == `INST_TYPE_I || opcode == `INST_TYPE_L || opcode == `INST_JALR)?`IMMSEL_I_TYPE:
                        (opcode == `INST_LUI || opcode == `INST_AUIPC)?`IMMSEL_U_TYPE:
                        (opcode == `INST_TYPE_S)?`IMMSEL_S_TYPE:
                        (opcode == `INST_TYPE_B)?`IMMSEL_B_TYPE:
                        (opcode == `INST_JAL)?`IMMSEL_J_TYPE:`IMMSEL_DEFAULT;
    assign BrUn_o =     (opcode != `INST_TYPE_B)?`BRUN_DEFAULT:
                        (funct3 == `INST_BLTU || funct3 == `INST_BGEU)?`BRUN_UNSIGNED:`BRUN_SIGNED;
    assign ASel_o =     (opcode == `INST_TYPE_B||opcode == `INST_JAL||
                         opcode == `INST_LUI||opcode == `INST_AUIPC)?`ASEL_PC:`ASEL_REG;
    assign BSel_o =     (opcode == `INST_TYPE_R_M)?`BSEL_REG:`BSEL_IMM;
    assign MemRW_o =    (opcode == `INST_TYPE_S)?`MEMRW_STORE:`MEMRW_LOAD;
    assign RegWEn_o =   (opcode == `INST_TYPE_S||opcode == `INST_TYPE_B)?`REGWEN_DISABLE:`REGWEN_ENABLE;
    assign WBSel_o =    (opcode == `INST_TYPE_L)?`WBSEL_MEM:
                        (opcode == `INST_JAL||opcode == `INST_JALR)?`WBSEL_PCADD4:`WBSEL_ALU;
    assign ALUSel_o =   (opcode == `INST_TYPE_R_M || opcode == `INST_TYPE_I)?(
                        (opcode == `INST_TYPE_R_M && funct3 == `INST_ADD_SUB && funct7 == `FUNCT7_LOW ||
                            opcode == `INST_TYPE_I && funct3 == `INST_ADD_SUB)?`ALUSEL_ADD:
                        (opcode == `INST_TYPE_R_M && funct3 == `INST_ADD_SUB && funct7 == `FUNCT7_HIGH)?`ALUSEL_SUB:
                        (funct3 == `INST_SLL)?`ALUSEL_SLL:
                        (funct3 == `INST_SLT)?`ALUSEL_SLT:
                        (funct3 == `INST_SLTU)?`ALUSEL_SLTU:
                        (funct3 == `INST_XOR)?`ALUSEL_XOR:
                        (funct3 == `INST_SR && funct7 == `FUNCT7_LOW)?`ALUSEL_SRL:
                        (funct3 == `INST_SR && funct7 == `FUNCT7_HIGH)?`ALUSEL_SRA:
                        (funct3 == `INST_OR)?`ALUSEL_OR:
                        (funct3 == `INST_AND)?`ALUSEL_AND:`ALUSEL_DEFAULT):`ALUSEL_ADD;
endmodule
