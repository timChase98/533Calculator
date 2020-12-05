`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2020 02:04:46 PM
// Design Name: 
// Module Name: simTop
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


module simTop;
    
    logic clk;
    
    logic [7:0] A;
    logic [7:0] B;
    logic [3:0] OP;
    logic [15:0] R;
    logic numops;
    
    initial begin
        clk <= 1'b0;
        forever #5 clk = ~clk;
    
    end
    
    ALU dut (A, B, OP, R, numops);
    AluTB tb (A, B, OP, R, numops);
    
endmodule













//