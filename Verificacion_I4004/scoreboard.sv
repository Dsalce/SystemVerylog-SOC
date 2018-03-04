class scoreboard extends uvm_scoreboard;
 
  `uvm_component_utils(scoreboard)
  uvm_analysis_imp#(transaction, scoreboard) item_collected_export;
  transaction tra_qu[$];
  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction: build_phase
   
  // Escritura del scoreboard
  virtual function void write(transaction trans);

    
   if(trans.cmrom_pad==1 ||trans.data_pad!=0 || trans.cmram0_pad!=0 || trans.cmram1_pad!=0 ||  trans.cmram2_pad!=0 ||trans.cmram3_pad!=0)begin
    $display("SCB:: Transaction recivida");
    trans.print();
    tra_qu.push_back(trans);
  end
   
  endfunction : write
 
  // run phase
  //Comprobamos que las operaciones que realiza alu corresponde con las mismas que realiza el test
  //
  virtual task run_phase(uvm_phase phase);
   transaction trans;
    forever begin
      wait(tra_qu.size() > 0);
      trans=tra_qu.pop_front();
      //Comprueba que data_pad tenga datos
      if(trans.data_pad=="x" || trans.data_pad=="X") begin
          `uvm_error(get_type_name(),"------ :: Resultado no definido:: ------")
      
      end  

      else begin
       
         
          `uvm_info(get_type_name(),$sformatf("Bus de datos I/O: %0h",trans.data_pad),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Memoria Rom output : %0h",trans.cmrom_pad),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Memoria Ram outputs : %0h%0h%0h%0h",trans.cmram0_pad,trans.cmram1_pad,trans.cmram2_pad,trans.cmram3_pad),UVM_LOW)

        end
      
    end
   
  endtask : run_phase

 
endclass : scoreboard