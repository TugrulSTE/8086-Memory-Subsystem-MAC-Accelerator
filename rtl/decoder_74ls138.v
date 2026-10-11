`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 19:43:01
// Design Name: 
// Module Name: decoder_74ls138
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


module decoder_74ls138 (
    input  wire [2:0] sel,      // A19, A18, A17
    input  wire       enable,   // A16
    output wire       y7_rom_n, // Fxxxx için aktif (0)
    output wire       y0_ram_n,  // 0xxxx için aktif (0)
    output wire       y1_acc_n
);
    assign y7_rom_n = (enable && (sel == 3'b111)) ? 1'b0 : 1'b1;
    assign y0_ram_n = (!enable && (sel == 3'b000)) ? 1'b0 : 1'b1;
    assign y1_acc_n = (!enable && (sel == 3'b001)) ? 1'b0 : 1'b1;
endmodule