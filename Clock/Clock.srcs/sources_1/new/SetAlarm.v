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


/************ ��������ʱ�� ************/
module SetAlarm( clk_1s,reset,K1,K2,shift,K5,AhH,AhL,AmH,AmL );
input clk_1s; //1Hz ʱ�� 
input reset; //��λ���� 
input K1; //K1,K2,K5,shift Ϊģʽѡ��
input K2;
input K5;
input [1:0]shift; 
output reg[3:0] AhH; //Сʱ��λ
output reg[3:0] AhL; //Сʱ��λ 
output reg[3:0] AmH; //���Ӹ�λ 
output reg[3:0] AmL; //���ӵ�λ

always@(posedge clk_1s )
    begin
    //reset �͵�ƽʱ��λ
    if(reset == 0) begin
        AhH = 4'd0;
        AhL = 4'd0;
        AmH = 4'd0;
        AmL = 4'd1;
    end
    if ( K1 == 1 && K2 == 1 ) begin
        case(shift ) //�鿴����Уʱλ 
        2'b00: begin //���ڷ��ӵĸ�λ
        if( K5 == 1 ) begin
            AmL = AmL + 1;
            if(AmL >= 4'd10)
            AmL = 4'd0;
        end 
        end
        
        2'b01: begin //���ڷ��ӵ�ʮλ 
        if( K5 == 1 ) begin //����ʮλ�仯��ΧΪ 0~5
            AmH = AmH + 1 ;
            if(AmH >= 4'd6)
            AmH = 4'd0;
        end
        end 
        
        2'b10: begin //����ʱ�ӵĸ�λ
        if( K5 == 1 ) begin
            AhL = AhL + 1;
            if(AhL >= 4'd10)
            AhL = 4'd0;
        end
        end 
        
        2'b11: begin //����ʱ�ӵ�ʮλ
        if( K5 == 1 )
            if( AhL < 4 ) begin //ʱ�Ӹ�λС�� 4 
                AhH = AhH + 1; //ʱ��ʮλ�ı仯��ΧΪ 0~2
                if(AhH >= 4'd3)
                AhH = 4'd0;
            end 
            else begin //ʱ�Ӹ�λ���ڵ��� 5 
                AhH = AhH + 1; //ʱ�Ӹ�λ�ı仯��ΧΪ 0~1
                if(AhH >= 4'd2)
                AhH = 4'd0;
            end
        end
        
        endcase
    end
    end
    
endmodule
