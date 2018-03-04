`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2015 12:49:07
// Design Name: 
// Module Name: definitions
// Project Name: 
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

package definitions;
    parameter version = "1.0";
    
    typedef struct packed {
        byte field0;
        byte field1;
        byte field2;
        byte field3;
     } packet_t;        

endpackage
