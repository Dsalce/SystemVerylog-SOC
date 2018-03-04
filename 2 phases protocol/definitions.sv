//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     definitions
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

package definitions;
   parameter version = "1.0";
   
   typedef struct packed {
      logic [7:0] head;
      logic [7:0] dst;
      logic [7:0] pay;
      logic [7:0] crc;
   } packet_in_t;
   
   typedef struct packed {
      logic [7:0] crc;
      logic [7:0] pay;
      logic [7:0] dst;
      logic [7:0] head;
   } packet_out_t;

   function automatic logic [7:0] scrambling (logic [7:0] field);
      if (field[7])
        scrambling = field ^ 8'hFF;
      else
        scrambling = field ^ (^field);
   endfunction : scrambling
   
   function automatic packet_out_t scrambling_packet (packet_in_t data);
      scrambling_packet = '{crc:  scrambling(data.crc), 
                            pay:  data.pay, 
                            dst:  scrambling(data.dst), 
                            head: scrambling(data.head)};
   endfunction : scrambling_packet
   
endpackage
