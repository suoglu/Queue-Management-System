`timescale 1ns / 1ps

module ssd( clk, rst, a0,a1,a2,a3,b0,b1,b2,b3,c0,c1,c2,c3,d0,d1,d2,d3,e0,e1,e2,e3,
f0,f1,f2,f3,g0,g1,g2,g3,a,b,c,d,e,f,g,an0,an1,an2,an3
    );

input clk, rst;// set clock and reset as input(1 bit)
input a0,a1,a2,a3,b0,b1,b2,b3,c0,c1,c2,c3,d0,d1,d2,d3,e0,e1,e2,e3,f0,f1,f2,f3,g0,g1,g2,g3;//set our display data as input(1 bit)
output reg a,b,c,d,e,f,g,an0,an1,an2,an3;//set outputs also as registers (1 bit)

reg [2:0] state;//holds state number (3 bit)
reg [14:0] counter;//counter to slow the input clock(15 bit)

//in this always block the speed of the clock reduced by 25000 times so that display works properly
//(for a clock frequency is diffent than 100MHz use a counter value that gives reduced clock frequency if ~4kHz.
//Line 12 and 23 should be changed accordingly)
always @ (posedge clk) begin //state counter
	if(rst) begin	//synchronus reset
		state <= 0;		//if reset set state and counter to zero
		counter <= 0;
	end else begin //else the counter untill 25000 (limit)

		if(counter == 15'h61A8) //if equal to 25000 (limit) 
		begin                
			if (state == 3'b100) //if it is in the last state return to state 1
			state <= 1;
			else 						//else go one state up
			state <= state + 1;

		counter <= 0;		//0 the counter because after it reaches 25000
		end
		else
		counter <= counter + 1; //if not 25000 add 1
	end
end

	
always@(posedge clk)
begin
	if(rst)// if reset initilize the outputs
	begin
	an0 <= 1;
	an1 <= 1;
	an2 <= 1;
	an3 <= 1;
	a <= 1;
	b <= 1;
	c <= 1;
	d <= 1;
	e <= 1;
	f <= 1;
	g <= 1;
	end
	else if(state == 3'b001) //state 1 gives the led outputs to the AN0
	begin
	an0 <= 0;
	an1 <= 1;
	an2 <= 1;
	an3 <= 1;
	a <= a0;
	b <= b0;
	c <= c0;
	d <= d0;
	e <= e0;
	f <= f0;
	g <= g0;
	end
	else if(state == 3'b010) //state 2 gives the led outputs to the AN1
	begin
	an0 <= 1;
	an1 <= 0;
	an2 <= 1;
	an3 <= 1;
	a <= a1;
	b <= b1;
	c <= c1;
	d <= d1;
	e <= e1;
	f <= f1;
	g <= g1;
	end
	else if(state == 3'b011) //state 3 gives the led outputs to the AN2
	begin
	an0 <= 1;
	an1 <= 1;
	an2 <= 0;
	an3 <= 1;
	a <= a2;
	b <= b2;
	c <= c2;
	d <= d2;
	e <= e2;
	f <= f2;
	g <= g2;
	end
	else if(state == 3'b100)	//state 4 gives the led outputs to the AN3
	begin
	an0 <= 1;
	an1 <= 1;
	an2 <= 1;
	an3 <= 0;
	a <= a3;
	b <= b3;
	c <= c3;
	d <= d3;
	e <= e3;
	f <= f3;
	g <= g3;
	end
	else //For other states default inputs and outputs
	begin
	an0 <= 1;
	an1 <= 1;
	an2 <= 1;
	an3 <= 1;
	a <= 1;
	b <= 1;
	c <= 1;
	d <= 1;
	e <= 1;
	f <= 1;
	g <= 1;
	end
end
endmodule
