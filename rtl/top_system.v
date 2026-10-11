`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 19:03:30
// Design Name: 
// Module Name: top_system
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

module top_system (
    
);

    wire [19:0] cpu_addr;
    wire        cpu_bhe_n;
    wire        cpu_rd_n;
    wire        cpu_wr_n;
    wire        intr;
    wire [15:0] cpu_data_bus;
    wire        acc_sel_n;
    wire        rom_sel_n;
    wire        ram_sel_n;
    
    cpu_8086 u_cpu (
        .intr(intr),
        .cpu_addr(cpu_addr),
        .cpu_bhe_n(cpu_bhe_n),
        .cpu_rd_n(cpu_rd_n),
        .cpu_wr_n(cpu_wr_n),
        .cpu_data_bus(cpu_data_bus)
    );

    memory_subsystem u_mem_subsystem (
        .cpu_addr(cpu_addr),
        .cpu_bhe_n(cpu_bhe_n),
        .cpu_rd_n(cpu_rd_n),
        .cpu_wr_n(cpu_wr_n),
        .rom_sel_n(rom_sel_n),         
        .ram_sel_n(ram_sel_n),
        .cpu_data_bus(cpu_data_bus)
    );
    
        accelerator acc_mod (
        .cpu_data(cpu_data_bus[15:0]),
        .cpu_addr(cpu_addr[3:1]),
        .cs_n(acc_sel_n),
        .oe_n(cpu_rd_n),
        .wr_n(cpu_wr_n),
        .irq(intr)
    );
    
        decoder_74ls138 u_decoder (
        .sel(cpu_addr[19:17]),
        .enable(cpu_addr[16]),
        .y7_rom_n(rom_sel_n),
        .y0_ram_n(ram_sel_n),
        .y1_acc_n(acc_sel_n)
    );

    wire rom_even_cs_n = rom_sel_n | cpu_addr[0];
    wire rom_odd_cs_n  = rom_sel_n | cpu_bhe_n;

    wire ram_even_cs_n = ram_sel_n | cpu_addr[0];
    wire ram_odd_cs_n  = ram_sel_n | cpu_bhe_n;

endmodule