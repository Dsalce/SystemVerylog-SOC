

module top;

 import uvm_pkg::*;
 import definitions::*;
   
  //clock and reset signal declaration
  bit clk;
  bit reset_n;
   
  //clock 
  always #5 clk = ~clk;
   
  //reset 
bfm_if bfm (.*);
initial begin
   //Inicializacion de señales
    reset_n = 0;
    #5 reset_n =1;
    bfm.A=0;
    bfm.B=0;
    bfm .op=0;
    bfm.start=1;
    
  end
      //Atado de las señales bfm
      
      //Atado de las seÃ±ales Alu
      tinyalu alut(.A(bfm.A),
        .B(bfm.B),
        .op(bfm.op),
        .start(bfm.start),
        .done(bfm.done),
        .result(bfm.result),
        .*);
  //enabling the wave dump
  initial begin
    //Atado de la interfaz en todo el test
    uvm_config_db#(virtual bfm_if)::set(null,"*","bfm",bfm);
  
    run_test();
  end
endmodule :top