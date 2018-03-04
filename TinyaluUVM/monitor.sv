class monitor extends uvm_monitor;
 
  // Virtual Interface
  virtual bfm_if bfm;
 
  uvm_analysis_port #(transaction) item_collected_port;
 
  // Definimos transaction
  transaction trans;
 
  `uvm_component_utils(monitor)
 
  // Constructor de monitor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new
 //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //sustituimos bfm por el definido en top
    if(!uvm_config_db#(virtual bfm_if)::get(this, "", "bfm", bfm))
       `uvm_fatal("NObfm",{"No hay bfm ",get_full_name(),".bfm"});
  endfunction: build_phase
 
  // run phase
virtual task run_phase(uvm_phase phase);
    forever begin
      
      @(posedge this.bfm.clk);
       wait( this.bfm.done);
       @(posedge this.bfm.clk);
        trans.A  = this.bfm.A;
        trans.B = this.bfm.B;
        trans.op  = this.bfm.op;
       @(posedge this.bfm.clk);
         trans.result = this.bfm.result;
      @(posedge this.bfm.clk);
      item_collected_port.write(trans);
     @(posedge this.bfm.clk);
    

    end
  endtask : run_phase
 
endclass : monitor