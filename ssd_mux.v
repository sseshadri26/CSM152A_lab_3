// Multiplexing Module
// input
// the numbers to display
// output
// every single 7 segment display wire (assign these in xilinx)


module ssd_mux (
    input  [3:0] inputNum,
    output [6:0] outputSegments
);

  // 7 segment display
  // 0 = a, 1 = b, 2 = c, 3 = d, 4 = e, 5 = f, 6 = g

  //  a
  // f b
  //  g
  // e c
  //  d
  reg [6:0] outputSegmentsTemp;
  assign outputSegments = outputSegmentsTemp;
  // assign using case statement

  always @(inputNum) begin
    case (inputNum)
      0: outputSegmentsTemp = 7'b0000001;
      1: outputSegmentsTemp = 7'b1001111;
      2: outputSegmentsTemp = 7'b0010010;
      3: outputSegmentsTemp = 7'b0000110;
      4: outputSegmentsTemp = 7'b1001100;
      5: outputSegmentsTemp = 7'b0100100;
      6: outputSegmentsTemp = 7'b0100000;
      7: outputSegmentsTemp = 7'b0001111;
      8: outputSegmentsTemp = 7'b0000000;
      9: outputSegmentsTemp = 7'b0000100;

      default: outputSegmentsTemp = 7'b1111111;
    endcase
  end


endmodule
