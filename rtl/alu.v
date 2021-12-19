/**
 * @file alu.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 实现一些基本运算，operate DataA and DataB based on method ALUSel gives
 *          excute cmd below:
 *              1.ADD 2.SUB 3.AND 4.OR 5.XOR
 *              6.SLL 7.SRL 8.SRA 9.SLT 10.SLTU
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module alu(
    input wire signed [`RegBus]DataA_i,     // 操作数A输入[31:0]        
    input wire signed [`RegBus]DataB_i,     // 操作数B输入[31:0]
    input wire [`ALUSEL_BUS]ALUSel_i,       // 运算方式选择[3:0]
    
    output reg signed [`RegBus]alu_o        // 运算结果[31:0]
    );

    /* 定义运算的中间过程 */
    wire Compare_Signed;
    wire Compare_Unsigned;
    wire [`RegBus]SR_Shift;
    wire [`RegBus]SR_DataB_Mask;

    /* 乘法中间过程 */
    wire[`DoubleRegBus] mul_temp;
    wire[`DoubleRegBus] mul_temp_invert;
    reg[`RegBus] mul_op1;
    reg[`RegBus] mul_op2;
    wire [`RegBus]DataA_invert;
    wire [`RegBus]DataB_invert;

    /* 用实现一些复杂运算的中间过程 */
    assign Compare_Signed = $signed(DataA_i) >= $signed(DataB_i);
    assign Compare_Unsigned = DataA_i >= DataB_i;
    assign SR_Shift = DataA_i >> DataB_i[4:0];
    assign SR_DataB_Mask = 32'hffffffff >> DataB_i[4:0];
    /* 乘法 */
    assign mul_temp = mul_op1 * mul_op2;
    assign mul_temp_invert = ~mul_temp + 1;
    assign DataA_invert = ~DataA_i + 1;
    assign DataB_invert = ~DataB_i + 1;

    always @(*) 
    begin
        // if(ALUSel_i[3:2] == 2'b11)
        // begin
        //     case(ALUSel_i)
        //         `ALUSEL_MUL:    // 算数乘法，取低位
        //         begin
        //             mul_op1 <= DataA_i;
        //             mul_op2 <= DataB_i;
        //             alu_o <= mul_temp[31:0];
        //         end
        //         `ALUSEL_MULH:   // 有符号数*有符号数，取高位
        //         begin
        //             mul_op1 <= (DataA_i[31] == 1'b1)? (DataA_invert): DataA_i;
        //             mul_op2 <= (DataB_i[31] == 1'b1)? (DataB_invert): DataB_i;
        //             case ({DataA_i[31], DataB_i[31]})
        //                 2'b00: begin
        //                     alu_o <= mul_temp[63:32];
        //                 end
        //                 2'b11: begin
        //                     alu_o <= mul_temp[63:32];
        //                 end
        //                 2'b10: begin
        //                     alu_o <= mul_temp_invert[63:32];
        //                 end
        //                 default: begin
        //                     alu_o <= mul_temp_invert[63:32];
        //                 end
        //             endcase
        //         end
        //         `ALUSEL_MULHU:  //算数乘法，取高位
        //         begin
        //             mul_op1 <= DataA_i;
        //             mul_op2 <= DataB_i;
        //             alu_o <= mul_temp[63:32];
        //         end
        //         `ALUSEL_MULHSU: //有符号数*无符号数，取高位
        //         begin
        //             mul_op1 <= (DataA_i[31] == 1'b1)? (DataA_invert): DataA_i;
        //             mul_op2 <= DataB_i;
        //             if (DataA_i[31] == 1'b1) begin
        //                 alu_o <= mul_temp_invert[63:32];
        //             end else begin
        //                 alu_o <= mul_temp[63:32];
        //             end
        //         end
        //         default:
        //         begin
        //             mul_op1 <= `ZeroWord;
        //             mul_op2 <= `ZeroWord;
        //             alu_o <= mul_temp[31:0];
        //         end
        //     endcase  
        // end
        // else
        begin
            mul_op1 <= `ZeroWord;
            mul_op2 <= `ZeroWord;
            case (ALUSel_i)
                `ALUSEL_ADD:    // 加法
                begin
                    alu_o <= DataA_i + DataB_i;
                end   
                `ALUSEL_SUB:   // 减法
                begin
                    alu_o <= DataA_i - DataB_i;
                end  
                `ALUSEL_AND:   // 逻辑与（位运算）
                begin
                    alu_o <= DataA_i & DataB_i;
                end  
                `ALUSEL_OR:   // 逻辑或（位运算）
                begin
                    alu_o <= DataA_i | DataB_i;
                end  
                `ALUSEL_XOR:  // 逻辑异或（位运算）
                begin
                    alu_o <= DataA_i ^ DataB_i;
                end   
                `ALUSEL_SLL:    // 逻辑左移（低位补零）
                begin
                    alu_o <= DataA_i << DataB_i[4:0];
                end  
                `ALUSEL_SRL:    // 逻辑右移（高位补零）
                begin
                    alu_o <= DataA_i >> DataB_i[4:0];
                end   
                `ALUSEL_SRA:    // 算数右移（高位用第一位填充）   
                begin
                    alu_o <= (SR_Shift & SR_DataB_Mask) | ({32{DataA_i[31]}} & (~SR_DataB_Mask));
                end  
                `ALUSEL_SLT:    // 符号数比较(A小于B返回1)
                begin
                    alu_o <= {32{(~Compare_Signed)}} & 32'h1;
                end    
                `ALUSEL_SLTU:   // 无符号数比较(A小于B返回1)
                begin
                    alu_o <= {32{(~Compare_Unsigned)}} & 32'h1;
                end  
                
                `ALUSEL_B:
                begin
                    alu_o <= DataB_i;
                end
                default: 
                begin
                    alu_o <= `ZeroWord;
                end  
            endcase    
        end  
    end
endmodule
