/**
 * @file ImmGen.v
 * @author ultralyj (1951578@tongji.edu.cn)
 * @brief 根据指令类型的不同，按不同的方式生成立即数
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */
 
`include "core_param.v"

module ImmGen(
    input wire [31:7]inst_i,   // 指令输入[31:0]
    input wire [`IMMSEL_BUS]ImmSel_i,   // 立即数选择[2:0]
    output wire signed [`RegBus]imm_o    // 立即数输出[31:0]
    );

assign imm_o =  (ImmSel_i == `IMMSEL_I_TYPE)?
                    /* I型立即数：将12位有符号的立即数（在指令的[31:20]）拓展为32位 */
                    {{(`RegWidth - `ImmWidth){inst_i[`InstWidth-1]}}, inst_i[31:20]}:
                (ImmSel_i == `IMMSEL_S_TYPE)?
                    /* S型立即数：将12位有符号的立即数（在指令的[31:25],[11:7]）拓展为32位 */
                    {{(`RegWidth - `ImmWidth){inst_i[`InstWidth-1]}},inst_i[31:25],inst_i[11:7]}:
                (ImmSel_i == `IMMSEL_B_TYPE)?
                    /* B型立即数：在S的基础上，右移一位 */
                    {{(`RegWidth - `ImmWidth){inst_i[`InstWidth-1]}},
                        inst_i[7],inst_i[30:25],inst_i[11:8],{1'b0}}:
                (ImmSel_i == `IMMSEL_J_TYPE)?
                    /* J型立即数：复杂 */
                    {{(11){inst_i[`InstWidth-1]}},inst_i[`InstWidth-1],inst_i[19:12],
                        inst_i[20],inst_i[30:21],{1'b0}}:
                (ImmSel_i == `IMMSEL_U_TYPE)?
                    /* U型立即数：20位长立即数 */
                    {inst_i[31:12],{(12){1'b0}}}:`ZeroWord;
// always @(*) 
// begin
//    case (ImmSel_i)
//         /* I型立即数：将12位有符号的立即数（在指令的[31:20]）拓展为32位 */
//         `IMMSEL_I_TYPE:
//         begin
//             imm_o = {{(`RegWidth - `ImmWidth){inst_i[`InstWidth-1]}}, inst_i[31:20]};
//         end
//         /* S型立即数：将12位有符号的立即数（在指令的[31:25],[11:7]）拓展为32位 */
//         `IMMSEL_S_TYPE:
//         begin
//             imm_o = {{(`RegWidth - `ImmWidth){inst_i[`InstWidth-1]}},inst_i[31:25],inst_i[11:7]};
//         end
//         /* B型立即数：在S的基础上，右移一位 */
//         `IMMSEL_B_TYPE:
//         begin
//             imm_o = {{(`RegWidth - `ImmWidth){inst_i[`InstWidth-1]}},
//                         inst_i[7],inst_i[30:25],inst_i[11:8],{1'b0}};
//         end
//         /* J型立即数：复杂 */
//         `IMMSEL_J_TYPE:
//         begin
//             imm_o = {{(11){inst_i[`InstWidth-1]}},
//                         inst_i[`InstWidth-1],inst_i[19:12],
//                         inst_i[20],inst_i[30:21],{1'b0}};
//         end
//         /* U型立即数：20位长立即数 */
//         `IMMSEL_U_TYPE:
//         begin
//             imm_o = {inst_i[31:20],{(12){1'b0}}};
//         end
//        default: 
//        begin
//            imm_o = `ZeroWord;
//        end
//    endcase 
//end


endmodule
