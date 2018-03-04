import definitions::packet_t;

module deserializer (
							input logic 	 din,
							input logic 	 clk,
							input logic 	 rst,
							bus.master  bus_m);
   /*---------------------------------------------------------------------------
	 * Definition of signals
	*----------------------------------------------------------------------------*/
	integer  cntr;
	
   always_ff @ (posedge clk)
	 if (rst)
	   cntr <= 0;
	 else if (cntr == 32)
	   cntr <= 0;
	 else
	   cntr <= cntr + 1;
       

   always_ff @ (posedge clk)
	 if (rst)
	   bus_m.data <= '{8'd0, 8'd0, 8'd0, 8'd0};
	 else begin
	   // data = data >> 1;
	   // data[31] = din;
	   bus_m.data <= {din, bus_m.data[31:1]};

	 end

	assign bus_m.data_en = (cntr == 32) ? 1'b1 : 1'b0;

endmodule // des
