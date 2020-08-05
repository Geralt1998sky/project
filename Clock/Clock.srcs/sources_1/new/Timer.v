`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 20:01:34
// Design Name: 
// Module Name: Timer
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


/************ 计时模块 ************/
module Timer( clk_1s, reset, K1, K2, shift, K5, hH, hL, mH, mL ); 
input clk_1s; //1Hz 时钟
input reset; //复位输入 
input K1; //K1,K2,K5,shift 为模式选择
input K2;
input K5;
input [1:0]shift; 
output reg[3:0] hH; //小时高位 
output reg[3:0] hL; //小时低位 
output reg[3:0] mH; //分钟高位 
output reg[3:0] mL; //分钟低位 
reg[3:0] sH; //秒高位
reg[3:0] sL; //秒低位

always@(posedge clk_1s)
    begin
        //reset 低电平时复位
        if(reset == 0) 
            begin
                hH = 4'd0;
                hL = 4'd0;
                mH = 4'd0;
                mL = 4'd0;
                sH = 4'd0;
                sL = 4'd0;
            end
        //K1,K2 都为低电平时正常计时
        if( K1 == 0 && K2 == 0 ) 
            begin
                sL = sL + 4'd1;
                if( sL == 4'd10 ) 
                    begin
                        sL = 0 ;
                        sH = sH + 4'd1 ;
                        if( sH == 4'd6 ) 
                            begin
                                sH = 0 ;
                                mL = mL + 4'd1;
                                if( mL == 4'd10 ) 
                                    begin
                                    mL = 0 ;
                                    mH = mH + 4'd1 ;
                                    if( mH == 4'd6 ) 
                                        begin
                                            mH = 0 ;
                                            hL = hL + 4'd1 ;
                                            if( hL == 4'd10 ) 
                                                begin
                                                    hL = 0 ;
                                                    hH = hH+4'd1 ;
                                                end
                                            if( hH == 4'd2 && hL == 4'd4 ) 
                                                begin
                                                    hL = 0 ;
                                                    hH = 0 ;
                                                end
                                    end
                        end
                end
        end
        end 
        //K1 为高电平， K2 为低电平时设置时间
        else if( K1 == 1 && K2 == 0 ) 
            begin 
                case(shift ) //查看现在校时位
                2'b00: begin //处于分钟的个位
                if( K5 == 1 ) 
                    begin
                        mL = mL + 1;
                        if(mL >= 4'd10)
                        mL = 4'd0;
                    end
                end 
                
                2'b01: begin //处于分钟的十位，分钟十位变化范围为 0~5
                if( K5 == 1 ) 
                    begin
                        mH = mH + 1 ;
                        if(mH >= 4'd6)
                        mH = 4'd0;
                    end
                end 
                
                2'b10: begin //处于时钟的个位
                if( K5 == 1 ) 
                    begin
                        hL = hL + 1;
                        if(hL >= 4'd10)
                        hL = 4'd0;
                    end
                end 
                
                2'b11: begin //处于时钟的十位
                if( K5 == 1 ) 
                    if( hL < 4 ) 
                        begin //时钟个位小于 4，时钟十位的变化范围为 0~2
                            hH = hH + 1 ;
                            if(hH >= 4'd3)
                            hH = 4'd0;
                        end 
                        else begin //时钟个位大于等于 4，时钟个位的变化范围为 0~1
                            hH = hH + 1 ;
                            if(hH >= 4'd2)
                            hH = 4'd0;
                        end
                    end
                endcase
            end
    end
    
endmodule
