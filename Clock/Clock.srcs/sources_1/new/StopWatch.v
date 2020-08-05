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


/************ ��� ************/
module StopWatch( clk_1s,reset,K1,K2,SmH,SmL,SsH,SsL );
input clk_1s; //1Hz ʱ�� 
input reset; //��λ���� 
input K1; //K1,K2,K5,shift Ϊģʽѡ��
input K2; 
output reg[3:0] SmH; //���Ӹ�λ 
output reg[3:0] SmL; //���ӵ�λ 
output reg[3:0] SsH; //���λ 
output reg[3:0] SsL; //���λ

always@(posedge clk_1s )
    begin
        //reset �͵�ƽʱ��λ
        if(reset == 0) 
            begin
                SmH = 4'd0;
                SmL = 4'd0;
                SsH = 4'd0;
                SsL = 4'd0;
            end
        //K1 Ϊ�͵�ƽ�� K2 Ϊ�ߵ�ƽʱ�������
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
