`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:54:42
// Design Name: 
// Module Name: testbench
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


module testbench();
	reg clk;
	reg rst;

	wire[31:0] aluoutM,aluoutW,writedataM;
	wire memwriteM,regwriteD,regwriteW,equalD;
	wire[31:0] readdataM,instrF,pcF,instrD;
	wire[31:0] rdreg1D,rdreg2D,resultW,signimmD,rf2,rf3,rf4,rf5,rf7;
	wire[31:0] srcaE,srcbE,writedataE,aluoutE;
	wire[4:0] writeregW;
	wire zeroE,memtoregW;
	wire[1:0] forwardAE,forwardBE;
	wire[4:0] RsE,RtE,RsD,RtD,writeregM,writeregE;
	top dut(clk,rst,memwriteM,writedataM,aluoutM,aluoutW,
	regwriteD,regwriteW,readdataM,instrF,pcF,instrD,
	rdreg1D,rdreg2D,resultW,signimmD,rf2,rf3,rf4,rf5,rf7,
	srcaE,srcbE,writedataE,aluoutE,writeregW,zeroE,memtoregW,equalD,
	forwardAE,forwardBE,RsE,RtE,RsD,RtD,writeregM,writeregE);

	initial begin 
		rst <= 1;
		#200;
		rst <= 0;
	end

	always begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	
	end

	always @(negedge clk) begin
		if(memwriteM) begin
			/* code */
			if(aluoutM === 84 & writedataM === 7) begin
				/* code */
				$display("Simulation succeeded");
				$stop;
			end 
			else if(aluoutM !== 80) begin
				/* code */
				$display("Simulation Failed");
				$stop;
			end
		end
	end
endmodule
