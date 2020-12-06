`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2020 02:05:54 PM
// Design Name: 
// Module Name: aluTB
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


program automatic AluTB(
        output logic [7:0] A,
        output logic [7:0] B,
        output logic [3:0] OP,
        input logic [15:0] R,
        input logic numops // 0 if one op 1 of 2 ops
    );
    
    logic [31:0] errors;
    initial errors = 32'b0;
    
    logic [15:0] result;
    
    initial A = 8'B0;
    initial B = 8'B0;
    initial OP = 4'B0;
    
    initial begin
        // 170 + 85 = 255
        // AA + 55 = FF
        #1; A=8'HAA; B=8'H55; OP=4'b0000; result=16'H00FF; #1; checkResults;
        // AA - 55 = 55
        #1; OP=4'b0001; result=16'H0055; #1; checkResults;
        // AA * 55 = 3872
        #1; OP=4'b0010; result=16'H3872; #1; checkResults;
        // AA / 55 = 2
        #1; OP=4'b0011; result=16'H0002; #1; checkResults;
        // AA & 55 = 00
        #1; OP=4'b0100; result=16'H0000; #1; checkResults;
        // AA | 55 = FF
        #1; OP=4'b0101; result=16'H00FF; #1; checkResults;
        // ~AA = FF55 because its a 16bit invert
        #1; OP=4'b0110; result=16'HFF55; #1; checkResults;
        // AA xor 55 = FF
        #1; OP=4'b0111; result=16'H00FF; #1; checkResults;
        // AA << 1 = 154
        #1; B=8'H01; OP=4'b1000; result=16'H0154; #1; checkResults;
        // AA >> 1 = 55
        #1; OP=4'b1001; result=16'H0055; #1; checkResults;
        // AA << 8 = AA00
        #1; B=8'H08; OP=4'b1000; result=16'HAA00; #1; checkResults;
        // AA >> 8 = 00
        #1; OP=4'b1001; result=16'H0000; #1; checkResults;
        // AA mod 8 = 2
        # 1 OP=4'B1010; result=16'H0002; #1 checkResults;
        // 08! = d40320 = H9D80
        #1; A=8'H08; OP=4'b1111; result=16'H9d80; #1; checkResults;
        // 09! = d362,880 = H58980 this overflows our 16 bit register so we display 0 instead
        #1; A=8'H09; OP=4'b1111; result=16'H00; #1; checkResults;
        #1; $finish;
    end;
    
    
    task checkResults;
        $display("At %0d: \t op = %b\t a = %H \t b = %H\t R = %H\t result = %H",
            $time, OP, A, B, R, result);
        if(result != R) begin
            $error("check failed");
            errors = errors + 1;
        end;
    
    endtask;
    
    final $display("Ended with %0d errrors", errors);
    
endprogram: AluTB
