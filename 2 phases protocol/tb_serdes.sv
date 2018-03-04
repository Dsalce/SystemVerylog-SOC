//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     tb_serdes
// Project Name:    DSoC
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
`timescale 1ns / 1ps

module tb_serdes();
   bit clk;
   bit rst;
   bit din;
   logic dout;

   parameter CLOCK_PERIOD = 10; 

   initial begin : p_init_values
      clk = 1'b0;
      rst = 1'b0;
      din = 1'b0;
   end

   always
     #(CLOCK_PERIOD/2)  clk =  !clk;

   initial begin : p_rst
      #1 rst = 1'b1;
      #45 rst = 1'b0;
   end

   initial begin
      static int i = 0;
      #95
        for (i = 0; i < 32; i++) begin
           @(negedge clk)
             din = 1'b1;
        end
      for (i = 0; i < 32; i++) begin
         @(negedge clk)
           din = 1'b0;
      end
      for (i = 0; i < 4; i++) begin
         @(negedge clk)
           din = 1'b1;
      end
      for (i = 0; i < 4; i++) begin
         @(negedge clk)
           din = 1'b1;
         @(negedge clk)
           din = 1'b0;
      end
      for (i = 0; i < 4; i++) begin
         @(negedge clk)
           din = 1'b1;
      end

   end

   serdes i_serdes (.*);

endmodule
