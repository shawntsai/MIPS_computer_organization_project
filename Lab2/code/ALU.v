//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	shamt_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;
input  [5-1:0]	 shamt_i;
output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
reg zero_o;

//Parameter
parameter AND = 0;
parameter OR  = 1;
parameter ADD = 2;
parameter SUB = 6;
parameter SLT = 7;
parameter NOR = 12;
parameter SRL = 3;
parameter SRLV = 4;
parameter LUI =5;
//parameter BNE =8;
//Main function
always @(src1_i, src2_i, ctrl_i,shamt_i) begin
	case (ctrl_i)
		AND:	result_o = src1_i & src2_i;
		OR:		result_o = src1_i | src2_i;
		ADD:	result_o = src1_i + src2_i;
		SUB:	begin 
				result_o = src1_i - src2_i;
				//zero_o = (result_o == 0);
				end
		SLT:	result_o = src1_i < src2_i ? 1:0;
		NOR: 	result_o = ~(src1_i ^ src2_i); 
		SRL:	result_o = src2_i >> shamt_i;
		SRLV:	result_o = src2_i >> src1_i;
		LUI:	result_o = src2_i << 16;
		default	:result_o = 0;
	endcase
	zero_o = (result_o == 0);
end

endmodule





                    
                    