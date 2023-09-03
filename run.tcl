create_project project_6 D:/Vivado2018.2/VivadoTclProject/project_6 -part xc7a35ticpg236-1L -force

add_files switch_LEDs.v switch_LEDs_basys3_constraints.xdc

synth_design -rtl -top switch_LEDs > elab.log

write_schematic elaborated_schematic.pdf -format pdf -force 

launch_runs synth_1 > synth.log

wait_on_run synth_1
open_run synth_1

write_schematic synthesized_schematic.pdf -format pdf -force 

write_verilog -force switch_LEDs_netlist.v

launch_runs impl_1 -to_step write_bitstream 

wait_on_run impl_1
open_run impl_1

open_hw

connect_hw_server