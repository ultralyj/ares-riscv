//Author: Fengshuai
//Time:2015-11-7 22:26:28


//Version：v1.0
//2015-11-7 22:31:39
//Function: the part of UART:RX end 

//version:v1.1
//2015-11-9 12:24:40
//删除，端口 input   wire          en_rx,


module uart_rx(
        input   wire          clk,      //输入的频率=baud*16
        input   wire          rst_n,
        input   wire          rx,
//        input   wire          en_rx,
        output  reg           rx_done_flag,
        output  wire    [7:0] data_out        							
								
);

parameter   IDLE  = 4'b0001,
             START = 4'b0010,
             DATA  = 4'b0100,
             STOP  = 4'b1000;


reg   [3:0] state_reg,state_reg_next;
reg		[3:0] cnt_reg,cnt_reg_next;
reg		[7:0] data_reg,data_reg_next;
reg		[2:0] data_num_reg,data_num_reg_next;

always@(posedge clk, negedge rst_n)
    if(!rst_n)
    	begin
        	state_reg <= IDLE;
        	cnt_reg <= 4'b0;
        	data_reg <= 8'b0;          
        	data_num_reg <= 3'b0;  
    	end  
    else
    	begin
    		state_reg <= state_reg_next;
    		cnt_reg <= cnt_reg_next;
    		data_reg <= data_reg_next;
    		data_num_reg <= data_num_reg_next;
    	end

//FSM   	
always@(*)
begin
	state_reg_next = state_reg;
	cnt_reg_next = cnt_reg;
	data_num_reg = data_num_reg_next;
	data_reg = data_reg_next;
	rx_done_flag = 1'b0;
	
	case(state_reg)
		IDLE:
			begin
				if(rx)
					begin
						state_reg_next = IDLE;
					end 
				else
					begin
						state_reg_next = START;
						cnt_reg_next= 4'b0;
					end 
			end
		START:
			begin
						if(cnt_reg_next == 4'd7)
							begin
								state_reg_next = DATA;
								cnt_reg_next = 4'b0;
								data_num_reg_next = 3'b0;
							end 
						else
							begin
								cnt_reg_next = cnt_reg + 1'b1;
							end
			end
		DATA:
			begin

						if(cnt_reg_next == 4'd15)
							begin
						      cnt_reg_next = 1'b0;
							    data_reg_next = {rx,data_reg[7:1]};
							    if(data_num_reg_next == 3'd7)
        						begin
                        state_reg_next = STOP;
                        data_num_reg_next = 3'd0;
                        cnt_reg_next = 4'b0;           
                    end 
                else
                    begin
                        data_num_reg_next = data_num_reg + 1'b1;
                    end

							end 
						else
							begin
								cnt_reg_next = cnt_reg + 1'b1;
							end 
			end
		STOP:
			begin
				if(cnt_reg_next == 4'd15)
					begin
						state_reg_next = IDLE;
						cnt_reg_next = 4'd0;    
						rx_done_flag = 1'b1;
					end 
				else
					begin
						cnt_reg_next = cnt_reg + 1'b1;
					end 
			end 
		default:state_reg_next = IDLE;
	endcase
end

assign data_out = data_reg;



endmodule

