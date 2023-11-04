`include "RISC_BUBBLE.v"
`include "ALU.v"
module dataPath (
	input         clk       ,
	input  [ 2:0] alucontrol,
	input         alu_src   ,
	input         branch    ,
	input         jump      ,
	input         mem_to_reg,
	input         mem_write ,
	input         reg_dst   ,
	input         reg_write ,
	// imem side
	input  [31:0] instr     ,
	output [31:0] pc        ,
	// dmem side
	input  [31:0] read_data ,
	output [31:0] alu_result,
	output [31:0] write_data
);

///////////////
	wire [31:0] pc_plus_4;
	assign pc_plus_4 = pc + 4;

	wire [31:0] pc_jump;
	assign pc_jump = {pc_plus_4[31:28], instr[25:0], 2'b00};

	wire branch_cond;
	wire pc_src;
	assign pc_src = branch & branch_cond;

	wire [31:0] pc_branch;
	assign pc_branch = pc_plus_4 + {extended_immediate[29:0], 2'b00};

	wire [31:0] pc_next;
	assign pc_next = jump ? pc_jump : (pc_src ? pc_branch : pc_plus_4);

	reg [31:0] pc;
	initial begin
		pc = 32'h00000000;
	end

	always @(posedge clk) begin
		pc = pc_next;
	end

/////////////////////

	wire [5:0] rt;
	assign rt = instr[20:16];

	wire [5:0] rd;
	assign rd = instr[15:11];

	wire [4:0] write_reg;
	assign write_reg = reg_dst ? rd : rt;

	wire [31:0] result;
	assign result = mem_to_reg ? read_data : alu_result ;

//connections to register file
	wire [31:0] reg_data1;
	wire [31:0] reg_data2;

	RISC_BUBBLE regfile (
		.clk  (clk         ),
		.write_enable   (reg_write   ),
		.addr1(instr[25:21]),
		.addr2(instr[20:16]),
		.addr3(write_reg   ),
		.wdata(result      ),
		.data1(reg_data1   ),
		.data2(reg_data2   )
	);


//input to alu
	wire [31:0] src_a;
	wire [31:0] src_b;

	assign src_a = reg_data1;
	assign src_b = alu_src ? extended_immediate : reg_data2;

	wire branch_eval;
	wire [31:0] alu_out;
	ALU alu (
		.a(src_a     ),
		.b (src_b     ),
		.what_to_do (alucontrol),
		.branch_eval (branch_eval ),
		.y_out(alu_out   )
	);
	assign alu_result = alu_out;
	assign branch_cond = branch_eval;

//sign extension of immediate: 16b to 32b
	wire [31:0] extended_immediate;	
	assign extended_immediate = {{16{instr[15]}}, instr[15:0]};

	assign write_data = reg_data2;

endmodule
