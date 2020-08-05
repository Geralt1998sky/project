`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 20:47:40
// Design Name: 
// Module Name: Switch
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


/************ 显示选择模块 ************/
module Switch(clk_in, reset, K1, K2, mH, mL, hH, hL, AhH, AhL,AmH, AmL, SmH, SmL, SsH, SsL, led_7seg, led_sel); 
input clk_in; //时钟 
input reset; //复位输入 
input K1; //K1,K2,K5,shift 为模式选择
input K2;
input [3:0] mH;
input [3:0] mL;
input [3:0] hH;
input [3:0] hL;
input [3:0] AhH;
input [3:0] AhL;
input [3:0] AmH;
input [3:0] AmL;
input [3:0] SmH;
input [3:0] SmL;
input [3:0] SsH;
input [3:0] SsL;
output [6:0] led_7seg;
output [3:0] led_sel;
reg [3:0] YmH;
reg [3:0] YmL;
reg [3:0] YhH;
reg [3:0] YhL;

always @(posedge clk_in) 
    begin 
        //K2 为低电平时显示时钟
        if(K2 == 0) begin
            YmH = mH;
            YmL = mL;
            YhH = hH;
            YhL = hL;
        end
        //K1 为低电平， K2 为高电平时显示秒表
        else if ( K1 == 0 ) begin
            YmH = SsH;
            YmL = SsL;
            YhH = SmH;
            YhL = SmL;
        end
        //K1 为高电平， K2 为高电平时显示闹钟
        else if ( K1 == 1 ) begin
            YmH = AmH;
            YmL = AmL;
            YhH = AhH;
            YhL = AhL;
        end
    end
    
//连接译码器
Decoder myDecoder(
.reset(reset),
.clk_in(clk_in),
.YhH(YhH),
.YhL(YhL),
.YmH(YmH),
.YmL(YmL),
.led_7seg(led_7seg),
.led_sel(led_sel)
);

endmodule



module Decoder( reset,clk_in,YmL,YmH,YhL,YhH,led_7seg,led_sel ); 
input reset; //时钟
input clk_in; //复位输入 
input [3:0] YmL; //小时高位 
input [3:0] YmH; //小时低位
input [3:0] YhL; //分钟高位 
input [3:0] YhH; //分钟低位 
output reg[6:0] led_7seg; //数码管段选 
output reg[3:0] led_sel; //数码管片选 
reg[1:0] sel; //数码管扫描计数器 
reg[3:0] count; //临时变量

always@(posedge clk_in) 
    begin 
        //reset 低电平时复位
        if(reset == 0) begin
            led_7seg = 7'd0;
            sel = 2'd0;
            led_sel = 4'b1110;
            count = 4'd0;
        end
        sel = sel + 2'b01; 
        case(sel) //数码管的扫描
            2'b00:count = YmL;
            2'b01:count = YmH;
            2'b10:count = YhL;
            2'b11:count = YhH;
        endcase
        if(sel == 2'b00) led_sel = 4'b1110;
        else if(sel == 2'b01) led_sel = 4'b1101;
        else if(sel == 2'b10) led_sel = 4'b1011;
        else if(sel == 2'b11) led_sel = 4'b0111; 
        //译码
        case(count)
            4'd0 : led_7seg = 7'b0000001;
            4'd1 : led_7seg = 7'b1001111;
            4'd2 : led_7seg = 7'b0010010;
            4'd3 : led_7seg = 7'b0000110;
            4'd4 : led_7seg = 7'b1001100;
            4'd5 : led_7seg = 7'b0100100;
            4'd6 : led_7seg = 7'b0100000;
            4'd7 : led_7seg = 7'b0001111;
            4'd8 : led_7seg = 7'b0000000;
            4'd9 : led_7seg = 7'b0000100;
            default : led_7seg = 7'b1111111;
        endcase
    end
    
endmodule

