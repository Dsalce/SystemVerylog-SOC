import agent::transaction;

class monitor;
   
   //recoge datos del bfm y se los pasa al mailbox de monitor y se lo psara luego al scoreboard

  virtual bfm_if bfm;
   
  int num;
  //Mailbox
  mailbox mon2score;
   
  //Constructor
  function new(virtual bfm_if bfm,mailbox mon2score,int num);
   
    this.bfm = bfm;
   
    this.mon2score = mon2score;
    this.num=num;
  endfunction
   

  task run;
    //Creamos un numero determinado
    repeat (this.num) begin
      transaction trans;
      trans = new();
      
    
      //Espera hasta que done=1
      wait( this.bfm.done);
     
      //cogemos tods los valores y se los pasamos a la transaccion q hemos creado
        trans.A  = this.bfm.A;
        trans.B = this.bfm.B;
        trans.op  = this.bfm.op;
        
         
         this.bfm.start=0;
         trans.start=0;
         trans.done =this.bfm.done;
         
          @(posedge this.bfm.clk);
          trans.result = this.bfm.result;
        
        //Se introduce en el mailbox la transaccion  
        mon2score.put(trans);
      //end
     @(posedge this.bfm.clk);
    @(posedge this.bfm.clk);
    end
  endtask
   
endclass
