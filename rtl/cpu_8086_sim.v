`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 19:02:56
// Design Name: 
// Module Name: cpu_8086_sim
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


module cpu_8086 (
    input  wire        intr,           
    output wire [19:0] cpu_addr,
    output wire        cpu_bhe_n,
    output wire        cpu_rd_n,
    output wire        cpu_wr_n,
    inout  wire [15:0] cpu_data_bus
);
    
endmodule