//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/05/2020 01:36:30 PM
// Design Name:
// Module Name: VgaController
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

// sync constants

// 0       HLINES HFP  HSP  HMAX
// |           |   |   |    |
// ________________    _____
//             XXXX|___|XXXX

`define HLINES 640
`define HFP `HLINES + 16
`define HSP `HFP + 96
`define HMAX 800

`define VLINES 480
`define VFP `VLINES + 10
`define VSP `VFP + 2
`define VMAX 525

module VgaController(
    input logic pxlClk,
    output logic r,
    output logic g,
    output logic b,
    output logic hsync,
    output logic vsync,
    output logic [6:0] xaddress,
    output logic [4:0] yaddress,
    input logic [6:0] vramQ
    );

    logic ven; // video enable
    logic [9:0] hcounter;
    logic [8:0] vcounter;

    logic [10:0] fontAddr;
    logic [7:0] fontData;

    logic pixel;

    assign fontAddr = {vramQ, vcounter[3:0]};

    FontRom fr (fontAddr, fontData);

    assign xaddress = hcounter[9:3];
    assign yaddress = vcounter[8:4];

    assign pixel = fontData[3'O7 - hcounter[2:0]];

    assign r = 1'b0;
    assign g = ven & pixel;
    assign b = 1'b0;

    // generate the vsync and hsync signals

    assign hsync = (hcounter > `HFP && hcounter <= `HSP) ? 1'b0 : 1'b1;
    assign vsync = (vcounter > `VFP && vcounter <= `VSP) ? 1'b0 : 1'b1;
    assign ven = (hcounter <= `HLINES && vcounter <= `VLINES) ? 1'b1 : 1'b0;

    always @ (posedge pxlClk) begin
        hcounter = hcounter + 1;
        if (hcounter == `HMAX) begin
           hcounter = 0;
           vcounter = vcounter + 1;
        end
        if (vcounter == `VMAX) begin
            vcounter = 0;
        end
    end

endmodule
























//
