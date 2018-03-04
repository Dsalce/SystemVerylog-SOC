import definitions::*;

module serializer (
            output logic dout,
            input logic   clk,
            input logic   rst,
            bus.slave  bus_s
            );
   
   packet_t  data_reg;
   byte      head_in;	
   
   always_ff @ (posedge clk)
     if (rst)
       data_reg <= '{8'd0, 8'd0, 8'd0, 8'd0};
     else if (bus_s.data_en)
       data_reg <= '{bus_s.data.field3, bus_s.data.field2, bus_s.data.field1, bus_s.data.field0};
     else
       data_reg <= data_reg >> 1;
   
   assign dout = data_reg.field3[0];
	
endmodule // des
