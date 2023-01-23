`timescale 1ns / 1ps

module instrflopFD # (parameter WIDTH = 32)(
    input wire clk,rst,en,clear,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
    always@(posedge clk,posedge rst)begin
        if(rst)begin
            q <= 32'hF0000000;
        end else if(clear)begin
            q <= 0;
        end else if(en)begin
            q <= d;
        end
    end
endmodule