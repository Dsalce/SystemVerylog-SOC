import agent::transaction;

class generator;
  //Instanciamos la transaccion de tipo randomizada
  rand transaction trans;
  //Mailbox
  mailbox gen2driv;
  int num;
  
 
  
  event ended;
  //Constructor
  function new(mailbox gen2driv,event ended,int num);
    this.gen2driv = gen2driv;
    trans=new();
    this.num=num;
  endfunction
   
  task run();
    //Creamos un numero determinado de transacciones
    repeat(this.num) begin
      trans = new();
      //Randomiza la transaccion si da error muestra un mensaje
      if( !trans.randomize() ) begin 
	    $display("error en la transaccion");   
      end
      trans.start=1;
      trans.done=0; //devolucion de la alu
      //Metemos la transaccion randomizada en el mailbox
      gen2driv.put(trans);
    end
   -> ended;
  endtask 
endclass

