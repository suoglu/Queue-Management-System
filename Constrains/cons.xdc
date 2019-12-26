## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {passSW[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[0]}]
set_property PACKAGE_PIN V16 [get_ports {passSW[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[1]}]
set_property PACKAGE_PIN W16 [get_ports {passSW[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[2]}]
set_property PACKAGE_PIN W17 [get_ports {passSW[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[3]}]
set_property PACKAGE_PIN W15 [get_ports {passSW[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[4]}]
set_property PACKAGE_PIN V15 [get_ports {passSW[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[5]}]
set_property PACKAGE_PIN W14 [get_ports {passSW[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[6]}]
set_property PACKAGE_PIN W13 [get_ports {passSW[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[7]}]
set_property PACKAGE_PIN V2 [get_ports {passSW[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[8]}]
set_property PACKAGE_PIN T3 [get_ports {passSW[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[9]}]
set_property PACKAGE_PIN T2 [get_ports {passSW[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[10]}]
set_property PACKAGE_PIN R3 [get_ports {passSW[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {passSW[11]}]

set_property PACKAGE_PIN U1 [get_ports {chPASS}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {chPASS}]
set_property PACKAGE_PIN T1 [get_ports {counterSW}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {counterSW}]
set_property PACKAGE_PIN R2 [get_ports {bankSW}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {bankSW}]
 

## LEDs
set_property PACKAGE_PIN U16 [get_ports {t0LED}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {t0LED}]
set_property PACKAGE_PIN E19 [get_ports {t1LED}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {t1LED}]

set_property PACKAGE_PIN V14 [get_ports {Wait}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Wait}]

set_property PACKAGE_PIN L1 [get_ports {bnkLED}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {bnkLED}]
	
	
##7 segment display
# NOTE: abcdefg signals are connected in reverse order
set_property PACKAGE_PIN W7 [get_ports {g}] #normally a				
	set_property IOSTANDARD LVCMOS33 [get_ports {g}] #normally a
set_property PACKAGE_PIN W6 [get_ports {f}] #normally  b				
	set_property IOSTANDARD LVCMOS33 [get_ports {f}] #normally b
set_property PACKAGE_PIN U8 [get_ports {e}] #normally c				
	set_property IOSTANDARD LVCMOS33 [get_ports {e}] #normally c
set_property PACKAGE_PIN V8 [get_ports {d}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {d}]
set_property PACKAGE_PIN U5 [get_ports {c}] #normally e				
	set_property IOSTANDARD LVCMOS33 [get_ports {c}] #normally e
set_property PACKAGE_PIN V5 [get_ports {b}] #normally f				
	set_property IOSTANDARD LVCMOS33 [get_ports {b}] #normally f
set_property PACKAGE_PIN U7 [get_ports {a}] #normally g			
	set_property IOSTANDARD LVCMOS33 [get_ports {a}] #normally g


set_property PACKAGE_PIN U2 [get_ports {an0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an0}]
set_property PACKAGE_PIN U4 [get_ports {an1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an1}]
set_property PACKAGE_PIN V4 [get_ports {an2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an2}]
set_property PACKAGE_PIN W4 [get_ports {an3}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an3}]


##Buttons

set_property PACKAGE_PIN T18 [get_ports Cbtn]						
	set_property IOSTANDARD LVCMOS33 [get_ports Cbtn]
set_property PACKAGE_PIN W19 [get_ports T1btn]						
	set_property IOSTANDARD LVCMOS33 [get_ports T1btn]
set_property PACKAGE_PIN T17 [get_ports T0btn]						
	set_property IOSTANDARD LVCMOS33 [get_ports T0btn]
set_property PACKAGE_PIN U17 [get_ports rst]						
        set_property IOSTANDARD LVCMOS33 [get_ports rst]
 
