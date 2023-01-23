`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:50:53
// Design Name: 
// Module Name: top
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


module top(
	input wire clk,rst,
	output wire memwriteM,
	output wire[31:0] writedataM, 
	output wire[31:0] aluoutM,aluoutW,
	output wire regwriteD,regwriteW,
	output wire[31:0] readdataM,instrF,pcF,instrD,
	output wire[31:0] rdreg1D,rdreg2D,resultW,signimmD,rf2,rf3,rf4,rf5,rf7,
	output wire[31:0] srcaE,srcbE,writedataE,aluoutE, 
	output wire[4:0] writeregW,
	output wire zeroE,memtoregW,equalD,

	output wire[1:0] forwardAE,forwardBE,
	output wire[4:0] RsE,RtE,RsD,RtD,writeregM,writeregE
    );

	mips mips(clk,rst,pcF,instrF,memwriteM,aluoutM,aluoutW,writedataM,readdataM,regwriteD,regwriteW,instrD,
	rdreg1D,rdreg2D,resultW,signimmD,rf2,rf3,rf4,rf5,rf7,
	srcaE,srcbE,writedataE,aluoutE,writeregW,zeroE,memtoregW,equalD,forwardAE,forwardBE,RsE,RtE,RsD,RtD,writeregM,writeregE);
	inst_mem imem(~clk,pcF[7:2],instrF);
	data_mem dmem(~clk,memwriteM,aluoutM,writedataM,readdataM);
endmodule
