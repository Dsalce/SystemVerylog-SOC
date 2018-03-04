//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     scrambler
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

module scrambler(input logic clk,
                 input logic rst,
                 bus.slave   des2scr,
                 bus.master  scr2ser);

   packet_in_t   d2get;
   packet_in_t   data;   
   packet_out_t scr;
   logic           req_d1;
   logic          req_d2;
   
   
   /*---------------------------------------------------------------------------
    * Receive interface. Bus comming from the deserializer
    *-------------------------------------------------------------------------*/
   
   always_ff @ (posedge clk)
     if (rst)
       data <= '{head: 8'd0, dst: 8'd0, pay: 8'd0, crc: 8'd0};
     else if (des2scr.slv_drdy())
       data <= d2get;

   always_ff  @ (posedge clk)
     des2scr.slave_fsm_nxt (rst);

   always_comb
     des2scr.getdata(d2get);

   always_ff @ (posedge clk)
     if (rst) begin
        req_d1 <= 'b0;
        req_d2<= 'b0;
     end
     else begin
        req_d1 <= des2scr.slv_drdy();
        req_d2 <= req_d1;
     end
   
   always_ff @(posedge clk) begin : b_scrambler_reg
      if (rst)
        scr <= '{head: 8'd0, dst: 8'd0, pay: 8'd0, crc: 8'd0};
      else
        // scr <= data;
	      scr <= scrambling_packet(data);      
   end : b_scrambler_reg

   /*---------------------------------------------------------------------------
    * Send interface. Bus to the serializer
    *-------------------------------------------------------------------------*/
   always_ff  @ (posedge clk)
     scr2ser.master_fsm_nxt (req_d2, rst);

   always_comb
     scr2ser.senddata(scr);


endmodule // scrambler
