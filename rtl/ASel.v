/**
 * @file ImmGen.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 根据指令类型的不同，选择输出是pc地址还是reg数据
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module ASel(
    input wire [`ASEL_BUS]ASel_i,              // 配置通路选择的输入
    input wire [`RegBus]DataD_i,
    input wire [`RegBus]alu_i,
    input wire [`RegBus]DataA_i,    // 数据A输入
    input wire [`RegBus]pc_i,       // pc地址输入
    output reg [`RegBus]DataA_o     // 选择输出
    );

always @(*) 
begin
    case (ASel_i)
        `ASEL_REG:
        begin
            DataA_o = DataA_i;
        end
        `ASEL_PC:  
        begin
            DataA_o = pc_i;
        end 
        `ASEL_ALU:
        begin
            DataA_o = alu_i;
        end  
        `ASEL_DATAD: 
        begin
            DataA_o = DataD_i;
        end
        default: 
        begin
            DataA_o = DataA_i;
        end
    endcase
end
endmodule
