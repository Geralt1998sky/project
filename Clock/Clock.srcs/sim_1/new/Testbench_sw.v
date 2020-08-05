`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 14:43:33
// Design Name: 
// Module Name: Testbench_sw
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


module Testbench_sw();
     reg clk_1s; //1Hz ʱ�� 
     reg reset; //��λ���� 
     reg K1; //K1,K2,K5,shift Ϊģʽѡ��
     reg K2; 
     wire [3:0] SmH; //���Ӹ�λ 
     wire [3:0] SmL; //���ӵ�λ 
     wire [3:0] SsH; //���λ 
     wire [3:0] SsL; //���λ

     StopWatch test(
        .clk_1s(clk_1s),
        .reset(reset),
        .K1(K1),
        .K2(K2),
        .SmH(SmH),
        .SmL(SmL),
        .SsH(SsH),
        .SsL(SsL)
       );
       
     always #1 clk_1s = ~clk_1s;

     initial begin
       reset = 0; clk_1s= 1;
       K1 = 0;K2 = 1;
       #40 reset = 1;
     end
endmodule
