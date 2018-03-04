class environment  extends uvm_env;
   `uvm_component_utils(environment)
  
  // Instancia del agente y el scoreboard
  agent      agnt;
  scoreboard scb;
   
  
   
  
  // constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 


  // Creacion del componente
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //creamos agent y scoreboard
    agnt = agent::type_id::create("agnt", this);
    scb  = scoreboard::type_id::create("scb", this);
  endfunction : build_phase
   

  // Conexion de monitor con scoreboard
  function void connect_phase(uvm_phase phase);
    agnt.mon.item_collected_port.connect(scb.item_collected_export);
  endfunction : connect_phase
 
endclass : environment