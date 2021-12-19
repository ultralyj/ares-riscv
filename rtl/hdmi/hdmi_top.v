/**
 * @file hdmi_top.v
 * @author amy 
 * @brief hdmi模组顶层文件
 * @version 0.1
 * @date 2021-12-17
 * 
 * @copyright Copyright (c) 2021
 * 
 */
module  hdmi_top(
    /* 时钟输入与复位 */
    input wire sys_clk_i,
    input wire pixel_clk,
    input wire pixel_clk_5x,
    input wire rst_i,
    
    /* 显存信号输入 */
    input wire gmemEn_i,
    input wire gmemWEn_i,
    input wire [14:0]gmemAddr_i,
    input wire [15:0]gmemWData_i,

    /* hdmi信号输出 */
    output wire      tmds_clk_p,    // TMDS 时钟通道
    output wire      tmds_clk_n,
    output wire[2:0] tmds_data_p,   // TMDS 数据通道
    output wire[2:0] tmds_data_n
);

wire  [10:0]  pixel_xpos_w;
wire  [10:0]  pixel_ypos_w;
wire  [23:0]  pixel_data_w;

wire          video_hs;
wire          video_vs;
wire          video_de;
wire  [23:0]  video_rgb;

wire [14:0]addrb;
wire [15:0]doutb;

//例化视频显示驱动模块
video_driver u_video_driver(
    .pixel_clk      (pixel_clk),
    .sys_rst_n      (rst_i),

    .video_hs       (video_hs),
    .video_vs       (video_vs),
    .video_de       (video_de),
    .video_rgb      (video_rgb),

    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );

video_display  u_video_display(
    .addrb_o(addrb),
    .doutb_i(doutb),

    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );

dvi_transmitter_top u_rgb2dvi_0(
    .pclk           (pixel_clk),
    .pclk_x5        (pixel_clk_5x),
    .reset_n        (rst_i),
                
    .video_din      (video_rgb),
    .video_hsync    (video_hs), 
    .video_vsync    (video_vs),
    .video_de       (video_de),
                
    .tmds_clk_p     (tmds_clk_p),
    .tmds_clk_n     (tmds_clk_n),
    .tmds_data_p    (tmds_data_p),
    .tmds_data_n    (tmds_data_n)
    );

gmem gmem_inst (
    .clka(sys_clk_i),    // input wire clka
    .ena(gmemEn_i),      // input wire ena
    .wea(gmemWEn_i),      // input wire [0 : 0] wea
    .addra(gmemAddr_i),  // input wire [14 : 0] addra
    .dina(gmemWData_i),    // input wire [15 : 0] dina
    .clkb(pixel_clk),    // input wire clkb
    .enb(rst_i),      // input wire enb
    .addrb(addrb),  // input wire [14 : 0] addrb
    .doutb(doutb)  // output wire [15 : 0] doutb
);
endmodule 