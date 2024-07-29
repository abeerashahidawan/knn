`timescale 1ns / 1ps
module knnTopModule(
	input clk,rst,
	input [6:0] unknown,
	output reg newClock,
	output [1:0] state,
	output [1:0] label 
    );

	reg [26:0] anode_timer;

	//Clock Divider
	always @ (posedge clk or posedge rst)
	begin
		if(rst) 
			begin
				newClock <=0;
				anode_timer <= 0;
			end
			
		else if(anode_timer == 12499999) //Clock of 100MHz has time period of 10ns. 10ns x 100_000 = 1ms
			begin
				anode_timer <= 0;
				newClock <= newClock +1;
			end
		else
			anode_timer <= anode_timer+1;
	end
	
	wire [6:0] Address;
        KNN knn_inst(
	.clk(newClock),.rst(rst),
	.unknown({1'b0, {unknown}}),
	.label(label),
	.state(state) 
    );
	

	endmodule

