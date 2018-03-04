class msequence extends uvm_sequence #(transaction);
	 
   `uvm_object_utils(msequence)
   transaction trans;
    
  //Constructor
  function new(string name = "msequence");
    super.new(name);
  endfunction
   //Creamos transaccion randomizada
  virtual task body();
    
    trans = transaction::type_id::create("trans");
    //Numero infinito de secuencias
     forever begin
      wait_for_grant();
      //Si randomice falla muestra error
      if( !trans.randomize() ) begin 
      $display("error en la transaccion");   
      end
      trans.start=1;
      trans.done=0; 
    send_request(trans);
    wait_for_item_done();
  end
    
    
  endtask
   
endclass