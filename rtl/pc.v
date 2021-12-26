/**
 * @file pc.v
 * @author ultralyj (1951578@tongji.edu.cn), SunShine.
 * @brief 控制pc指针指向的地址
 * @version 0.2
 * @date 2021-12-11
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

/* Program Counter */
module pc(
    input wire clk_i,                       // 时钟信号
    input wire rst_i,                       // 复位信号
    input wire[`InstAddrBus] jump_addr_i,   // 跳转地址
    input wire PCSel_i,     
    input wire pc_stopFlag_i,                
    output reg[`InstAddrBus] pc_o           // PC指针
    );

initial 
    begin
        pc_o <= `ZeroWord;        
    end

always @(posedge clk_i or negedge rst_i) 
begin
    if(rst_i == `RESET_ENABLE)
    begin
        pc_o <= `ZeroWord;
    end
    else 
    begin
        if(pc_stopFlag_i == `PC_STOP_ENABLE)
        /* 停下PC,准备插空指令 */
        begin
            pc_o <= pc_o;
        end
        else
        begin
            /* 跳转pc */
            if (PCSel_i == `PCSEL_ALU) 
            begin
                pc_o <= jump_addr_i;
            end 
            else 
            /* 指令递增 */
            begin
                pc_o <= pc_o + 32'h4;
            end  
        end    
    end          
end

endmodule

// /* Program Counter */
// module pc(
//     input wire clk_i,                       
//     input wire rst_i,                       
//     input wire[`InstAddrBus] jump_addr_i,                    
//     input wire pc_stopFlag_i,  

//     input wire[`InstAddrBus] JalTarget,    
//     //input wire[`InstAddrBus] JalrTarget,   
//     input wire[`InstAddrBus] BranchTarget, 
//     input wire BranchE,
//     input wire JalD,
//     input wire JalrE,
//     input wire BranchPredictedF,
//     input wire BranchPredictedE,
//     input wire BranchPredictedTakenF,
//     input wire BranchPredictedTakenE,
//     input wire[`InstAddrBus] BranchPredictedTargetF,

//     output reg[`InstAddrBus] pc_o          
//     );
    
// initial 
//     begin
//         pc_o <= `PC_START_ADDR;  
//     end

// always @(posedge clk_i or negedge rst_i) 
// begin
//     if(rst_i == `RESET_ENABLE)
//     begin
//         pc_o <= `PC_START_ADDR;
//     end
//     else 
//     begin
//         if(pc_stopFlag_i == `PC_STOP_ENABLE)
//        
//         begin
//             pc_o <= pc_o;
//         end
//         else if(JalrE == `PCSEL_ALU)
//         begin
//             pc_o <= jump_addr_i;
//             $display("PC:输入的跳转地址:%h",jump_addr_i);
//         end
//         else if(~BranchPredictedE && BranchE) 
//        
//         begin 
//             pc_o <= BranchTarget;
//             $display("PC:之前没预测或者预测不跳转，但实际跳转了:",BranchTarget);
//         end
// 		else if(BranchPredictedE && ~BranchE) 
// 		begin
//         
// 			pc_o <= pc_o + 32'h4;
// 			$display("PC:之前预测跳转，但实际不跳转:%h",pc_o);
// 	    end
//         else if(BranchPredictedF ) 
//         begin
// 			pc_o <= BranchPredictedTargetF;
// 			$display("PC:本次进行预测且预测跳转:%h",BranchPredictedTargetF);
// 		end
// 		else
//             pc_o <= pc_o + 32'h4;
//     end          
// end


// endmodule