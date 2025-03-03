
# MIPS Single Cycle Processor

This repository contains a Verilog implementation of a single-cycle MIPS processor. The processor is designed to execute a subset of the MIPS instruction set, including arithmetic, logical, memory access, and control flow instructions.

---

## **Project Structure**

The project is organized into several Verilog modules, each representing a different component of the processor. Below is a brief description of each module:

- **Top.v**: The top-level module that integrates all the components of the processor.
- **Instruction_memory.v**: The instruction memory module that stores the program to be executed.
- **Control_Block.v**: The control unit that generates control signals based on the instruction opcode.
- **Add4.v**: A simple adder module that increments the program counter by 4.
- **Data.v**: The data memory module that handles memory read and write operations.
- **ALU.v**: The Arithmetic Logic Unit (ALU) that performs arithmetic and logical operations.
- **Registers_Block.v**: The register file that contains the processor's general-purpose registers.
- **ALU_Control.v**: The ALU control unit that determines the operation to be performed by the ALU.
- **shiftleft2.v**: A module that performs a left shift by 2 bits, used for branch address calculation.
- **Sign_extended.v**: A module that sign-extends a 16-bit immediate value to 32 bits.
- **PC.v**: The program counter module that manages the address of the next instruction.
- **testbench.v**: The testbench for simulating and testing the entire processor.

---

## **Instructions Supported**

The processor supports the following MIPS instructions:

- **R-Type Instructions**: `add`, `sub`, `and`, `or`, `slt`
- **I-Type Instructions**: `addi`, `lw`, `sw`, `beq`
- **J-Type Instructions**: Not supported in this implementation.

---

## **How to Run the Simulation**

To simulate the processor, you can use any Verilog simulator such as **Icarus Verilog**. Below are the steps to run the simulation:

---

### **1. Install Icarus Verilog**

#### **On Ubuntu/Debian**
```bash
sudo apt-get install iverilog
```

#### **On Fedora**
```bash
sudo dnf install iverilog
```

#### **On Arch Linux**
```bash
sudo pacman -S iverilog
```

#### **On macOS**
```bash
brew install icarus-verilog
```

#### **On Windows**
1. Download the Icarus Verilog installer from the [official website](http://iverilog.icarus.com/).
2. Run the installer and ensure that the option to add Icarus Verilog to the system PATH is selected.

---

### **2. Clone the Repository**
```bash
git clone https://github.com/your-username/mips-single-cycle.git
cd mips-single-cycle
```

---

### **3. Compile the Verilog Files**
Compile all the Verilog modules and the testbench using the following command:

```bash
iverilog -o mips_single_cycle Top.v Instruction_memory.v Control_Block.v Add4.v Data.v ALU.v Registers_Block.v ALU_Control.v shiftleft2.v Sign_extended.v PC.v testbench.v
```

---

### **4. Run the Simulation**
After successful compilation, run the simulation using:

```bash
vvp mips_single_cycle
```

---

### **5. Expected Output**
The testbench will simulate the processor and monitor the values of `A` (address) and `WriteData`. If the processor writes the value `7` to address `84`, the simulation will print:

```
Simulation succeeded
```

and stop.

---

### **6. Optional: Generate and View Waveforms**
To generate waveforms for debugging, modify the `testbench.v` file to include the following lines at the beginning of the `initial` block:

```verilog
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, testbench);
    reset <= 1; #22;
    reset <= 0;
    $display("\t\t time \tA\t\tWriteData");
    $monitor("%d\t%d\t%d", $time, A, WriteData);
end
```

Recompile and run the simulation. Then, open the waveform file using GTKWave:

```bash
gtkwave waveform.vcd
```

---

## **Testbench**

The `testbench.v` file simulates the entire processor and checks if the value `7` is written to address `84`. If successful, it will print `Simulation succeeded`.


---


## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This updated `README.md` provides clear installation instructions, simulation steps, and debugging tips. Let me know if you need further assistance!
