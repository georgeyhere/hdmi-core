// debounce module
// -> 100 MHz
// -> applies 20 ms debounce to input
//
/*
	**** INSTANTIATION TEMPLATE ****
	
debounce 
#(.DB_COUNT(500_500)) // 20ms, 25MHz clock
db_i 
(
.i_clk         (i_sysclk),
.i_input       (~i_rst),
.o_db          (rstn)
);     

*/

module debounce 
	// debounce period in clock periods
	#(parameter DB_COUNT = 2_000_000)
	(
    input  wire i_clk,
    input  wire i_input, // input to be debounced

    output reg  o_db     // debounced
	);

	reg [31:0] counter;

	reg        r_input1;
	reg        r_input2;

	initial begin
		r_input1 = 0;
		r_input2 = 0;
		o_db     = 0;
		counter  = 0;
	end

//
// double flop the input
//
	always@(posedge i_clk) begin
		r_input1 <= i_input;
		r_input2 <= r_input1;
	end

//
// debounce logic
//
	always@(posedge i_clk) begin
		if(r_input2 != o_db && counter < DB_COUNT) begin
			counter <= counter + 1;
		end
		else if(counter == DB_COUNT) begin
			o_db    <= r_input2;
			counter <= 0;
		end
		else begin
			counter <= 0;
		end
	end

endmodule // debounce