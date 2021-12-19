
`include "core_param.v"

`define slave_1 8'b0000_0000   //分配给从设备1的地址，用高8位表示
`define slave_2 8'b0000_0001
`define slave_3 8'b0000_0010
`define RBUS_SLAVE_ENABLE 1'b1
`define RBUS_SLAVE_DISABLE 1'b0

module rbus(
    input wire rst_i,
    //主设备
    input wire[`MEMAddrBus] m_addr_i,   //主设备的读写地址
    input wire[`MEM_BUS] m_data_i,      //主设备的写数据
    output reg[`MEM_BUS] m_data_o,      // 主设备读取到的数据
    input wire m_writeFlag_i,           //主设备写标志
    // input wire m_req_i,                 //主设备访问请求标志
    
    //从设备
    output reg s1_en_o,
    output wire[9:0] s1_addr_o,          //从设备1的片选信号
    output wire[`MEM_BUS] s1_data_o,     //从设备1的写数据
    input wire[`MEM_BUS] s1_data_i,      //从设备1读取到的数据
    output wire s1_writeFlag_o,          //从设备1写标志
    
    output reg s2_en_o,                  //从设备2的片选信号
    output wire[14:0] s2_addr_o,  //从设备2的读写地址
    output wire[15:0] s2_data_o,     //从设备2的写数据
    //input wire[31:0] s2_data_i,      //从设备2读取到的数据
    output wire s2_writeFlag_o,           //从设备2写标志
    
    output reg s3_en_o,                     //从设备2的片选信号
    // output reg[`MEMAddrBus] s3_addr_o,   //从设备3的读写地址
    output wire[7:0] s3_data_o,         //从设备3的写数据
    // input wire[`MEM_BUS] s3_data_i,      //从设备3读取到的数据
    output wire s3_writeFlag_o               //从设备3写标志
    );
    

    wire [7:0]rbus_addr_head = m_addr_i[31:24];
    /* 连通从设备地址与主设备地址 */
    /* 从设备1 */
    assign s1_addr_o = m_addr_i[11:2];
    assign s1_data_o = m_data_i;
    assign s1_writeFlag_o = m_writeFlag_i;

    /* 从设备2 */
    assign s2_addr_o = m_addr_i[16:2];
    assign s2_data_o = m_data_i[15:0];
    assign s2_writeFlag_o = m_writeFlag_i;

    /* 从设备2 */
    assign s3_data_o = m_data_i[7:0];
    assign s3_writeFlag_o = m_writeFlag_i;

    always @(*)
    begin
        /* 如果正在复位，则所有设备失能 */
        if(rst_i == `RESET_ENABLE)
        begin
            s1_en_o <= `RBUS_SLAVE_DISABLE;
            s2_en_o <= `RBUS_SLAVE_DISABLE;
            s3_en_o <= `RBUS_SLAVE_DISABLE;
            m_data_o <= `ZeroWord;
        end
        else
        begin
            /* 根据地址前8位是能设备 */
            case (rbus_addr_head)
                `slave_1:
                begin
                    /* 从设备1使能 */
                    s1_en_o <= `RBUS_SLAVE_ENABLE;
                    s2_en_o <= `RBUS_SLAVE_DISABLE;
                    s3_en_o <= `RBUS_SLAVE_DISABLE;
                    m_data_o <= s1_data_i;
                end
                `slave_2:
                begin
                    /* 从设备2使能 */
                    s1_en_o <= `RBUS_SLAVE_DISABLE;
                    s2_en_o <= `RBUS_SLAVE_ENABLE;
                    s3_en_o <= `RBUS_SLAVE_DISABLE;
                    m_data_o <= `ZeroWord;
                end
                `slave_3:
                begin
                    /* 从设备3使能 */
                    s1_en_o <= `RBUS_SLAVE_DISABLE;
                    s2_en_o <= `RBUS_SLAVE_DISABLE;
                    s3_en_o <= `RBUS_SLAVE_ENABLE;
                    m_data_o <= `ZeroWord;
                end
                default:
                begin
                    s1_en_o <= `RBUS_SLAVE_DISABLE;
                    s2_en_o <= `RBUS_SLAVE_DISABLE;
                    s3_en_o <= `RBUS_SLAVE_DISABLE;
                    m_data_o <= `ZeroWord;
                end
            endcase
        end
        
    end
endmodule

