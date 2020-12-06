//////////////////////////////////////////////////////////////////////////////////
// Engineer: Tim Chase
//
// Create Date: 09/04/2020 06:31:13 PM
// Design Name:
// Module Name: SevenSegDecoder
// Project Name:
// Description: 8x7SEG driver for common anode display
//
//////////////////////////////////////////////////////////////////////////////////


module SevenSegDecoder(
	input logic [3:0] data,
	input logic latch,
	output logic [7:0] pattern
	);

	always @ ( posedge latch ) begin
		case (data)
			4'h0: pattern = 8'b11000000;
			4'h1: pattern = 8'b11111001;
			4'h2: pattern = 8'b10100100;
			4'h3: pattern = 8'b10110000;
			4'h4: pattern = 8'b10011001;
			4'h5: pattern = 8'b10010010;
			4'h6: pattern = 8'b10000010;
			4'h7: pattern = 8'b11111000;
			4'h8: pattern = 8'b10000000;
			4'h9: pattern = 8'b10010000;
			4'hA: pattern = 8'b10001000;
			4'hB: pattern = 8'b10000011;
			4'hC: pattern = 8'b11000110;
			4'hD: pattern = 8'b10100001;
			4'hE: pattern = 8'b10000110;
			4'hF: pattern = 8'b10001110;
		endcase;
		end
endmodule















//
