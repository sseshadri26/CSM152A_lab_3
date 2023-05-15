// The modules controls the blink for the 7 wires for one digit on the clock
// If blink select is set to 0, then return the original input for 7 wires
// If blink select is set to 1, check for blink clock. 
// If blink clock is positive edge, return the original input for 7 wires
// If blink clock is negative edge, return empty wires

module blink (
    in,
    blink_clk,
    blink_sel,
    out
);
  input [6:0] in;
  input blink_clk;
  input blink_sel;
  output [6:0] out;

  reg [6:0] blank_output = 7'b1111111;
  wire on_off;  // Originally it is 1

  assign on_off = (blink_sel == 0) || (blink_sel == 1 && blink_clk == 1);

  //on if sel = 0 or (sel = 1 and clk is posedge)
  //off if sel = 1 and clk is negedge

  // on = true, off = false
  assign out = on_off ? in : blank_output;

endmodule
