`default_nettype none
//
module example_sys
	(
	input  wire       i_sysclk, // 125MHz board clock
	input  wire       i_rst,    // active high board button

	// HDMI interface
	output wire [3:0] o_TMDS_N,
	output wire [3:0] o_TMDS_P
	);

	wire rstn;
	wire clk_25MHz;
	wire clk_250MHz;

	wire vsync, hsync, active;
	wire [9:0] counterX, counterY;

	wire [7:0] red, green, blue;
//
// Checkerboard Test Pattern
//
	assign red   = counterY[3] | (counterX == 256);
	assign green = (counterX[5] ^ counterY[6]) | (counterX == 256);
	assign blue  = counterX[4] | (counterX == 256);

	debounce db_i (
	.i_clk   (clk_25MHz),
	.i_input (~i_rst),
	.o_db    (rstn)
	);

	clk_wiz_0 dcm_i (
	.clk_in1       (i_sysclk),
	.resetn        (~i_rst),
	.clk_out1      (clk_25MHz),
	.clk_out2      (clk_250MHz)
	);

	vtc vtc_i (
	.i_clk         (clk_25MHz),
	.i_rstn        (rstn),
	.o_vsync       (vsync),
	.o_hsync       (hsync),
	.o_active      (active),
	.o_counterX    (counterX),
	.o_counterY    (counterY)
	);   

	HDMI_top HDMI_i (
	.i_p_clk       (clk_25MHz),  // pixel clock
	.i_tmds_clk    (clk_250MHz), // 10x pixel clock
	.i_resetn      (rstn),       // sync active low reset

	// 24-bit RGB
	.i_rgb         ({red, green, blue}), // r[7:0], g[15:8], b[23:16]
   
	// VTC   
	.i_vsync       (vsync),
	.i_hsync       (hsync),
	.i_active_area (active),

	// HDMI interface
	.o_TMDS_P      (o_TMDS_P),
	.o_TMDS_N      (o_TMDS_N)
	);

endmodule