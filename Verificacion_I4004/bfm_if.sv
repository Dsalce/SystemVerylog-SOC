
interface bfm_if(
		  input sysclk,
      input clk1_pad,
      input clk2_pad,
	  	input reset_n
		);
        
   //Señales

 
    
    logic       poc_pad;//input
    logic       test_pad;//input
    wire  [3:0] data_pad;//inout
    logic [3:0] data_aux;
    
    logic         cmrom_pad;//out
    logic         cmram0_pad;//out
    logic        cmram1_pad;//out  
    logic        cmram2_pad;//out
    logic         cmram3_pad;//out
    logic         sync_pad;//out

    //Si poc_pad=0 se pasan los datos de data_aux
    assign data_pad= !poc_pad? data_aux: 1'bz;
    
    //Gestion del puerto I/O
    function logic [3:0] getData_Pad();   
      return data_pad;   
    endfunction   


    function void setData_Pad(logic [3:0] data);  
     data_aux = data;  
   endfunction 


   
     
endinterface : bfm_if
