//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     serializer
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
import definitions::*;

module serializer (input logic  clk,
                   input logic  rst,
                   output logic dout,
                   bus.slave    scr2ser);

   packet_out_t  d2get;   
   packet_out_t  data;
   
   always_ff @ (posedge clk)
     if (rst)
       data <= '{head: 8'd0, dst: 8'd0, pay: 8'd0, crc: 8'd0};
     else if (scr2ser.slv_drdy())
       data <= d2get;
     else
       data <= data >> 1;

   always_ff  @ (posedge clk)
     scr2ser.slave_fsm_nxt (rst);

   always_comb
     scr2ser.getdata(d2get);
   
   
   //   assign  dout= data.field3[0];
   //   assign  dout= data[31];
   assign dout = data[0];
   
endmodule
