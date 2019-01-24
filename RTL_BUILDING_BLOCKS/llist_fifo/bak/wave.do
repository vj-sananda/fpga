onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/SYSTEM_CLOCK
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/LED_0
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/LED_1
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/LED_2
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/LED_3
add wave -noupdate -divider ALLOC
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/alloc_req
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/wait_for_alloc_ack
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/alloc_ack
add wave -noupdate -format Literal -radix hexadecimal /stimulus_test/stim/alloc_id
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/not_full
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/push
add wave -noupdate -format Literal -radix hexadecimal /stimulus_test/stim/din
add wave -noupdate -divider DEALLOC
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/rdy
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/pop
add wave -noupdate -format Literal -radix hexadecimal /stimulus_test/stim/dout
add wave -noupdate -format Literal -radix hexadecimal /stimulus_test/stim/dealloc_id
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/dealloc_req
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/wait_for_dealloc_ack
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/dealloc_ack
add wave -noupdate -divider MISC
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/clk_enable
add wave -noupdate -format Literal -radix hexadecimal /stimulus_test/stim/div_count
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/RESET
add wave -noupdate -format Logic -radix hexadecimal /stimulus_test/stim/init_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8195000 ps} 0}
configure wave -namecolwidth 297
configure wave -valuecolwidth 94
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {4574464 ps} {5016874 ps}
