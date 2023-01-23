`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 15:12:22
// Design Name: 
// Module Name: datapath
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


module datapath(
	input wire clk,rst,
	input wire memtoregW,pcsrcD,
	input wire alusrcE,regdstE,
	input wire regwriteW,jumpD,
	input wire[2:0] alucontrolE,
	output wire overflow,equalD,
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	output wire[31:0] aluoutM,aluoutW,writedataM,
	input wire[31:0] readdataM,
	output wire[31:0] rdreg1D,rdreg2D,resultW,signimmD,
	output wire[31:0] rf2,rf3,rf4,rf5,rf7,
	output wire[31:0] srcaE,srcbE,writedataE,aluoutE,
	output wire[4:0] writeregW,
	output wire zeroE,

	input wire[1:0] forwardAE,forwardBE,
	input wire forwardAD,forwardBD,
	output wire[4:0] RsE,RtE,RsD,RtD,writeregM,writeregE,
	input wire stallF,stallD,flushE
    );

	wire[4:0] RdE;
	wire[31:0] pcnext,pcnextbr,pcplus4F,pcplus4D,pcbranchD;
	wire[31:0] signimmE,signimmshD;
	wire[31:0] instrD;
	wire[31:0] readdataW;
	wire[31:0] rdreg1E,rdreg2E,equal1D,equal2D;

	assign RsD = instrD[25:21];
	assign RtD = instrD[20:16];
	//-----------------Fetch-------------------------
	pcff #(32) pcreg(clk,rst,~stallF,pcnext,pcF);
	adder pcadd1(pcF,32'b100,pcplus4F);
	//-----------------------------------------------
	//flopFD
	flopenrc #(32) instflopFD(clk,rst,~stallD,(pcsrcD|jumpD),instrF,instrD);
	flopenrc #(32) pcplus4flopFD(clk,rst,~stallD,(pcsrcD|jumpD),pcplus4F,pcplus4D);
	//-----------------Decode------------------------
	regfile rf(clk,regwriteW,instrD[25:21],instrD[20:16],writeregW,resultW,rdreg1D,rdreg2D,rf2,rf3,rf4,rf5,rf7);
	mux2 #(32) muxeq1(rdreg1D,aluoutM,forwardAD,equal1D);
	mux2 #(32) muxeq2(rdreg2D,aluoutM,forwardBD,equal2D);
	assign equalD = (equal1D == equal2D);
	signext se(instrD[15:0],signimmD);
	sl2 immsh(signimmD,signimmshD);
	adder pcadd2(pcplus4D,signimmshD,pcbranchD);
	//-----------------------------------------------
	//flopDE
	floprc #(32)	rdreg1flopDE(clk,rst,flushE,rdreg1D,rdreg1E);
	floprc #(32)	rdreg2flopDE(clk,rst,flushE,rdreg2D,rdreg2E);
	floprc #(5)	RteflopDE(clk,rst,flushE,instrD[20:16],RtE);
	floprc #(5)	RdeflopDE(clk,rst,flushE,instrD[15:11],RdE);
	floprc #(5)	RseflopDE(clk,rst,flushE,instrD[25:21],RsE);
	floprc #(32)	signimmflopDE(clk,rst,flushE,signimmD,signimmE);
	//-----------------Execute-----------------------
	mux3 #(32) forwardAEmux(rdreg1E,resultW,aluoutM,forwardAE,srcaE);
	mux3 #(32) forwardBEmux(rdreg2E,resultW,aluoutM,forwardBE,writedataE);
	mux2 #(32) srcbEmux(writedataE,signimmE,alusrcE,srcbE);
	alu alu(srcaE,srcbE,alucontrolE,aluoutE,overflow,zeroE);
	mux2 #(5) wrmux(RtE,RdE,regdstE,writeregE);
	//-----------------------------------------------
	//flopEM
	flopr #(32)	aluoutflopEW(clk,rst,aluoutE,aluoutM);
	flopr #(32)	writedataflopEW(clk,rst,writedataE,writedataM);
	flopr #(5)	writeregflopEW(clk,rst,writeregE,writeregM);
	//-----------------Memory------------------------
	
	//-----------------------------------------------
	//flopMW
	flopr #(32) aluoutflopMW(clk,rst,aluoutM,aluoutW);
	flopr #(32)	readdataflopMW(clk,rst,readdataM,readdataW);
	flopr #(5)	writeregflopMW(clk,rst,writeregM,writeregW);
	//----------Writeback & pcupdate-----------------
	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbr);
	mux2 #(32) pcmux(pcnextbr,{pcplus4D[31:28],instrD[25:0],2'b00},jumpD,pcnext);
	//-----------------------------------------------
endmodule
