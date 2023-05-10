// Multiplexing Module
// input
// the numbers to display
// output
// every single 7 segment display wire (assign these in xilinx)


module ssd_mux (
    input [3:0] inputNum,
    output reg [6:0] outputSegments
);

  // 7 segment display
  // 0 = a, 1 = b, 2 = c, 3 = d, 4 = e, 5 = f, 6 = g

  //  a
  // f b
  //  g
  // e c
  //  d

  // assign using case statement

  always @(inputNum) begin
    case (inputNum)
      0: outputSegments = 7'b0000001;
      1: outputSegments = 7'b1001111;
      2: outputSegments = 7'b0010010;
      3: outputSegments = 7'b0000110;
      4: outputSegments = 7'b1001100;
      5: outputSegments = 7'b0100100;
      6: outputSegments = 7'b0100000;
      7: outputSegments = 7'b0001111;
      8: outputSegments = 7'b0000000;
      9: outputSegments = 7'b0000100;

      default: outputSegments = 7'b1111111;
    endcase
  end


endmodule
