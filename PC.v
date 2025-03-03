
module PC (
    input clk,               
    input reset,             
    input [31:0] pc_in,      
    output reg [31:0] pc_out 
);

    
    always @(posedge clk) begin
        if (reset)
            pc_out <= 32'b0;      
        else
            pc_out <= pc_in;      
    end

endmodule
//module PC_tb;
//
//    reg clk;                 // Clock signal
//    reg reset;               // Reset signal
//    reg [31:0] pc_in;        // Input to the PC
//    wire [31:0] pc_out;      // Output of the PC
//
//    // Instantiate the ProgramCounter module
//    PC uut (
//        .clk(clk),
//        .reset(reset),
//        .pc_in(pc_in),
//        .pc_out(pc_out)
//    );
//
//    // Clock generation
//    always #5 clk = ~clk;    // Clock period = 10 time units
//
//    initial begin
//        // Initialize signals
//        clk = 0;
//        reset = 1;
//        pc_in = 32'b0;
//
//        // Monitor PC output
//        $monitor("Time = %0t, Reset = %b, PC_in = %h, PC_out = %h", $time, reset, pc_in, pc_out);
//
//        // Test reset behavior
//        #10 reset = 0;       // De-assert reset
//        pc_in = 32'h4;       // Next PC value = 4
//        #10;
//
//        pc_in = 32'h8;       // Next PC value = 8
//        #10;
//
//        pc_in = 32'hC;       // Next PC value = C
//        #10;
//
//        reset = 1;           // Assert reset again
//        #10;
//
//        $finish;             // End simulation
//    end
//
//endmodule
