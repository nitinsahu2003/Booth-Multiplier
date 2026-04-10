`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2026 14:07:26
// Design Name: 
// Module Name: booth_multiplier
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


module booth_multiplier(
        input clk,
        input rst,
        input start,
        input signed[3:0] x,
        input signed[3:0] y,
        
        output reg signed[7:0] z,
        output reg valid
    );
    
    reg signed[3:0] M, Q;
    reg signed[4:0] A;
    reg q0;
    reg[2:0] count;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            M <= 0;
            Q <= 0;
            A <= 0;
            q0 <= 0;
            count <= 0;
            z <= 0;
            valid <= 0;
        end
        else if(start) begin
            M <= x;
            Q <= y;
            A <= 0;
            q0 <= 0;
            count <= 4;
            valid <= 0;
        end
        else if(count > 0) begin
            case({Q[0], q0})
                2'b01 : A = A + M;
                2'b10 : A = A - M;
                default : A = A;
            endcase
            {A , Q, q0} <= {A[4], A, Q}; // Arithmetic Right Shift
            count <= count - 1;
        end
        else if(count == 0) begin
            z <= {A[3:0], Q};
            valid <= 1;
        end
    end
endmodule
