`include "ctrl_unit.v"

module testbench;

    reg clk;

    ctrl_unit uut(.clk(clk));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(3);
    end

    initial begin
        clk = 0;
        forever begin
            #10;
            clk <= ~clk;
        end
    end

    initial begin
        #1000;
        $finish;
    end
endmodule