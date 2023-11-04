`include "CSE_BUBBLE.v"
module tb;

    reg clock;
  
    CSE_BUBBLE uut (.clk(clock));

    // generate clock
    always begin
        #5 clock = ~clock;
    end

    initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        clock = 0;
        #10000
        $finish;
    end

endmodule
