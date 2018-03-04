//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     serdes
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

module serdes (input logic  din,
               input logic  clk,
               input logic  rst,
               output logic dout);

   bus  #(.packet_t(packet_in_t))   des2scr();
   bus  #(.packet_t(packet_out_t)) scr2ser();
 
   deserializer i_des (.*);
   serializer   i_ser (.*);
   scrambler    i_scrambler(.*);
   
endmodule
