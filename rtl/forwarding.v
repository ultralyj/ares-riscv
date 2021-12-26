/**
 * @file forwarding.v
 * @author ARES Team.
 * @brief 实现前馈控制
 *          前馈控制置于cpu的译码级，接受来自E级的AddrD,RegWEn,DataD的输入
 *          当冲突发生时，用前级的数据替换D级的DataA,DataB以实现在不损失性能
 *          的前提下，避免冲突的发生。
 * @version 0.2
 * @date 2021-12-10
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module forwarding(
    /* 指令输入（获取DataA,DataB的地址） */
    input wire [`RegAddrBus]AddrA_di,
    input wire [`RegAddrBus]AddrB_di,
    /* 数据输入DataA,DataB,DataD(from S.E,S.M) */
    input wire [`RegBus]DataA_di,
    input wire [`RegBus]DataB_di,
    input wire [`RegBus]DataD_ei,
    input wire [`RegBus]DataD_mi,
    /* 地址和写入使能输入(from S.E,S.M) */
    input wire RegWEn_ei,
    input wire [`RegAddrBus]AddrD_ei,
    input wire RegWEn_mi,
    input wire [`RegAddrBus]AddrD_mi,
    /* 数据输出 */
    output wire [`RegBus]DataA_do,
    output wire [`RegBus]DataB_do,
    /* l-type指令必须插空 */
    input wire [`WBSEL_BUS]WBSel_ei,
    output wire pc_stopFlag_o
    );

    /* DataA的前馈控制 */
    /* 判断依据：前一个指令（在E级）写回寄存器（首先要有写回）
            和当前指令（D级）读出的寄存器地址相同且不为0 */
    /* 判断依据：前第二个指令（在M级）写回寄存器（首先要有写回）
            和当前指令（D级）读出的寄存器地址相同且不为0 */
    assign DataA_do = (RegWEn_ei && (AddrA_di == AddrD_ei) && AddrD_ei != `ZeroReg) ?
        (DataD_ei) : ((RegWEn_mi && (AddrA_di == AddrD_mi) && AddrD_mi != `ZeroReg) ?
        DataD_mi : DataA_di);

    /* DataB的前馈控制 */
    /* 判断依据：前一个指令（在E级）写回寄存器（首先要有写回）
            和当前指令（D级）读出的寄存器地址相同且不为0 */
    /* 判断依据：前第二个指令（在M级）写回寄存器（首先要有写回）
            和当前指令（D级）读出的寄存器地址相同且不为0 */
    assign DataB_do = (RegWEn_ei && (AddrB_di == AddrD_ei) && AddrD_ei != `ZeroReg) ?
        (DataD_ei) : ((RegWEn_mi && (AddrB_di == AddrD_mi) && AddrD_mi != `ZeroReg) ?
        DataD_mi : DataB_di);

    /* l-type的特殊前馈控制 */
    /* 如果D,E级发生了冲突，且E级的指令是一个l-type的指令，需要插入一个NOP指令
            具体做法是：
            1.PC停止一次； 
            2.F-D流水线寄存器不更新(保留D指令) 
            3.D-E流水线冲刷(将l-type后面的指令变成NOP指令)  */
    assign pc_stopFlag_o = (WBSel_ei == `WBSEL_MEM && ((AddrA_di == AddrD_ei) || ((AddrB_di == AddrD_ei))) && AddrD_ei != `ZeroReg) ?
                    `PC_STOP_ENABLE:`PC_STOP_DISABLE;
endmodule
 