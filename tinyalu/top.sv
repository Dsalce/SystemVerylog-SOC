`timescale 1ns / 1ps
`include "test.sv"
//`include "bfm_if.sv"
module top();
 //declaracion clock y reset 
  bit clk;
  bit reset_n;

   always #5 clk = ~clk;
  
  //generamos el reset
  initial begin
    reset_n = 0;
    #5 reset_n =1;
  end
     test te;
      //Atado de las señales bfm
      bfm_if bfm (.*);
      //Atado de las señales Alu
      tinyalu alut(.A(bfm.A),
        .B(bfm.B),
        .op(bfm.op),
        .start(bfm.start),
        .done(bfm.done),
        .result(bfm.result),
        .*);
    //Instancia el test
    initial begin
      te = new(bfm);
      te.run();
     end
      
     
     
endmodule
