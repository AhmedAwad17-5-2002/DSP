quit -sim
vlib work
vlog Spartan6_DSP48A1_tb.v Spartan6_DSP48A1.v test1.v
vsim -voptargs=+acc work.Spartan6_DSP48A1_tb
add wave *
run -all