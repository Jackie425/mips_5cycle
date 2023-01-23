`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:20:09
// Design Name: 
// Module Name: hazard
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


module hazard(
    input wire memtoregE,regwriteE,branchD,regwriteM,memtoregM,regwriteW,
    input wire[4:0] writeregW,writeregM,RsE,RtE,RsD,RtD,writeregE,
    output wire[1:0] forwardAE,forwardBE,
    output wire stallF,stallD,flushE,forwardAD,forwardBD
    );
    wire branchstall,lwstall;
    
    assign forwardAE = ((RsE != 0) && (RsE == writeregM) && regwriteM) ? 2'b10 :
    ((RsE != 0) && (RsE == writeregW) && regwriteW) ? 2'b01 :
    2'b00;
    assign forwardBE = ((RtE != 0) && (RtE == writeregM) && regwriteM) ? 2'b10 :
    ((RtE != 0) && (RtE == writeregW) && regwriteW) ? 2'b01 :
    2'b00;
    assign forwardAD = (RsD != 0) && (RsD == writeregM) && regwriteM;
    assign forwardBD = (RtD != 0) && (RtD == writeregM) && regwriteM;
    assign lwstall = (((RsD == RtE) || (RtD == RtE)) && memtoregE);
    assign branchstall = (branchD && regwriteE && ((writeregE == RsD) || (writeregE == RtD)))    //流水线暂停将E的结果延到M，方便下一周期forward数据前推
    || (branchD && memtoregM && ((writeregM == RsD) || (writeregM == RtD)));    //若寄存器要读的值正在M阶段则暂停一个周期，让寄存器写进去再读出
    assign flushE = branchstall || lwstall;
    assign stallF = flushE;
    assign stallD = flushE;
endmodule