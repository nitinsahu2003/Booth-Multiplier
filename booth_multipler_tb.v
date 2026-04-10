`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2026 14:08:06
// Design Name: 
// Module Name: booth_multipler_tb
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


module booth_multipler_tb;

    reg clk;
    reg rst;
    reg start;
    reg signed[3:0] x;
    reg signed[3:0] y;
    
    wire signed[7:0] z;
    wire valid;
    
    booth_multiplier DUT(
        .clk(clk),
        .rst(rst),
        .start(start),
        .x(x),
        .y(y),
        .z(z),
        .valid(valid)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        x = 0;
        y = 0;
        
        
        @(posedge clk);
        rst = 0; // Release reset
        
        
        //Test 1
        @(posedge clk);
        x = 5;
        y = 6;
        start = 1;
        
        @(posedge clk)
        start = 0;
        wait(valid);
        
        #20;
        
        // Test 2
        @(posedge clk);
        x = -7;
        y = 3;
        start = 1;
        
        @(posedge clk);
        start = 0;
        wait(valid);
        
        #20 $finish;
    end
endmodule
