`include "./CPU/alu.v"
`include "./CPU/memory.v"
`include "./CPU/register.v"
`include "./CPU/mux.v"
`include "./CPU/stack.v"
`include "./CPU/mux31.v"


module ctrl_unit(
    clk
);

    input clk;
    wire [7:0] alu_in1, alu_in2;
    wire [7:0] alu_out;
    wire [3:0] opcode, reg1, reg2, reg3;
    wire [7:0] reg1_out, reg2_out, reg3_out, sreg1_o, sreg1_i;
    wire [7:0] data_in;
    wire [7:0] stack_in, stack_out;
    //0 for register, 1 for immediat.e
    reg mux_ctrl;
    reg write_enable;
    //Controls data in of reg_bank
    //Decides between ALU Output(00), SET command(01), STACK Output(10)
    reg [1:0] ctrl_data_in;
    //Immediate if 1, reg if 0
    reg stack_in_ctrl;

    alu alu1(
        .clk(clk),
        .a(alu_in1),
        .b(alu_in2),
        .sreg1_i(sreg1_o),
        .out(alu_out),
        .sreg1_o(sreg1_i),
        .opcode(opcode)
    );

    register_bank bank1(
        .clk(clk),
        .data_i(data_in),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3),
        .reg1_o(reg1_out),
        .reg2_o(reg2_out),
        .reg3_o(reg3_out),
        .sreg1_o(sreg1_o),
        .sreg1_i(sreg1_i),
        .write_enable(write_enable)
    );

    mem mem1(
        .clk(clk),
        .opcode(opcode),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3),
        .sreg1(sreg1_o)
    );

    stack stack1(
        .clk(clk),
        .data_i(stack_in),
        .opcode(opcode),
        .data_o(stack_out)
    );

    mux mux1(
        //Only reg3 arg is immediate
        //To change set b to {4'b0000, reg2}
        .a(reg2_out),
        .b(reg2_out),
        .out(alu_in1),
        .ctrl(mux_ctrl)
    );

    mux mux2(
        .a(reg3_out),
        .b({4'b0000,reg3}),
        .out(alu_in2),
        .ctrl(mux_ctrl)
    );

    mux31 mux3(
        .a(alu_out),
        .b({reg2, reg3}),
        .c(stack_out),
        .out(data_in),
        .ctrl(ctrl_data_in)
    );

    mux mux4(
        .a(reg1_out),
        .b({reg2, reg3}),
        .out(stack_in),
        .ctrl(stack_in_ctrl)
    );

    always @(posedge clk) begin
        #1; //Delay to wait for new opcode
        //Standard on, off for jmp command
        write_enable <= 1;
        //Disable writing if jmp instruction or HLT command or push stack command
        if(opcode == 4'b1000 || opcode == 4'b1001 || opcode == 4'b1010 || opcode == 4'b1100 || opcode == 4'b1101 || opcode == 4'b1110) begin
            write_enable <= 0;
        end
        //Decides between immediate and register source for alu commands
        //Determined by bit 2 of the opcode_
        mux_ctrl <= opcode[2];

        //Standard selection is ALU out
        ctrl_data_in <= 2'b00;
        //Uses reg2 and reg3 if SET command
        if(opcode == 4'b1011) begin
            ctrl_data_in <= 2'b01;
        end
        //Use STACK Out if POP command
        else if(opcode == 4'b1111) begin
            ctrl_data_in <= 2'b10;
        end

        //Control stack in
        //Standard is register as input
        stack_in_ctrl <= 0;
        //If immediate command, use immediate instead
        if(opcode == 4'b1110) begin
            stack_in_ctrl <= 1;
        end

    end


endmodule