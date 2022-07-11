# Cadence Genus(TM) Synthesis Solution, Version 17.11-s014_1, built Oct  9 2017

# Date: Wed Jun 15 22:28:08 2022
# Host: boron01.comp.vlsi.labs (x86_64 w/Linux 2.6.32-279.el6.x86_64) (4cores*16cpus*2physical cpus*Intel(R) Xeon(R) CPU X5570 @ 2.93GHz 8192KB)
# OS:   CentOS release 6.3 (Final)

set DATE [clock format [clock seconds] -format "%b%d-%T"];# Will hold date and clock (EX: Mar16-11:16:44)
set _OUTPUTS_PATH ./results;# Output file path will be synth/results
set _REPORTS_PATH ./reports;# Report path will be synth/reports
set DESIGN  "Core";# Name for our design
set_db lib_search_path "../liberty";
set_db library "./D_CELLS_3V//D_CELLS_3V_LPMOS_typ_3_30V_25C.lib";
set_db cell "BU_3VX1";
set_db init_hdl_search_path "../src";
set_db script_search_path "../tcl";
set_db operating_conditions typ_3_30V_25C;
read_hdl {  \
genus.MUX2to1.v \genus.
barrel_arith_shift.v \
genus.barrel_shifter.v \
genus.DECODER5to32.v \
genus.FA.v \
genus.HA.v \
genus.ID.v \
genus.MUX5to32.v \
genus.RCA_nocin.v \
genus.RCA.v \
genus.ALU.v \
genus.REG_32bit.v \
genus.REG_bit.v \
genus.shifter.v \
genus.SQRT_CSLA_ZFC.v \
genus.ZFC.v \
genus.PC.v \
  genus.CU.v \
genus.RegisterFile.v \
genus.FU.v \
genus.Core.v \
    }
set_db hdl_track_filename_row_col true;
set_db hdl_parameterize_module_name false;
elaborate $DESIGN
exit
