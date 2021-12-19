-makelib xcelium_lib/xpm -sv \
  "C:/Users/ultralyj/AppData/Local/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Users/ultralyj/AppData/Local/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Users/ultralyj/AppData/Local/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../Ares.srcs/sources_1/ip/gmem/sim/gmem.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

