`timescale 1ns / 1ps

`include "core_param.v"

module datapath_tb();

reg clk;

initial 
begin
    clk = 1'b0;
end

always #10 
begin
    clk = ~clk;        
end

rvtop rvtop_inst(
    .clk_i(clk)
);
endmodule
