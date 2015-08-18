//Subject:      CO project 2 - Shift_Left_Two_32
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Shift_Left_Two_26(
    data_i,
    data_o
    );

//I/O ports                    
input [26-1:0] data_i;
output [28-1:0] data_o;
reg [28-1:0] data_o;
always @(data_i)
	begin
    data_o[28-1:0] = {data_i[26-1:0],2'b00};
	end
endmodule
