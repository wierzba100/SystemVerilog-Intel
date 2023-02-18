set_global_assignment -entity "gen_pll" -library "lib_gen_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "gen_pll" -library "lib_gen_pll" -name IP_TOOL_VERSION "22.1"
set_global_assignment -entity "gen_pll" -library "lib_gen_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_gen_pll" -name SPD_FILE [file join $::quartus(sip_path) "gen_pll.spd"]

set_global_assignment -library "lib_gen_pll" -name MISC_FILE [file join $::quartus(sip_path) "gen_pll_sim/gen_pll.vo"]
