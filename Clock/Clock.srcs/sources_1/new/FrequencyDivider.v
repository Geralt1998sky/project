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


/************ ��Ƶģ�� ************/
module FrequencyDivider( clk_in, reset, clk_1s, clk_1ms ); 
input clk_in; //ʱ������ 
input reset; //��λ����
output reg clk_1s; //1Hz ʱ����� 
output reg clk_1ms; //1kHz ʱ����� 
reg[28:0] cnt_1s; //1Hz ������ 
reg[19:0] cnt_1ms; //1kHz ������

always@(posedge clk_in)
    begin
        //reset �͵�ƽʱ��λ
        if(reset == 0) 
        begin
            cnt_1s = 0;
            clk_1s = 1;
            cnt_1ms = 0;
            clk_1ms = 1;
        end 
        //�������� 1
        cnt_1s = cnt_1s + 29'd1;
        cnt_1ms = cnt_1ms + 20'd1;
        //�� 100MHz ʱ�ӷ�ƵΪ 1Hz ������ 50000000
        if(cnt_1s == 29'd2) 
            begin
                cnt_1s = 29'd0;
                clk_1s = ~clk_1s;
            end 
            //�� 100MHz ʱ�ӷ�ƵΪ 1kHz ������ 50000
        if(cnt_1ms == 20'd5) 
            begin
                cnt_1ms = 20'd0;
                clk_1ms = ~clk_1ms;
            end   
    end
    
endmodule

