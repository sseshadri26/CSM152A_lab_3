// // Button/Switch Output Module
// // input
// // the button raw values
// // output
// // the fancy fancy flip flopped, filtered outputs

// module input_filtering (
//     input  [3:0] buttonRaw,
//     output [3:0] buttonFiltered
// );


// endmodule  //button_output


//fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog code for button debouncing on FPGA
// debouncing module without creating another clock domain
// by using clock enable signal 



module input_filtering (
    input  pb_1,
    input  clk,
    input  slow_clk_en,
    output pb_out
);
  wire slow_clk_en;
  wire Q1, Q2, Q2_bar, Q0;
  wire rst = 1;

  my_dff_en d0 (
      clk,
      slow_clk_en,
      pb_1,
      Q0
  );

  my_dff_en d1 (
      clk,
      slow_clk_en,
      Q0,
      Q1
  );
  my_dff_en d2 (
      clk,
      slow_clk_en,
      Q1,
      Q2
  );
  assign Q2_bar = ~Q2;
  assign pb_out = Q1 & Q2_bar;
endmodule



// Slow clock enable for debouncing button 
module clock_enable (
    input  Clk_100M,
    output slow_clk_en
);
  reg [26:0] counter = 0;
  always @(posedge Clk_100M) begin
    counter <= (counter >= 249999) ? 0 : counter + 1;
  end
  assign slow_clk_en = (counter == 249999) ? 1'b1 : 1'b0;
endmodule


// D-flip-flop with clock enable signal for debouncing module 
module my_dff_en (
    input DFF_CLOCK,
    clock_enable,
    D,
    output reg Q = 0
);
  always @(posedge DFF_CLOCK) begin
    if (clock_enable == 1) Q <= D;
  end
endmodule
