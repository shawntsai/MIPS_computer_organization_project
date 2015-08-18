
`include "alu_top.v"

`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:	0346005
// Engineer:	蔡宇翔
//
// Create Date:    15:15:11 08/18/2010
// Design Name:	
// Module Name:    alu
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

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
		 //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire   [31:0]   W; // 宣告32條線，叫做"W"
wire   [31:0]   R; // 宣告32條線，叫做"R"
wire            L; // 宣告1條線，叫做"L"

assign L = src1[31]^(~src2[31])^W[30]; // 給 wire L一個數值。 
 //use for subtraction , less


  	alu_top A0(.src1(src1[0]),
	     .src2(src2[0]), 
	     .less(L),
	     .A_invert(ALU_control[3]),
	     .B_invert(ALU_control[2]), 
	     .cin((~ALU_control[3])&(ALU_control[2])),  //use for sub and set less than
	     .operation(ALU_control[1:0]),
	     .result(R[0]), 
	     .cout(W[0])); 	


  // 每個參數都要附上module上寫的名稱作辨認，如 alu_top.v 的 alu_top module 寫上"A_invert"，就要用 點A_invert括著你的參數 那樣去寫。另外每個 alu_top module 都要給予不同的名稱，這個叫 "A0"，下一個 alu_top 叫 "A1"
  
  	alu_top A1(.src1(src1[1]),
	     .src2(src2[1]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[0]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[1]), 
	     .cout(W[1]));

   // 第一個 alu_top 的 cout 跟第二個的 alu_top 的 cin 用 W[0] 這條線連接著。
  	alu_top A2(.src1(src1[2]),
	     .src2(src2[2]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[1]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[2]), 
	     .cout(W[2]));

    alu_top A3(.src1(src1[3]),
	     .src2(src2[3]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[2]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[3]), 
	     .cout(W[3]));  
    alu_top A4(.src1(src1[4]),
	     .src2(src2[4]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[3]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[4]), 
	     .cout(W[4]));
  	alu_top A5(.src1(src1[5]),
	     .src2(src2[5]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[4]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[5]), 
	     .cout(W[5]));
    alu_top A6(.src1(src1[6]),
	     .src2(src2[6]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[5]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[6]), 
	     .cout(W[6]));
    alu_top A7(.src1(src1[7]),
	     .src2(src2[7]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[6]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[7]), 
	     .cout(W[7]));
    alu_top A8(.src1(src1[8]),
	     .src2(src2[8]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[7]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[8]), 
	     .cout(W[8]));
	alu_top A9(.src1(src1[9]),
	     .src2(src2[9]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[8]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[9]), 
	     .cout(W[9]));
	alu_top A10(.src1(src1[10]),
	     .src2(src2[10]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[9]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[10]), 
	     .cout(W[10]));
alu_top A11(.src1(src1[11]),
	     .src2(src2[11]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[10]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[11]), 
	     .cout(W[11]));
alu_top A12(.src1(src1[12]),
	     .src2(src2[12]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[11]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[12]), 
	     .cout(W[12]));
alu_top A13(.src1(src1[13]),
	     .src2(src2[13]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[12]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[13]), 
	     .cout(W[13]));
alu_top A14(.src1(src1[14]),
	     .src2(src2[14]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[13]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[14]), 
	     .cout(W[14]));
alu_top A15(.src1(src1[15]),
	     .src2(src2[15]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[14]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[15]), 
	     .cout(W[15]));
alu_top A16(.src1(src1[16]),
	     .src2(src2[16]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[15]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[16]), 
	     .cout(W[16]));
alu_top A17(.src1(src1[17]),
	     .src2(src2[17]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[16]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[17]), 
	     .cout(W[17]));
alu_top A18(.src1(src1[18]),
	     .src2(src2[18]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[17]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[18]), 
	     .cout(W[18]));
alu_top A19(.src1(src1[19]),
	     .src2(src2[19]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[18]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[19]), 
	     .cout(W[19]));
alu_top A20(.src1(src1[20]),
	     .src2(src2[20]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[19]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[20]), 
	     .cout(W[20]));
alu_top A21(.src1(src1[21]),
	     .src2(src2[21]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[20]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[21]), 
	     .cout(W[21]));
alu_top A22(.src1(src1[22]),
	     .src2(src2[22]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[21]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[22]), 
	     .cout(W[22]));
alu_top A23(.src1(src1[23]),
	     .src2(src2[23]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[22]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[23]), 
	     .cout(W[23]));
alu_top A24(.src1(src1[24]),
	     .src2(src2[24]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[23]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[24]), 
	     .cout(W[24]));
alu_top A25(.src1(src1[25]),
	     .src2(src2[25]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[24]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[25]), 
	     .cout(W[25]));
alu_top A26(.src1(src1[26]),
	     .src2(src2[26]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[25]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[26]), 
	     .cout(W[26]));
alu_top A27(.src1(src1[27]),
	     .src2(src2[27]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[26]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[27]), 
	     .cout(W[27]));
alu_top A28(.src1(src1[28]),
	     .src2(src2[28]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[27]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[28]), 
	     .cout(W[28]));
alu_top A29(.src1(src1[29]),
	     .src2(src2[29]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[28]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[29]), 
	     .cout(W[29]));
alu_top A30(.src1(src1[30]),
	     .src2(src2[30]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[29]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[30]), 
	     .cout(W[30]));
alu_top A31(.src1(src1[31]),
	     .src2(src2[31]), 
	     .less(1'b0), 
	     .A_invert(ALU_control[3]), 
	     .B_invert(ALU_control[2]), 
	     .cin(W[30]), 
	     .operation(ALU_control[1:0]), 
	     .result(R[31]), 
	     .cout(W[31])); //not really how to deal with it
 

//always @(rst_n or src1 or src2 )

always @(*)
    begin
      if (!rst_n) 
      begin
        zero = 0;
        cout = 0;
        overflow = 0;
      end
      else begin
          result = R;
          cout = 0; //default no carry out, only happen in add and sub
          case(ALU_control)
          
              //4'b0000://and
              //4'b0001://or
              4'b0010://addition
                begin
                if (~src1[31]&(~src2[31])&R[31])  overflow = 1;     //overflow  + add +  = -
                if (src1[31]&src2[31]& (~R[31]))  overflow = 1;  //overflow  - add -  = +
                if (W[31])  cout = 1; //carry out
                end
              4'b0110://subtraction
                  begin
                  if (src1[31]&~src2[31]&~R[31]) overflow = 1;    //overflow - sub + = + 
                  if (~src1[31]&src2[31]&R[31])  overflow = 1;  //overflow + sub - = -
                  if (W[31])  cout = 1; //carry out
                  end
              //4'b1100://Nor
              //4'b1101://Nand
              //4'b0111://set less than
            //          cin[0] =1; //set LSB =1 for subtraction  A - B = A + ~B +1
                 
          
          endcase 

          //if(R[0]&R[1]&R[2]R[3]&R[4]&R[5]&R[6]&R[7]&R[8]&R[9]
            //R[10]&R[11]&R[12]R[13]&R[14]&R[15]&R[16]&R[17]&R[18]&R[19]
            //R[20]&R[21]&R[22]R[23]&R[24]&R[25]&R[26]&R[27]&R[28]&R[29]
            //R[30]&R[31])
          //zero = 1;
          //if (result[0]&result[1]&result[2]result[3]&result[4]&result[5]&result[6]&result[7]&result[8]&result[9]
            //result[10]&result[11]&result[12]result[13]&result[14]&result[15]&result[16]&result[17]&result[18]&result[19]
            //result[20]&result[21]&result[22]result[23]&result[24]&result[25]&result[26]&result[27]&result[28]&result[29]
            //result[30]&result[31])
            //zero = 1;         
            if (result == 32'b00000000000000000000000000000000) 
              zero = 1;
              else
              zero = 0;
      end//end else
    end //end always

    		

endmodule


