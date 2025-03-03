module Add4(
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] sum
);
    assign sum = a + b;
endmodule
//module Add4_tb;
//
//    reg [31:0] a;            // First input
//    reg [31:0] b;            // Second input
//    wire [31:0] sum;         // Output
//
//    // Instantiate the Adder module
//    Add4 uut (
//        .a(a),
//        .b(b),
//        .sum(sum)
//    );
//
//    initial begin
//        // Monitor outputs
//        $monitor("Time = %0t, a = %h, b = %h, sum = %h", $time, a, b, sum);
//
//        // Test case 1: Increment by 4
//        a = 32'h0000_0000;   // PC = 0
//        b = 32'h0000_0004;   // Constant = 4
//        #10;
//
//        // Test case 2: Add offset
//        a = 32'h0000_0008;   // PC = 8
//        b = 32'h0000_0010;   // Offset = 16
//        #10;
//
//        // Test case 3: Large values
//        a = 32'hFFFF_FFFC;   // PC = large number
//        b = 32'h0000_0004;   // Increment by 4
//        #10;
//
//        $finish;             // End simulation
//    end
//
//endmodule
