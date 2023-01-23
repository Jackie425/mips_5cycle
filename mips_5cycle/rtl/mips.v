`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 10:58:03
// Design Name: 
// Module Name: mips
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
//////////////////////////////////////////////////////////////////////////////////\km,h


module mips(
	input wire clk,rst,
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	output wire memwriteM,
	output wire[31:0] aluoutM,aluoutW,writedataM,
	input wire[31:0] readdataM,
	output wire regwriteD,regwriteW,
	output wire[31:0] instrD,
	output wire[31:0] rdreg1D,rdreg2D,resultW,signimmD,rf2,rf3,rf4,rf5,rf7,
	output wire[31:0] srcaE,srcbE,writedataE,aluoutE,
	output wire[4:0] writeregW,
	output wire zeroE,memtoregW,equalD,

	output wire[1:0] forwardAE,forwardBE,
	output wire[4:0] RsE,RtE,RsD,RtD,writeregM,writeregE
    );
	wire stallF,stallD,flushE,regwriteE,regwriteM,memtoregM,branchD;
	wire alusrcE,regdstE,pcsrcD,overflow,jumpD,memtoregE,forwardAD,forwardBD;
	wire[2:0] alucontrolE;

	controller c(clk,rst,instrD[31:26],instrD[5:0],equalD,memtoregW,
		memwriteM,pcsrcD,alusrcE,regdstE,regwriteD,regwriteW,jumpD,memtoregE,alucontrolE,
		stallF,stallD,flushE,regwriteE,regwriteM,memtoregM,branchD);
	datapath dp(clk,rst,memtoregW,pcsrcD,alusrcE,
		regdstE,regwriteW,jumpD,alucontrolE,overflow,equalD,pcF,instrF,
		aluoutM,aluoutW,writedataM,readdataM,rdreg1D,rdreg2D,resultW,signimmD,rf2,rf3,rf4,rf5,rf7,
		srcaE,srcbE,writedataE,aluoutE,writeregW,zeroE,forwardAE,forwardBE,forwardAD,forwardBD,
		RsE,RtE,RsD,RtD,writeregM,writeregE,stallF,stallD,flushE);
	hazard hu(memtoregE,
	regwriteE,branchD,regwriteM,memtoregM,regwriteW,//
	writeregW,writeregM,RsE,RtE,RsD,RtD,
	writeregE,//
	forwardAE,forwardBE,stallF,stallD,flushE,
	forwardAD,forwardBD);//
	instrflopFD #(32) instrFflop(clk,rst,~stallD,(pcsrcD|jumpD),instrF,instrD);
endmodule
