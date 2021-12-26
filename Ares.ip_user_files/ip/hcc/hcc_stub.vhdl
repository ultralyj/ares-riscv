-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Wed Dec 22 23:45:37 2021
-- Host        : DESKTOP-DAO2O90 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/code/verilog/FPGA_Project/Ares/Ares.srcs/sources_1/ip/hcc/hcc_stub.vhdl
-- Design      : hcc
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hcc is
  Port ( 
    systick : out STD_LOGIC;
    pixel_clock : out STD_LOGIC;
    pixel_clockx5 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_i : in STD_LOGIC
  );

end hcc;

architecture stub of hcc is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "systick,pixel_clock,pixel_clockx5,resetn,locked,clk_i";
begin
end;
