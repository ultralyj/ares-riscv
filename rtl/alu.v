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

    /* 用实现一些复杂运算的中间过程 */
    assign Compare_Signed = $signed(DataA_i) >= $signed(DataB_i);
    assign Compare_Unsigned = DataA_i >= DataB_i;
    assign SR_Shift = DataA_i >> DataB_i[4:0];
    assign SR_DataB_Mask = 32'hffffffff >> DataB_i[4:0];

    always @(*) 
    begin
        case (ALUSel_i)
            `ALUSEL_ADD:    // 加法
            begin
                alu_o = DataA_i + DataB_i;
            end   
            `ALUSEL_SUB:   // 减法
            begin
                alu_o = DataA_i - DataB_i;
            end  
            `ALUSEL_AND:   // 逻辑与（位运算）
            begin
                alu_o = DataA_i & DataB_i;
            end  
            `ALUSEL_OR:   // 逻辑或（位运算）
            begin
                alu_o = DataA_i | DataB_i;
            end  
            `ALUSEL_XOR:  // 逻辑异或（位运算）
            begin
                alu_o = DataA_i ^ DataB_i;
            end   
            `ALUSEL_SLL:    // 逻辑左移（低位补零）
            begin
                alu_o = DataA_i << DataB_i[4:0];
            end  
            `ALUSEL_SRL:    // 逻辑右移（高位补零）
            begin
                alu_o = DataA_i >> DataB_i[4:0];
            end   
            `ALUSEL_SRA:    // 算数右移（高位用第一位填充）   
            begin
                alu_o = (SR_Shift & SR_DataB_Mask) | ({32{DataA_i[31]}} & (~SR_DataB_Mask));
            end  
            `ALUSEL_SLT:    // 符号数比较(A小于B返回1)
            begin
                alu_o = {32{(~Compare_Signed)}} & 32'h1;
            end    
            `ALUSEL_SLTU:   // 无符号数比较(A小于B返回1)
            begin
                alu_o = {32{(~Compare_Unsigned)}} & 32'h1;
            end  
            default: 
            begin
                alu_o = `ZeroWord;
            end  
        endcase    
    end
endmodule
