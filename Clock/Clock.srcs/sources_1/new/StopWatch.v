`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 20:25:35
// Design Name: 
// Module Name: StopWatch
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


/************ 秒表 ************/
module StopWatch( clk_1s,reset,K1,K2,SmH,SmL,SsH,SsL );
input clk_1s; //1Hz 时钟 
input reset; //复位输入 
input K1; //K1,K2,K5,shift 为模式选择
input K2; 
output reg[3:0] SmH; //分钟高位 
output reg[3:0] SmL; //分钟低位 
output reg[3:0] SsH; //秒高位 
output reg[3:0] SsL; //秒低位

always@(posedge clk_1s )
    begin
        //reset 低电平时复位
        if(reset == 0) 
            begin
                SmH = 4'd0;
                SmL = 4'd0;
                SsH = 4'd0;
                SsL = 4'd0;
            end
        //K1 为低电平， K2 为高电平时开启秒表
        if( K1 == 0 && K2 == 1 ) 
            begin
                SsL = SsL + 4'd1;
                if( SsL == 4'd10 ) 
                    begin
                        SsL = 0 ;
                        SsH = SsH + 4'd1;
                        if( SsH == 4'd6 ) 
                            begin
                                SsH = 0 ;
                                SmL = SmL + 4'd1;
                                if( SmL == 4'd10 ) 
                                    begin
                                        SmL = 0 ;
                                        SmH = SmH + 4'd1 ;
                                        if( SmH == 4'd6 ) 
                                            begin
                                                SmH = 0 ;
                                            end
                                    end
                            end
                    end
            end
    end
    
endmodule
