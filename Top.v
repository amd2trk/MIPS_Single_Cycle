module Top(
    input wire clk,
    input wire reset,
    input wire [31:0] WriteData,    
    input wire [31:0] A,           
    input wire MemWrite            
);
    parameter MEMORY_DEPTH = 256;
    
    // Internal wires
    wire [31:0] pc_next;
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] out_Signextended, out_shiftleft2;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] RD;
    wire [31:0] ALU_result;
    wire [31:0] write_data_reg;
    wire [31:0] alu_input2;
    wire [31:0] branch_target;
    wire zero;
    
    // Control signals
    wire RegDst, Branch, MemRead, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire MemtoReg;
    
    // Instruction fields
    wire [5:0] opcode;  // Changed name to match Control_Block
    wire [5:0] FuncCode;
    wire [4:0] rs, rt, rd;
    wire [15:0] immediate;
    wire [4:0] write_reg;
    
    // PC and branch handling
    wire [31:0] pc_plus4;
    wire pc_src;
    
    // Instruction decode
    assign opcode = instruction[31:26];
    assign FuncCode = instruction[5:0];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign immediate = instruction[15:0];
    
    // Program Counter
    PC ProgramCounter(
        .clk(clk),
        .reset(reset),
        .pc_in(pc_next),
        .pc_out(pc_out)
    );
    
    // Add 4 to PC with proper 32-bit connections
    Add4 PCPlus4(
        .a(pc_out),
        .b(32'd4),
        .sum(pc_plus4)
    );
    
    // Instruction Memory
    instruction_memory InstructionMemory(
        .address(pc_out),
        .instruction(instruction)
    );
    
    // Control Unit with corrected port name
    Control_Block ControlUnit(
        .opcode(opcode),  // Changed from op to opcode
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUOp(ALUOp),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg)
    );    
    // Register file write register MUX
    assign write_reg = RegDst ? rd : rt;
    
    // Register File
    Registers_Block Registers(
        .clk(clk),
        .WE(RegWrite),
        .ReadReg1(rs),
        .ReadReg2(rt),
        .WriteReg(write_reg),
        .WriteData(write_data_reg),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    // Sign Extend
    Sign_extended SignExtend(
        .in_S(immediate),
        .out_S(out_Signextended)
    );
    
    // Shift Left 2
    shiftleft2 ShiftLeft2(
        .in(out_Signextended),
        .out(out_shiftleft2)
    );
    
    // ALU Control
    ALU_Control ALUControlUnit(
        .ALUOp(ALUOp),
        .FuncCode(FuncCode),
        .ALUControl(ALUControl)
    );
    
    // ALU source MUX
    assign alu_input2 = ALUSrc ? out_Signextended : ReadData2;
    
    // ALU
    ALU ArithmeticLogicUnit(
        .X(ReadData1),
        .Y(alu_input2),
        .control(ALUControl),
        .result(ALU_result),
        .zero(zero)
    );
    
    // Data Memory
    Data #(
        .MEMORY_DEPTH(MEMORY_DEPTH)
    ) DataMemory(
        .clk(clk),
        .WE(MemWrite),
        .A(ALU_result),
        .WD(ReadData2),
        .RD(RD)
    );
    
    // Memory to Register MUX
    assign write_data_reg = MemtoReg ? RD : ALU_result;
    
    // Branch target calculation
    Add4 BranchAdd(
        .a(pc_plus4),
        .b({out_shiftleft2[29:0], 2'b00}),
        .sum(branch_target)
    );
    
    // Branch control
    assign pc_src = Branch & zero;
    
    // Next PC MUX
    assign pc_next = pc_src ? branch_target : pc_plus4;
    
    // Assign WriteData and A for testbench
    assign WriteData = write_data_reg;
    assign A = ALU_result;
    
endmodule
