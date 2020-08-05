`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 14:52:18
// Design Name: 
// Module Name: Testbench_sa
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


module Testbench_sa();
     reg clk_1s; 
     reg reset; 
     reg K1; //K1,K2,K5,shift Ϊģʽѡ��
     reg K2;
     reg K5;
     reg[1:0] shift; 
     wire[3:0] AhH; //Сʱ��λ 
     wire[3:0] AhL; //Сʱ��λ 
     wire[3:0] AmH; //���Ӹ�λ 
     wire[3:0] AmL; //���ӵ�λ 
     
      SetAlarm test(
        .clk_1s(clk_1s),
        .reset(reset),
        .K1(K1),
        .K2(K2),
        .K5(K5),
        .shift(shift),
        .AhH(AhH),
        .AhL(AhL),
        .AmH(AmH),
        .AmL(AmL)
       );
       
     always #1 clk_1s = ~clk_1s;
     
     initial begin
       shift=2'b01;
       reset = 0; clk_1s= 1;
       K1 = 1;K2 = 1;K5 = 1;
       #40 reset = 1;
       #200 shift=2'b11;
     end
endmodule
