iverilog -o sim.out picorv32.v testbench.v 
vvp sim.out +vcd +firmware=firmware.hex
gtkwave testbench.vcd
