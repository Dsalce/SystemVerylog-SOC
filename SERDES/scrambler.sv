
import definitions::*;
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2017 19:25:35
// Design Name: 
// Module Name: changeord
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


module scrambler( input logic 	 clk,
				 input logic 	 rst,
				bus.slave  bus_s,
				bus.master bus_m
    );
    
    
    
    function byte scram(input byte in);
         if(in[7]==1'b1) return in^1'b1;
         else return in^in[0];
          
    endfunction
    
   
    packet_t  data_reg;
    
    
     always_ff @ (posedge clk)begin
        if (rst)
          bus_m.data <= '{8'd0, 8'd0, 8'd0, 8'd0};
        else if (bus_s.data_en) begin
        
         data_reg.field0 <= scram(bus_s.data.field0); 
         data_reg.field1 <= bus_s.data.field1;
         data_reg.field2 <= scram(bus_s.data.field2); 
         data_reg.field3 <= scram(bus_s.data.field3); 
        
         bus_m.data <= '{data_reg.field0,data_reg.field1, data_reg.field2, data_reg.field3};
         end
       else begin
           bus_m.data <=  bus_m.data >> 1;
          end
       end
      
     
        
    
endmodule
