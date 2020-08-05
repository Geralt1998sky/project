`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 19:55:16
// Design Name: 
// Module Name: FrequencyDivider
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


/************ 分频模块 ************/
module FrequencyDivider( clk_in, reset, clk_1s, clk_1ms ); 
input clk_in; //时钟输入 
input reset; //复位输入
output reg clk_1s; //1Hz 时钟输出 
output reg clk_1ms; //1kHz 时钟输出 
reg[28:0] cnt_1s; //1Hz 计数器 
reg[19:0] cnt_1ms; //1kHz 计数器

always@(posedge clk_in)
    begin
        //reset 低电平时复位
        if(reset == 0) 
        begin
            cnt_1s = 0;
            clk_1s = 1;
            cnt_1ms = 0;
            clk_1ms = 1;
        end 
        //计数器加 1
        cnt_1s = cnt_1s + 29'd1;
        cnt_1ms = cnt_1ms + 20'd1;
        //将 100MHz 时钟分频为 1Hz 的脉冲 50000000
        if(cnt_1s == 29'd2) 
            begin
                cnt_1s = 29'd0;
                clk_1s = ~clk_1s;
            end 
            //将 100MHz 时钟分频为 1kHz 的脉冲 50000
        if(cnt_1ms == 20'd5) 
            begin
                cnt_1ms = 20'd0;
                clk_1ms = ~clk_1ms;
            end   
    end
    
endmodule

