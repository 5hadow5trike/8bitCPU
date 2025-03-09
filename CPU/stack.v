module stack(
    data_i,
    opcode,
    clk,
    data_o
);
    input clk;
    input [7:0] data_i;
    input [3:0] opcode;
    output reg[7:0] data_o;

    reg [7:0] stp = 8'h00;
    reg [7:0] stack[0:255];

    always @(posedge clk) begin
        #3;
        //PUSH Reg
        if(opcode == 4'b1101) begin
            stack[stp] <= data_i;
            stp <= stp + 1;
        end else if(opcode == 4'b1110) begin
            stack[stp] <= data_i;
            stp <= stp + 1;
        end else if(opcode == 4'b1111) begin
            stp <= stp-1;
            //has to say stp-1
            data_o <= stack[stp-1];
        end
    end

endmodule