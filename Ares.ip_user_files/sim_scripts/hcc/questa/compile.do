vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -sv "+incdir+../../../ipstatic" \
"C:/Users/ultralyj/AppData/Local/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Users/ultralyj/AppData/Local/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/Users/ultralyj/AppData/Local/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" \
"../../../../Ares.srcs/sources_1/ip/hcc/hcc_clk_wiz.v" \
"../../../../Ares.srcs/sources_1/ip/hcc/hcc.v" \

vlog -work xil_defaultlib \
"glbl.v"

