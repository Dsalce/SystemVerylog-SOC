`include "environment.sv"
class test;
  
//instancia enviroment y lo invoca


  environment env;
  virtual bfm_if bfm;

  //Constructor
  function new(virtual bfm_if bfm);
    this.bfm=bfm;
  endfunction


  task run;
  
    env = new(this.bfm);

    env.run();
  endtask
endclass
