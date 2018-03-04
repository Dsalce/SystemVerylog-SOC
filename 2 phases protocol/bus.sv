//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad Complutense de Madrid
// Engineer:        O. Garnica
//
// Create Date:     20.10.2017
// Design Name:     serdes
// Module Name:     bus
// Project Name:    DSoC
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
import definitions::*;

interface bus #(parameter type packet_t = packet_in_t);
   packet_t data;
   logic    ack=0;
   logic    req=0;
   logic hsPhase=1;// Se usa para controlar el flujo del protocolo two-phase handshaking

   typedef enum logic [1:0] {init_st, req_st, ack_st} if_st_t;
   if_st_t mtr_current_state, slv_current_state;
   
   task automatic master_fsm_nxt (input logic rdy,
                                  input logic rst);
      if (rst)
        mtr_current_state <= init_st;
      else begin
         unique case (mtr_current_state) 
         
        init_st:
             if (rdy)//Cuando se han recibido los 32 bits
               mtr_current_state <= req_st;
           
           req_st:
            
             if (ack ==hsPhase)
               mtr_current_state <= ack_st;
           
           ack_st:
               //Vuelta al estado inicial
               mtr_current_state <= init_st;
           
         endcase // case (mtr_current_state)
      end
   endtask : master_fsm_nxt

   function automatic void senddata (input packet_t d2send);
      unique case (mtr_current_state)
        init_st: begin
           data = '{head: 8'd0, dst: 8'd0, pay: 8'd0, crc: 8'd0};
          
        end
        req_st: begin
           //Carga packet_t con los datos introducidos por la entrada
           data = d2send;
           req  =hsPhase;
        end
        ack_st: begin
           //negacion del parametro hsPhase
           hsPhase=~hsPhase;
        end
        default : begin
           data = '{8'd0, 8'd0, 8'd0, 8'd0};
           req  = 1'b0;          
        end
      endcase
   endfunction : senddata
   
   task automatic slave_fsm_nxt (input logic rst);
      if (rst)
        slv_current_state <= init_st;
      else begin
         unique case (slv_current_state) 
           init_st:
            if(req ==hsPhase)//Si hay una peticion se pasa al estado req_st 
               slv_current_state <= req_st;
           
           req_st:
        
               slv_current_state <= ack_st;
           
           ack_st:
             
            mtr_current_state <= init_st;
         endcase // case (slv_current_state)
      end
   endtask : slave_fsm_nxt
   
   
   function automatic void getdata (output packet_t d2get);
      unique case (slv_current_state)
        init_st: begin
           d2get = '{8'd0, 8'd0, 8'd0, 8'd0};
          
        end
        req_st: begin
        
            d2get = data;
            ack   = hsPhase;
           
        end
        ack_st: begin
          d2get = data;
       
           
        end
        default : begin
           d2get = '{8'd0, 8'd0, 8'd0, 8'd0};
           ack   = 1'b0;          
        end
      endcase
   endfunction : getdata
   
   function automatic logic slv_drdy ();
      unique case (slv_current_state)
        init_st: begin
           slv_drdy  = 1'b0;
        end
        req_st: begin
           
           slv_drdy   = 1'b1;
        end
        ack_st: begin
           
          slv_drdy   = 1'b0;
        end
        default : begin
           slv_drdy   = 1'b0;          
        end
      endcase
   endfunction : slv_drdy
   

   modport master (import master_fsm_nxt,
                   import senddata,
		               output data,
                   output req,
                   input  ack);

   
   modport slave   (import slave_fsm_nxt,
                    import getdata,
                    import slv_drdy,
                    input  data,
                    input  req,
                    output ack
                    );
   
endinterface : bus
