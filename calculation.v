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
  
  //wire clocks = clk1|| clk2;


  always @(posedge clk2) begin
    // if adjust switch is ON
    if (rst == 1) begin
      currentSeconds <= 6'b000000;
      currentMinutes <= 6'b000000;
    end
    else if (adj_switch || clk1) begin
      if (pause == 0) begin
        currentSeconds <= nextSeconds;
        currentMinutes <= nextMinutes;
      end
    end
    if (rst == 1) begin
      currentSeconds <= 6'b000000;
      currentMinutes <= 6'b000000;
    end
  end


endmodule
