
module shiftleft2 (
    input [31:0] in,         
    output [31:0] out        
);

    
     assign out = {in[29:0], 2'b00};

endmodule
module shiftleft2_tb;

    reg [31:0] in_shiftleft2;           // Input
    wire [31:0] out_shiftleft2;         // Output

    // Instantiate the ShiftLeft2 module
    shiftleft2 uut (
        .in_shiftleft2(in_shiftleft2),
        .out_shiftleft2(out_shiftleft2)
    );

    initial begin
        // Monitor the inputs and outputs
        $monitor("Time = %0t, Input = %h, Output = %h", $time, in, out);

        // Test case 1: Input = 1
        in_shiftleft2 = 32'h0000_0001; #10; // Output = 4 (1 << 2)

        // Test case 2: Input = 2
        in_shiftleft2 = 32'h0000_0002; #10; // Output = 8 (2 << 2)

        // Test case 3: Input = 10
        in_shiftleft2 = 32'h0000_000A; #10; // Output = 40 (10 << 2)

        // Test case 4: Input = 0x0000_00FF
        in_shiftleft2 = 32'h0000_00FF; #10; // Output = 0x0000_03FC

        $finish; // End simulation
    end

endmodule
