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


/************ ��ʱģ�� ************/
module Timer( clk_1s, reset, K1, K2, shift, K5, hH, hL, mH, mL ); 
input clk_1s; //1Hz ʱ��
input reset; //��λ���� 
input K1; //K1,K2,K5,shift Ϊģʽѡ��
input K2;
input K5;
input [1:0]shift; 
output reg[3:0] hH; //Сʱ��λ 
output reg[3:0] hL; //Сʱ��λ 
output reg[3:0] mH; //���Ӹ�λ 
output reg[3:0] mL; //���ӵ�λ 
reg[3:0] sH; //���λ
reg[3:0] sL; //���λ

always@(posedge clk_1s)
    begin
        //reset �͵�ƽʱ��λ
        if(reset == 0) 
            begin
                hH = 4'd0;
                hL = 4'd0;
                mH = 4'd0;
                mL = 4'd0;
                sH = 4'd0;
                sL = 4'd0;
            end
        //K1,K2 ��Ϊ�͵�ƽʱ������ʱ
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
        //K1 Ϊ�ߵ�ƽ�� K2 Ϊ�͵�ƽʱ����ʱ��
        else if( K1 == 1 && K2 == 0 ) 
            begin 
                case(shift ) //�鿴����Уʱλ
                2'b00: begin //���ڷ��ӵĸ�λ
                if( K5 == 1 ) 
                    begin
                        mL = mL + 1;
                        if(mL >= 4'd10)
                        mL = 4'd0;
                    end
                end 
                
                2'b01: begin //���ڷ��ӵ�ʮλ������ʮλ�仯��ΧΪ 0~5
                if( K5 == 1 ) 
                    begin
                        mH = mH + 1 ;
                        if(mH >= 4'd6)
                        mH = 4'd0;
                    end
                end 
                
                2'b10: begin //����ʱ�ӵĸ�λ
                if( K5 == 1 ) 
                    begin
                        hL = hL + 1;
                        if(hL >= 4'd10)
                        hL = 4'd0;
                    end
                end 
                
                2'b11: begin //����ʱ�ӵ�ʮλ
                if( K5 == 1 ) 
                    if( hL < 4 ) 
                        begin //ʱ�Ӹ�λС�� 4��ʱ��ʮλ�ı仯��ΧΪ 0~2
                            hH = hH + 1 ;
                            if(hH >= 4'd3)
                            hH = 4'd0;
                        end 
                        else begin //ʱ�Ӹ�λ���ڵ��� 4��ʱ�Ӹ�λ�ı仯��ΧΪ 0~1
                            hH = hH + 1 ;
                            if(hH >= 4'd2)
                            hH = 4'd0;
                        end
                    end
                endcase
            end
    end
    
endmodule
