import agent::transaction;

//Muestra los datos por el simulador

class scoreboard;
    
  //Mailbox
  mailbox mon2score;
   int num;
 
 
   
  //constructor
  function new(mailbox mon2score,int num);
   
    this.mon2score = mon2score;
    this.num=num;
  endfunction
   

  task run;
    transaction trans;
    repeat (this.num) begin
      //Se recupera la transaccion
       
      mon2score.get(trans);
      //Si done=1 se muestran los datos con los que se ha realizado el test en l alu
      if(trans.done) begin
        $display("Scoreboard: %0h \t %0h \t%0h  ==   %0h",trans.A,trans.op,trans.B,trans.result);
     
          
      end
     
 
     
    end
  endtask
   
endclass
