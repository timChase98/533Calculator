`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 07:25:51 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [7:0] A,
    input logic [7:0] B,
    input logic [3:0] OP,
    output logic [15:0] R,
    output logic numops // 0 if one op 1 of 2 ops
    );
    
    logic [15:0] factorial;
    
    always @ (*) begin
        case (OP)
			4'h0: R <= A + B; // add
			4'h1: R <= A - B; // subtract
			4'h2: R <= A * B; // multiply 
			4'h3: R <= A / B; // div
			4'h4: R <= A & B; // and
			4'h5: R <= A | B; // or
			4'h6: R <= ~A;    // not
			4'h7: R <= A ^ B; // xor
			4'h8: R <= A << B;// left shift
			4'h9: R <= A >> B;// right shift
			4'hA: R <= A % B; // mod
			4'hB: R <= 16'H0000;
			4'hC: R <= 16'H0000;
			4'hD: R <= 16'H0000;
			4'hE: R <= 16'H0000;
			4'hF: R <= factorial; // factorial 
		endcase;
		
        case (OP)
			4'h0: numops <= 1; // add
			4'h1: numops <= 1; // subtract
			4'h2: numops <= 1; // multiply 
			4'h3: numops <= 1; // div
			4'h4: numops <= 1; // and
			4'h5: numops <= 1; // or
			4'h6: numops <= 0; // not
			4'h7: numops <= 1; // xor
			4'h8: numops <= 1; // left shift
			4'h9: numops <= 1; // right shift
			4'hA: numops <= 1; // mod
			4'hB: numops <= 1;
			4'hC: numops <= 1;
			4'hD: numops <= 1;
			4'hE: numops <= 1;
			4'hF: numops <= 0; // factorial 
		endcase;
    end;
    
    always @ (*) begin 
        case (A)
            8'h0: factorial <= 16'd1;
			8'h1: factorial <= 16'd1;
			8'h2: factorial <= 16'd2;
			8'h3: factorial <= 16'd6;
			8'h4: factorial <= 16'd24;
			8'h5: factorial <= 16'd120;
			8'h6: factorial <= 16'd720;
			8'h7: factorial <= 16'd5040;
			8'h8: factorial <= 16'd40320;
			default: factorial <= 16'H0;
        endcase;
    end
    
endmodule











//