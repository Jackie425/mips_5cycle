`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: controller
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


module controller(
	input wire clk,rst,
	input wire[5:0] opD,functD,
	input wire equalD,
	output wire memtoregW,memwriteM,
	output wire pcsrcD,alusrcE,
	output wire regdstE,regwriteD,regwriteW,jumpD,memtoregE,
	output wire[2:0] alucontrolE,
	input wire stallF,stallD,flushE,
	output wire regwriteE,regwriteM,memtoregM,branchD
    );
	wire[1:0] aluopD;
	wire[2:0] alucontrolD;
	maindec md(clk,rst,opD,memtoregW,memwriteM,branchD,alusrcE,regdstE,
	regwriteD,regwriteW,jumpD,memtoregE,aluopD,stallF,stallD,flushE,regwriteE,
	regwriteM,memtoregM);
	aludec ad(functD,aluopD,alucontrolD);
	floprc #(3) alucontrolDE(clk,rst,flushE,alucontrolD,alucontrolE);
	assign pcsrcD = branchD & equalD;
endmodule
