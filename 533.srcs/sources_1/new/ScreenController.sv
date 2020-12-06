`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/09/2020 09:41:47 PM
// Design Name:
// Module Name: ScreenController
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


module ScreenController(
	input logic clk,
	input logic go,
	input logic [7:0] alua,
	input logic [7:0] alub,
	input logic [3:0] opcode,
	input logic [15:0] alur,
	input logic numops, 
	input logic [7:0] alust,
	output logic  [6:0] vramX,
	output logic [4:0] vramY,
	output logic [6:0] vramD,
	output logic vramL
	);

	logic running;
	logic [3:0] xcounter;
	logic [6:0] data; // used for conversion from nibble to hex char
	logic [6:0] opchar;
	assign vramY = 1'b0;
	assign vramL = ~clk;

    assign vramX = xcounter;
    // convert nibble to char if less than 0xA add the 0x30 to get from 0 to '0'
    // if > 0xA and < 0x10 add 0x37 to get form 0xA to 'A'
    // else we are looking at an opcode char and do nothing
    assign vramD = data + ((data < 7'hA) ? 7'h30 : (data < 8'h10 ) ? 7'h37 : 7'b0);

	always @ (posedge clk) begin
			case(xcounter)
                4'H0: data <= alua[7:4]; // a top nibble
                4'H1: data <= alua[3:0]; // b top nibble
                4'H2: data <= opchar; // op code
                4'H3: data <= numops == 1'b1 ? alub[7:4]: 7'H7F; // b top nibble if both ops are used
                4'H4: data <= numops == 1'b1 ? alub[3:0]: 7'H7F; // b bottom nibble 
                4'H5: data <= 7'H3D; // equal sign 
                4'H6: data <= alur[15:12]; // result 
                4'H7: data <= alur[11:8]; // result 
                4'H8: data <= alur[7:4]; // result 
                4'H9: data <= alur[3:0]; // result 
                4'HC: data <= 7'H1C; // storeage char
                4'HD: data <= alust[7:4]; // storage
                4'HE: data <= alust[3:0]; // storage
			    default: data <= 7'H7F; // blank
			endcase
    			xcounter <= xcounter + 1;
	end

	always @ (*) begin
	   case(opcode)
           4'H0: opchar <= 7'H2b; // + 
           4'H1: opchar <= 7'H2d; // - 
           4'H2: opchar <= 7'H78; // x 
           4'H3: opchar <= 7'H7e; // divide
           4'H4: opchar <= 7'H26; // &
           4'H5: opchar <= 7'H7c; // | 
           4'H6: opchar <= 7'H20; // N couldnt get ~ to look right
           4'H7: opchar <= 7'H5e; // ^
           4'H8: opchar <= 7'H3c; // <
           4'H9: opchar <= 7'H3e; // >
           4'HA: opchar <= 7'H25; // %
           4'HB: opchar <= 7'H7F; //
           4'HC: opchar <= 7'H7F; //
           4'HD: opchar <= 7'H7F; //
           4'HE: opchar <= 7'H7F; //
           4'HF: opchar <= 7'H21; // !
           default: opchar <= 7'H7F; // blank
       endcase
    end


endmodule
