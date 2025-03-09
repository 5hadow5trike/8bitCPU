module mux(
    a,
    b,
    out,
    ctrl
);

    input [7:0] a,b;
    input ctrl;
    output reg[7:0] out;

    always @(*) begin
        case (ctrl)
            1'b0: out <= a;
            1'b1: out <= b; 
        endcase
    end
endmodule