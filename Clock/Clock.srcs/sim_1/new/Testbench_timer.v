`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 13:47:33
// Design Name: 
// Module Name: Testbench_timer
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


module Testbench_timer();
     reg clk_1s; 
     reg reset; 
     reg K1; //K1,K2,K5,shift 为模式选择
     reg K2;
     reg K5;
     reg[1:0] shift; 
     wire[3:0] hH; //小时高位 
     wire[3:0] hL; //小时低位 
     wire[3:0] mH; //分钟高位 
     wire[3:0] mL; //分钟低位 
        
     Timer test(
        .clk_1s(clk_1s),
        .reset(reset),
        .K1(K1),
        .K2(K2),
        .K5(K5),
        .shift(shift),
        .hH(hH),
        .hL(hL),
        .mH(mH),
        .mL(mL)
       );
       
     always #1 clk_1s = ~clk_1s;
     
     initial begin
       shift=2'b01;
       reset = 0; clk_1s= 1;
       K1 = 1;K2 = 0;K5 = 1;
       #40 reset = 1;
     end
   

endmodule
