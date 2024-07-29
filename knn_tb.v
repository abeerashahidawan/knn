`timescale 1ns / 1ps
module knn_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [6:0] unknown;

	// Outputs
	wire newClock;
	wire [1:0] state;
	wire [1:0] label;

	// Instantiate the Unit Under Test (UUT)
	knnTopModule uut (
		.clk(clk), 
		.rst(rst), 
		.unknown(unknown), 
		.newClock(newClock), 
		.state(state), 
		.label(label)
	);

// Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        unknown = 7'b0;
        rst = 1;
        #10;
        rst = 0;

        // Apply test vectors
        unknown = 7'd119;
        #2000;
    end
	
      
endmodule

