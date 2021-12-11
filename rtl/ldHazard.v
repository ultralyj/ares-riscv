/**
 * @file ldHazard.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 当出现l-type的指令与接下来的指令出现冲突时，插空指令
 * @version 0.2
 * @date 2021-12-11
 * 
 * @copyright Copyright (c) 2021
 * 
 */


module ldHazard(
    input wire [`InstAddrBus]inst_di,
    input wire [`ASEL_BUS]ASel_di,
    input wire [`BSEL_BUS]BSel_di,

    input wire RegWEn_ei,
    input wire [`RegAddrBus]AddrD_ei,

    input wire RegWEn_mi,
    input wire [`RegAddrBus]AddrD_mi,
    
    output reg [`ASEL_BUS] ASel_o,
    output reg [`BSEL_BUS] BSel_o
    );
endmodule
