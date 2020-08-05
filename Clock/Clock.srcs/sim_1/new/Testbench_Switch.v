`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 15:14:42
// Design Name: 
// Module Name: Testbench_Switch
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


module Testbench_Switch();
reg clk_in; //时钟 
reg reset; //复位输入 
reg K1; //K1,K2,K5,shift 为模式选择
reg K2;
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
reg [3:0] SmH; //分钟高位 
reg [3:0] SmL; //分钟低位 
reg [3:0] SsH; //秒高位 
reg [3:0] SsL; //秒低位
wire [6:0] led_7seg;
wire [3:0] led_sel;

Switch test(
        .clk_in(clk_in),
        .reset(reset),
        .K1(K1),
        .K2(K2),
        .hH(hH),
        .hL(hL),
        .mH(mH),
        .mL(mL),
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
       
     always #1 clk_in = ~clk_in;

     initial begin
       reset = 0; clk_in= 1;
       AhL=0;AhH=1;AmL=0;AmH=3; 
       hL=0;hH=0;mL=0;mH=0; 
       SmH=1;SmL=0;SsH=4;SsL=5;
       K1=0;K2=0;
       #40 reset = 1;
       #960 K1=0;K2=1;
       #1000 K1=1;K2=1;
     end
endmodule
