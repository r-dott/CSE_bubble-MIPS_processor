module ALU (
    input  [31:0] a, b,
    input  [ 2:0] what_to_do ,
    output        branch_eval,
    output [31:0] y_out
);
    wire [31:0] add_out;
    assign add_out = a + b;

    wire [31:0] addi_out;
    assign addi_out = a + b;

    wire [31:0] sll_out;
    assign sll_out = a << b;

    wire [31:0] slt_out;
    assign slt_out = ($signed(a) < $signed(b) )? 1:0 ;

    wire [31:0] sw_out;
    assign sw_out = a + b;

    wire [31:0] lw_out;
    assign lw_out = a + b;

    
    assign y_out = (
        ((3'b000 == what_to_do) ? add_out :
            ((3'b001 == what_to_do) ? addi_out : 
                ((3'b010 == what_to_do) ? sll_out: 
                    ((3'b011 == what_to_do)? slt_out :
                        ((3'b100 == what_to_do) ? sw_out : 
                            (3'b101 == what_to_do)? lw_out:0
                        )
                    )
                )
            )
        )
    );
    
    assign branch_eval = (a==b)? 1'b1 : 1'b0;

endmodule
