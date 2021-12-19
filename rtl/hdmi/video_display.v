/**
 * @file video_display.v
 * @author amy 
 * @brief 从显存读取屏幕颜色信息
 * @version 0.1
 * @date 2021-12-17
 * 
 * @copyright Copyright (c) 2021
 * 
 */
module  video_display(
    
    input        [10:0]  pixel_xpos,  //像素点横坐标
    input        [10:0]  pixel_ypos,  //像素点纵坐标
    output wire  [14:0] addrb_o,
    input wire   [15:0] doutb_i,
    output       [23:0]  pixel_data   //像素点数据
);

assign addrb_o ={pixel_ypos[9:3],pixel_xpos[10:3]};
assign pixel_data={ doutb_i[15:11],{(3){1'b0}},
                    doutb_i[10:5],{(2){1'b0}},
                    doutb_i[4:0],{(3){1'b0}}};

endmodule