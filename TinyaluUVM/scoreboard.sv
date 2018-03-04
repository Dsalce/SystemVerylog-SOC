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
    $display("SCB:: Transaction recivida");
    trans.print();
    tra_qu.push_back(trans);
  endfunction : write
 
  // run phase
  //Comprobamos que las operaciones que realiza alu corresponde con las mismas que realiza el test
  //
  virtual task run_phase(uvm_phase phase);
   transaction trans;
   bit [15:0] result;
   forever begin
     wait(tra_qu.size() > 0);
      trans=tra_qu.pop_front();
      if(trans.op[2]==1) begin
           result=trans.A * trans.B;

          
        end
        else if(trans.op[2]==0)  begin
            trans.op[2]=0;
            case(trans.op)
              3'b001 : result = trans.A + trans.B;
              3'b010 : result = trans.A & trans.B;
              3'b011 : result = trans.A ^ trans.B;
             endcase // case (op)
             
        end
       //Si el resultado es el esperado mostramos que el resultado es correcto
        if(trans.result==result)begin
     
         `uvm_info(get_type_name(),$sformatf("Resultado correcto : %0h",result),UVM_LOW)
        
          `uvm_info(get_type_name(),$sformatf("A:%0h \top:%0h \tB:%0h = \tResultado: %0h",trans.A,trans.op,trans.B,trans.result),UVM_LOW)
         end
           //Si el resultado no es el esperado mostramos un error con los datos,la operacion y el resultado esperado
         else begin
           `uvm_error(get_type_name(),"------ :: Error resultado no esperado :: ------")
           `uvm_info(get_type_name(),$sformatf("A:%0h \top:%0h \tB:%0h \tResultado Esperado: %0h \t\tResultado Actual: %0h",trans.A,trans.op,trans.B,result,trans.result),UVM_LOW)
         end
    end
  endtask : run_phase

 
endclass : scoreboard