`timescale 1ns / 1ps

`include "core_param.v"

module datapath_tb();

reg clk;
reg rst;

initial 
begin
    rst = 1'b1;
    clk = 1'b0;
end

always #10 
begin
    clk = ~clk;        
end

rvtop rvtop_inst(
    .clk_i(clk),
    .rst_i(rst)
);
endmodule
