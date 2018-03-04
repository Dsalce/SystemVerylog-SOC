

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
   
 

  @(posedge this.bfm.clk);
  @(posedge this.bfm.clk);
  @(posedge this.bfm.clk);
     //Si start=1 y done=0 pasamos los datos al bfm
     if(trans.start ) begin
      @(posedge this.bfm.clk);
       this.bfm.start<=trans.start;
       this.bfm.A<=trans.A;
       this.bfm.B<=trans.B;
       this.bfm.op<=trans.op;
      @(posedge this.bfm.clk);
      @(posedge this.bfm.clk);

     end


 endtask : drive

endclass :driver