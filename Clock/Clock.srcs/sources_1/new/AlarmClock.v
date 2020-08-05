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


/************ ����ģ�� ************/
module AlarmClock( clk_in,reset,Sout,mL,mH,hL,hH,AhH,AhL,AmH,AmL ); 
input clk_in; //ʱ�� 
input reset; //��λ���� 
//ʱ��ʱ��
input [3:0] hL;
input [3:0] hH;
input [3:0] mL;
input [3:0] mH; 
//����ʱ��
input [3:0] AhL;
input [3:0] AhH;
input [3:0] AmL;
input [3:0] AmH; 
//������ʾ
output reg Sout;

always@( posedge clk_in )
    begin
        //reset �͵�ƽʱ��λ
        if( reset == 0 ) begin
            Sout = 1'd0;
        end
        if( ( AhH == hH ) && ( AhL == hL ) && ( AmH == mH ) && ( AmL == mL ) )
        //������ʱ�䵽��ʱ 
        Sout = 1; //led ���� 
        else 
        //������ʱ��û�е���ʱ
        Sout = 0; //led ����
    end
    
endmodule
