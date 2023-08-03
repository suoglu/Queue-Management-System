/*
 *  Yigit Suoglu 
 *    Licence: CERN-OHL-W  
 *    Out signals in form of abcdefg corresponding:
 *      a
 *    f   b        Note: abcdefg signals should driven low to ilmunate
 *      g                corresponding segment.
 *    e   c
 *      d
 */
 `timescale 1ns / 1ps

module int4bitToHexSSD(in, out);
  parameter zero = 7'b0000001, one = 7'b1001111, two = 7'b0010010;
  parameter thr = 7'b0000110, four = 7'b1001100, five = 7'b0100100;
  parameter six = 7'b0100000, svn = 7'b0001111, eght = 7'b0000000;
  parameter nine = 7'b0000100, A = 7'b0001000, B = 7'b1100000;
   parameter C = 7'b0110001, D = 7'b1000010, E = 7'b0110000, F = 7'b0111000;


  input [3:0] in;
  output reg [6:0] out;

  always@(*)
        case (in)
          4'b0: out = zero;
          4'b1: out = one;
          4'b10: out = two;
          4'b11: out = thr;
          4'b100: out = four;
          4'b101: out = five;
          4'b110: out = six;
          4'b111: out = svn;
          4'b1000: out = eght;
          4'b1001: out = nine;
          4'b1010: out = A;
          4'b1011: out = B;
          4'b1100: out = C;
          4'b1101: out = D;
          4'b1110: out = E;
          4'b1111: out = F;

        endcase
endmodule

module int5bitToHexSSD_bankVer(in, out);
  parameter zero = 7'b0000001, one = 7'b1001111, two = 7'b0010010; //in = 0, 1, 2
  parameter thr = 7'b0000110, four = 7'b1001100, five = 7'b0100100; //in = 3, 4, 5 ~ 5 = s in ssd
  parameter six = 7'b0100000, svn = 7'b0001111, eght = 7'b0000000; //in = 6, 7, 8
  parameter nine = 7'b0000100, A = 7'b0001000, B = 7'b1100000; //in = 9, 10, 11
  parameter C = 7'b0110001, D = 7'b1000010, E = 7'b0110000, F = 7'b0111000; //in = 12, 13, 14, 15
  parameter  o = 7'b1100010, L = 7'b1110001, empty = 7'b1111111; //in = 16, 17, others
  parameter  p = 7'b0011000, h = 7'b1101000, r = 7'b1111010; //in = 18, 19, 20




  input [4:0] in;
  output reg [6:0] out;

  always@(*)
        case (in)
          5'b0: out = zero;
          5'b1: out = one;
          5'b10: out = two;
          5'b11: out = thr;
          5'b100: out = four;
          5'b101: out = five;
          5'b110: out = six;
          5'b111: out = svn;
          5'b1000: out = eght;
          5'b1001: out = nine;
          5'b1010: out = A;
          5'b1011: out = B;
          5'b1100: out = C;
          5'b1101: out = D;
          5'b1110: out = E;
          5'b1111: out = F;
          5'b10000: out = o;
          5'b10001: out = L;
          5'b10010: out = p;
          5'b10011: out = h;
          5'b10100: out = r;
          default: out = empty;
        endcase
endmodule
