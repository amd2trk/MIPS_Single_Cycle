//`timescale 1ns / 1ps

module ALU (
    input [31:0] X,             // First input operand
    input [31:0] Y,             // Second input operand
    input [3:0] control,        // Control signal to select the ALU operation
    output reg [31:0] result,   // Output result of ALU operation
    output reg zero             // Zero flag (set to 1 if result is zero)
);

    always @(*) begin
        case (control)
            4'b0000: result = X & Y;    // AND operation
            4'b0001: result = X | Y;    // OR operation
            4'b0010: result = X + Y;    // ADD operation
            4'b0110: result = X - Y;    // SUB operation
            4'b0111: result = (X < Y) ? 32'b1 : 32'b0; // Set Less Than
            4'b1100: result = ~(X | Y); // NOR operation
            default: result = 32'b0;    // Default case
        endcase
    end
    
    // Assign zero flag if result is zero
    always @(*) begin
        zero = (result == 32'b0); // Zero flag
    end

endmodule

//
//module ALU_tb;
//    reg [31:0] X;
//    reg [31:0] Y;
//    reg [3:0] control;
//    wire [31:0] result;
//    wire zero;
//
//    ALU uut (
//        .X(X),
//        .Y(Y),
//        .control(control),
//        .result(result),
//        .zero(zero)    );
//
//    initial begin
//        X = 32'h00000015; 
//        Y = 32'h0000000A; 
//        
//        control = 4'b0000; #10;
//        control = 4'b0001; #10;
//        control = 4'b0010; #10;
//        control = 4'b0110; #10;
//        control = 4'b0111; #10;
//        control = 4'b1100; #10;
//    end
//endmodule

