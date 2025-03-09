module mux31(
    a,
    b,
    c,
    out,
    ctrl
);

    input [7:0] a,b,c;
    input [1:0] ctrl;
    output reg[7:0] out;

    always @(*) begin
        case (ctrl)
            2'b00: out <= a;
            2'b01: out <= b;
            2'b10: out <= c; 
        endcase
    end
endmodule