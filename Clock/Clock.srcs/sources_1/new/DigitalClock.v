`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 09:36:09
// Design Name: 
// Module Name: DigitalClock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DigitalClock( clk_in, reset, K1, K2, K5, shift, Sout, led_7seg, led_sel ,hH, hL, mH, mL);
input clk_in;
input reset;
input K1; 
input K2;
input K5;
input [1:0]shift;  
output Sout; 
output [6:0] led_7seg;
output [3:0] led_sel;
output [3:0] hH; //小时高位 
output [3:0] hL; //小时低位 
output [3:0] mH; //分钟高位 
output [3:0] mL; //分钟低位

wire clk_1s, clk_1ms;
wire SmH, SmL, SsH, SsL;
wire AhH, AhL, AmH, AmL;

FrequencyDivider u1( 
.clk_in(clk_in),
.reset(reset), 
.clk_1s(clk_1s), 
.clk_1ms(clk_1ms)
); 

Timer u2( 
.clk_1s(clk_1s), 
.reset(reset), 
.K1(K1), 
.K2(K2), 
.shift(shift), 
.K5(K5), 
.hH(hH), 
.hL(hL), 
.mH(mH), 
.mL(mL)
); 

StopWatch u3( 
.clk_1s(clk_1s),
.reset(reset),
.K1(K1),
.K2(K2),
.SmH(SmH),
.SmL(SmL),
.SsH(SsH),
.SsL(SsL)
);

SetAlarm u4( 
.clk_1s(clk_1s),
.reset(reset),
.K1(K1),
.K2(K2),
.shift(shift),
.K5(K5),
.AhH(AhH),
.AhL(AhL),
.AmH(AmH),
.AmL(AmL)
);

AlarmClock u5( 
.clk_in(clk_in),
.reset(reset),
.Sout(Sout),
.mL(mL),
.mH(mH),
.hL(hL),
.hH(hH),
.AhH(AhH),
.AhL(AhL),
.AmH(AmH),
.AmL(AmL)
); 

Switch u6(
.clk_in(clk_in),
.reset(reset),
.K1(K1), 
.K2(K2), 
.mH(mH), 
.mL(mL), 
.hH(hH), 
.hL(hL), 
.AhH(AhH),
.AhL(AhL),
.AmH(AmH), 
.AmL(AmL), 
.SmH(SmH), 
.SmL(SmL), 
.SsH(SsH), 
.SsL(SsL), 
.led_7seg(led_7seg), 
.led_sel(led_sel)
); 

endmodule
