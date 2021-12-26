/**
 * @file BTB.v
 * @author SunShine
 * @brief 
 * @version 0.1
 * @date 2021-12-19
 * 
 * @copyright Copyright (c) 2021
 * 
 */

`include "core_param.v"

module BTB #(parameter  BUFFER_ADDR_LEN = 12)
(
	input wire clk_i, 
    input wire rst_i,

	input wire[`InstAddrBus] rd_PC,					//输入PC指针
	input wire btb_en,						        //写请求信号
	input wire[`InstAddrBus] wr_PC,					//要写入的分支PC指针
	input wire[`InstAddrBus] wr_predicted_PC,		//要写入的预测PC指针
    input wr_predicted_state_bit,		            //要写入的预测状态位

    output reg rd_predicted,				        //对外输出的信号, 表示rd_PC是跳转指令，此时rd_predicted_PC是有效数
	output reg[`InstAddrBus] rd_predicted_PC	    //从buffer中得到的预测PC指针
	
);

    localparam TAG_ADDR_LEN = 32 - BUFFER_ADDR_LEN - 2;	//计算tag的数据位数
    localparam BUFFER_SIZE = 1 << BUFFER_ADDR_LEN;		//计算buffer的大小(4096)

    reg [TAG_ADDR_LEN-1:0] PCTag [0:BUFFER_SIZE-1];     //BUFFER_SIZE个分支PC的TAG(4096位12bit数组)
    reg [`InstAddrBus] PredictPC [0:BUFFER_SIZE-1];     //BUFFER_SIZE个预测PC(4096位32bit数组)
    reg PredictStateBit	[0 : BUFFER_SIZE - 1];          //BUFFER_SIZE个预测状态位

    wire [BUFFER_ADDR_LEN-1:0] rd_buffer_addr;          
    wire [TAG_ADDR_LEN-1:0] rd_tag_addr;
    wire [2-1:0] rd_word_addr;                          

    wire [BUFFER_ADDR_LEN-1:0] wr_buffer_addr;          
    wire [TAG_ADDR_LEN-1:0] wr_tag_addr;
    wire [2-1:0] wr_word_addr;                          

    assign rd_buffer_addr = rd_PC[11:0];
    assign wr_buffer_addr = wr_PC[11:0];
    assign rd_word_addr = rd_PC[1:0];
    assign wr_word_addr = wr_PC[1:0];
    assign rd_tag_addr = rd_PC[18 : 0];
    assign wr_tag_addr = wr_PC[18 : 0];
    
    
     
        begin:counter
            integer i;
            always @ (posedge clk_i or posedge rst_i) begin//写入buffer
                if(rst_i == `RESET_ENABLE) begin
                    for(i = 0; i < BUFFER_SIZE; i = i + 1) 
                    begin
                        PCTag[i] = 0;
                        PredictPC[i] = 0;
                        PredictStateBit[i] = 1'b0;
                    end
                    rd_predicted = 1'b0;
                    rd_predicted_PC = 0;
                end 
                else begin
                    if(btb_en) begin
                        PCTag[wr_buffer_addr] <= wr_tag_addr;
                        PredictPC[wr_buffer_addr] <= wr_predicted_PC;
                        PredictStateBit[wr_buffer_addr] <= wr_predicted_state_bit;
                        $display("BTB:写入BTB中的预测PC:%h",PredictPC[wr_buffer_addr]);
                    end               
                end
            end
        end
    endgenerate
    
    always @ (*) 
    begin 
        if(PCTag[rd_buffer_addr] == rd_tag_addr)
        begin
            rd_predicted = 1'b1;
            $display("BTB:从btb中得到的预测PC:%h,是否预测跳转:%d",PredictPC[rd_buffer_addr] ,rd_predicted);
        end
        else 
        begin
                rd_predicted = 1'b0;
        end
        rd_predicted_PC = PredictPC[rd_buffer_addr];
        //$display("BTB:是否预测跳转:%d ,从btb中得到的预测PC:%d ,预测pc指针地址:%d, 输入tag:%d",rd_predicted , rd_predicted_PC , rd_buffer_addr , PCTag[rd_buffer_addr]);
        //$display("BTB:从btb中得到的预测PC:%h,是否预测跳转:%d",rd_predicted_PC,rd_predicted);
        //$display("BTB:rd_PC:%h,wr_PC:%h",rd_PC,wr_PC);
        //$display("BTB:rd_tag_addr:%d,wr_tag_addr:%d",rd_tag_addr,wr_tag_addr);
        //$display("BTB:rd_buffer_addr:%d,wr_buffer_addr:%d",rd_buffer_addr,wr_buffer_addr);
        //$display("BTB:输入tag:",PCTag[rd_buffer_addr]);
    end
endmodule