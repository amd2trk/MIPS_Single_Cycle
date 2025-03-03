module ALU_Control(
    input [1:0] ALUOp,
    input [5:0] FuncCode,
    output reg [3:0] ALUControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010;
            2'b01: ALUControl = 4'b0110;
            2'b10: begin
                case (FuncCode)
                    6'b100000: ALUControl = 4'b0010;
                    6'b100010: ALUControl = 4'b0110;
                    6'b100100: ALUControl = 4'b0000;
                    6'b100101: ALUControl = 4'b0001;
                    6'b101010: ALUControl = 4'b0111;
                    default:   ALUControl = 4'b0000;
                endcase
            end
            default: ALUControl = 4'b0000;
        endcase
    end
endmodule
//module ALU_Control_tb;
//
//    reg [1:0] ALUOp;
//    reg [5:0] FuncCode;
//    wire [3:0] ALUControl;
//
//    // Instantiate the ALU_Control module
//    ALU_Control uut (
//        .ALUOp(ALUOp),
//        .FuncCode(FuncCode),
//        .ALUControl(ALUControl)
//    );
//
//    initial begin
//        // Test LW/SW
//        ALUOp = 2'b00; FuncCode = 6'bXXXXXX;
//        #10 $display("LW/SW: ALUControl = %b", ALUControl);
//
//        // Test BEQ
//        ALUOp = 2'b01; FuncCode = 6'bXXXXXX;
//        #10 $display("BEQ: ALUControl = %b", ALUControl);
//
//        // Test R-Type: Add
//        ALUOp = 2'b10; FuncCode = 6'b100000;
//        #10 $display("R-Type Add: ALUControl = %b", ALUControl);
//
//        // Test R-Type: Subtract
//        ALUOp = 2'b10; FuncCode = 6'b100010;
//        #10 $display("R-Type Subtract: ALUControl = %b", ALUControl);
//
//        // Test R-Type: AND
//        ALUOp = 2'b10; FuncCode = 6'b100100;
//        #10 $display("R-Type AND: ALUControl = %b", ALUControl);
//
//        // Test R-Type: OR
//        ALUOp = 2'b10; FuncCode = 6'b100101;
//        #10 $display("R-Type OR: ALUControl = %b", ALUControl);
//
//        // Test R-Type: Set on Less Than
//        ALUOp = 2'b10; FuncCode = 6'b101010;
//        #10 $display("R-Type SLT: ALUControl = %b", ALUControl);
//
//        $stop;
//    end
//endmodule
//
