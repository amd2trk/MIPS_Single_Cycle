module instruction_memory(
    input wire [31:0] address,
    output wire [31:0] instruction
);
    reg [31:0] memory [0:63];  // 64 words of memory
    
    // Initialize with your program
    initial begin
        memory[0] = 32'h20020005;  // addi $2, $0, 5
        memory[1] = 32'h2003000c;  // addi $3, $0, 12
        memory[2] = 32'h20670009;  // addi $7, $3, 9
        memory[3] = 32'h00e22025;  // or $4, $7, $2
        memory[4] = 32'h00642824;  // and $5, $3, $4
        memory[5] = 32'h00a42820;  // add $5, $5, $4
        memory[6] = 32'h10a70008;  // beq $5, $7, end
        memory[7] = 32'h0064202a;  // slt $4, $3, $4
        memory[8] = 32'h10800001;  // beq $4, $0, around
        memory[9] = 32'h20050000;  // addi $5, $0, 0
        memory[10] = 32'h00e2202a; // slt $4, $7, $2
        memory[11] = 32'h00853820; // add $7, $4, $5
        memory[12] = 32'h00e23822; // sub $7, $7, $2
        memory[13] = 32'hac670044; // sw $7, 68($3)
        memory[14] = 32'h8c020050; // lw $2, 80($0)
        memory[15] = 32'hac020054; // sw $2, 84($0)
    end
    
    // Word aligned addresses (divide by 4)
    assign instruction = memory[address[31:2]];
endmodule


//module Instruction_memory_tb;
//
//    reg [31:0] address;           // Input address
//    wire [31:0] instruction;      // Output instruction
//
//    // Instantiate the InstructionMemory module
//    instruction_memory uut (
//        .address(address),
//        .instruction(instruction)
//    );
//
//    initial begin
//        // Monitor outputs
//        $monitor("Time = %0t, Address = %h, Instruction = %h", $time, address, instruction);
//
//        // Test cases
//        address = 32'h0000_0000; #10; // Fetch first instruction
//        address = 32'h0000_0004; #10; // Fetch second instruction
//        address = 32'h0000_0008; #10; // Fetch third instruction
//        address = 32'h0000_000C; #10; // Fetch fourth instruction
//
//        $finish; // End simulation
//    end
//
//endmodule

