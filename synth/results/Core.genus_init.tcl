#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 06/20/2022 13:00:00
#
#####################################################################


read_mmmc ./results/Core.mmmc.tcl

read_physical -lef {}

read_netlist ./results/Core.v

init_design -skip_sdc_read
