`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: maindec
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


module maindec(
	input wire clk,rst,
	input wire[5:0] opD,

	output wire memtoregW,memwriteM,
	output wire branchD,alusrcE,
	output wire regdstE,regwriteD,regwriteW,jumpD,memtoregE,
	output wire[1:0] aluopD,
	input wire stallF,stallD,flushE,
	output wire regwriteE,regwriteM,memtoregM
    );
	wire regdstD,alusrcD,memwriteD,memtoregD;
	wire memwriteE;
	reg[8:0] controlsD;
	assign {regwriteD,regdstD,alusrcD,branchD,memwriteD,memtoregD,jumpD,aluopD} = controlsD;
	always @(*) begin
		case (opD)
			6'b000000:controlsD <= 9'b110000010;//R-TYRE
			6'b100011:controlsD <= 9'b101001000;//LW
			6'b101011:controlsD <= 9'b001010000;//SW
			6'b000100:controlsD <= 9'b000100001;//BEQ
			6'b001000:controlsD <= 9'b101000000;//ADDI

			6'b000010:controlsD <= 9'b000000100;//J
			default:  controlsD <= 9'b000000000;//illegal op
		endcase
	end
	floprc #(6) controlflop1(clk,rst,flushE,{regwriteD,regdstD,alusrcD,memwriteD,memtoregD},{regwriteE,regdstE,alusrcE,memwriteE,memtoregE});
	flopr #(4) controlflop2(clk,rst,{regwriteE,memwriteE,memtoregE},{regwriteM,memwriteM,memtoregM});
	flopr #(2) controlflop3(clk,rst,{regwriteM,memtoregM},{regwriteW,memtoregW});
endmodule
