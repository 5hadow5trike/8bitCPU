# 8bitCPU

This is a short project of mine, created during semester break. It's a 8bit CPU with a custom instruction set.

 **Features**

- Stack holding 256 Bytes
- 16 All-purpose Registers
- 1 Special Register
    - Overflow flag
    - Negative flag
    - Zero flag
- Program ROM holding 512 Bytes or 256 commands
- Custom instruction set with 16 commands
    - 8 ALU commands (AND, OR, ADD, SUB and the corresponding immediate versions)
    - Conditional and unconditional jumps
    - PUSH and POP commands for the stack
    - GET and HLT command

For more in-depth information on the instruction set, check the documentation folder

**Executing a program**

1. Write your assembly code and safe as program.asm in the compiler folder
2. Run the compiler.py script
3. Replace the program.mem file in the CPU folder with the one in the compiler folder
4. Run the simulation using icarus verilog
    - Execute the command iverilog -o out ./CPU/ctrl_tb.v in the 8BITCPU folder as the working directory
    - Generate the waveform using vvp out
5. View the simulation using gtkwave
    - Run the command gtkwave wave.vcd to view the generated wave form of the simulation