`timescale 1ns / 1ps


module sim(
    );

        reg clk, rst, T1btn, T0btn, Cbtn, counterSW, bankSW, chPASS;
        wire bnkLED, t1LED, t0LED, Wait;
        reg [11:0] passSW;
        wire [4:0] ssd0, ssd1, ssd2, ssd3;
    bankSystem core(.ssd0(ssd0), .ssd1(ssd1), .ssd2(ssd2), .ssd3(ssd3), .passSW(passSW),
            .Teller1btn(T1btn), .Teller0btn(T0btn), .bankLed(bnkLED), .Teller1led(t1LED), .Teller0led(t0LED),
            .rst(rst), .clk(clk), .customerBTN(Cbtn),  .counterSW(counterSW), .bankSW(bankSW), .chPASS(chPASS), .Wait(Wait));

    always #5 clk = !clk; //posedge @ ...X5, negedge @...X0

    initial
        begin
            clk = 0;
            rst = 0;
            T1btn = 0;
            T0btn = 0;
            Cbtn = 0;
            counterSW = 0;
            bankSW = 0;
            chPASS = 0;
            passSW = 12'b0;
            #1 //1
            rst = 1;
            #5; //6
            rst = 0;
            #5; //11
            bankSW = 1;
            T0btn = 1;
            #5; //16
            T0btn = 0;
            #5; //21
            T1btn = 1;
            #5; //26
            T1btn = 0;
            bankSW = 0;
            #5 //31
            Cbtn = 1;
            #5 //36
            Cbtn = 0;
            #5 //41
            counterSW = 1;
            T1btn = 1;
            #5 //46
            counterSW = 0;
            T1btn = 0;
            #105 //151
            T1btn = 1;
            #5; //156
            T1btn = 0;
            #5 //161
            T1btn = 1;
            #5; //166
            T1btn = 0;
            #5 //171
            Cbtn = 1;
            #5 //176
            Cbtn = 0;
            #5 //181
            counterSW = 1;
            T0btn = 1;
            #5 //186
            counterSW = 0;
            T0btn = 0;
            #5 //191
            chPASS = 1;
            T0btn = 1;
            #10 //201
            passSW = 12'b1;
            T0btn = 0;
            #10 //211
            T0btn = 1;
            #5 //216
            chPASS = 0;
            T0btn = 0;
            #5 //221
            T0btn = 1;
            #5 //226
            T0btn = 0;
            #5 //231
            counterSW = 1;
            T1btn = 1;
            #10 //241
            passSW = 12'b0;
            #5 //246
            counterSW = 0;
            T1btn = 0;
            #35 //281
            bankSW = 1;
            #5 //286
            bankSW = 0;
            #5 //291
            Cbtn = 1;
            #5 //296
            Cbtn = 0;
            passSW = 12'b1;
            #95 //391
            bankSW = 1;
            T0btn = 1;
            #5 //396
            bankSW = 0;
            T0btn = 0;
            #5 //401
            T1btn = 1;
            #5 //406
            T1btn = 0;
            #5 //411
            T0btn = 1;
            #5 //416
            T0btn = 0;
            #5 //421
            counterSW = 1;
            T0btn = 1;
            #5 //426
            counterSW = 0;
            T0btn = 0;
            #5 //431
            bankSW = 1;
            passSW = 12'b0;
            T1btn = 1;
            #5 //436
            T1btn = 0;
            #5 //441
            T0btn = 1;
            passSW = 12'b1;
            #5 //446
            T0btn = 0;
            bankSW = 0;

        end

endmodule
