

class driver extends uvm_driver #(transaction);
	transaction trans;
  virtual bfm_if bfm;

  `uvm_component_utils(driver)

  //Constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

   //buid_phase
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual bfm_if)::get(this, "", "bfm", bfm))
       `uvm_fatal("NOBFM",{"virtual interface must be set for: ",get_full_name(),".bfm"});
  endfunction: build_phase



  //Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
    seq_item_port.get_next_item(trans);
   
    drive();
    seq_item_port.item_done();
    end
  endtask : run_phase


   //Inyecta datos en el bfm
   virtual task drive();
     
      //Espera a la sincronizacion
      wait(this.bfm.sync_pad);
       @(posedge this.bfm.sysclk);
       this.bfm.poc_pad<=trans.poc_pad;
       @(posedge this.bfm.sysclk);
       this.bfm.test_pad<=trans.test_pad;
       @(posedge this.bfm.sysclk);
       this.bfm.setData_Pad(trans.data_pad);

      
        


 endtask : drive

endclass :driver