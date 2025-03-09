module register_bank(
    clk,
    data_i,
    reg1,
    reg2,
    reg3,
    reg1_o,
    reg2_o,
    reg3_o,
    sreg1_i,
    sreg1_o,
    write_enable
);
    input clk;
    input write_enable;
    input[7:0] data_i, sreg1_i;
    input[3:0] reg1,reg2,reg3;

    output reg[7:0] reg1_o, reg2_o, reg3_o, sreg1_o;
    reg [7:0] reg_bank [0:15]; 
    reg [7:0] SREG1 = 8'b00000000;

    always @(posedge clk) begin
        #4;
        if(write_enable)
            reg_bank[reg1] <= data_i;
            SREG1 <= sreg1_i;
            sreg1_o <= sreg1_i; 
    end

    always @(posedge clk) begin
        #2;
        reg1_o <= reg_bank[reg1];
        reg2_o <= reg_bank[reg2];
        reg3_o <= reg_bank[reg3];
        sreg1_o <= SREG1;
    end

endmodule