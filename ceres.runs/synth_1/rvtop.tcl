# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 4
set_param synth.incrementalSynthesisCache C:/Users/ultralyj/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-5892-DESKTOP-DAO2O90/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg400-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/code/verilog/FPGA_Project/ceres/ceres.cache/wt [current_project]
set_property parent.project_path D:/code/verilog/FPGA_Project/ceres/ceres.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/code/verilog/FPGA_Project/ceres/ceres.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files D:/code/verilog/FPGA_Project/ceres/ceres.srcs/imem_inst/imem_inst.coe
add_files D:/code/verilog/FPGA_Project/ceres/csrcs/riscv_test.coe
read_verilog {
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/core_param.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/risc_v_codetable.v
}
set_property file_type "Verilog Header" [get_files D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/core_param.v]
set_property file_type "Verilog Header" [get_files D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/risc_v_codetable.v]
read_verilog -library xil_defaultlib {
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/ASel.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/BSel.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/BranchComp.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/ImmGen.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/alu.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ctrl.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/pc.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/ex_core/regs.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/rv_core.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/writeback.v
  D:/code/verilog/FPGA_Project/ceres/ceres.srcs/rvtop.v
}
read_ip -quiet d:/code/verilog/FPGA_Project/ceres/ceres.srcs/sources_1/ip/imem/imem.xci
set_property used_in_implementation false [get_files -all d:/code/verilog/FPGA_Project/ceres/ceres.srcs/sources_1/ip/imem/imem_ooc.xdc]

read_ip -quiet d:/code/verilog/FPGA_Project/ceres/ceres.srcs/sources_1/ip/dmem/dmem.xci
set_property used_in_implementation false [get_files -all d:/code/verilog/FPGA_Project/ceres/ceres.srcs/sources_1/ip/dmem/dmem_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/code/verilog/FPGA_Project/ceres/ceres.srcs/constrs_1/new/ceres_noOutput.xdc
set_property used_in_implementation false [get_files D:/code/verilog/FPGA_Project/ceres/ceres.srcs/constrs_1/new/ceres_noOutput.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top rvtop -part xc7z020clg400-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef rvtop.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file rvtop_utilization_synth.rpt -pb rvtop_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]