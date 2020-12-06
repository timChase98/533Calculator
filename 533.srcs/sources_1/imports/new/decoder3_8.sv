//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/04/2020 08:01:57 PM
// Design Name:
// Module Name: decoder3_8
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


module decoder3_8(
    input logic [2:0] s,
    output logic [7:0] o
    );

    always @ ( * ) begin
        case (s)
            3'o0: o = 8'b00000001;
            3'o1: o = 8'b00000010;
            3'o2: o = 8'b00000100;
            3'o3: o = 8'b00001000;
            3'o4: o = 8'b00010000;
            3'o5: o = 8'b00100000;
            3'o6: o = 8'b01000000;
            3'o7: o = 8'b10000000;
        endcase
    end
endmodule
