//function: FIFO buffer
//by:rzjm
//time:2015-11-10 15:32:45
//ref:fpga prototyping by verilog examples

//用三段式状态机实现
module fifo#(
            parameter B = 8,
                   W = 4
            )
          (
            input   wire            clk,
            input   wire            rst_n,
            input   wire            wr,
            input   wire            rd,
            input   wire    [B-1:0] w_data,
            output  wire    [B-1:0] r_data,
            output  wire            empty,
            output  wire            full  
          );
      
      //signal declaration
      reg   [B-1:0]     array_reg   [2**W-1:0];     //寄存器阵列
      reg   [W-1:0]     w_ptr_reg, w_ptr_next, w_ptr_succ;
      reg   [W-1:0]     r_ptr_reg, r_ptr_next, r_ptr_succ;
      reg   full_reg, empty_reg, full_next, empty_next;
      
      wire  wr_en;
      
      //body
      //寄存器文件 写操作
      always @(posedge clk)
        if(wr_en)
            array_reg[w_ptr_reg] <= w_data;
            
      assign    r_data = array_reg[r_ptr_reg];
      assign    wr_en = wr & ~full_reg;
      
      //fifo contrlol logic
      //register for read and write pointers
      always @ (posedge clk or posedge rst_n)
        if(!rst_n)
            begin
                w_ptr_reg <= 0;
                r_ptr_reg <= 0;
                full_reg <= 1'b0;
                empty_reg <= 1'b1;
            end 
        else
            begin
                w_ptr_reg <= w_ptr_next;
                r_ptr_reg <= r_ptr_next;
                full_reg <= full_next;
                empty_reg <= empty_next;
            end 
            
      //next stage logic for read and wire pointers
      always @*
        begin
            //successive pointer values
            w_ptr_succ = w_ptr_reg + 1;
            r_ptr_succ = r_ptr_reg + 1;
            //default:keep old values
            w_ptr_next = w_ptr_reg;
            r_ptr_next = r_ptr_reg;
            full_next = full_reg;
            empty_next = empty_reg;
            
            case({wr, rd})
                //2'b00: no operation
                2'b01:      //read
                    begin
                        if(~empty_reg)
                            begin
                                r_ptr_next = r_ptr_succ;
                                full_next = 1'b0;
                                if(r_ptr_succ == w_ptr_reg)
                                    empty_next = 1'b1;
                            end 
                    end 
                2'b10:  //write
                    begin
                        if(~full_reg)       //not full
                            begin
                                w_ptr_next = w_ptr_succ;
                                empty_next = 1'b0;
                                if(w_ptr_succ == r_ptr_reg)
                                    full_next = 1'b1;
                            end 
                    end 
                 2'b11:
                    begin
                        w_ptr_next = w_ptr_succ;
                        r_ptr_next = r_ptr_succ;
                    end 
                 
            endcase
                 
        end         

        //output
        assign full = full_reg;
        assign empty = empty_reg;

endmodule
