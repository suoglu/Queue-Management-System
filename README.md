# Queue Management System
### About
This project was originated from a [term project](https://suoglu.github.io/misc/other/Term_Project_Fall_2015-2016+v.1.pdf) and rewritten with [Xilinx Vivado](http://www.xilinx.com/products/design-tools/vivado.html) to work on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) FPGA.

* **Inputs:**
  * Passcode switches (Rightmost 12 switches):
  * Bank switch (Leftmost switch)
  * 


* **System description:**
This project provides a queue management system with two tellers. Each teller has a 12bit passcode. Initial value for passcodes is 0. Tellers can change their passcode when the bank is open using passcode change switch. While passcode change switch is on, teller that wants to change his/her passcode enters old passcode and pushes his/her button. Later enters new passcode and pushes his/her button. To cancel this process teller can turn passcode switch off. Tellers can open and close their counter using counter switch while bank is open. Teller that wants to open/close his/her counter enters his/her passcode and pushes his/her button. To open/close bank, bank switch turn on, tellers enters their passcodes and pushes their buttons one after other.
