module tff (
    input clk,
    input rst,
    input t,
    output reg q
);

  always @(posedge t) begin
    q <= ~q;
  end

endmodule
