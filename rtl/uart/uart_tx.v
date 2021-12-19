//the part of uart  tx-end 
//time:2015-11-9 12:04:00
//author:fenshuai

module uart_tx(
        input   wire            clk,        //16±¶µÄ²¨ÌØÂÊ
        input   wire            rst_n,
        input   wire            tx_start,
        input   wire    [7:0]   data_in,
        output  wire            tx,
        output  reg             tx_done_flag
);

parameter   IDLE  = 4'b0001,
            START = 4'b0010,
            DATA  = 4'b0100,
            STOP  = 4'b1000;


reg [3:0] state_reg,state_reg_next;
reg	[3:0] cnt_reg,cnt_reg_next;
reg	[7:0] data_reg,data_reg_next;
reg	[2:0] data_num_reg,data_num_reg_next;

reg         tx_reg,tx_reg_next;

always@(posedge clk, negedge rst_n)
    if(!rst_n)
    	begin
        	state_reg <= IDLE;
        	cnt_reg <= 4'b0;
        	data_reg <= 8'b0;          
        	data_num_reg <= 3'b0;  
        	tx_reg  <= 1'b1;
    	end  
    else
    	begin
    		state_reg <= state_reg_next;
    		cnt_reg <= cnt_reg_next;
    		data_reg <= data_reg_next;
    		data_num_reg <= data_num_reg_next;
    		tx_reg  <= tx_reg_next;
    	end

//FSM   	
always@(*)
begin
	state_reg_next = state_reg;
	cnt_reg_next = cnt_reg;
	data_num_reg = data_num_reg_next;
	data_reg = data_reg_next;
	tx_done_flag = 1'b0;
	tx_reg_next = tx_reg;
	
	case(state_reg)
		IDLE:
			begin
				if(tx_start == 1'b1)
					begin
						state_reg_next = START;
						cnt_reg_next= 4'b0;
						tx_reg_next = 1'b0;
						data_reg_next = data_in;
					end 
				else
					begin
						state_reg_next = IDLE;
					end 
			end
		START:
			begin
				if(cnt_reg_next == 4'd15)
					begin
						state_reg_next = DATA;
						cnt_reg_next = 4'b0;
						data_num_reg_next = 3'b0;
						tx_reg_next = data_reg[0];
						data_reg_next = data_reg >> 1;
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
				      data_reg_next = data_reg >> 1;
					    tx_reg_next = data_reg[0];
					    if(data_num_reg_next == 3'd7)
    						begin
                    state_reg_next = STOP;
                    data_num_reg_next = 3'd0;
                    cnt_reg_next = 4'b0;  
                    tx_reg_next = 1'b1;         
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
						tx_done_flag = 1'b1;
					end 
				else
					begin
						cnt_reg_next = cnt_reg + 1'b1;
					end 
			end 
		default:state_reg_next = IDLE;
	endcase
end

assign tx = tx_reg;



endmodule
