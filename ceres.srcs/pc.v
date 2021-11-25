/**
 * @file pc.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 控制pc指针指向的地址
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

/* Program Counter */
module pc(
    input wire clk_i,                       // 时钟信号
    input wire[`InstAddrBus] jump_addr_i,   // 跳转地址
    input wire PCSel_i,                     
    output reg[`InstAddrBus] pc_o           // PC指针
    );

initial 
    begin
        pc_o = `ZeroWord;        
    end

always @(posedge clk_i) 
begin
    if (PCSel_i == `PCSEL_ALU) 
    begin
        pc_o = jump_addr_i;
    end 
    else 
    /* 指令递增 */
    begin
        pc_o = pc_o + 4'h4;
    end        
end

endmodule
