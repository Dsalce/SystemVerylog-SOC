
//

 import agent::monitor;
 import agent::generator;
 import agent::driver;
 import agent::transaction;

`include "scoreboard.sv"

 

class environment;
  int num=30;
  //generator and driver instance
  generator gen;
  driver    driver;
  scoreboard score;
  monitor mon;
  event gen_ended;
   
  //mailbox ()colas para el generator y el monitor
  mailbox gen2driv,mon2score;
  
  //virtual interface
  virtual bfm_if bfm;
  
  //constructor
  function new(virtual bfm_if bfm);

    this.bfm = bfm;
    
    //Instanciamos las clases
    this.gen2driv = new();
    this.mon2score=new();
    this.gen  = new(gen2driv,gen_ended,num);
    this.driver = new(bfm,gen2driv,num);
    this.mon  = new(bfm,mon2score,num);
    this.score  = new(mon2score,num);
  endfunction
  
  //Test del reset
  task test_reset();
    driver.reset();
  endtask
  
  //Test de las clases
  task test();
    //se lanzan los metodos run en paralelo hasta que no acaben todos no termina la tarea 
    fork 
    this.gen.run();
    this.driver.run();
    this.mon.run();
    this.score.run();
    join
  endtask
  

  //run task
  task run;
    test_reset();
    test();
   
  
  endtask
  
endclass
