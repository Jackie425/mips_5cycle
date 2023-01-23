`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:44:10
// Design Name: 
// Module Name: mux3
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

module mux3 #(parameter WIDTH = 8)(
    input wire[WIDTH-1:0] d00,d01,d10,
    input wire[1:0] s,
    output wire[WIDTH-1:0] y
    );
    assign y = (s == 2'b00) ? d00 :
                (s == 2'b01) ? d01 :
                (s == 2'b10) ? d10 : d00;
endmodule