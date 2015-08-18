//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name:    Forwarding_unit
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Forwarding_unit(
            id_ex_rs_i,
            id_ex_rt_i,
            ex_mem_rd_i,
            mem_wb_rd_i,
            ex_mem_regwrite_i,
            mem_wb_regwrite_i,
            forwardA_o,
            forwardB_o
            );

input       ex_mem_regwrite_i;
input       mem_wb_regwrite_i;
input [5-1:0] id_ex_rs_i;
input [5-1:0] id_ex_rt_i;
input [5-1:0] ex_mem_rd_i;
input [5-1:0] mem_wb_rd_i;
output [2-1:0] forwardA_o;
output [2-1:0] forwardB_o;

reg [2-1:0] forwardA_o;
reg [2-1:0] forwardB_o;

always @(*) begin
//EX hazard
    forwardA_o =0; //don't change
    forwardB_o =0; //don't change
    if (ex_mem_regwrite_i==1&& (ex_mem_rd_i != 0) //1a
        &&(ex_mem_rd_i==id_ex_rs_i)) begin
        forwardA_o = 2'b01;//don't change
    end
    if (ex_mem_regwrite_i==1&&(ex_mem_rd_i != 0) //1b
        &&(ex_mem_rd_i == id_ex_rt_i)) begin
        forwardB_o = 2'b10;//don't change
    end
//MEM hazard
    if(mem_wb_regwrite_i==1&&(mem_wb_rd_i !=0)
        &&
        !((ex_mem_regwrite_i==1&& (ex_mem_rd_i != 0) //not 1a
        &&(ex_mem_rd_i==id_ex_rs_i)))
        &&(mem_wb_rd_i == id_ex_rs_i)
        )begin
        forwardA_o = 2'b10; //don't change
        end
    if (mem_wb_regwrite_i==1 && (mem_wb_rd_i !=0)
        &&
        !((ex_mem_regwrite_i==1&&(ex_mem_rd_i != 0) //not 1b
        &&(ex_mem_rd_i == id_ex_rt_i)))
        &&(mem_wb_rd_i == id_ex_rt_i)

        ) begin
        forwardB_o = 2'b01;//don't change
    end
end

endmodule
