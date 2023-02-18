transcript on
if ![file isdirectory lab2_iputf_libs] {
	file mkdir lab2_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "D:/Semestr_5/Programowalne_uklady_logiczne/Verilog/lab2_files/ip/pll_sim/pll.vo" 
vlog "D:/Semestr_5/Programowalne_uklady_logiczne/Verilog/lab2_files/pll99_sim/pll99.vo"

vlog -vlog01compat -work work +incdir+D:/Semestr_5/Programowalne_uklady_logiczne/Verilog/lab2_files {D:/Semestr_5/Programowalne_uklady_logiczne/Verilog/lab2_files/de0_nano_soc_baseline.v}

vlog -sv -work work +incdir+D:/Semestr_5/Programowalne_uklady_logiczne/Verilog/lab2_files/sim {D:/Semestr_5/Programowalne_uklady_logiczne/Verilog/lab2_files/sim/tb_pll.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_pll

add wave *
view structure
view signals
run -all
