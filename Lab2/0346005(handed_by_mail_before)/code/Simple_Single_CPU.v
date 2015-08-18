//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
                clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles


wire [32-1:0]pc_;
wire [32-1:0]instrucitonMemory_;
wire decoder_regwrite_registerFile_;
wire decoder_RegDst_MuxWriteReg_;
wire decoder_branch_AND_;
wire decoder_MuxALUSrc_;
wire [3-1:0]decoder_ALUOp_ALUctrl_;
wire [32-1:0]registerFile_RSdata_ALU_;
wire [32-1:0]registerFile_RTdata_ALU_;
wire [32-1:0]ALUResult_WriteData_;
wire ALUZero_AND_;
wire [32-1:0]Adder1_;
wire [32-1:0]Adder2_MuxPCSource_;
wire [32-1:0]MuxPCSource_pc_;
wire [32-1:0]signExtend_;
wire [32-1:0]shiftLeft2_Adder2_;
wire [4-1:0]ALUCtrl_ALU_;
wire [5-1:0]MuxWriteReg_;
wire [32-1:0]MuxALUSrc_;
wire branchOrNot_;
wire MuxForBranch_;
    
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(MuxPCSource_pc_) ,   
	    .pc_out_o(pc_) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_),     
	    .sum_o(Adder1_)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_),  
	    .instr_o(instrucitonMemory_)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instrucitonMemory_[20:16]),
        .data1_i(instrucitonMemory_[15:11]),
        .select_i(decoder_RegDst_MuxWriteReg_),
        .data_o(MuxWriteReg_)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(instrucitonMemory_[25:21]) ,  
        .RTaddr_i(instrucitonMemory_[20:16]) ,  
        .RDaddr_i(MuxWriteReg_) ,  
        .RDdata_i(ALUResult_WriteData_)  , 
        .RegWrite_i (decoder_regwrite_registerFile_),
        .RSdata_o(registerFile_RSdata_ALU_) ,  
        .RTdata_o(registerFile_RTdata_ALU_)   
        );
	
Decoder Decoder(
        .instr_op_i(instrucitonMemory_[31:26]), 
	    .RegWrite_o(decoder_regwrite_registerFile_), 
	    .ALU_op_o(decoder_ALUOp_ALUctrl_),   
	    .ALUSrc_o(decoder_MuxALUSrc_),   
	    .RegDst_o(decoder_RegDst_MuxWriteReg_),   
		.Branch_o(decoder_branch_AND_),
        .branchOrNot_o(branchOrNot_)
	    );

ALU_Ctrl AC(
        .funct_i(instrucitonMemory_[5:0]),   
        .ALUOp_i(decoder_ALUOp_ALUctrl_),   
        .ALUCtrl_o(ALUCtrl_ALU_) 
        );
	
Sign_Extend SE(
        .data_i(instrucitonMemory_[15:0]),
        .data_o(signExtend_)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(registerFile_RTdata_ALU_),
        .data1_i(signExtend_),
        .select_i(decoder_MuxALUSrc_),
        .data_o(MuxALUSrc_)
        );	
		
ALU ALU(
        .src1_i(registerFile_RSdata_ALU_),
        .src2_i(MuxALUSrc_),
        .ctrl_i(ALUCtrl_ALU_),
        .shamt_i(instrucitonMemory_[10:6]),
        .result_o(ALUResult_WriteData_),
        .zero_o(ALUZero_AND_)
        );
		
Adder Adder2(
            .src1_i(shiftLeft2_Adder2_),     
	    .src2_i(Adder1_),     
	    .sum_o(Adder2_MuxPCSource_)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(signExtend_),
        .data_o(shiftLeft2_Adder2_)
        ); 		


MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Adder1_),
        .data1_i(Adder2_MuxPCSource_),
        .select_i(MuxForBranch_),
        .data_o(MuxPCSource_pc_)
        );	

MUX_2to1 #(.size(1)) MuxForBranch(
    .data0_i(decoder_branch_AND_& ALUZero_AND_),//BEQ
        .data1_i(~ALUZero_AND_),//BNE
        .select_i(branchOrNot_),
        .data_o(MuxForBranch_)
        );

endmodule
		  


