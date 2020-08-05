`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 20:31:38
// Design Name: 
// Module Name: SetAlarm
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


/************ 设置闹钟时间 ************/
module SetAlarm( clk_1s,reset,K1,K2,shift,K5,AhH,AhL,AmH,AmL );
input clk_1s; //1Hz 时钟 
input reset; //复位输入 
input K1; //K1,K2,K5,shift 为模式选择
input K2;
input K5;
input [1:0]shift; 
output reg[3:0] AhH; //小时高位
output reg[3:0] AhL; //小时低位 
output reg[3:0] AmH; //分钟高位 
output reg[3:0] AmL; //分钟低位

always@(posedge clk_1s )
    begin
    //reset 低电平时复位
    if(reset == 0) begin
        AhH = 4'd0;
        AhL = 4'd0;
        AmH = 4'd0;
        AmL = 4'd1;
    end
    if ( K1 == 1 && K2 == 1 ) begin
        case(shift ) //查看现在校时位 
        2'b00: begin //处于分钟的个位
        if( K5 == 1 ) begin
            AmL = AmL + 1;
            if(AmL >= 4'd10)
            AmL = 4'd0;
        end 
        end
        
        2'b01: begin //处于分钟的十位 
        if( K5 == 1 ) begin //分钟十位变化范围为 0~5
            AmH = AmH + 1 ;
            if(AmH >= 4'd6)
            AmH = 4'd0;
        end
        end 
        
        2'b10: begin //处于时钟的个位
        if( K5 == 1 ) begin
            AhL = AhL + 1;
            if(AhL >= 4'd10)
            AhL = 4'd0;
        end
        end 
        
        2'b11: begin //处于时钟的十位
        if( K5 == 1 )
            if( AhL < 4 ) begin //时钟个位小于 4 
                AhH = AhH + 1; //时钟十位的变化范围为 0~2
                if(AhH >= 4'd3)
                AhH = 4'd0;
            end 
            else begin //时钟个位大于等于 5 
                AhH = AhH + 1; //时钟个位的变化范围为 0~1
                if(AhH >= 4'd2)
                AhH = 4'd0;
            end
        end
        
        endcase
    end
    end
    
endmodule
