`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 11:36:44
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


module FrequencyDivider();
     reg clk_in; //时钟输入 
     reg reset; //复位输入
     reg clk_1s; //1Hz 时钟输出 
     reg clk_1ms; //1kHz 时钟输出 
     parameter DELY=10;
        
      FrequencyDivider test(
        .clk_in(clk_in),
        .reset(reset),
        .clk_1s(clk_1s),
        .clk_1ms(clk_1ms)
       );
       
     always #(DELY/2) clk_in=!clk_in;
     
     initial begin
         reset = 0;
       #((DELY*1000000))$finish;
     end
       
endmodule
