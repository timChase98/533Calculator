
// Engineer: Tim Chase
//
// Create Date: 09/04/2020 06:31:13 PM
// Design Name:
// Module Name: SevenSegDecoder
// Project Name:
// Description: 8x7SEG driver for common anode display
//
//////////////////////////////////////////////////////////////////////////////////

module SevenSegmentController(
	input logic [31:0] data,
	input logic latch,
	input logic pxlClk,
	output logic [7:0] anodes,
	output logic [7:0] cathodes
	);

	logic [2:0] currentDigit;
	logic [7:0] currentDigitDecoder;
	logic [7:0] patterns [7:0];

	decoder3_8 cdd (currentDigit, currentDigitDecoder);

	SevenSegDecoder digit0 (data[3:0], latch, patterns[0]);
	SevenSegDecoder digit1 (data[7:4], latch, patterns[1]);
	SevenSegDecoder digit2 (data[11:8], latch, patterns[2]);
	SevenSegDecoder digit3 (data[15:12], latch, patterns[3]);
	SevenSegDecoder digit4 (data[19:16], latch, patterns[4]);
	SevenSegDecoder digit5 (data[23:20], latch, patterns[5]);
	SevenSegDecoder digit6 (data[27:24], latch, patterns[6]);
	SevenSegDecoder digit7 (data[31:28], latch, patterns[7]);

	assign cathodes = patterns[currentDigit];
	assign anodes = ~currentDigitDecoder;

	always @ (posedge pxlClk) begin
		currentDigit = currentDigit + 1;
	end



endmodule
