/*
 * Yigit Suoglu
 * Bank Queue Management System
 * Designed to work on Digilent Basys 3 but it should work on any FPGA
 * Size of password switches and leds output can be changed without effecting functionality
 */
`timescale 1ns / 1ps

module bankSystem(ssd0, ssd1, ssd2, ssd3, passSW, Teller1btn, Teller0btn,
  bankLed, Teller1led, Teller0led, rst, clk, customerBTN, counterSW, bankSW, chPASS, Wait);


  input clk, rst; //clock and reset
  output [4:0] ssd1, ssd2, ssd3, ssd0; //what each ssd should be in abcdefg format
  input [11:0] passSW; //password switches
  input Teller1btn, Teller0btn; //teller buttons
  input customerBTN; //button for customer to take number
  input counterSW; //open-close counter
  input bankSW; //open-close bank
  input chPASS; //change password
  output reg bankLed, Teller1led, Teller0led; //bank & counter open leds
  reg [7:0] callingCus, totalCus, teller1call, teller0call;
  //output [12:0] leds; //other leds to show stage
  reg [11:0] passT1, passT0; //holds passwords for tellers default 12'd0;
  reg trigQueNumTake; //trigger to show taken Queue number
  output reg Wait; //waiting something, works with operation signal
  reg waitswho; //Shows system waitng who, work with wait signal

  wire blinkOff, queueActive;
  wire [7:0] waitingCus; //remaning customer
  wire readyForClose; //no customer left and both counters are closed
  wire [2:0] operation; //combined operation switches
  wire notRdyCls;

  assign notRdyCls = ~readyForClose & bankSW;
  assign operation = {bankSW, counterSW, chPASS}; //order: bank, counter, change password
  assign readyForClose = (~(Teller1led | Teller0led) & (callingCus == totalCus)) | ~bankLed;
  assign waitingCus = totalCus - callingCus;

  always@(posedge clk or posedge rst) //Calling customer
    begin
      if(rst)
        begin
          teller1call <= 8'b0;
          teller0call <= 8'b0;
          callingCus <= 8'b0;
        end
      else if((operation == 3'b0) & (waitingCus != 8'b0))
        begin
        /* if(Teller0btn & Teller1btn & Teller1led & Teller0led) //both tellers call at same time cycle, not necessary
            begin
              teller1call <= callingCus + 8'b10;
              teller0call <= callingCus + 8'b1;
              callingCus <= callingCus + 8'b10;
            end 
          else */if(Teller0btn & Teller0led)
            begin
              teller0call <= callingCus + 8'b1;
              callingCus <= callingCus + 8'b1;
            end
          else if(Teller1btn & Teller1led)
            begin
              teller1call <= callingCus + 8'b1;
              callingCus <= callingCus + 8'b1;
            end
        end
    end

  always@(posedge clk or posedge rst) //operations
    begin
      if(rst)
        begin
          bankLed <= 0;
          Teller0led <= 0;
          Teller1led <= 0;
          Wait <= 0;
          passT0 <= 12'd0;
          passT1 <= 12'd0;
        end
      else
        case (operation)
          3'b100: //bank open-close
            begin //#1
              if(readyForClose)
                begin //#2
                  if (Wait) //if one of the tellers entered pasword
                      case(waitswho)
                        0: if((passSW == passT0) & Teller0btn)
                            begin //#3
                              bankLed <= ~bankLed;
                              Wait <= 0;
                            end //#3
                        1: if((passSW == passT1) & Teller1btn)
                            begin //#3
                              bankLed <= ~bankLed;
                              Wait <= 0;
                            end //#3
                      endcase
                  else
                    begin //#3
                      if((passSW == passT0) & Teller0btn)
                        begin //#4
                          Wait <= 1;
                          waitswho <= 1;
                        end //#4
                      else if((passSW == passT1) & Teller1btn)
                        begin //#4
                          Wait <= 1;
                          waitswho <= 0;
                        end //#4
                    end //#3
                  end //#2
            end //#1
          3'b010: //counter open-close
            begin
              if((passSW == passT0) & Teller0btn)
                  Teller0led <= ~Teller0led;
              else if((passSW == passT1) & Teller1btn)
                  Teller1led <= ~Teller1led;
            end
          3'b001: //change password
            begin
              if (Wait) //if one of the tellers entered pasword
                  case(waitswho)
                    0: if(Teller0btn)
                        passT0 <= passSW;
                    1: if(Teller1btn)
                        passT1 <= passSW;
                  endcase
              else
                begin //#3
                  if((passSW == passT0) & Teller0btn)
                    begin //#4
                      Wait <= 1;
                      waitswho <= 0;
                    end //#4
                  else if((passSW == passT1) & Teller1btn)
                    begin //#4
                      Wait <= 1;
                      waitswho <= 1;
                    end //#4
                end //#3
            end
          default: Wait <= 0;
        endcase
    end

  always@(posedge clk or posedge rst) //Queue number taking
    begin
      if (rst)
        begin
          trigQueNumTake <= 0;
          totalCus <= 8'd0;
        end
      else if(bankLed)
        begin
          if(customerBTN)
            begin
              trigQueNumTake <= 1;
              totalCus <= totalCus + 8'b1;
            end
          else
            begin
              trigQueNumTake <= 0;
            end
        end
      else
        begin
          totalCus <= 8'd0;
          trigQueNumTake <= 0;
        end
    end

  displaySelection ssdSelector(.dig0(ssd0), .dig1(ssd1), .dig2(ssd2), .dig3(ssd3),
      .bankClosed(bankLed), .queueNum(queueActive), .totalCus(totalCus),
      .teller1call(teller1call), .teller0call(teller0call),
      .notRdyCls(notRdyCls), .waitingCus(waitingCus), .blinkOff(blinkOff));

  queueNumTakeProces queuemng(.trigQueNumTake(trigQueNumTake), .clk(clk), .rst(rst),
                                .queueActive(queueActive), .blinkOff(blinkOff));

endmodule

module displaySelection(dig0, dig1, dig2, dig3, bankClosed, queueNum, totalCus,
  teller1call, teller0call, notRdyCls, waitingCus, blinkOff/*, pswrdCH*/);
  parameter a = 5'd10, b = 5'd11, c = 5'd12, d = 5'd13, h = 5'd19;
  parameter e = 5'd14, f = 5'd15, o = 5'd16, L = 5'd17, p = 5'd18, r = 5'd20;

  output reg [4:0] dig0, dig1, dig2, dig3;
  input bankClosed, notRdyCls;
  input blinkOff, queueNum/*, pswrdCH*/;
  input [7:0] totalCus, teller1call, teller0call, waitingCus;

  always@(*)
    if(!bankClosed) //bank closed
      begin
        dig3 = c;
        dig2 = L;
        dig1 = 5'd5; //s
        dig0 = d;
      end
    else if(blinkOff) //ssd's are not ilmunated (used for blinking)
      begin
        dig3 = 5'b11111;
        dig2 = 5'b11111;
        dig1 = 5'b11111;
        dig0 = 5'b11111;
      end
    else if(queueNum) //show taken number
      begin
        dig3 = 5'b11111;
        dig2 = 5'b11111;
        dig1 = {1'b0 ,totalCus[7:4]};
        dig0 = {1'b0 ,totalCus[3:0]};
      end
    else if(notRdyCls) //show taken number
      begin
        dig3 = r;
        dig2 = 5'd12; //c
        dig1 = {1'b0 ,waitingCus[7:4]};
        dig0 = {1'b0 ,waitingCus[3:0]};
      end
  /*  else if(pswrdCH) //ch pasword mode
      begin
        dig3 = 5'd12; //c
        dig2 = h;
        dig1 = p;//
        dig0 = 5'd5; //s
      end */
    else
      begin //last called number
        dig3 = {1'b0 ,teller1call[7:4]};
        dig2 = {1'b0 ,teller1call[3:0]};
        dig1 = {1'b0 ,teller0call[7:4]};
        dig0 = {1'b0 ,teller0call[3:0]};
      end
endmodule

module queueNumTakeProces(trigQueNumTake, clk, rst, queueActive, blinkOff);
  input trigQueNumTake, clk, rst;
  output reg queueActive;
  output blinkOff;
  reg [1:0] state;
  wire oneSecSig, quarSecSig, quaTrig, quaTrigRep;
  reg quarSecSig_s;

  quarSecWait quaCount(.start(quaTrig), .rst(rst), .clk(clk), .lastCycle(quarSecSig));
  oneSecWait oneCount(.start(trigQueNumTake), .rst(rst), .clk(clk), .lastCycle(oneSecSig));

  assign quaTrig = trigQueNumTake | quaTrigRep;
  assign blinkOff = state[0];

  always@(posedge clk or posedge rst) //state transaction
    begin
      if (rst)
        begin
          state <= 2'b0;
        end
      else
        case (state)
          2'b11: state <= 2'b0;
          default: state <= state + {1'b0, quarSecSig};
        endcase
    end

  always@(posedge clk or posedge rst)//queueActive signal
    if (rst)
        queueActive <= 0;
    else if (oneSecSig)
        queueActive <= 0;
    else if (trigQueNumTake)
        queueActive <= 1;

    assign quaTrigRep = quarSecSig_s & (state != 2'd3);

    always@(posedge clk)
        begin
            quarSecSig_s <= quarSecSig;   
        end
            


endmodule
