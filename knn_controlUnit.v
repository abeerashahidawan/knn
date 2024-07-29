`timescale 1ns / 1ps
 // FSM with 3 States

module state_register(
    input clk,
    input rst,
    input [1:0] next_state,
    output reg [1:0] current_state
);

    always @ (posedge clk or posedge rst) begin
        if (rst)
            current_state <= 2'b01; 
        else
            current_state <= next_state;
    end

endmodule

///////////////////////////////////////

module next_state_logic(
    input clk,
    input rst,
    input [1:0] current_state,
    output reg [1:0] next_state,
    output reg [6:0] counter 
);
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

	// State Definitions
	
    always @ (posedge clk or posedge rst) begin
        if (rst) 
			  begin
					counter <= 7'd0;
					next_state <= S1;
			  end 
		  else begin
					case (current_state)
						 S1: begin		
								  if (counter < 7'd127) begin
					
										if (counter == 7'd126) begin
											next_state <= S2; end
											
										counter <= counter + 1;
										
										end
								  else 
									  begin
											counter <= 7'd0;	
										end
								end
								
						 S2: begin
								 if (counter < 7'd4) 
									begin
										if (counter == 7'd3) 
										 begin
											next_state <= S3;
										 end
										counter <= counter + 1;
									end
								 else 
									  begin
											counter <= 7'd0;
									  end
								end
						 S3: begin 
								  if (counter < 7'd3) 
										begin
											if (counter == 7'd2) 
											 begin
												next_state <= S1;
											end
											counter <= counter + 1;
										end
								  else 
									  begin
											counter <= 7'd0;
									  end
								end
						 default: 
							 begin
								  counter <= 7'd0;
								  next_state <= S1;
							 end
					endcase
        end
    end

endmodule

///////////////////////////////////////

module control(
    input clk,
    input rst,
    output [6:0] address,
    output [1:0] state
);

    wire [1:0] next_state;
    state_register state_reg (
        .clk(clk),
        .rst(rst),
        .next_state(next_state),
        .current_state(state)
    );
    next_state_logic next_state_logic_inst (
        .clk(clk),
        .rst(rst),
        .current_state(state),
        .next_state(next_state),
        .counter(address)
    );

endmodule






