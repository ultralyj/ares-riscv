/**
 * @file asyn_rst_syn.v
 * @author amy, Candyaner  
 * @brief ʵ���첽����Ч��λ��ͬ������Ч��λ
 * @version 0.1
 * @date 2021-12-17
 * 
 * @copyright Copyright (c) 2021
 * 
 */

module asyn_rst_syn(
    input clk,          //Ŀ��ʱ����
    input reset_n,      //�첽��λ������Ч
    
    output syn_reset    //����Ч
    );
    
//reg define
reg reset_1;
reg reset_2;
    
//*****************************************************
//**                    main code
//***************************************************** 
assign syn_reset  = reset_2;
    
//���첽��λ�źŽ���ͬ���ͷţ���ת���ɸ���Ч
always @ (posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        reset_1 <= 1'b1;
        reset_2 <= 1'b1;
    end
    else begin
        reset_1 <= 1'b0;
        reset_2 <= reset_1;
    end
end
    
endmodule