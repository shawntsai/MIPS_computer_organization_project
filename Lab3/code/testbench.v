`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:58 11/17/2013
// Design Name: 
// Module Name:    testbench 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define CYCLE_TIME 50			

module TestBench;
  reg Clk, Start;
 // reg [31:0] i;

  Simple_Single_CPU CPU(Clk,Start);
  
  initial
  begin
    Clk = 0;
    Start = 0;
    
    #(`CYCLE_TIME)
    
    Start = 1;
    #(`CYCLE_TIME*400)	
    
  $finish;
  end
  
  always@(posedge Clk) begin
  	$display("PC = %d----------------------------------------------------------------------------------------------------------------", CPU.PC.pc_out_o);
    $display("m0 = %d, m1 = %d, m2 = %d, m3 = %d, m4 = %d, m5 = %d, m6 = %d, m7 = %d",CPU.Data_Memory.memory[0], CPU.Data_Memory.memory[1], CPU.Data_Memory.memory[2], CPU.Data_Memory.memory[3], CPU.Data_Memory.memory[4], CPU.Data_Memory.memory[5], CPU.Data_Memory.memory[6], CPU.Data_Memory.memory[7]);
    $display("m8= %d, m9= %d, m10= %d, m11= %d, m12= %d, m13= %d, m14= %d, m15= %d",CPU.Data_Memory.memory[8], CPU.Data_Memory.memory[9], CPU.Data_Memory.memory[10], CPU.Data_Memory.memory[11], CPU.Data_Memory.memory[12], CPU.Data_Memory.memory[13], CPU.Data_Memory.memory[14], CPU.Data_Memory.memory[15]);
    $display("m16= %d, m17=  %d, m18= %d, m19= %d, m20= %d, m21= %d, m22= %d, m23= %d",CPU.Data_Memory.memory[16], CPU.Data_Memory.memory[17], CPU.Data_Memory.memory[18], CPU.Data_Memory.memory[19], CPU.Data_Memory.memory[20], CPU.Data_Memory.memory[21], CPU.Data_Memory.memory[22], CPU.Data_Memory.memory[23]);
    $display("m24=  %d, m25= %d, m26= %d, m27= %d, m28= %d, m29= %d, m30= %d, m31= %d",CPU.Data_Memory.memory[24], CPU.Data_Memory.memory[25], CPU.Data_Memory.memory[26], CPU.Data_Memory.memory[27], CPU.Data_Memory.memory[28], CPU.Data_Memory.memory[29], CPU.Data_Memory.memory[30], CPU.Data_Memory.memory[31]);
    $display("Registers");
    $display("R0 = %d, R1 = %d, R2 = %d, R3 = %d, R4 = %d, R5 = %d, R6 = %d, R7 = %d", CPU.RF.Reg_File[ 0], CPU.RF.Reg_File[ 1], CPU.RF.Reg_File[ 2], CPU.RF.Reg_File[ 3], CPU.RF.Reg_File[ 4], CPU.RF.Reg_File[ 5], CPU.RF.Reg_File[ 6], CPU.RF.Reg_File[ 7]);
    $display("R8 = %d, R9 = %d, R10 =%d, R11 =%d, R12 =%d, R13 =%d, R14 =%d, R15 =%d", CPU.RF.Reg_File[ 8], CPU.RF.Reg_File[ 9], CPU.RF.Reg_File[10], CPU.RF.Reg_File[11], CPU.RF.Reg_File[12], CPU.RF.Reg_File[13], CPU.RF.Reg_File[14], CPU.RF.Reg_File[15]);
    $display("R16 =%d, R17 =%d, R18 =%d, R19 =%d, R20 =%d, R21 =%d, R22 =%d, R23 =%d", CPU.RF.Reg_File[16], CPU.RF.Reg_File[17], CPU.RF.Reg_File[18], CPU.RF.Reg_File[19], CPU.RF.Reg_File[20], CPU.RF.Reg_File[21], CPU.RF.Reg_File[22], CPU.RF.Reg_File[23]);
    $display("R24 =%d, R25 =%d, R26 =%d, R27 =%d, R28 =%d, R29 =%d, R30 =%d, R31 =%d", CPU.RF.Reg_File[24], CPU.RF.Reg_File[25], CPU.RF.Reg_File[26], CPU.RF.Reg_File[27], CPU.RF.Reg_File[28], CPU.RF.Reg_File[29], CPU.RF.Reg_File[30], CPU.RF.Reg_File[31]);
  end

  always #(`CYCLE_TIME/2) Clk = ~Clk;	
  
endmodule

