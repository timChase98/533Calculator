//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/04/2020 09:37:14 PM
// Design Name:
// Module Name: Top
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


module Top(
    input logic CLK100MHZ,
    input logic [15:0] sw,
    input logic [4:0] btn,
    output logic [15:0] led,
    output logic r,
    output logic g,
    output logic b,
    output logic hsync,
    output logic vsync,
    output logic [7:0] an,
    output logic [7:0] ca
    );

    logic [53:0] clockDiv;
    logic [6:0] vramD;
    logic vramL;
    logic [6:0] vramXAddressW;
    logic [4:0] vramYAddressW;
    logic [6:0] vramXAddressR;
    logic [4:0] vramYAddressR;
    logic [6:0] vramQ;

    logic screenClk;
    logic [6:0] screenXStart;
    logic [4:0] screenYStart;
    logic screengo;

    logic [15:0] aluR;
    logic [7:0] aluA;
    logic [7:0] aluB;
    logic [7:0] aluST;
    logic [4:0] opCode;
    logic aluNumOps;
    
    logic [7:0] inputVal;
    
    logic [31:0] sevenSegValue;

    assign led = sw;
    
    assign inputVal = sw[7:0];
    assign opCode = sw[15:12];

    assign screenClk = clockDiv[10];

    assign sevenSegValue = {aluR, aluA, aluB};

    SevenSegmentController ssc (sevenSegValue, clockDiv[21], clockDiv[16], an, ca);
    VgaController vga (clockDiv[1], r, g, b, hsync, vsync, vramXAddressR, vramYAddressR, vramQ);
    ScreenController scr (screenClk, aluA, aluB, opCode, aluR, aluNumOps, aluST, vramXAddressW, vramYAddressW, vramD, vramL);
    ALU alu (aluA, aluB, opCode, aluR, aluNumOps);

    vram vr (vramXAddressW, vramYAddressW, vramXAddressR, vramYAddressR, vramD, vramL, vramQ);

    always @ ( posedge CLK100MHZ ) begin
        clockDiv = clockDiv + 1;
    end
    
    always @ (posedge(CLK100MHZ)) begin
        if (btn[2]) // left: latch a 
            aluA <= inputVal ;
        else if (btn[1]) // up: load a
            aluA <= aluST;
            
        if (btn[3]) // right: latch b 
            aluB <= inputVal ;
        else if (btn[4]) // down: load b
            aluB <= aluST;
            
        if (btn[0]) // center: store
            aluST <= aluR[7:0];
        
    end

endmodule
