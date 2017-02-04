`timescale 1ns / 1ps

module board(
    input clk,
    input rst,
    input [11:0] passSW,
    input T1btn,
    input T0btn,
    input Cbtn,
    output bnkLED,
    output t1LED,
    output t0LED,
    input counterSW,
    input bankSW,
    input chPASS,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output an0,
    output an1,
    output an2,
    output an3,
    output Wait
    );
    
    wire [4:0] ssd0_pre, ssd1_pre, ssd2_pre, ssd3_pre;
    wire [6:0] ssd0, ssd1, ssd3, ssd2;
    wire  T1btn_c, T0btn_c,  Cbtn_c;
    
    bankSystem core(.ssd0(ssd0_pre), .ssd1(ssd1_pre), .ssd2(ssd2_pre), .ssd3(ssd3_pre), .passSW(passSW), 
    .Teller1btn(T1btn_c), .Teller0btn(T0btn_c), .bankLed(bnkLED), .Teller1led(t1LED), .Teller0led(t0LED), 
    .rst(rst), .clk(clk), .customerBTN(Cbtn_c),  .counterSW(counterSW), .bankSW(bankSW), .chPASS(chPASS), .Wait(Wait));
    
    int5bitToHexSSD_bankVer ssd0M(.in(ssd0_pre), .out(ssd0));
    int5bitToHexSSD_bankVer ssd1M(.in(ssd1_pre), .out(ssd1));
    int5bitToHexSSD_bankVer ssd2M(.in(ssd2_pre), .out(ssd2));
    int5bitToHexSSD_bankVer ssd3M(.in(ssd3_pre), .out(ssd3));
    
    ssd ssdControl(.clk(clk), .rst(rst), .a0(ssd0[0]), .a1(ssd1[0]), .a2(ssd2[0]), .a3(ssd3[0]),
    .b0(ssd0[1]), .b1(ssd1[1]), .b2(ssd2[1]), .b3(ssd3[1]), .c0(ssd0[2]), .c1(ssd1[2]), .c2(ssd2[2]), .c3(ssd3[2]),
    .d0(ssd0[3]), .d1(ssd1[3]), .d2(ssd2[3]), .d3(ssd3[3]), .e0(ssd0[4]), .e1(ssd1[4]), .e2(ssd2[4]), .e3(ssd3[4]),
    .f0(ssd0[5]), .f1(ssd1[5]), .f2(ssd2[5]), .f3(ssd3[5]), .g0(ssd0[6]), .g1(ssd1[6]), .g2(ssd2[6]), .g3(ssd3[6]),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .an0(an0), .an1(an1), .an2(an2), .an3(an3));
    
    debouncer t0BUT(.clk(clk), .rst(rst), .noisy_in(T0btn), .clean_out(T0btn_c));
    debouncer t1BUT(.clk(clk), .rst(rst), .noisy_in(T1btn), .clean_out(T1btn_c));
    debouncer cBUT(.clk(clk), .rst(rst), .noisy_in(Cbtn), .clean_out(Cbtn_c));
    
endmodule
