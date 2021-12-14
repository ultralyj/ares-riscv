set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property PACKAGE_PIN U18 [get_ports clk_i]
set_property PACKAGE_PIN M15 [get_ports dmem_o]
set_property PACKAGE_PIN N15 [get_ports rst_i]
set_property IOSTANDARD LVCMOS33 [get_ports dmem_o]
set_property IOSTANDARD LVCMOS33 [get_ports rst_i]
set_property DRIVE 8 [get_ports dmem_o]
set_property SLEW SLOW [get_ports dmem_o]

create_clock -period 20.000 -name clk_i -waveform {0.000 10.000} [get_ports clk_i]

set_operating_conditions -grade extended
