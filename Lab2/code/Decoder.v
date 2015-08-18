//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	branchOrNot_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output		   branchOrNot_o;
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg 		   branchOrNot_o;

//Parameter
parameter Rtype = 3'b000;
parameter ADDI 	= 3'b001;
parameter BEQ 	= 3'b010;
parameter SLTI 	= 3'b011;
parameter LUI 	= 3'b100;
parameter ORI 	= 3'b101;
parameter BNE 	= 3'b110;
always @(instr_op_i) begin
	case(instr_op_i[5:0])
	6'd0:begin //R-format
		RegDst_o = 1;
		ALUSrc_o = 0;
		RegWrite_o = 1;
		Branch_o = 0;
		branchOrNot_o =0;
		ALU_op_o = Rtype;
	end
	6'd4:begin // BEQ
		//RegDst_o <= x;
		ALUSrc_o = 0;
		RegWrite_o = 0;
		Branch_o = 1;
		branchOrNot_o =0;
		ALU_op_o = BEQ;
	end
	6'd5:begin //BNE
		//RegDst_o <= x;
		ALUSrc_o = 0;
		RegWrite_o = 0;
		Branch_o = 1;
		branchOrNot_o =1;
		ALU_op_o = BNE;
	end
	//I-format
	6'd8:begin //ADDI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		Branch_o = 0;
		branchOrNot_o =0;
		ALU_op_o = ADDI;
	end
	6'd10:begin //SLTI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		Branch_o = 0;
				branchOrNot_o =0;
		ALU_op_o = SLTI;
	end
	6'd15:begin //LUI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		Branch_o = 0;
				branchOrNot_o =0;

		ALU_op_o = LUI;
	end
	6'd13:begin //ORI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		Branch_o = 0;
				branchOrNot_o =0;

		ALU_op_o = ORI;
	end
	endcase

end

//Main function

endmodule





                    
                    