import definitions::packet_t;


interface bus();
    logic     data_en;
	logic 		ack;
	logic 		req;
	packet_t  data;
	
    //desser
modport master(	output data_en, 
				output data, 
				output req,
				input ack);
		//Ser		
 modport slave(input data_en,
				input data, 
				input req,
				output ack
				);

endinterface