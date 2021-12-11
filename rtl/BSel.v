/**
 * @file ImmGen.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 根据指令类型的不同，选择输出是立即数还是reg数据
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module BSel(
    input wire [`BSEL_BUS]BSel_i,              // 配置通路选择的输入
    input wire [`BSEL_BUS]REGBSel_i,

    input wire [`RegBus]DataD_i,
    input wire [`RegBus]alu_i,
    input wire [`RegBus]DataB_i,    // 数据B输入
    input wire [`RegBus]Imm_i,      // 立即数输入
    
    output reg [`RegBus]RegDataB_o,
    output reg [`RegBus]DataB_o     // 选择输出
    );

always @(*) 
begin
    case (BSel_i)
        `BSEL_REG:
        begin
            DataB_o = DataB_i;
        end
        `BSEL_IMM:  
        begin
            DataB_o = Imm_i;
        end 
        `BSEL_ALU:
        begin
            DataB_o = alu_i;
        end  
        `BSEL_DATAD: 
        begin
            DataB_o = DataD_i;
        end
        default: 
        begin
            DataB_o = DataB_i;
        end
    endcase
end

always @(*) 
begin
    case (REGBSel_i)
        `BSEL_ALU:
        begin
            RegDataB_o = alu_i;
        end  
        `BSEL_DATAD: 
        begin
            RegDataB_o = DataD_i;
        end
        default: 
        begin
            RegDataB_o = DataB_i;
        end
    endcase
end
endmodule
