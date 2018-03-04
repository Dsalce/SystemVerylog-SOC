


class transaction extends uvm_sequence_item;
`uvm_object_utils(transaction)
 //Declaracion de los datos randomizados
   rand bit       poc_pad;//input
    rand bit       test_pad;//input
    rand bit  [3:0] data_pad;//inout
  
    bit         cmrom_pad;//out
    bit         cmram0_pad;//out
    bit        cmram1_pad;//out  p
    bit        cmram2_pad;//out
    bit         cmram3_pad;//out
    bit         sync_pad;//out




function new(string name = "transaction");
    super.new(name);
  endfunction
//funcion para mostrar  las operaciones y resultados
task print();
 $display("poc_pad(Input):%h \ttest_pad(Input):%h \tsync_pad(Output):%h"
 	,this.poc_pad,this.test_pad,this.sync_pad);
endtask:print;
  

endclass
 