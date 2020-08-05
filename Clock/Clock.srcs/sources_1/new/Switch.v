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


/************ ��ʾѡ��ģ�� ************/
module Switch(clk_in, reset, K1, K2, mH, mL, hH, hL, AhH, AhL,AmH, AmL, SmH, SmL, SsH, SsL, led_7seg, led_sel); 
input clk_in; //ʱ�� 
input reset; //��λ���� 
input K1; //K1,K2,K5,shift Ϊģʽѡ��
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
        //K2 Ϊ�͵�ƽʱ��ʾʱ��
        if(K2 == 0) begin
            YmH = mH;
            YmL = mL;
            YhH = hH;
            YhL = hL;
        end
        //K1 Ϊ�͵�ƽ�� K2 Ϊ�ߵ�ƽʱ��ʾ���
        else if ( K1 == 0 ) begin
            YmH = SsH;
            YmL = SsL;
            YhH = SmH;
            YhL = SmL;
        end
        //K1 Ϊ�ߵ�ƽ�� K2 Ϊ�ߵ�ƽʱ��ʾ����
        else if ( K1 == 1 ) begin
            YmH = AmH;
            YmL = AmL;
            YhH = AhH;
            YhL = AhL;
        end
    end
    
//����������
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
input reset; //ʱ��
input clk_in; //��λ���� 
input [3:0] YmL; //Сʱ��λ 
input [3:0] YmH; //Сʱ��λ
input [3:0] YhL; //���Ӹ�λ 
input [3:0] YhH; //���ӵ�λ 
output reg[6:0] led_7seg; //����ܶ�ѡ 
output reg[3:0] led_sel; //�����Ƭѡ 
reg[1:0] sel; //�����ɨ������� 
reg[3:0] count; //��ʱ����

always@(posedge clk_in) 
    begin 
        //reset �͵�ƽʱ��λ
        if(reset == 0) begin
            led_7seg = 7'd0;
            sel = 2'd0;
            led_sel = 4'b1110;
            count = 4'd0;
        end
        sel = sel + 2'b01; 
        case(sel) //����ܵ�ɨ��
            2'b00:count = YmL;
            2'b01:count = YmH;
            2'b10:count = YhL;
            2'b11:count = YhH;
        endcase
        if(sel == 2'b00) led_sel = 4'b1110;
        else if(sel == 2'b01) led_sel = 4'b1101;
        else if(sel == 2'b10) led_sel = 4'b1011;
        else if(sel == 2'b11) led_sel = 4'b0111; 
        //����
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

