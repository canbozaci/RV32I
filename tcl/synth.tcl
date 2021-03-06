#-------------------------------------------------------------------------------
# Info and path setup
#-------------------------------------------------------------------------------

set DATE [clock format [clock seconds] -format "%b%d-%T"];	# Will hold date and clock (EX: Mar16-11:16:44)
set _OUTPUTS_PATH ./results;	# Output file path will be synth/results
set _REPORTS_PATH ./reports;	# Report path will be synth/reports  
set DESIGN  "Core";		# Name for our design

#-------------------------------------------------------------------------------
# Library setup
#-------------------------------------------------------------------------------
set_db lib_search_path "../liberty";
set_db library "./D_CELLS_3V//D_CELLS_3V_LPMOS_typ_3_30V_25C.lib";
set_db cell "BU_3VX1";
set_db init_hdl_search_path "../src";
set_db script_search_path "../tcl";

set_db operating_conditions typ_3_30V_25C;

#------------------------------------------------------------------------------- 
# Read design
#-------------------------------------------------------------------------------
read_hdl {  \
	MUX2to1.v \	
	barrel_arith_shift.v \
	barrel_shifter.v \
	DECODER5to32.v \
	FA.v \
	HA.v \
	ID.v \
	MUX5to32.v \
	RCA_nocin.v \
	RCA.v \
	ALU.v \
	REG_32bit.v \
	REG_bit.v \
	shifter.v \
	SQRT_CSLA_ZFC.v \
	ZFC.v \
	PC.v \
  	CU.v \
	RegisterFile.v \
	FU.v \
	Forward_unit.v \
	Hazard_detect_unit.v \
	Core.v \
    }

set_db hdl_track_filename_row_col true;
set_db hdl_parameterize_module_name false;

elaborate $DESIGN

check_design -all > $_REPORTS_PATH/elab_report.txt

#-------------------------------------------------------------------------------
# Constraints 
#-------------------------------------------------------------------------------

set_db wireload_mode "segmented"

# 100 MHz system clock model
create_clock -name "sys_clk1" -period 10 -waveform {0.0 5.0} [get_ports clk]

#Define external transition/driver to inputs
set_driving_cell -cell "BU_3VX1" [all_inputs]

# Define capacitive loads on outputs
set_load -pin_load -max 10 [all_outputs]

# External input/output delays on I/O ports
set_input_delay 0.01 -clock [get_clocks sys*] [all_inputs]
set_output_delay -clock sys_clk1 0.01 [all_outputs]


#-------------------------------------------------------------------------------
# Synthesis
#-------------------------------------------------------------------------------
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort high

syn_generic [get_designs $DESIGN*]
report_timing -lint -verbose > $_REPORTS_PATH/${DESIGN}_generic_timing_lint.rpt

syn_map [get_designs $DESIGN*]

#set_dont_touch  

syn_opt -incremental

#-------------------------------------------------------------------------------
# Reporting and export
#-------------------------------------------------------------------------------
report_gates -power          	 > $_REPORTS_PATH/${DESIGN}_gates_power_${DATE}.rpt
report_area                  	 > $_REPORTS_PATH/${DESIGN}_area_${DATE}.rpt
report_power		     	 > $_REPORTS_PATH/${DESIGN}_power_${DATE}.rpt
report_qor -levels_of_logic  	 > $_REPORTS_PATH/${DESIGN}_qor_${DATE}.rpt		
report_nets > $_REPORTS_PATH/${DESIGN}_nets_${DATE}.rpt

check_timing_intent > $_REPORTS_PATH/${DESIGN}_postopt_timing_lint.rpt
report_timing  >> $_REPORTS_PATH/${DESIGN}final${DATE}.rpt
report_timing -unconstrained     > $_REPORTS_PATH/${DESIGN}unconstrained${DATE}.rpt

write_design innovus -basename        ${_OUTPUTS_PATH}/${DESIGN}
write_design -basename        ${_OUTPUTS_PATH}/${DESIGN}
write_sdc -exclude "set_ideal_network set_dont_use group_path \
                    set_max_dynamic_power set_max_leakage_power \
                    set_units set_operating_conditions"    > ${_OUTPUTS_PATH}/${DESIGN}.sdc

write_sdf -timescale ns -edges check_edge -delimiter "/" > ${_OUTPUTS_PATH}/${DESIGN}.sdf


