// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Dec 13 15:26:10 2021
// Host        : DESKTOP-DAO2O90 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top hcc -prefix
//               hcc_ hcc_stub.v
// Design      : hcc
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module hcc(systick, pixel_clock, pixel_clockx5, resetn, 
  locked, clk_i)
/* synthesis syn_black_box black_box_pad_pin="systick,pixel_clock,pixel_clockx5,resetn,locked,clk_i" */;
  output systick;
  output pixel_clock;
  output pixel_clockx5;
  input resetn;
  output locked;
  input clk_i;
endmodule
