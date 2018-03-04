`timescale 1ns / 1ps

module top;

 import uvm_pkg::*;
 import definitions::*;
   
  //clock and reset signal declaration
  bit sysclk,clk1_pad,clk2_pad;
  bit reset_n;
   
  //clock 
  always #5 sysclk = ~sysclk;
  always #10 clk1_pad = ~clk1_pad;
  always #20 clk2_pad = ~clk2_pad;
  //reset 
bfm_if bfm (.*);
initial begin
   //Inicializacion de señales
    reset_n = 0;
    #5 reset_n =1;
    bfm.poc_pad=0;
    bfm.test_pad=0;
    bfm.setData_Pad(0);

    
  end
      //Atado de las señales bfm
      
      //Atado de las seÃ±ales i4004
      i4004 __i4004(
        .poc_pad(bfm.poc_pad),
        .test_pad(bfm.test_pad),
        .data_pad(bfm.data_pad),
        .cmrom_pad(bfm.cmrom_pad),
        .cmram0_pad(bfm.cmram0_pad),
        .cmram1_pad(bfm.cmram1_pad),
        .cmram2_pad(bfm.cmram2_pad),
        .cmram3_pad(bfm.cmram3_pad),
        .sync_pad(bfm.sync_pad),
        .*);
  //enabling the wave dump
  initial begin
    //Atado de la interfaz en todo el test
    uvm_config_db#(virtual bfm_if)::set(null,"*","bfm",bfm);
  
    run_test();
  end
endmodule :top