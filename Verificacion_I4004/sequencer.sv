

class sequencer extends uvm_sequencer#(transaction);
  `uvm_sequencer_utils(sequencer)

    //constructor
  function new(string name , uvm_component parent );
    super.new(name,parent);
  endfunction

endclass