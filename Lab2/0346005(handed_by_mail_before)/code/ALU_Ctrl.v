//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
parameter AND = 0;
parameter OR  = 1;
parameter ADD = 2;
parameter SUB = 6;
parameter SLT = 7;
parameter NOR = 12;
parameter SRL = 3;
parameter SRLV= 4;
parameter LUI =	5;
//parameter BNE = 8;
//Select exact operation
	always @(funct_i or ALUOp_i) begin
		
		case(ALUOp_i[2:0])
			3'd0:	case(funct_i[5:0]) //R function
					6'd32:	ALUCtrl_o = ADD;
					6'd34:	ALUCtrl_o = SUB;
					6'd36:	ALUCtrl_o = AND;
					6'd37:  ALUCtrl_o = OR;
					6'd42:  ALUCtrl_o = SLT;
					6'd2:	ALUCtrl_o = SRL;	
					6'd6:	ALUCtrl_o = SRLV;
					endcase
			3'd1:	ALUCtrl_o = ADD; //ADDI
			3'd2:	ALUCtrl_o = SUB; //branch equal
			3'd3:	ALUCtrl_o = SLT; //SLTI
			3'd4:	ALUCtrl_o = LUI; //LUI
			3'd5:	ALUCtrl_o = OR; //ORI
			3'd6:	ALUCtrl_o =	SUB; //BNE
		endcase
	end
endmodule     





                    
                    