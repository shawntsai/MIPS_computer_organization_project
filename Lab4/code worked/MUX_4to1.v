//Subject:     CO project 2 - MUX 221
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      shawn
//----------------------------------------------
//Date:        2010/8/17
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
     
module MUX_4to1(
               data0_i,
               data1_i,
               data2_i,
               data3_i,
               select_i,
               data_o
               );

parameter size=0;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input   [size-1:0] data2_i;
input   [size-1:0] data3_i;
input   [2-1:0]    select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function
always @(*) begin
	if (select_i == 0) begin
		data_o[size-1:0] = data0_i[size-1:0];
	end
	else if(select_i == 1) begin
		data_o[size-1:0] = data1_i[size-1:0];
	end
	else if(select_i == 2) begin
		data_o[size-1:0] = data2_i[size-1:0];
	end
	else if(select_i == 3) begin
		data_o[size-1:0] = data3_i[size-1:0];
	end

end


endmodule      
          
