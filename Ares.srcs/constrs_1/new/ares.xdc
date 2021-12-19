set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property PACKAGE_PIN U18 [get_ports clk_i]
set_property PACKAGE_PIN N15 [get_ports rst_i]
set_property IOSTANDARD LVCMOS33 [get_ports rst_i]

create_clock -period 20.000 -name clk_i -waveform {0.000 10.000} [get_ports clk_i]


set_property PACKAGE_PIN N18 [get_ports tmds_clk_p]
set_property PACKAGE_PIN V20 [get_ports {tmds_data_p[0]}]
set_property PACKAGE_PIN T20 [get_ports {tmds_data_p[1]}]
set_property PACKAGE_PIN N20 [get_ports {tmds_data_p[2]}]



set_property IOSTANDARD LVCMOS33 [get_ports uart_txd]
set_property PACKAGE_PIN M20 [get_ports uart_txd]
set_property SLEW SLOW [get_ports uart_txd]
