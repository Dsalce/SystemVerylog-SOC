`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2015 13:54:11
// Design Name: 
// Module Name: tb_serdes
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


module tb_serdes();

    logic clk;
    logic rst;
    logic din;
    logic dout;
    
    parameter CLOCK_PERIOD = 10; 
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        din = 1'b0;
    end
    
    always 
        #(CLOCK_PERIOD/2)  clk =  !clk;
    
    initial begin
        #1 rst = 1'b1;
        #45 rst = 1'b0;
    end
    
    always begin
        #40 din = 1'b0;
        #10 din = 1'b1;
        #10 din = 1'b1;
        #10 din = 1'b1;
        #10 din = 1'b0;
        #10 din = 1'b0;
        #10 din = 1'b1;
        #10 din = 1'b1;
        #10 din = 1'b0;
        #10 din = 1'b0;
        #10 din = 1'b0;
        #10 din = 1'b1;
        #10 din = 1'b1;
        #10 din = 1'b1;
    end
        
    serdes i_serdes (.*);
endmodule
