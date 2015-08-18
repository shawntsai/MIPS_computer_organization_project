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
	BranchType_o,
	Jump_o,//p3
	MemRead_o,//p3
	MemWrite_o,//p3
	MemtoReg_o,//p3
	jr_o,
	jal_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [2-1:0] RegDst_o;
output         Branch_o;
output [2-1:0] BranchType_o;
output		   Jump_o;
output		   MemRead_o;//p3
output		   MemWrite_o;//p3
output         MemtoReg_o;//p3
output		   jr_o;
output		   jal_o;

//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    [2-1:0] RegDst_o;
reg            Branch_o;
reg    [2-1:0] BranchType_o;
reg 		   Jump_o;
reg 		   MemRead_o;//p3
reg			   MemWrite_o;//p3
reg	           MemtoReg_o;//p3
reg 		   jr_o;
reg 		   jal_o;

//Parameter
parameter Rtype = 3'b000;
parameter ADDI 	= 3'b001;//add
parameter BEQ 	= 3'b010;//sub
parameter BNE 	= 3'b010;//sub
parameter BLT	= 3'b010;//sub
parameter BNEZ	= 3'b010;//sub
parameter BGEZ  = 3'b110;
parameter SLTI 	= 3'b011;//slt
parameter LUI 	= 3'b100;//lui
parameter ORI 	= 3'b101;//or
parameter LW	= 3'b001;//add
parameter SW	= 3'b001;//add

always @(instr_op_i) begin
	case(instr_op_i[5:0])
	6'd0:begin //R-format
		RegDst_o = 1;
		ALUSrc_o = 0;
		MemRead_o = 0;
		MemWrite_o = 0;
		RegWrite_o = 1;
		MemtoReg_o=0;
		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		// BranchType_o =0;
		ALU_op_o = Rtype;
	end
	6'd1:begin//BGEZ need check
		ALUSrc_o = 0;
		RegWrite_o = 0;
		MemRead_o = 0;
		MemWrite_o = 0;
		Branch_o = 1;
		BranchType_o =1;
		// MemtoReg_o=0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		ALU_op_o = BGEZ;
	end
	6'd4:begin // BEQ
		ALUSrc_o = 0;
		RegWrite_o = 0;
		MemRead_o = 0;
		MemWrite_o = 0;
		Branch_o = 1;
		// MemtoReg_o=0;
		BranchType_o =0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		ALU_op_o = BEQ;
	end
	6'd5:begin //BNE
		ALUSrc_o = 0;
		RegWrite_o = 0;
		MemRead_o = 0;
		MemWrite_o = 0;
		// MemtoReg_o=0;
		Branch_o = 1;
		BranchType_o =3;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		ALU_op_o = BNE;

	end
	6'd6:begin//BLT need check
		ALUSrc_o = 0;
		RegWrite_o = 0;
		MemRead_o = 0;
		MemWrite_o = 0;
		// MemtoReg_o=0;
		Branch_o = 1;
		BranchType_o =2;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		ALU_op_o = BLT;
		
	end
	//I-format
	6'd8:begin //ADDI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		MemRead_o = 0;
		MemtoReg_o=0;//from alu
		MemWrite_o = 0;
		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		// BranchType_o =0;
		ALU_op_o = ADDI;
	end
	6'd10:begin //SLTI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		MemRead_o = 0;
		MemtoReg_o=0;
		MemWrite_o = 0;
		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		// BranchType_o =0;
		ALU_op_o = SLTI;
	end
	6'd15:begin //LUI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		MemRead_o = 0;
		MemWrite_o = 0;
		MemtoReg_o=0;


		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		// BranchType_o =0;
		ALU_op_o = LUI;
	end
	6'd13:begin //ORI
		RegDst_o = 0;
		ALUSrc_o = 1;
		RegWrite_o = 1;
		MemRead_o = 0;
		MemWrite_o = 0;
		MemtoReg_o=0;

		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		// BranchType_o =0;
		ALU_op_o = ORI;
	end
	6'd35:begin//lw
		RegDst_o = 0; //for rt


		ALUSrc_o = 1; //for immediate
		MemtoReg_o = 1;//for lw output from!!!!!!!!!!!!!!!!!!!!!!!!ALU

		RegWrite_o = 1; //write register
		MemRead_o = 1; 
		MemWrite_o = 0;
		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		ALU_op_o = LW;
	end
	6'd43:begin//sw
		ALUSrc_o =1; //for immediate
		RegWrite_o = 0;
		MemRead_o = 0;
		MemWrite_o = 1;
	    // MemtoReg_o=1;
		Branch_o = 0;
		Jump_o =0;
		jal_o =0;
		jr_o =0;
		ALU_op_o = SW;
		
	end
	//J-fromat
	6'd2:begin//jump
		RegWrite_o = 0;
		MemRead_o = 0;
		MemWrite_o = 0;
		Branch_o = 0;
		Jump_o =1;
		jal_o =0;
		jr_o =0;
	end
	6'd3:begin //jal
		RegWrite_o = 1;
		MemRead_o = 0;
		MemWrite_o = 0;
		Branch_o = 0;
		RegDst_o =2; //for jal to save $31
		Jump_o =1;
		jal_o =1;//for jal
		jr_o =0;
	end
	// 6'd0:begin//jr
	// 	RegWrite_o = 0;
	// 	MemRead_o = 0;
	// 	MemWrite_o = 0;
	// 	Branch_o = 0;
	// 	Jump_o =0;
	// 	jal_o =0;
	// 	jr_o =1;
	// end
	endcase

end

//Main function

endmodule





                    
                    