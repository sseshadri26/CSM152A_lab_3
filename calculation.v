module calculation (

    input rst,
    input pause,
    input sel_switch,
    input adj_switch,

    // add clock inputs
    input clk1,  // 1Hz clock
    input clk2,  // 2Hz clock

    output [5:0] outputSeconds,
    output [5:0] outputMinutes

);


  reg  [5:0] currentSeconds = 0;
  reg  [5:0] currentMinutes = 0;


  wire [5:0] nextSeconds;
  wire [5:0] nextMinutes;

  // instantiate next number module
  next_number nn (
      .currentSeconds(currentSeconds),
      .currentMinutes(currentMinutes),
      .switches({adj_switch, sel_switch}),


      .nextSeconds(nextSeconds),
      .nextMinutes(nextMinutes)
  );


  assign outputSeconds = currentSeconds;
  assign outputMinutes = currentMinutes;

  always @* begin
    if (rst == 1) begin
      currentSeconds <= 6'b000000;
      currentMinutes <= 6'b000000;
    end

  end


  always @(posedge clk1) begin
    // if adjust switch is ON
    if (adj_switch == 0) begin
      if (pause == 1) begin
        currentSeconds <= currentSeconds;
        currentMinutes <= currentMinutes;
      end else begin
        //print hello
        currentSeconds <= nextSeconds;
        currentMinutes <= nextMinutes;
        // $display("calc Next time: %d:%d", nextMinutes, nextSeconds);
        // $display("calc Current time: %d:%d", currentMinutes, currentSeconds);

      end

    end


  end

  always @(posedge clk2) begin
    // if adjust switch is OFF
    if (adj_switch == 1) begin
      if (pause == 1) begin
        currentSeconds <= currentSeconds;
        currentMinutes <= currentMinutes;
      end else begin
        currentSeconds <= nextSeconds;
        currentMinutes <= nextMinutes;
      end
    end
  end

endmodule
