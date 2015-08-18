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

module Hazard_detection_unit(
      branch_i,
      // if_id_op_i,
          if_id_rs_i,
          if_id_rt_i,
          id_ex_rt_i,
          // id_ex_rd_i,
          id_ex_memRead_i,
          id_flush_o,
          if_id_write_o,
          pc_write_o,
          if_flush_o,
          ex_flush_o
          );
          
input       branch_i;
input [6-1:0]if_id_op_i;
input [5-1:0]if_id_rs_i;
input [5-1:0]if_id_rt_i;
input [5-1:0]id_ex_rt_i;
input [5-1:0]id_ex_rd_i;
input       id_ex_memRead_i;
parameter branch = 6'b000100;

output      if_id_write_o;
output      pc_write_o;

output      id_flush_o;
output      if_flush_o;
output      ex_flush_o;

reg [5-1:0] control_o;

assign {pc_write_o, if_id_write_o, if_flush_o, id_flush_o, ex_flush_o} = control_o;

always@(*) begin

        if(branch_i)
        //branch control hazard
        //flush instructions if_flush =1
        //if flush don't care of stall
        //if flush then  don't care  if_id write
        begin
        control_o = 5'b11111;          
        end
        else begin
          control_o = 5'b11000;
          //load use data hazard
          //force control values in ID/EX register to 0
          //id_flush =1
          //if_flush =0
          //if_id_write = 0 need to stall
          //use instruction is decoded again id_write =0
          //use instruction fetched again pc_write = 0
          //allow MEM to read data for lw ex_flush = 0
          if(id_ex_memRead_i == 1 && 
              (if_id_rs_i == id_ex_rt_i || ( id_ex_rt_i == if_id_rt_i)
            ))
            //stall and inserted bubble
          begin
              control_o = 5'b00010;//don't change
          end
            
          // Data hazards for branches
          // if ((if_id_rs_i == id_ex_rd_i ||  if_id_rt_i==id_ex_rd_i ) &&if_id_op_i ==branch) 
          // begin
          // // stall and inserted bubble
          //     control_o = 5'b00010; //111 010 110 100 okay
          // end
  
        end
end

endmodule


        