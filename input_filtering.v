// Code your design here
module input_filtering(
	input pb_1,
	input clk,
	output pb_out
    );
	 
reg button_state_reg = 0;

reg [15:0] counter;

always @ (posedge clk)
begin
  if(pb_1 == 0) //If the button is idle, not pressed
	begin
		counter <= 0;
		button_state_reg <= 0;
	end
	else
	begin
		counter <= counter + 1'b1;
		if(counter == 16'hffff) //We hit counter max (all 1's)
		begin
			button_state_reg <= 1;
			counter <= 0;
		end
	end
end

assign pb_out = button_state_reg;

endmodule
