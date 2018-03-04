
class test extends uvm_test;
 
  `uvm_component_utils(test)
 //Instacias de enviroment y sequence
  environment env;
  msequence  seq;
  
  //Constructor
  function new(string name = "test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
 //build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   //Creamos el environment y la sequencia
    env = environment::type_id::create("env", this);
    seq = msequence::type_id::create("seq");
  endfunction : build_phase
 //run_phase
  task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq.start(env.agnt.seq);
      phase.drop_objection(this);
  endtask : run_phase
 
endclass : test