module alu(
    clk,
    a,
    b,
    sreg1_i,
    out,
    sreg1_o,
    opcode
);


    input clk;
    input[7:0] a,b, sreg1_i;
    input[3:0] opcode;
    output reg[7:0] out, sreg1_o;

    always @(posedge clk) begin
        #3;
        //Pass through SREG if nothing happens
        sreg1_o <= sreg1_i;
        case(opcode)
            4'b0000:out <= a&b;
            4'b0001:out <= a|b;
            4'b0010: begin
                out <= a+b;
                //Handle zero flag
                if(a+b == 8'h00) begin
                    sreg1_o[5] <= 1;
                end else
                    sreg1_o[5] <= 0;
                //Handle overflow flag
                if(a+b < a || a+b < b) begin
                    sreg1_o[6] <= 1;
                end else
                    sreg1_o[6] <= 0;
            end
            4'b0011: begin
                out <= a-b;
                //Handle zero flag
                if(a == b) begin
                    sreg1_o[5] <= 1;
                end else
                    sreg1_o[5] <= 0;
                //Handle negative flag
                if(b > a) begin
                    sreg1_o[7] <= 1;
                end else
                    sreg1_o[7] <= 0;
            end
            //Same code for immediate commands
            4'b0100:out <= a&b;
            4'b0101:out <= a|b;
            4'b0110: begin
                out <= a+b;
                //Handle zero flag
                if(a+b == 8'h00) begin
                    sreg1_o[5] <= 1;
                end else
                    sreg1_o[5] <= 0;
                //Handle overflow flag
                if(a+b > 8'hff) begin
                    sreg1_o[6] <= 1;
                end else
                    sreg1_o[6] <= 0;
            end
            4'b0111: begin
                out <= a-b;
                //Handle zero flag
                if(a == b) begin
                    sreg1_o[5] <= 1;
                end else
                    sreg1_o[5] <= 0;
                //Handle negative flag
                if(b > a) begin
                    sreg1_o[7] <= 1;
                end else
                    sreg1_o[7] <= 0;
            end
        endcase
    end  

endmodule