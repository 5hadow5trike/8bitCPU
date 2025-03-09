module mem(
    clk,
    opcode,
    reg1,
    reg2,
    reg3,
    sreg1
);

    input clk;
    input [7:0] sreg1;
    output reg[3:0] opcode,reg1,reg2,reg3;
    reg [15:0] memory[0:255];
    reg[7:0] counter = 8'h00;
    
    initial begin
        $readmemh("program.mem", memory);    
    end
    
    always @(posedge clk) begin
        opcode <= memory[counter][15:12];
        reg1 <= memory[counter][11:8];
        reg2 <= memory[counter][7:4];
        reg3 <= memory[counter][3:0];
        //Next command controlled by jmp command
        //Unconditional jump
        if(memory[counter][15:12] == 4'b1000) begin
            counter <= counter + {memory[counter][11],memory[counter][11],memory[counter][11],memory[counter][11],memory[counter][11:8]};
        end 
        //Conditional jump BZ
        else if(memory[counter][15:12] == 4'b1001 && sreg1[5] == 1) begin
            counter <= counter + {memory[counter][11],memory[counter][11],memory[counter][11],memory[counter][11],memory[counter][11:8]};
        end 
        //Conditional jump BN
        else if(memory[counter][15:12] == 4'b1010 && sreg1[7] == 1) begin
            counter <= counter + {memory[counter][11],memory[counter][11],memory[counter][11],memory[counter][11],memory[counter][11:8]};
        end else if(memory[counter][15:12] == 4'b1100) begin
            counter <= counter;
        end else begin
            counter <= counter+1;
        end
    end

endmodule