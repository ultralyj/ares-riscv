/**
 * @file forwarding.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 实现前馈控制
 * @version 0.2
 * @date 2021-12-10
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module forwarding(
    input wire [`InstAddrBus]inst_di,
    input wire [`ASEL_BUS]ASel_di,
    input wire [`BSEL_BUS]BSel_di,

    input wire [`WBSEL_BUS]WBSel_ei,
    input wire RegWEn_ei,
    input wire [`RegAddrBus]AddrD_ei,

    input wire RegWEn_mi,
    input wire [`RegAddrBus]AddrD_mi,
    
    output reg [`ASEL_BUS] ASel_o,
    output reg [`BSEL_BUS] BSel_o,
    output reg [`BSEL_BUS] REGBSel_o,
    output reg pc_stopFlag_o
    );
    initial 
    begin
        ASel_o = `ASEL_REG;  
        BSel_o = `BSEL_REG;
        pc_stopFlag_o = `PC_STOP_DISABLE; 
    end
    /* 译码级寄存器地址 */
    wire[`RegAddrBus] rs1_D = inst_di[19:15];
    wire[`RegAddrBus] rs2_D = inst_di[24:20];
    always @(*) 
    begin
        if((ASel_di == `ASEL_REG) && RegWEn_ei && (rs1_D == AddrD_ei) && AddrD_ei != `ZeroReg)
        begin
            ASel_o = `ASEL_ALU;
        end
        else if((ASel_di == `ASEL_REG) && RegWEn_mi && (rs1_D == AddrD_mi) && AddrD_mi != `ZeroReg)
        begin
            ASel_o = `ASEL_DATAD;
        end
        else
        begin
            ASel_o = ASel_di;
        end
    end

    always @(*) 
    begin
        if((BSel_di == `BSEL_REG) && RegWEn_ei && (rs2_D == AddrD_ei) && AddrD_ei != `ZeroReg)
        begin
            BSel_o = `BSEL_ALU;
        end
        else if((BSel_di == `BSEL_REG) && RegWEn_mi && (rs2_D == AddrD_mi) && AddrD_mi != `ZeroReg)
        begin
            BSel_o = `BSEL_DATAD;
        end
        else
        begin
            BSel_o = BSel_di;
        end
    end

    always @(*) 
    begin
        if(RegWEn_ei && (rs2_D == AddrD_ei) && AddrD_ei != `ZeroReg)
        begin
            REGBSel_o = `BSEL_ALU;
        end
        else if(RegWEn_mi && (rs2_D == AddrD_mi) && AddrD_mi != `ZeroReg)
        begin
            REGBSel_o = `BSEL_DATAD;
        end
        else
        begin
            REGBSel_o = `BSEL_REG;
        end
    end

    always @(*) 
    begin
        if(WBSel_ei == `WBSEL_MEM && ((rs1_D == AddrD_ei) || ((rs2_D == AddrD_ei))) && AddrD_ei != `ZeroReg)
        begin
            pc_stopFlag_o = `PC_STOP_ENABLE;
        end
        else
        begin
            pc_stopFlag_o = `PC_STOP_DISABLE;
        end
    end

    
endmodule
 