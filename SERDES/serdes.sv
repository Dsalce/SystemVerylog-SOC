import definitions::*;

module serdes (input  logic din,
               input  logic clk,
               input  logic rst,
               output logic dout);

	/*logic     data_en;
	packet_t  data;
	packet_t  data_scram;*/
	bus i_bus();
	
   deserializer i_des (.*,.bus_m(i_bus.master));//.din(din),.clk(clk),.rst(rst),.bus_m(i_bus.master));
                
   scrambler i_scram(.*,.bus_s(i_bus.slave),.bus_m(i_bus.master));//clk(clk),.rst(rst),.bus_s(i_bus.slave),.bus_m(i_bus.master));
   serializer   i_ser (.*,.bus_s(i_bus.slave));//(.dout(dout),.clk(clk),.rst(rst),.bus_s(i_bus.slave));

endmodule // serdes