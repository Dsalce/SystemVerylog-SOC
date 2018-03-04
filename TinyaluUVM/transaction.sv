


class transaction extends uvm_sequence_item;
`uvm_object_utils(transaction)
 //Declaracion de los datos randomizados
  rand bit  [7:0] A;//data
  rand bit  [7:0] B;//data
  rand bit  [2:0] op;//op
  bit start;
  bit done;
  bit [15:0] result;



function new(string name = "transaction");
    super.new(name);
  endfunction
//funcion para mostrar  las operaciones y resultados
task print();
 $display("\t%0h \top%0h \t%0h = \t%0h",this.A,this.op,this.B,this.result);
endtask:print;
  

endclass
