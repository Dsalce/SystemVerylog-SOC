
interface bfm_if(
		input clk,
		input reset_n
		);
        
   //Señales
   logic [7:0] A;//data
   logic [7:0] B;//data
   logic [2:0] op;//op
   logic start;
   logic done;//out
   logic [15:0] result;//out

   



   
     
endinterface : bfm_if
