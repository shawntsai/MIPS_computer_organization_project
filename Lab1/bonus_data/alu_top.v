`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 	0346005
// Engineer:	蔡宇翔 
// 
// Create Date:    10:58:01 10/10/2011 
// Design Name: 
// Module Name:    alu_top 
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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;

wire          A_invertNsrc1_;
wire          B_invertNsrc2_;
wire          AND_;
wire          OR_;
wire          ADD_;
wire          COUT_; //I add

assign A_invertNsrc1_ = A_invert ? ~src1 : src1;
assign B_invertNsrc2_ = B_invert ? ~src2 : src2;
or(OR_,A_invertNsrc1_,B_invertNsrc2_);
and(AND_,A_invertNsrc1_,B_invertNsrc2_);
assign {COUT_,ADD_} = A_invertNsrc1_ + B_invertNsrc2_ + cin;
assign  cout = COUT_;

//always@(A_invert or B_invert or cin or src1 or src2 or less)
always@(*)

    begin
  case(operation)
	2'b00:result = AND_;    
	2'b01:result = OR_;
	2'b10:result = ADD_;
	2'b11:result = less; 
  endcase
    end

endmodule
