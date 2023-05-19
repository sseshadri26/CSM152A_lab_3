// Clock Module
// input
// main clock
// output
// 4 new clocks

// For this assignment, you will be using four different clocks – a 2 Hz clock, a 1 Hz clock, a much
// faster clock (50 – 700 Hz), and a clock for blinking in the adjust mode (>1Hz). 

module clk_div #(
    parameter DIVISOR = 100000000
) (
    input clk,
    input rst,
    output reg clk_out

);

  reg [27:0] counter = 28'd0;


  //count up to div_frequency and then switch clk_dv

  always @(posedge clk) begin

    counter <= counter + 28'd1;

    if (rst) begin
      clk_out <= 0;
    end else begin
      if (counter >= (DIVISOR - 1)) counter <= 28'd0;


      clk_out <= (counter < DIVISOR / 2) ? 1'b1 : 1'b0;
    end
  end


endmodule
