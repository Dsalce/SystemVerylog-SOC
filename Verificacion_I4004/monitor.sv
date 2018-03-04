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
    
        
        //Paso de datos del bfm a la transaction
     
        @(posedge this.bfm.sysclk);
        trans.poc_pad=this.bfm.poc_pad;
        @(posedge this.bfm.sysclk);
        trans.test_pad=this.bfm.test_pad;
        @(posedge this.bfm.sysclk);
        trans.data_pad=this.bfm.getData_Pad();
        @(posedge this.bfm.sysclk);
        trans.cmrom_pad=this.bfm.cmrom_pad;
        @(posedge this.bfm.sysclk);
        trans.cmram0_pad=this.bfm.cmram0_pad;
        @(posedge this.bfm.sysclk);
        trans.cmram1_pad=this.bfm.cmram1_pad;
        @(posedge this.bfm.sysclk);
        trans.cmram2_pad=this.bfm.cmram2_pad;
        @(posedge this.bfm.sysclk);
        trans.cmram3_pad=this.bfm.cmram3_pad;
        @(posedge this.bfm.sysclk);
        trans.sync_pad=this.bfm.sync_pad;
       
         
        @(posedge this.bfm.sysclk);
        item_collected_port.write(trans);

    
      
    end
  endtask : run_phase
 
endclass : monitor