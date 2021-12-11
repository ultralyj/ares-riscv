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
`include "risc_v_codetable.v"

module ctrl(
    /* 指令输入 */
    input wire[`INST_BUS] inst_i,              
    /* 控制输入 */
    input wire BrEq_i,                      //branch equal(input)
    input wire BrLt_i,                      //branch less-than(input)
    /* 控制输出 */
    output reg PCSel_o,                     //program counter register select(output)
    output reg [`IMMSEL_BUS]ImmSel_o,       //immidiate number select(output)
    output reg BrUn_o,                      //branch unisgned(output)
    output reg [`ASEL_BUS]ASel_o,                      //register1 select(output)
    output reg [`BSEL_BUS]BSel_o,                      //register2 select(output)
    output reg [`ALUSEL_BUS]ALUSel_o,       //ALU function select(output)
    output reg MemRW_o,                     //memory read/write(output)
    output reg RegWEn_o,                    //register write enable(output)
    output reg [`WBSEL_BUS]WBSel_o          //write back select(output)
    );
    /* 分割指令的各部分 */
    /* 运算指令由下面三部分确定 */
    wire[4:0]   opcode = inst_i[4:0];
    wire[2:0]   funct3 = inst_i[7:5];
    wire        funct7 = inst_i[8];
    
    always @(*) 
    begin
        case (opcode)
            `INST_TYPE_R_M:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_DEFAULT;
                ASel_o = `ASEL_REG;
                BSel_o = `BSEL_REG;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_ALU;
                case (funct3)
                    `INST_ADD_SUB:
                    begin
                        case (funct7)
                            `FUNCT7_LOW: 
                                ALUSel_o = `ALUSEL_ADD;
                            `FUNCT7_HIGH:
                                ALUSel_o = `ALUSEL_SUB;
                            default: 
                            begin
                                ALUSel_o = `ALUSEL_DEFAULT;
                            end
                        endcase
                    end 
                    `INST_SLL:
                    begin
                        ALUSel_o = `ALUSEL_SLL;
                    end
                    `INST_SLT:
                    begin
                        ALUSel_o = `ALUSEL_SLT;
                    end
                    `INST_SLTU:
                    begin
                        ALUSel_o = `ALUSEL_SLTU;
                    end     
                    `INST_XOR:
                    begin
                        ALUSel_o = `ALUSEL_XOR;
                    end 
                    `INST_SR:
                    begin
                        case (funct7)
                            `FUNCT7_LOW: 
                                ALUSel_o = `ALUSEL_SRL;
                            `FUNCT7_HIGH:
                                ALUSel_o = `ALUSEL_SRA;
                            default: 
                            begin
                                ALUSel_o = `ALUSEL_DEFAULT;
                            end
                        endcase
                    end 
                    `INST_OR:
                    begin
                        ALUSel_o = `ALUSEL_OR;
                    end

                    `INST_AND:
                    begin
                        ALUSel_o = `ALUSEL_AND;
                    end 
                    default: 
                    begin
                        ALUSel_o = `ALUSEL_DEFAULT;
                    end
                endcase
            end
            `INST_TYPE_I:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_I_TYPE;
                ASel_o = `ASEL_REG;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_ALU;
                case (funct3)
                    `INST_ADDI:
                    begin
                        ALUSel_o = `ALUSEL_ADD;
                    end
                        
                    `INST_SLTI:
                    begin
                        ALUSel_o = `ALUSEL_SLT;
                    end 
                    `INST_SLTIU:
                    begin
                        ALUSel_o = `ALUSEL_SLTU;
                    end 
                    `INST_XORI:
                    begin
                        ALUSel_o = `ALUSEL_XOR;
                    end
                    `INST_ORI:
                    begin
                        ALUSel_o = `ALUSEL_OR;
                    end
                    `INST_ANDI:
                    begin
                        ALUSel_o = `ALUSEL_AND;
                    end 
                    `INST_SLLI:
                    begin
                        ALUSel_o = `ALUSEL_SLL;
                    end
                    `INST_SRI: 
                    begin
                        case (funct7)
                            `FUNCT7_LOW: 
                                ALUSel_o = `ALUSEL_SRL;
                            `FUNCT7_HIGH:
                                ALUSel_o = `ALUSEL_SRA;
                            default: 
                            begin
                                ALUSel_o = `ALUSEL_DEFAULT;
                            end
                        endcase
                    end
                    default: 
                    begin
                        ALUSel_o = `ALUSEL_DEFAULT;
                    end
                endcase
            end
            `INST_TYPE_L:
            begin
                case (funct3)
                    `INST_LB, `INST_LH, `INST_LW, `INST_LBU, `INST_LHU: 
                    begin
                        BrUn_o = `BRUN_DEFAULT;
                        PCSel_o = `PCSEL_ADD4;
                        ImmSel_o = `IMMSEL_I_TYPE;
                        ASel_o = `ASEL_REG;
                        BSel_o = `BSEL_IMM;
                        ALUSel_o = `ALUSEL_ADD;
                        MemRW_o = `MEMRW_LOAD;
                        RegWEn_o = `REGWEN_ENABLE;
                        WBSel_o = `WBSEL_MEM;
                    end
                    default: 
                    begin
                        BrUn_o = `BRUN_DEFAULT;
                        PCSel_o = `PCSEL_DEFAULT;
                        ImmSel_o = `IMMSEL_DEFAULT;
                        ASel_o = `ASEL_DEFAULT;
                        BSel_o = `BSEL_DEFAULT;
                        ALUSel_o = `ALUSEL_DEFAULT;
                        MemRW_o = `MEMRW_DEFAULT;
                        RegWEn_o = `REGWEN_DEFAULT;
                        WBSel_o = `WBSEL_DEFAULT;
                    end
                endcase
            end
            `INST_TYPE_S:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_S_TYPE;
                ASel_o = `ASEL_REG;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_STORE;
                RegWEn_o = `REGWEN_DISABLE;
                WBSel_o = `WBSEL_DEFAULT;
                case (funct3)
                    `INST_SB, `INST_SW, `INST_SH: 
                    begin
                        MemRW_o = `MEMRW_STORE;
                    end
                    default: 
                    begin
                        MemRW_o = `MEMRW_STORE;
                    end
                endcase
            end
            `INST_TYPE_B:
            begin
                //PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_B_TYPE;
                ASel_o = `ASEL_PC;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_DISABLE;
                WBSel_o = `WBSEL_DEFAULT;
                case (funct3)
                    `INST_BEQ:
                    begin
                        BrUn_o = `BRUN_DEFAULT;
                        case (BrEq_i)
                            `BREQ_BNE: 
                            begin
                                PCSel_o = `PCSEL_ADD4;
                            end
                            `BREQ_BEQ:
                            begin
                                PCSel_o = `PCSEL_ALU;
                            end
                            default: 
                            begin
                                PCSel_o = `PCSEL_DEFAULT;
                            end
                        endcase
                    end
                    `INST_BNE:
                    begin
                        BrUn_o = `BRUN_DEFAULT;
                        case (BrEq_i)
                            `BREQ_BNE: 
                            begin
                                PCSel_o = `PCSEL_ALU;
                            end
                            `BREQ_BEQ:
                            begin
                                PCSel_o = `PCSEL_ADD4;
                            end
                            default: 
                            begin
                                PCSel_o = `PCSEL_DEFAULT;
                            end
                        endcase
                    end
                    `INST_BLT:
                    begin
                        BrUn_o = `BRUN_SIGNED;
                        case (BrLt_i)
                            `BRLT_BGE_BGEU: 
                                PCSel_o = `PCSEL_ADD4;
                            `BRLT_BLT_BLTU:
                                PCSel_o = `PCSEL_ALU;
                            default: 
                            begin
                                PCSel_o = `PCSEL_DEFAULT;
                            end
                        endcase
                    end 

                    `INST_BLTU:
                    begin
                        BrUn_o = `BRUN_UNSIGNED;
                        case (BrLt_i)
                            `BRLT_BGE_BGEU: 
                                PCSel_o = `PCSEL_ADD4;
                            `BRLT_BLT_BLTU:
                                PCSel_o = `PCSEL_ALU;
                            default: 
                            begin
                                PCSel_o = `PCSEL_DEFAULT;
                            end
                        endcase
                    end 

                    `INST_BGE:
                    begin
                        BrUn_o = `BRUN_SIGNED;
                        case (BrLt_i)
                            `BRLT_BGE_BGEU: 
                                PCSel_o = `PCSEL_ALU;
                            `BRLT_BLT_BLTU:
                                PCSel_o = `PCSEL_ADD4;
                            default: 
                            begin
                                PCSel_o = `PCSEL_DEFAULT;
                            end
                        endcase
                    end
                    `INST_BGEU: 
                    begin
                        BrUn_o = `BRUN_UNSIGNED;
                        case (BrLt_i)
                            `BRLT_BGE_BGEU: 
                                PCSel_o = `PCSEL_ALU;
                            `BRLT_BLT_BLTU:
                                PCSel_o = `PCSEL_ADD4;
                            default: 
                            begin
                            PCSel_o = `PCSEL_DEFAULT; 
                            end
                        endcase
                    end
                    default: 
                    begin
                        BrUn_o = `BRUN_DEFAULT;
                        PCSel_o = `PCSEL_DEFAULT;
                    end
                endcase
            end
            /* J-type(用于无条件操作) */
            `INST_JAL:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ALU;
                ImmSel_o = `IMMSEL_J_TYPE;
                ASel_o = `ASEL_PC;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_PCADD4;
            end
            /* 以下为其他指令 */
            `INST_JALR:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ALU;
                ImmSel_o = `IMMSEL_I_TYPE;
                ASel_o = `ASEL_REG;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_PCADD4;
            end
            `INST_LUI:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_U_TYPE;
                ASel_o = `ASEL_PC;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_ALU;
            end
            `INST_AUIPC:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_U_TYPE;
                ASel_o = `ASEL_PC;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_ALU;
            end
            `INST_FENCE:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_I_TYPE;
                ASel_o = `ASEL_REG;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_ALU;
            end
            `INST_CSR:
            begin
                BrUn_o = `BRUN_DEFAULT;
                PCSel_o = `PCSEL_ADD4;
                ImmSel_o = `IMMSEL_I_TYPE;
                ASel_o = `ASEL_REG;
                BSel_o = `BSEL_IMM;
                ALUSel_o = `ALUSEL_ADD;
                MemRW_o = `MEMRW_LOAD;
                RegWEn_o = `REGWEN_ENABLE;
                WBSel_o = `WBSEL_ALU;
                case (funct3)
                    `INST_CSRRW, `INST_CSRRS, `INST_CSRRC: 
                    begin
                        
                    end
                    `INST_CSRRWI, `INST_CSRRSI, `INST_CSRRCI: 
                    begin
                        
                    end
                    default: 
                    begin
                        
                    end
                endcase
            end
            
            default: 
                begin
                    /* 全部设为不定态 */
                    BrUn_o = `BRUN_DEFAULT;
                    PCSel_o = `PCSEL_DEFAULT;
                    ImmSel_o = `IMMSEL_DEFAULT;
                    ASel_o = `ASEL_DEFAULT;
                    BSel_o = `BSEL_DEFAULT;
                    ALUSel_o = `ALUSEL_DEFAULT;
                    MemRW_o = `MEMRW_DEFAULT;
                    RegWEn_o = `REGWEN_DEFAULT;
                    WBSel_o = `WBSEL_DEFAULT;
                end
        endcase
    end
    
endmodule
