/**
 * @file uart_baud_generate.v
 * @author zz16
 * @brief �����ʷ�����
 *       sys_clk=150MHz the cycle = 10^9 / 150*10^6 = 10^3/125 = 8ns
 *      if baud=115200,16������������/2=271   271/8=34
 *      if baud=19200,16������������/2=1628   1628/8=204
 *      if baud=9600,16������������/2=3255    4069/8=509          
 * @version 0.1
 * @date 2021-11-22
 * 
 * @copyright Copyright (c) 2021
 * 
 */


module uart_baud_generate(
        input   wire            sys_clk_i,
        input   wire            rst_n_baud,
        output  reg             baud_clk_o      
);

parameter baud_115200_cycle = 34;     //baud=115200ʱ������    16������������/2=baud_115200_cycle/32
parameter baud_19200_cycle = 204;     //baud=19200ʱ������     16������������/2=baud_19200_cycle/32   (10^9/(19200*16))/2 = 3255.2/2=1628    10^9/19200=52083
parameter baud_9600_cycle = 509;     //baud=9600ʱ������      16������������/2=baud_9600_cycle/32



parameter baud_cycle_num= baud_115200_cycle;   //�޸Ĵ˴�

reg [7:0] baud_cnt;

always @(posedge sys_clk_i or negedge rst_n_baud)
    if(!rst_n_baud)
        begin
            baud_clk_o <= 1'b0;
            baud_cnt <= 8'b0;
        end 
    else
        begin
            baud_cnt <= baud_cnt + 8'b1;
            if(baud_cnt == baud_cycle_num-1)
                begin
                    baud_clk_o <= ~baud_clk_o;
                    baud_cnt <= 8'b0;
                end 
        end 

endmodule