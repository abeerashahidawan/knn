`timescale 1ns / 1ps
module KNN (
	input clk,rst,
	input [7:0] unknown,
	output reg[1:0] label,
	output [1:0] state 
    );
	 
	 // Initializations
	 
	 reg [9:0] DataMem [0:127];
         
	 wire [6:0] Address;
	 wire [6:0] distance;
	 reg  [6:0] a,b,c,d,e;
    control cu (.clk(clk), .rst(rst), .address(Address), .state(state));
	 

	// -- Populating Data Memory with Random Values
	
	// integer i;
	//initial begin
	//	for (i = 0; i < 128; i = i + 1) begin
	//				DataMem[i] <= $random % 1024;
	//		  end
   // end

	initial begin
        $readmemb("dataset.txt", DataMem);
		end

	// State : 1          DISTANCE CALCULATION
	
	distance distance_mod(.unknownData(unknown),.knownData(DataMem[Address]), .labeledDistance(distance));
	
	 always@(posedge clk or posedge rst)
	 begin
		if(rst)
			begin
			a <= 7'b1111111;
			b <= 7'b1111111;
			c <= 7'b1111111;
			d <= 7'b1111111;
			e <= 7'b1111111;
			end
		else if(state == 2'b01)
			begin
			 if(distance[4:0] < a[4:0] )
			  begin
				e <= d;
				d <= c;
				c <= b;
				b <= a;
				a <= distance;
			  end
			 else if(distance[4:0] < b[4:0])
				begin
				 e <= d;
				 d <= c;
				 c <= b;
				 b <= distance;
				end
			 else if (distance[4:0] < c[4:0])
				begin
				 e <= d;
				 d <= c;
				 c <= distance;
				end
			 else if(distance[4:0] < d[4:0])
			 	begin
				 e <= d;
				 d <= distance;
				end
			 else if(distance[4:0] < e[4:0])
			 	begin
				 e <= distance;
				end	
			end
	 end
	 
	///////////////////////////////////////////////
	
	//State : 2         Label Frequency Counting
	
	reg [1:0] label_Address;

	always@*	//combinational block-> =
		begin
			if(Address == 7'b0000000)
				label_Address = a[6:5];			
			else if(Address == 7'b0000001)
				label_Address = b[6:5];
				
			else if(Address == 7'b0000010)
				label_Address = c[6:5];
				
			else if(Address == 7'b0000011)
				label_Address = d[6:5];
				
			else if(Address == 7'b0000100)
				label_Address = e[6:5];
			else
				label_Address = 0;
		end
	
	
		reg [2:0] CountMem [0:3] ;
		always @ (posedge clk or posedge rst)
			begin
				if (rst)
					begin
						CountMem[0] <= 3'b000;
						CountMem[1] <= 3'b000;
						CountMem[2] <= 3'b000;
						CountMem[3] <= 3'b000;
					end
				else if(state == 2'b10)
				 begin
					CountMem[label_Address] <= CountMem[label_Address] + 1;
				 end
			end

	/////////////////////////////////////////////////////
	
	// State: 3      MAJORITY VOTING
	
	reg [2:0] max;
	
	always@(posedge clk or posedge rst)
		begin
			if(rst)
			 begin
				max <= 3'b000;
				label <= 2'b11;
			 end
			else if(state == 2'b11)
				begin
					if(CountMem[Address] > max) 
						begin
							max <= CountMem[Address]; 
							label <= Address;
						end
				end
		end

endmodule


module distance (
	input [7:0] unknownData,
	input [9:0] knownData,
	output [6:0] labeledDistance
);

	wire [3:0] diff1, diff2;
	wire [4:0] sum;
	
	ADU adu1 (.a(unknownData[7:4]), .b(knownData[7:4]), .diff(diff1));
	ADU adu2 (.a(unknownData[3:0]), .b(knownData[3:0]), .diff(diff2));
	
	assign sum = diff1 + diff2;
	assign labeledDistance = {knownData[9:8], sum};
	endmodule

////////////////////////////////////////////

module ADU (
	input [3:0] a,b,
	output [3:0] diff
);
assign diff = (a > b) ? (a - b) : (b - a);
endmodule

////////////////////////////////////////////

