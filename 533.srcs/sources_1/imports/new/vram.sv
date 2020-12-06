//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/05/2020 09:13:40 PM
// Design Name:
// Module Name: vram
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


module vram(
    input [6:0] wx, // write x address
    input [4:0] wy, // write y address
    input [6:0] rx, // read x address
    input [4:0] ry, // read y address
    input [6:0] d,
    input latch,
    output [6:0] q
    );

    logic [6:0] ram [31:0][127:0]; // ram array

    initial begin
        for(integer x = 0; x < 128; x++) begin
            for(integer y = 0; y < 32; y++) begin
                ram[y][x] = 7'H0;
            end
        end
        ram[4][0] = 7'H19;ram[4][1] = 7'H19;ram[4][2] = 7'H19;ram[4][3] = 7'H19;ram[4][4] = 7'H00;ram[4][5] = 7'H41;ram[4][6] = 7'H00;ram[4][7] = 7'H2b;ram[4][8] = 7'H00;ram[4][9] = 7'H42;//0000 A + B
        ram[5][0] = 7'H19;ram[5][1] = 7'H19;ram[5][2] = 7'H19;ram[5][3] = 7'H18;ram[5][4] = 7'H00;ram[5][5] = 7'H41;ram[5][6] = 7'H00;ram[5][7] = 7'H2d;ram[5][8] = 7'H00;ram[5][9] = 7'H42;//0001 A - B
        ram[6][0] = 7'H19;ram[6][1] = 7'H19;ram[6][2] = 7'H18;ram[6][3] = 7'H19;ram[6][4] = 7'H00;ram[6][5] = 7'H41;ram[6][6] = 7'H00;ram[6][7] = 7'H78;ram[6][8] = 7'H00;ram[6][9] = 7'H42;//0010 A x B
        ram[7][0] = 7'H19;ram[7][1] = 7'H19;ram[7][2] = 7'H18;ram[7][3] = 7'H18;ram[7][4] = 7'H00;ram[7][5] = 7'H41;ram[7][6] = 7'H00;ram[7][7] = 7'H2f;ram[7][8] = 7'H00;ram[7][9] = 7'H42;//0011 A / B
        ram[8][0] = 7'H19;ram[8][1] = 7'H18;ram[8][2] = 7'H19;ram[8][3] = 7'H19;ram[8][4] = 7'H00;ram[8][5] = 7'H41;ram[8][6] = 7'H00;ram[8][7] = 7'H61;ram[8][8] = 7'H6e;ram[8][9] = 7'H64;ram[8][10] = 7'H00;ram[8][11] = 7'H42;//0100 A and B
        ram[9][0] = 7'H19;ram[9][1] = 7'H18;ram[9][2] = 7'H19;ram[9][3] = 7'H18;ram[9][4] = 7'H00;ram[9][5] = 7'H41;ram[9][6] = 7'H00;ram[9][7] = 7'H6f;ram[9][8] = 7'H72;ram[9][9] = 7'H00;ram[9][10] = 7'H42;//0101 A or B
        ram[10][0] = 7'H19;ram[10][1] = 7'H18;ram[10][2] = 7'H18;ram[10][3] = 7'H19;ram[10][4] = 7'H00;ram[10][5] = 7'H6e;ram[10][6] = 7'H6f;ram[10][7] = 7'H74;ram[10][8] = 7'H00;ram[10][9] = 7'H41;//0110 not A
        ram[11][0] = 7'H19;ram[11][1] = 7'H18;ram[11][2] = 7'H18;ram[11][3] = 7'H18;ram[11][4] = 7'H00;ram[11][5] = 7'H41;ram[11][6] = 7'H00;ram[11][7] = 7'H78;ram[11][8] = 7'H6f;ram[11][9] = 7'H72;ram[11][10] = 7'H00;ram[11][11] = 7'H42;//0111 A xor B
        ram[12][0] = 7'H18;ram[12][1] = 7'H19;ram[12][2] = 7'H19;ram[12][3] = 7'H19;ram[12][4] = 7'H00;ram[12][5] = 7'H41;ram[12][6] = 7'H00;ram[12][7] = 7'H73;ram[12][8] = 7'H68;ram[12][9] = 7'H69;ram[12][10] = 7'H66;ram[12][11] = 7'H74;ram[12][12] = 7'H00;ram[12][13] = 7'H6c;ram[12][14] = 7'H65;ram[12][15] = 7'H66;ram[12][16] = 7'H74;ram[12][17] = 7'H00;ram[12][18] = 7'H42;//1000 A shift left B
        ram[13][0] = 7'H18;ram[13][1] = 7'H19;ram[13][2] = 7'H19;ram[13][3] = 7'H18;ram[13][4] = 7'H00;ram[13][5] = 7'H41;ram[13][6] = 7'H00;ram[13][7] = 7'H73;ram[13][8] = 7'H68;ram[13][9] = 7'H69;ram[13][10] = 7'H66;ram[13][11] = 7'H74;ram[13][12] = 7'H00;ram[13][13] = 7'H72;ram[13][14] = 7'H69;ram[13][15] = 7'H67;ram[13][16] = 7'H68;ram[13][17] = 7'H74;ram[13][18] = 7'H00;ram[13][19] = 7'H42;//1001 A shift right B
        ram[14][0] = 7'H18;ram[14][1] = 7'H19;ram[14][2] = 7'H18;ram[14][3] = 7'H19;ram[14][4] = 7'H00;ram[14][5] = 7'H41;ram[14][6] = 7'H00;ram[14][7] = 7'H6d;ram[14][8] = 7'H6f;ram[14][9] = 7'H64;ram[14][10] = 7'H00;ram[14][11] = 7'H42;//1010 A mod B
        ram[15][0] = 7'H18;ram[15][1] = 7'H19;ram[15][2] = 7'H18;ram[15][3] = 7'H18;ram[15][4] = 7'H00;ram[15][5] = 7'H00;//1011
        ram[16][0] = 7'H18;ram[16][1] = 7'H18;ram[16][2] = 7'H19;ram[16][3] = 7'H19;ram[16][4] = 7'H00;ram[16][5] = 7'H00;//1100
        ram[17][0] = 7'H18;ram[17][1] = 7'H18;ram[17][2] = 7'H19;ram[17][3] = 7'H18;ram[17][4] = 7'H00;ram[17][5] = 7'H00;//1101
        ram[18][0] = 7'H18;ram[18][1] = 7'H18;ram[18][2] = 7'H18;ram[18][3] = 7'H19;ram[18][4] = 7'H00;ram[18][5] = 7'H00;//1110
        ram[19][0] = 7'H18;ram[19][1] = 7'H18;ram[19][2] = 7'H18;ram[19][3] = 7'H18;ram[19][4] = 7'H00;ram[19][5] = 7'H41;ram[19][6] = 7'H00;ram[19][7] = 7'H46;ram[19][8] = 7'H61;ram[19][9] = 7'H63;ram[19][10] = 7'H74;ram[19][11] = 7'H6f;ram[19][12] = 7'H72;ram[19][13] = 7'H69;ram[19][14] = 7'H61;ram[19][15] = 7'H6c;//1111 A Factorial 
    end

    always @ (posedge latch) begin
        ram[wy][wx] <= d;
    end

    assign q = ram[ry][rx];

endmodule
