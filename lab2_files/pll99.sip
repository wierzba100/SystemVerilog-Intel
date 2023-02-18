set_global_assignment -entity "pll99" -library "lib_pll99" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll99" -library "lib_pll99" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "pll99" -library "lib_pll99" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll99" -name SPD_FILE [file join $::quartus(sip_path) "pll99.spd"]

set_global_assignment -library "lib_pll99" -name MISC_FILE [file join $::quartus(sip_path) "pll99_sim/pll99.vo"]
