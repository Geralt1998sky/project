`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 13:07:11
// Design Name: 
// Module Name: Testbench_fre
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


module Testbench_fre();
     reg clk_in; //ʱ������ 
     reg reset; //��λ����
     wire clk_1s; //1Hz ʱ����� 
     wire clk_1ms; //1kHz ʱ����� 
        
      FrequencyDivider test(
        .clk_in(clk_in),
        .reset(reset),
        .clk_1s(clk_1s),
        .clk_1ms(clk_1ms)
       );
       
     always #10 clk_in = ~clk_in;
     
     initial begin
       reset = 0;clk_in= 1;
       #40 reset = 1;
     end
   
endmodule
