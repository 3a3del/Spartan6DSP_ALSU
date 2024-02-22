onerror {resume}
add list -width 11 /alsuuu/A
add list /alsuuu/B
add list /alsuuu/opcode
add list /alsuuu/cin
add list /alsuuu/serial_in
add list /alsuuu/direction
add list /alsuuu/red_op_A
add list /alsuuu/red_op_B
add list /alsuuu/bypass_A
add list /alsuuu/bypass_B
add list /alsuuu/clk
add list /alsuuu/rst
add list /alsuuu/i
add list /alsuuu/out
add list /alsuuu/leds
configure list -usestrobe 0
configure list -strobestart {0 ns} -strobeperiod {0 ns}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
