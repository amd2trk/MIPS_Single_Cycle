module Registers_Block (
    input wire clk,               // Clock signal
    input wire WE,                // Write Enable signal
    input wire [4:0] ReadReg1,    // Address of register 1 to read
    input wire [4:0] ReadReg2,    // Address of register 2 to read
    input wire [4:0] WriteReg,    // Address of register to write
    input wire [31:0] WriteData,  // Data to write to register
    output reg [31:0] ReadData1,  // Changed to reg since used in always block
    output reg [31:0] ReadData2   // Changed to reg since used in always block
);
    // Define the 32 registers, each 32 bits wide
    reg [31:0] registers [31:0];
    
    // Declare integer outside the initial block
    integer i;
    
    // Initialize registers to zero
    initial begin
        for(i = 0; i < 32; i = i + 1)
            registers[i] = 32'b0;
    end
    
    // Always block to handle the read operation
    always @(*) begin
        ReadData1 = registers[ReadReg1]; // Read the data from register ReadReg1
        ReadData2 = registers[ReadReg2]; // Read the data from register ReadReg2
    end
    
    // Always block to handle the write operation on the positive clock edge
    always @(posedge clk) begin
        if (WE && WriteReg != 5'b00000)  // Ensure that $zero cannot be written to
            registers[WriteReg] <= WriteData;  // Write data to the specified register
    end
endmodule

//`timescale 1ns / 1ps
//
//module Registers_Block_tb;
//
//    // Inputs
//    reg clk;
//    reg WE; // Write Enable
//    reg [4:0] ReadReg1;
//    reg [4:0] ReadReg2;
//    reg [4:0] WriteReg;
//    reg [31:0] WriteData;
//
//    // Outputs
//    wire [31:0] ReadData1;
//    wire [31:0] ReadData2;
//
//    // Instantiate the Registers module
//    Registers_Block uut (
//        .clk(clk),
//        .WE(WE),
//        .ReadReg1(ReadReg1),
//        .ReadReg2(ReadReg2),
//        .WriteReg(WriteReg),
//        .WriteData(WriteData),
//        .ReadData1(ReadData1),
//        .ReadData2(ReadData2)
//    );
//
//    // Clock generation
//    always #5 clk = ~clk;
//
//    // Test sequence
//    initial begin
//        // Initialize inputs
//        clk = 0;
//        WE = 0;
//        ReadReg1 = 0;
//        ReadReg2 = 0;
//        WriteReg = 0;
//        WriteData = 0;
//
//        // Test case 1: Write and read from a register
//        #10;
//        WE = 1;           // Enable writing
//        WriteReg = 5'd1;  // Write to register 1
//        WriteData = 32'hA5A5A5A5; // Write data
//        #10;
//        WE = 0;           // Disable writing
//        ReadReg1 = 5'd1;  // Read from register 1
//        #10;
//
//        // Test case 2: Write and read from a different register
//        WE = 1;
//        WriteReg = 5'd2;  // Write to register 2
//        WriteData = 32'h5A5A5A5A; // Write data
//        #10;
//        WE = 0;
//        ReadReg2 = 5'd2;  // Read from register 2
//        #10;
//
//        // Test case 3: Ensure writing to $zero (register 0) is ignored
//        WE = 1;
//        WriteReg = 5'd0;  // Attempt to write to register 0
//        WriteData = 32'hFFFFFFFF; // Write data
//        #10;
//        WE = 0;
//        ReadReg1 = 5'd0;  // Read from register 0
//        #10;
//
//        // Test case 4: Simultaneously read from two different registers
//        ReadReg1 = 5'd1;  // Read from register 1
//        ReadReg2 = 5'd2;  // Read from register 2
//        #10;
//
//        // End simulation
//        $finish;
//    end
//
//endmodule
