/**
 * @file uart_top.v
 * @author zz16
 * @brief uart?????????   
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */


module uart_top(
        input   wire            clk_i,
        input   wire            sys_rst_n,

        input wire uartWen,
        input wire [7:0] uartWData,
        input wire       uart_start,

        output  wire            uart_txd,
        output wire uart_done_flag
);


wire baud_clk;      //16 times of the baud 

uart_tx uart_tx_inst(
    .clk(baud_clk),        
    .rst_n(sys_rst_n),
    .tx_start(uart_start&&uartWen),
    .data_in(uartWData),
    .tx(uart_txd),
    .tx_done_flag(uart_done_flag)
);

uart_baud_generate uart_baud_generate_inst(
    .sys_clk_i   (clk_i),
    .rst_n_baud  (sys_rst_n),
    .baud_clk_o  (baud_clk)      
);


endmodule