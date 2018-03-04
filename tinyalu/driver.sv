

import agent::transaction;
class driver;

  virtual bfm_if bfm;
  mailbox gen2driv;
  int num;
  
  function new( virtual bfm_if bfm_i,mailbox gen2driv,int num);
  	 this.bfm=bfm_i;
         this.gen2driv=gen2driv;
         this.num=num;
  endfunction

  task run;
  @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
    //Repite un numero de veces
    repeat (this.num) begin
     transaction trans;
     
     
     
     //Obtenemos la transaccion
     gen2driv.get(trans);
     @(posedge this.bfm.clk);
     //Si start=1 y done=0 pasamos los datos al bfm
     if(trans.start && !trans.done) begin
       this.bfm.start<=trans.start;
      
       this.bfm.A<=trans.A;
       this.bfm.B<=trans.B;
       this.bfm.op<=trans.op;
     
       $display("Driver: \tA =%0h \t%0h \tB=%0h",trans.A,trans.op,trans.B);
     end;
    //Si done=1 pasamos los datos del bfm
    if( this.bfm.done)begin
     
       
       @(posedge bfm.clk);
       //Recuperamos el resultado del bfm
 
       $display("Driver: \tResult = %0h ",this.bfm.result);
   end;
     @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
   @(posedge this.bfm.clk);
  
  end
endtask 

   task reset;
    wait(!bfm.reset_n);
    
    bfm.A <= 0;
    bfm.B <= 0;
    bfm.op <= 0;
    bfm.start<= 0;
    wait(bfm.reset_n);
  
  endtask

endclass
