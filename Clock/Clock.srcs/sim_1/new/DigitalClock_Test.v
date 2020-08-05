`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 21:26:24
// Design Name: 
// Module Name: DigitalClock_Test
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


module DigitalClock_Test( );
reg clk_in;
reg reset;
reg K1;
reg K2;
reg [1:0]shift;
reg K5;
wire[6:0] led_7seg;
wire[3:0] led_sel;
wire Sout;



DigitalClock Test(
.clk_in(clk_in),
.reset(reset),
.K1(K1),
.K2(K2),
.K5(K5),
.shift(shift),
.Sout(Sout),
.led_7seg(led_7seg),
.led_sel(led_sel)
);

initial 
    begin
        shift=2'b00;
        clk_in = 1;
        reset = 0;
        K1 = 0;
        K2 = 0;
        K5 = 0;
        #10 reset = 1;
    end
    
always #1 clk_in = ~clk_in;

endmodule

