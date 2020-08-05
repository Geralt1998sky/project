`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 15:06:30
// Design Name: 
// Module Name: Testbench_AC
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


module Testbench_AC();
reg clk_in; //时钟 
reg reset; //复位输入 
//时钟时间
reg [3:0] hL;
reg [3:0] hH;
reg [3:0] mL;
reg [3:0] mH; 
//闹钟时间
reg [3:0] AhL;
reg [3:0] AhH;
reg [3:0] AmL;
reg [3:0] AmH; 
//闹钟提示
wire Sout;

AlarmClock test(
        .clk_in(clk_in),
        .reset(reset),
        .Sout(Sout),
        .hH(hH),
        .hL(hL),
        .mH(mH),
        .mL(mL),
        .AhH(AhH),
        .AhL(AhL),
        .AmH(AmH),
        .AmL(AmL)
       );
       
     always #1 clk_in = ~clk_in;

     initial begin
       reset = 0; clk_in= 1;
       AhL=0;AhH=1;AmL=0;AmH=3; 
       hL=0;hH=0;mL=0;mH=0; 
       #40 reset = 1;
       #1960 hL=0;hH=1;mL=0;mH=3; 
     end
endmodule
