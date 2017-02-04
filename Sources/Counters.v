  //Yigit Suoglu
 //This file contains counters to count 1 sec, 0.5 sec and 0.25 sec.
//Note: parameters should be updated according to device clock
//Parameters are for clock frequency of 100MHz (period of 10 ns)
`timescale 1ns / 1ps

module oneSecWait(start, rst, clk, lastCycle);
  parameter oneSec = 27'd100000000; //frequency of device clock, use 4'b1000 for sim
  parameter counterSize = 27; //size of reg, use 4 for sim

  input start, rst, clk;
  output lastCycle;

  reg [(counterSize - 1):0] count;

  assign lastCycle = (count == oneSec);

  always@(posedge clk or posedge rst)
    begin
      if(rst)
        count <= 0;
      else if(count == oneSec)
        count <= 0;
      else if(start)
        count <= 1;
      else if(count != 0)
        count <= count + 1;
      else
        count <= count;
    end


endmodule //1 sec

module halfSecWait(start, rst, clk, lastCycle);
  parameter oneSec = (27'd100000000 >> 1); //frequency of device clock, use 3'b100 for sim
  parameter counterSize = (27 - 1); //size of reg, use 3 for sim

  input start, rst, clk;
  output lastCycle;

  reg [(counterSize - 1):0] count;

  assign lastCycle = (count == oneSec);

  always@(posedge clk or posedge rst)
    begin
      if(rst)
        count <= 0;
      else if(count == oneSec)
        count <= 0;
      else if(start)
        count <= 1;
      else if(count != 0)
        count <= count + 1;
      else
        count <= count;
    end


endmodule //0.5 sec

module quarSecWait(start, rst, clk, lastCycle);
  parameter oneSec = (27'd100000000 >> 2); //frequency of device clock, use 2'b10 for sim
  parameter counterSize = (27 - 2); //size of reg, use 2 for sim

  input start, rst, clk;
  output lastCycle;

  reg [(counterSize - 1):0] count;

    
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        count <= 0;
      else if(count == oneSec)
        count <= 0;
      else if(start)
        count <= 1;
      else if(count != 0)
        count <= count + 1;
      else
        count <= count;
    end
    
  assign lastCycle = (count == oneSec);


endmodule //0.25 sec
