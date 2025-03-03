module Data #(
    parameter MEMORY_DEPTH = 256
)(
    input wire clk,
    input wire WE,
    input wire [31:0] A,
    input wire [31:0] WD,
    output reg [31:0] RD
);
    reg [31:0] memory [0:MEMORY_DEPTH-1];

    // Declare integer outside initial block
    integer i;

    initial begin
        for(i = 0; i < MEMORY_DEPTH; i = i + 1)
            memory[i] = 32'b0;
    end

    always @(posedge clk) begin
        if(WE)
            memory[A[9:2]] <= WD;
    end

    always @(*) begin
        RD = memory[A[9:2]];
    end
endmodule

//module tb_Data();
//
//    // Parameters
//    parameter MEMORY_DEPTH = 256;
//
//    // Inputs
//    reg clk;
//    reg WE;
//    reg [31:0] A;
//    reg [31:0] WD;
//
//    // Outputs
//    wire [31:0] RD;
//
//    // Instantiate the Unit Under Test (UUT)
//    Data #(
//        .MEMORY_DEPTH(MEMORY_DEPTH)
//    ) uut (
//        .clk(clk),
//        .WE(WE),
//        .A(A),
//        .WD(WD),
//        .RD(RD)
//    );
//
//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // Clock period = 10 units
//    end
//
//    // Testbench logic
//    initial begin
//        // Initialize inputs
//        WE = 0;
//        A = 0;
//        WD = 0;
//
//        // Wait for the clock to stabilize
//        #10;
//
//        // Write test
//        WE = 1;         // Enable write
//        A = 8'h04;      // Address = 4
//        WD = 32'hDEADBEEF; // Write data = DEADBEEF
//        #10;
//
//        WE = 1;         // Enable write
//        A = 8'h10;      // Address = 16
//        WD = 32'hCAFEBABE; // Write data = CAFEBABE
//        #10;
//
//        WE = 0;         // Disable write
//        A = 8'h04;      // Address = 4
//        #10;
//
//        $display("Read data at address 4: %h (Expected: DEADBEEF)", RD);
//
//        A = 8'h10;      // Address = 16
//        #10;
//
//        $display("Read data at address 16: %h (Expected: CAFEBABE)", RD);
//
//        // End simulation
//        $stop;
//    end
//
//endmodule
