module tb();

	reg sysclk = 0;
	reg rst;

	wire [3:0] o_TMDS_N;
	wire [3:0] o_TMDS_P;

	example_sys DUT
	(
    .i_sysclk  (sysclk),
    .i_rst     (rst),
    .o_TMDS_N  (o_TMDS_N),
    .o_TMDS_P  (o_TMDS_P)
	);

	always#4 sysclk = ~sysclk;

	initial begin
		rst = 1;
		#100;
		rst = 0;
	end

endmodule