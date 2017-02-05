# Queue Management System
### Contents of Readme
1. About
 1. Inputs
 2. Outputs
 3. System description
2. Simulation
3. Implementation
4. Extra Notes

---
### About
This project was originated from a [term project](https://suoglu.github.io/misc/other/Term_Project_Fall_2015-2016+v.1.pdf) and rewritten with [Xilinx Vivado](http://www.xilinx.com/products/design-tools/vivado.html) to work on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) FPGA.

* **Inputs:**
  * `Passcode switches (Rightmost 12 switches)`: Used to enter passcode
  * `Bank switch (Leftmost switch)`: Used to open/close bank
  * `Counter switch (2nd leftmost switch)`: Used to open/close counter
  * `Passcode change switch (3rd leftmost switch)`: Used to change passcode
  * `Reset button (Lower button)`: Used to reset system
  * `Customer button (Upper button)`: Used to taking queue number
  * `Teller buttons (Right and left button)`: Used for teller actions, effects to the system changes according to leftmost three switches.
  
* **Outputs:**
  * `Bank LED (Leftmost LED)`: Shows if the bank is open or not
  * `Counter LEDs (Rightmost two LEDs)`: Shows if the corresponding counter is open or not
  * `Wait LED (9th LED from left site)`: Shows if system waiting for teller action to complate a process
  * `Seven Segment Displays`: Can show different things according to other signals
    * `Default`: Last called customer for the tellers (Right two for one teller left two for the other)
    * `When customer takes number`: For one second left two seven segment displays are blank, right two seven segment displays show taken number. seven segment displays blink with period of 0.5 second and duty cycle of 50%.
    * `Bank closed`: Writes "CLSd"
    * `If tellers try to close bank while there is/are customer(s) waitng and/or there is an open counter`: "rCXX", where XX number of remaining customer(s)
  
  
* **System description:**
This project provides a queue management system with two tellers. 
 * Each teller has a 12-bit passcode. Initial values for the passcodes are 12'b0. Tellers can change their passcode when the bank is open using passcode change switch. While passcode change switch is on, teller that wants to change his/her passcode enters old passcode and pushes his/her button. Later enters new passcode and pushes his/her button. To cancel this process teller can turn passcode switch off. 
 * Tellers can open and close their counter using counter switch while the bank is open. Teller that wants to open/close his/her counter enters his/her passcode and pushes his/her button. 
 * To open/close bank, the bank switch is turned on to system to enter open/close state. Tellers enters their passcodes and pushes their buttons one after other. Later the bank switch should be turned off. Bank cannot be closed while there is/are waiting customer(s) or/and any of the counters is open.
 * Customers take number by pushing the Customer button.
 * Tellers call the next customer by pressing teller button while leftmost three switches are off. Tellers cannot call next customer if next customer does not exists.
 * System can be reset asynchronously with reset button.

---

### Simulation
Designed system was successfully simulated using [`sim.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Simulation/sim.v) file, which is included in the repository. [`sim.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Simulation/sim.v) file contains a short scenario, which I try to cover all possible situations.

**Important note:** For system to work properly at simulation [`Counters.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Sources/Counters.v) file should be edited as commented on line 8 and 65.

---

### Implementation
Design can be implemented on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) FPGA using verilog files in the [Sources](https://github.com/suoglu/Queue-Management-System/tree/master/Sources) folder and provided constrains file, [`cons.xdc`](https://github.com/suoglu/Queue-Management-System/blob/master/Constrains/cons.xdc).

**Important note:** System is desgined and tested for 100MHz clock frequency, for other clock frequencies files [`Counters.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Sources/Counters.v) and [`ssd.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Sources/ssd.v) should be edited as commented.

**Important note:** In the Reference Manual, pin numbers for seven segment displays are assigned wrong. (At least this was the case for me). I fixed it by reversing assignment order. (e.g. in the Reference Manual 'a' is assigned to W7 and 'g' is assigned to U7 how ever at [`cons.xdc`](https://github.com/suoglu/Queue-Management-System/blob/master/Constrains/cons.xdc) 'a' is assigned to U7 and 'g' is assigned to W7)

---

### Extra Notes
* Files [`ssd.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Sources/ssd.v) and [`debouncer.v`](https://github.com/suoglu/Queue-Management-System/blob/master/Sources/debouncer.v) provided by the instructor
* Last stable simulation date: Feb 4th, 2017
* Last stable test date: Feb 5th, 2017
* For any questions or suggestions you can contact me at yigitsuoglu@sabanciuniv.edu
