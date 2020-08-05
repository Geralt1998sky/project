`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 20:42:46
// Design Name: 
// Module Name: AlarmClock
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


/************ 闹钟模块 ************/
module AlarmClock( clk_in,reset,Sout,mL,mH,hL,hH,AhH,AhL,AmH,AmL ); 
input clk_in; //时钟 
input reset; //复位输入 
//时钟时间
input [3:0] hL;
input [3:0] hH;
input [3:0] mL;
input [3:0] mH; 
//闹钟时间
input [3:0] AhL;
input [3:0] AhH;
input [3:0] AmL;
input [3:0] AmH; 
//闹钟提示
output reg Sout;

always@( posedge clk_in )
    begin
        //reset 低电平时复位
        if( reset == 0 ) begin
            Sout = 1'd0;
        end
        if( ( AhH == hH ) && ( AhL == hL ) && ( AmH == mH ) && ( AmL == mL ) )
        //当闹钟时间到来时 
        Sout = 1; //led 灯亮 
        else 
        //当闹钟时间没有到来时
        Sout = 0; //led 灯灭
    end
    
endmodule
