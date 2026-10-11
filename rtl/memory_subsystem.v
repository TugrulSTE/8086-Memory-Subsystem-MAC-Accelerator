`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2026 21:46:59
// Design Name: 
// Module Name: memory_subsystem
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

`timescale 1ns / 1ps



// ==========================================
// 2. ALT MODÜL: 8-bit Bellek Çipi (ROM/RAM Temsili)
// ==========================================
module memory_chip (
    input  wire [3:0] addr,
    input  wire       cs_n,
    input  wire       oe_n,
    output wire [7:0] data_out
);
    reg [7:0] mem [0:15]; // Şematik şişmesin diye 16 adreslik mini dizi

    initial begin
        mem[0] = 8'hAA;
        mem[1] = 8'hCC;
    end

    assign data_out = (!cs_n && !oe_n) ? mem[addr] : 8'bZZZZZZZZ;
endmodule

module memory_ram_chip (
    input  wire [3:0] addr,
    input  wire       cs_n,
    input  wire       oe_n,
    input  wire       wr_n, 
    input wire [7:0] data_in,
    output wire [7:0] data_out
);
    reg [7:0] mem [0:15]; // Şematik şişmesin diye 16 adreslik mini dizi

    initial begin
        mem[0] = 8'hAA;
        mem[1] = 8'hCC;
    end
    always @(*) begin
        if (!cs_n && !wr_n) begin
            mem[addr] = data_in;
        end
    end
    assign data_out = (!cs_n && !oe_n) ? mem[addr] : 8'bZZZZZZZZ;
    // HATALI: assign mem[addr] = (!cs_n && !wr_n) ? data_in : 8'b00000000;
endmodule


module memory_subsystem (
    input  wire [19:0] cpu_addr,
    input  wire        cpu_bhe_n,
    input  wire        cpu_rd_n,
    input  wire        cpu_wr_n,
    input  wire        rom_sel_n,
    input  wire        ram_sel_n,
    inout wire [15:0] cpu_data_bus
);


    wire acc_sel_n;

    memory_chip u_rom_even (
        .addr(cpu_addr[4:1]), // A1->A0 kaydırması
        .cs_n(rom_even_cs_n),
        .oe_n(cpu_rd_n),
        .data_out(cpu_data_bus[7:0])
    );

    memory_chip u_rom_odd (
        .addr(cpu_addr[4:1]),
        .cs_n(rom_odd_cs_n),
        .oe_n(cpu_rd_n),
        .data_out(cpu_data_bus[15:8])
    );
    
    memory_ram_chip u_ram_even (
        .addr(cpu_addr[4:1]),
        .cs_n(ram_even_cs_n),
        .oe_n(cpu_rd_n),
        .wr_n(cpu_wr_n),
        .data_in(cpu_data_bus[7:0]),
        .data_out(cpu_data_bus[7:0])
     );
    
    memory_ram_chip u_ram_odd (
        .addr(cpu_addr[4:1]),
        .cs_n(ram_odd_cs_n),
        .oe_n(cpu_rd_n),
        .wr_n(cpu_wr_n),
        .data_in(cpu_data_bus[15:8]),
        .data_out(cpu_data_bus[15:8])
     );


endmodule