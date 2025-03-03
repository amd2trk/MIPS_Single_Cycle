module Sign_extended(
    input [15:0] in_S,         
    output [31:0] out_S        
);

    assign out_S= {{16{in_S[15]}}, in_S};

endmodule
//module Sign_extended_tb;
//
//    reg [15:0] in_Signextended;           // 16-bit input stimulus
//    wire [31:0] out_Signextended;         // 32-bit output wire
//
//    // Instantiate the SignExtend module
//    Sign_extended uut (
//        .in_Signextended(in_Signextended),
//        .out_Signextended(out_Signextended)
//    );
//
//    initial begin
//        // Apply test cases
//        $monitor("Input = %b, Output = %b", in_Signextended, out_Signextended);
//
//        in_Signextended = 16'b0000_0000_0000_0001;   // Positive number
//        #10;
//        in_Signextended = 16'b1000_0000_0000_0000;   // Negative number (sign bit 1)
//        #10;
//        in_Signextended = 16'b0111_1111_1111_1111;   // Largest positive number
//        #10;
//        in_Signextended = 16'b1111_1111_1111_1111;   // -1 (all bits 1)
//        #10;
//
//        $finish;
//    end
//
//endmodule
//
