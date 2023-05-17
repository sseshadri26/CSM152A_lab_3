//~ `New testbench
`timescale 1ns / 1ps

module tb_next_number;

  // next_number Parameters
  parameter PERIOD = 10;


  // next_number Inputs
  reg  [5:0] currentSeconds = 0;
  reg  [5:0] currentMinutes = 0;
  reg  [1:0] switches = 0;

  // next_number Outputs
  wire [5:0] nextSeconds;
  wire [5:0] nextMinutes;


  //   initial begin
  //     forever #(PERIOD / 2) clk = ~clk;
  //   end

  //   initial begin
  //     #(PERIOD * 2) rst_n = 1;
  //   end

  next_number u_next_number (
      .currentSeconds(currentSeconds[5:0]),
      .currentMinutes(currentMinutes[5:0]),
      .switches      (switches[1:0]),

      .nextSeconds(nextSeconds[5:0]),
      .nextMinutes(nextMinutes[5:0])
  );

  initial begin
    #100;
    // Wait 100 ns for global reset to finish
    //set inputs and outputs:
    //   reg  [5:0] currentSeconds = 0;
    //   reg  [5:0] currentMinutes = 0;
    //   reg  [1:0] switches = 0;

    //   // next_number Outputs
    //   wire [5:0] nextSeconds;
    //   wire [5:0] nextMinutes;


    // Initialize Inputs
    currentSeconds = 0;
    currentMinutes = 0;
    switches = 0;
    #100;

    // print the current seconds and minutes and the next seconds and minutes
    $display("Current time: %d:%d", currentMinutes, currentSeconds);
    $display("Next time: %d:%d", nextMinutes, nextSeconds);

    currentSeconds = 1;
    currentMinutes = 0;
    #100;
    $display("Current time: %d:%d", currentMinutes, currentSeconds);
    $display("Next time: %d:%d", nextMinutes, nextSeconds);

    currentSeconds = 59;
    currentMinutes = 0;
    #100;
    $display("Current time: %d:%d", currentMinutes, currentSeconds);
    $display("Next time: %d:%d", nextMinutes, nextSeconds);

    currentSeconds = 0;
    currentMinutes = 59;
    #100;
    $display("Current time: %d:%d", currentMinutes, currentSeconds);
    $display("Next time: %d:%d", nextMinutes, nextSeconds);

    currentSeconds = 59;
    currentMinutes = 59;
    #100;
    $display("Current time: %d:%d", currentMinutes, currentSeconds);
    $display("Next time: %d:%d", nextMinutes, nextSeconds);


    $finish;
  end

endmodule
