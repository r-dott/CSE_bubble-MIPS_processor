//VEDA LIKE READ + WRITE MEMORY
module dataMemory (
	input         clk  ,
	input         write_enable   ,
	input  [31:0] addr ,
	input  [31:0] wdata,
	output [31:0] rdata
);

	reg [31:0] memdata [1023:0];

	assign rdata = memdata[addr];

	always @(posedge clk) begin
		if(1'b1 == write_enable) begin
			memdata[addr] = wdata;
		end
	end

	initial begin
		memdata[0] = 32'h00000009; //N
		memdata[1] = 32'h00000008; //N-1
		memdata[2] = 32'd9;
		memdata[3] = -32'd56;
		memdata[4] = -32'd9;
		memdata[5] = 32'd17;
		memdata[6] = 32'd100;
		memdata[7] = 32'd2938;
		memdata[8] = -32'd1987;
		memdata[9] = 32'd2083;
		memdata[10] = 32'd1;
	end

endmodule
