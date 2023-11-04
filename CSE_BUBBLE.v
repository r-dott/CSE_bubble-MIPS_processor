`include "instrMemory.v"
`include "dataMemory.v"
`include "manipulate.v"
module CSE_BUBBLE (
	input clk // clock
);

	wire [31:0] imem_data ; 
	wire [31:0] imem_addr ;
	
	wire [31:0] dmem_rdata;
	wire        dmem_we   ;
	wire [31:0] dmem_addr ;
	wire [31:0] dmem_wdata;

	//READ ONLY veda memory
	instrMemory imem (
		.clk(clk),
		.addr(imem_addr[7:2]),
		.data(imem_data     )
	);

	//READ + WRITE veda memory
	dataMemory dmem (
		.clk  (clk       ),
		.write_enable  (dmem_we   ),
		.addr (dmem_addr ),
		.wdata(dmem_wdata),
		.rdata(dmem_rdata)
	);

	manipulate man (
		.clk       (clk       ),
		.imem_data (imem_data ),
		.imem_addr (imem_addr ),
		.dmem_rdata(dmem_rdata),
		.dmem_we   (dmem_we   ),
		.dmem_addr (dmem_addr ),
		.dmem_wdata(dmem_wdata)
	);
	

endmodule