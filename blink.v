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

  wire is_on;  // Originally it is 1

  assign is_on = blink_sel == 0 || blink_clk == 0;

  //on if sel = 0 or (sel = 1 and clk is posedge)
  //off if sel = 1 and clk is negedge

  // on = true, off = false
  assign out   = is_on ? in : 7'b1111111;

endmodule
