out = []

with open("program.asm", "r") as f:
    lines = len(f.readlines())

with open("program.asm", "r") as f:
    for i in range(lines):
        line = f.readline()
        line = line.split()
        out_line = ""
        if line[0] == "AND":
            out_line += "0"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "ANDI":
            
            out_line += "4"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "OR":
            
            out_line += "1"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "ORI":
            
            out_line += "5"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "ADD":
            
            out_line += "2"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "ADDI":
            
            out_line += "6"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "SUB":
            
            out_line += "3"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "SUBI":
            
            out_line += "7"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            out_line += hex(int(reg[1]))[2:]
            out_line += hex(int(reg[2]))[2:]
            
        elif line[0] == "JMP":
            out_line += "8"
            out_line += hex((int(line[1]) + (1 << 4)) % (1 << 4))[2:]
            out_line += "00"
            
        elif line[0] == "BZ":
            out_line += "9"
            out_line += hex((int(line[1]) + (1 << 4)) % (1 << 4))[2:]
            out_line += "00"
        elif line[0] == "BN":
            out_line += "a"
            out_line += hex((int(line[1]) + (1 << 4)) % (1 << 4))[2:]
            out_line += "00"
        elif line[0] == "SET":
            out_line += "b"
            reg = line[1].split(",")
            out_line += hex(int(reg[0]))[2:]
            if int(reg[1]) <= 15:
                out_line += "0"
            out_line += hex((int(reg[1]) + (1 << 8)) % (1 << 8))[2:]
            
        elif line[0] == "HLT":
            out_line += "c"
            out_line += "000"
            
        elif line[0] == "PUSH":
            out_line += "d"
            out_line += hex(int(line[1]))[2:]
            out_line += "00"
        elif line[0] == "PUSHI":
            out_line += "e"
            out_line += "0"
            out_line += hex((int(line[1]) + (1 << 8)) % (1 << 8))[2:]
        elif line[0] == "POP":
            out_line += "f"
            out_line += hex(int(line[1]))[2:]
            out_line += "00"
        out_line += "\n"
        out.append(out_line)
        print(out_line)

with open("program.mem", "w") as f:
    f.writelines(out)