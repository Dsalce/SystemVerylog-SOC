class agent extends uvm_agent;
  
 
  
  `uvm_component_utils(agent)
 //Declaracion de los componentes de agente
  driver    driv;
  sequencer seq;
  monitor   mon;
  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //Si el agente inyecta trafico es  activo
    if(get_is_active() == UVM_ACTIVE) begin
      //Creamos el driver y el sequencer
      driv = driver::type_id::create("driv", this);
      seq = sequencer::type_id::create("seq", this);
    end
   //creamos monitor
    mon = monitor::type_id::create("mon", this);
  endfunction : build_phase
 
  // conectamos driver con sequencer
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driv.seq_item_port.connect(seq.seq_item_export);
    end
  endfunction : connect_phase
 
endclass : agent