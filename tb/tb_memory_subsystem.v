`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2026 22:17:26
// Design Name: 
// Module Name: tb_memory_subsystem
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

module tb_memory_subsystem;

    reg  [19:0] cpu_addr;
    reg         cpu_bhe_n;
    reg         cpu_rd_n;
    reg         cpu_wr_n;
    wire         intr;
    reg  [15:0] tb_data_out;
    wire [15:0] cpu_data_bus;

    assign cpu_data_bus = (cpu_rd_n) ? tb_data_out : 16'hZZZZ;
    // Modül baðlantýsý
    memory_subsystem uut (
        .cpu_addr(cpu_addr),
        .cpu_bhe_n(cpu_bhe_n),
        .cpu_rd_n(cpu_rd_n),
        .cpu_wr_n(cpu_wr_n),
        .cpu_data_bus(cpu_data_bus),
        .intr(intr)
    );

    initial begin
        cpu_addr    = 20'h00000;
        cpu_bhe_n   = 1'b1;
        cpu_rd_n    = 1'b1;
        cpu_wr_n    = 1'b1;
        tb_data_out = 16'h0000;
        #20;

        // ==========================================
        // 1. RAM'E 16-BIT YAZMA (Adres: 00000H)
        // ==========================================
        cpu_addr    = 20'h00000;
        cpu_bhe_n   = 1'b0;      // Ýki bank da aktif
        cpu_wr_n    = 1'b0;      // Yazma baþladý
        tb_data_out = 16'h3355;  // Üst bayt=33, Alt bayt=55
        #20;
        cpu_wr_n    = 1'b1;      // Yazma bitti
        #10;

        // ==========================================
        // 2. RAM'DEN 16-BIT OKUMA (Adres: 00000H)
        // ==========================================
        cpu_rd_n    = 1'b0;      // Okuma baþladý
        #20;
        cpu_rd_n    = 1'b1;      // Okuma bitti
        #20;
        // ACCELERATOR PART
        cpu_addr    = 20'h20000;       
        tb_data_out = 16'h0003;       
        #5;
        cpu_wr_n    = 1'b0;            
        #20;
        cpu_wr_n    = 1'b1;            
        #5;                            

        // 2. B Sayýsýný Yaz (5)
        cpu_addr    = 20'h20002;       
        tb_data_out = 16'h0005;        
        #5;
        cpu_wr_n    = 1'b0;            
        #20;
        cpu_wr_n    = 1'b1;            
        #5;

        // 3. Kesmeyi Bekle ve Sonucu Oku
        wait (intr == 1'b1);
        #10;
        cpu_addr    = 20'h20008;       
        #5;
        cpu_rd_n    = 1'b0;            
        #20;
        cpu_rd_n    = 1'b1;            
        #20;
        
        
        $finish;
    end

endmodule
