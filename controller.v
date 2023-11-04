module controller (
	input  [31:0] instr     ,
	// other side
	output        branch    ,
	output        jump      ,
	output        mem_to_reg,
	output        mem_write ,
	output        reg_dst   ,
	output        reg_write ,
	// alu side
	output [ 2:0] alucontrol,
	output        alu_src
);

	/////////////////
	wire [5:0] opcode;
	assign opcode = instr[31:26];
	
	wire cond_for_add = (opcode == 0 );
    wire cond_for_addi = (opcode == 1);
    wire cond_for_sll = (opcode == 2);
    wire cond_for_slt = (opcode == 3);
    wire cond_for_sw = (opcode == 4);
    wire cond_for_lw = (opcode == 5);
    wire cond_for_beq = (opcode == 6);
    wire cond_for_j = (opcode == 7);

	wire cond_for_sub = (opcode == 8);
    wire cond_for_addu = (opcode == 9);
    wire cond_for_subu = (opcode == 10);
    wire cond_for_addiu = (opcode == 11);

    wire cond_for_and = (opcode == 12);
    wire cond_for_or = (opcode == 13);
    wire cond_for_andi = (opcode == 14);
    wire cond_for_ori = (opcode == 15);
    wire cond_for_bne = (opcode == 16);



	assign branch     = cond_for_beq;
	assign jump       = cond_for_j;
	assign mem_to_reg = cond_for_lw;
	assign mem_write  = cond_for_sw;
	assign reg_dst    = cond_for_add | cond_for_slt;
	assign reg_write  = cond_for_add | cond_for_sll| cond_for_slt | cond_for_addi | cond_for_lw;
	assign alu_src    = cond_for_addi | cond_for_sll| cond_for_lw | cond_for_sw;	

	reg [3:0] alu_command;
	always @(instr) begin
		casex (instr[31:26])
			6'b00000: alu_command = 3'b000;
			6'b00001: alu_command = 3'b001;
			6'b00010: alu_command = 3'b010;
			6'b00011: alu_command = 3'b011;
			6'b00100: alu_command = 3'b100;
			6'b00101: alu_command = 3'b101;
			6'b00110: alu_command = 3'b110;
			6'b00111: alu_command = 3'b111;
			default: alu_command = 3'b000;
		endcase
	end

	assign alucontrol = alu_command;

endmodule