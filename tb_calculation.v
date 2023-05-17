//~ `New testbench
`timescale 1ns / 1ps

module tb_calculation;

  // calculation Parameters
  parameter PERIOD = 10;


  // calculation Inputs
  wire [5:0] outputSeconds;
  wire [5:0] outputMinutes;

  reg        rst = 0;
  reg        pause = 0;
  reg        sel_switch = 0;
  reg        adj_switch = 0;
  reg        clk1 = 0;
  reg        clk2 = 0;

  // calculation Outputs



  //   initial begin
  //     forever #(PERIOD / 2) clk = ~clk;
  //   end

  //   initial begin
  //     #(PERIOD * 2) rst_n = 1;
  //   end

  calculation u_calculation (
      .outputSeconds(outputSeconds),
      .outputMinutes(outputMinutes),
      .rst          (rst),
      .pause        (pause),
      .sel_switch   (sel_switch),
      .adj_switch   (adj_switch),
      .clk1         (clk1),
      .clk2         (clk2)
  );

  initial begin
    // Wait 100 ns for global reset to finish
    rst = 1;
    #100;

    // Initialize Inputs
    rst = 0;
    pause = 0;
    sel_switch = 0;
    adj_switch = 0;
    clk1 = 0;
    clk2 = 0;


    $display("Current time: %d:%d", outputMinutes, outputSeconds);

    #10;
    clk1 = 1;
    // clk2 = 1;
    #10;

    clk1 = 0;
    // clk2 = 0;
    #10;
    $display("Current time: %d:%d", outputMinutes, outputSeconds);

    #10;
    clk1 = 1;
    // clk2 = 1;
    #10;

    clk1 = 0;
    // clk2 = 0;
    #10;
    $display("Current time: %d:%d", outputMinutes, outputSeconds);

    #10;
    clk1 = 1;
    // clk2 = 1;
    #10;

    clk1 = 0;
    // clk2 = 0;
    #10;
    //print the current time
    $display("Current time: %d:%d", outputMinutes, outputSeconds);

    $finish;
  end

endmodule
