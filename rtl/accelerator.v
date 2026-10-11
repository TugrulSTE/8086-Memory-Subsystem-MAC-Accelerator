`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 19:05:05
// Design Name: 
// Module Name: accelerator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module accelerator (
    inout wire [15:0] cpu_data,
    input wire [2:0] cpu_addr,   
    input wire      acc_sel_n, 
    input wire cs_n,
    input wire oe_n,
    input wire wr_n,
    output wire irq
 );
    reg irq_in = 1'b0;
    reg [15:0] reg_a;
    reg [15:0] reg_b;
    reg [15:0] reg_ctrl;
    wire [15:0] result;
    reg [2:0] addr;
    
    always @(posedge wr_n) begin
        if (!cs_n) begin
            case (cpu_addr)
                3'b000: reg_a    <= cpu_data;   // A sayýsýný sakla
                3'b001: begin
                    reg_b    <= cpu_data;   // B sayýsýný sakla
                    irq_in   <= 1'b1;
                end
                3'b010: reg_ctrl <= cpu_data;   // ADDITIONAL
            endcase
        end
    end
    assign irq = irq_in;
    assign result = reg_a * reg_b;
    assign cpu_data = (!cs_n && !oe_n && cpu_addr == 3'b100) ? result : 16'hZZZZ;
endmodule
