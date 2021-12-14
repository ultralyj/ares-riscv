/**
 * @file BranchComp.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 分支比较模块
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module BranchComp(
    input wire BrUn_i,              // 无符号有符号标志位
    input wire [`RegBus]DataA_i,    // 比较数1
    input wire [`RegBus]DataB_i,    // 比较数2
    output wire BrEq_o,              // 等于标志位
    output wire BrLt_o               // 小于标志位
    );

    assign BrEq_o = (DataA_i == DataB_i)?`BREQ_BEQ:`BREQ_BNE;
    assign BrLt_o = (DataA_i == DataB_i)?`BRLT_BGE_BGEU:
                    ((BrUn_i == `BRUN_UNSIGNED)?
                    ((DataA_i < DataB_i)?`BRLT_BLT_BLTU:`BRLT_BGE_BGEU):
                    (((DataA_i[31] == 1'b1 && DataB_i[31]  == 1'b0)||
                        (DataA_i[31] == 1'b1 && DataB_i[31]  == 1'b1 && DataA_i > DataB_i)||
                        (DataA_i[31] == 1'b0 && DataB_i[31]  == 1'b0 && DataA_i < DataB_i))?
                        `BRLT_BLT_BLTU:`BRLT_BGE_BGEU));
    // always @(*) 
    // begin
    //     /* 1. 如果两个数相等，那么可以直接得到输出 */  
    //     if(DataA_i == DataB_i)
    //     begin
    //         BrEq_o <= `BREQ_BEQ;
    //         BrLt_o <= `BRLT_BGE_BGEU;
    //     end
    //     else 
    //     begin
    //         BrEq_o = `BREQ_BNE;
    //         /* 2.1 如果两个数不等且为无符号数，再进行一次比较得到输出 */
    //         if(BrUn_i == `BRUN_UNSIGNED)
    //         begin
    //             if(DataA_i < DataB_i)
    //             begin
    //                 BrLt_o <= `BRLT_BLT_BLTU;
    //             end
    //             else
    //             begin
    //                 BrLt_o <= `BRLT_BGE_BGEU;
    //             end
    //         end
    //         /* 2.2 如果两个数是有符号数比较，需要考虑符号再进行比较 */
    //         else
    //         begin
    //             if((DataA_i[31] == 1'b1 && DataB_i[31]  == 1'b0)||
    //             (DataA_i[31] == 1'b1 && DataB_i[31]  == 1'b1 && DataA_i > DataB_i)||
    //             (DataA_i[31] == 1'b0 && DataB_i[31]  == 1'b0 && DataA_i < DataB_i))
    //             begin
    //                 BrLt_o <= `BRLT_BLT_BLTU;
    //             end
    //             else
    //             begin
    //                 BrLt_o = `BRLT_BGE_BGEU;
    //             end
    //         end
    //     end
    // end
endmodule
