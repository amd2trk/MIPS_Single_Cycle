module Control_Block(
    input [5:0] opcode,     // 6-bit opcode from the instruction
    output reg RegDst,      // Register destination signal
    output reg Branch,      // Branch signal
    output reg MemRead,     // Memory read signal
    output reg MemtoReg,    // Memory to register signal
    output reg [1:0] ALUOp, // ALU operation signal
    output reg MemWrite,    // Memory write signal
    output reg ALUSrc,      // ALU source signal
    output reg RegWrite     // Register write signal
    );

always @(*) begin
    RegDst = 0;
    Branch = 0;
    MemRead = 0;
    MemtoReg = 0;
    ALUOp = 2'b00;
    MemWrite = 0;
    ALUSrc = 0;
    RegWrite = 0;
    case (opcode)
        6'b000000: begin // R-Type
            RegDst = 1;
            RegWrite = 1;
            ALUOp = 2'b10;
        end
        6'b100011: begin // lw
            ALUSrc = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead = 1;
        end
        6'b101011: begin // sw 
            ALUSrc = 1;
            MemWrite = 1;
        end
        6'b000100: begin // beq 
            Branch = 1;
            ALUOp = 2'b01;
        end
        6'b001000: begin // addi 
            ALUSrc = 1;
            RegWrite = 1;
        end
        default: begin
        end
    endcase
end

endmodule
//module tb_Control();
//
//    // Inputs
//    reg [5:0] OpCode;
//
//    // Outputs
//    wire RegDst;
//    wire Branch;
//    wire MemRead;
//    wire MemtoReg;
//    wire [1:0] ALUOp;
//    wire MemWrite;
//    wire ALUSrc;
//    wire RegWrite;
//
//    // Instantiate the Unit Under Test (UUT)
//    Control uut (
//        .OpCode(OpCode),
//        .RegDst(RegDst),
//        .Branch(Branch),
//        .MemRead(MemRead),
//        .MemtoReg(MemtoReg),
//        .ALUOp(ALUOp),
//        .MemWrite(MemWrite),
//        .ALUSrc(ALUSrc),
//        .RegWrite(RegWrite)
//    );
//
//    // Testbench logic
//    initial begin
//        // Monitor the control signals
//        $monitor("Time: %0t | OpCode: %b | RegDst: %b | Branch: %b | MemRead: %b | MemtoReg: %b | ALUOp: %b | MemWrite: %b | ALUSrc: %b | RegWrite: %b",
//                 $time, OpCode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
//
//        // Test R-Type instruction
//        OpCode = 6'b000000; #10;
//        $display("Expected: RegDst=1, Branch=0, MemRead=0, MemtoReg=0, ALUOp=10, MemWrite=0, ALUSrc=0, RegWrite=1");
//
//        // Test lw instruction
//        OpCode = 6'b100011; #10;
//        $display("Expected: RegDst=0, Branch=0, MemRead=1, MemtoReg=1, ALUOp=00, MemWrite=0, ALUSrc=1, RegWrite=1");
//
//        // Test sw instruction
//        OpCode = 6'b101011; #10;
//        $display("Expected: RegDst=0, Branch=0, MemRead=0, MemtoReg=0, ALUOp=00, MemWrite=1, ALUSrc=1, RegWrite=0");
//
//        // Test beq instruction
//        OpCode = 6'b000100; #10;
//        $display("Expected: RegDst=0, Branch=1, MemRead=0, MemtoReg=0, ALUOp=01, MemWrite=0, ALUSrc=0, RegWrite=0");
//
//        // Test addi instruction
//        OpCode = 6'b001000; #10;
//        $display("Expected: RegDst=0, Branch=0, MemRead=0, MemtoReg=0, ALUOp=00, MemWrite=0, ALUSrc=1, RegWrite=1");
//
//        // Test default case
//        OpCode = 6'b111111; #10;
//        $display("Expected: All control signals should be 0");
//
//        // End simulation
//        $stop;
//    end
//
//endmodule
