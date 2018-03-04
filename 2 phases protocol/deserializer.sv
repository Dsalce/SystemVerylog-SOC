//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     deserializer
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
import definitions::packet_in_t;

module deserializer (input logic din,
                     input logic clk,
                     input logic rst,
		                 bus.master des2scr);
   
   /*------------------------------------------------------------------------
    * Definition of signals
    *------------------------------------------------------------------------*/
   typedef logic [5:0]           int5;
   int5        cntr;
   packet_in_t data;
   packet_in_t d2send;
   logic                         datardy;
   
   always_ff @ (posedge clk)
     if (rst)
       cntr <= 0;
     else if (cntr == 32)
       cntr <= 1;
     else
       cntr <= cntr + 1;

   assign datardy = (cntr == 32)? 1'b1 : 1'b0;

   always_ff @ (posedge clk)
     if (rst)
       d2send <= '{head: 8'd0, dst: 8'd0, pay: 8'd0, crc: 8'd0};
     else if (datardy)
       d2send <= data;
   
   always_ff  @ (posedge clk)
     if (rst)
       data <= '{head: 8'd0, dst: 8'd0, pay: 8'd0, crc: 8'd0};
     else
       data <= {din, data[31:1]};

   always_ff @ (posedge clk)
     des2scr.master_fsm_nxt (datardy, rst);

   always_comb
     des2scr.senddata(d2send);
   
endmodule
