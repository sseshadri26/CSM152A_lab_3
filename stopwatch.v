module stopwatch (
    input clk,
    input pb_rst,
    input pb_pause,
    input sw_select,
    input sw_mode,
    output [6:0] seven_seg,
    output [3:0] anode_count,
    output [1:0] Led
);

  wire clk1Hz;
  wire clk2Hz;
  wire clk10Hz;
  wire clk100Hz;
  wire slow_clk_en;


  wire [5:0] currentSeconds;
  wire [5:0] currentMinutes;

  wire [3:0] currentSeconds1sPlace;
  wire [3:0] currentSeconds10sPlace;
  wire [3:0] currentMinutes1sPlace;
  wire [3:0] currentMinutes10sPlace;

  wire [6:0] currentSeconds1sPlaceSegments;
  wire [6:0] currentSeconds10sPlaceSegments;
  wire [6:0] currentMinutes1sPlaceSegments;
  wire [6:0] currentMinutes10sPlaceSegments;


  wire [6:0] currentSeconds1sPlaceSegmentsBlinked;
  wire [6:0] currentSeconds10sPlaceSegmentsBlinked;
  wire [6:0] currentMinutes1sPlaceSegmentsBlinked;
  wire [6:0] currentMinutes10sPlaceSegmentsBlinked;

  wire pb_pause_filtered;
  wire sw_select_filtered;
  wire sw_mode_filtered;

  wire blink_sel_seconds;
  wire blink_sel_minutes;
  wire pause;

assign Led[0] = rst;
assign Led[1] = pause;



  //create the four clocks

  // 1 Hz

  ssd_display_mux u_ssd_display_mux (
      .segments1      (currentMinutes10sPlaceSegmentsBlinked),
      .segments2      (currentMinutes1sPlaceSegmentsBlinked),
      .segments3      (currentSeconds10sPlaceSegmentsBlinked),
      .segments4      (currentSeconds1sPlaceSegmentsBlinked),
      .clk            (clk100Hz),
      .Anode_Activate (anode_count),
      .output_segments(seven_seg)
  );



  clk_div #(
      .DIVISOR(100000000)
  ) u_clk_div_0 (
      .clk(clk),
      .rst(0),
      .clk_out(clk1Hz)
  );

  // 2 Hz
  clk_div #(
      .DIVISOR(50000000)
  ) u_clk_div_1 (
      .clk(clk),
      .rst(0),
      .clk_out(clk2Hz)
  );

  // 10 Hz
  clk_div #(
      .DIVISOR(20000000)
  ) u_clk_div_2 (
      .clk(clk),
      .rst(0),
      .clk_out(clk10Hz)
  );

  // 100 Hz
  clk_div #(
      .DIVISOR(10000)
  ) u_clk_div_3 (
      .clk(clk),
      .rst(0),
      .clk_out(clk100Hz)
  );




  // filter buttons and switches
  // first create the 4 wires for 2 buttons, 2 switches




  assign rst = pb_rst;


  input_filtering u_input_filtering_button_2 (
      .pb_1       (pb_pause),
      .clk        (clk),
      .pb_out     (pb_pause_filtered)
  );


  input_filtering u_input_filtering_switch_1 (
      .pb_1       (sw_select),
      .clk        (clk),
      .pb_out     (sw_select_filtered)
  );


  input_filtering u_input_filtering_switch_2 (
      .pb_1       (sw_mode),
      .clk        (clk),
      .pb_out     (sw_mode_filtered)
  );

  get_digits u_get_digits_seconds (
      .inputNum         (currentSeconds),
      .outputNum1sPlace (currentSeconds1sPlace),
      .outputNum10sPlace(currentSeconds10sPlace)
  );


  get_digits u_get_digits_minutes (
      .inputNum         (currentMinutes),
      .outputNum1sPlace (currentMinutes1sPlace),
      .outputNum10sPlace(currentMinutes10sPlace)
  );




  ssd_mux u_ssd_mux_0 (
      .inputNum(currentSeconds1sPlace),
      .outputSegments(currentSeconds1sPlaceSegments)
  );

  ssd_mux u_ssd_mux_1 (
      .inputNum(currentSeconds10sPlace),
      .outputSegments(currentSeconds10sPlaceSegments)
  );

  ssd_mux u_ssd_mux_2 (
      .inputNum(currentMinutes1sPlace),
      .outputSegments(currentMinutes1sPlaceSegments)
  );

  ssd_mux u_ssd_mux_3 (
      .inputNum(currentMinutes10sPlace),
      .outputSegments(currentMinutes10sPlaceSegments)
  );

//assign currentMinutes1sPlaceSegments = 7'b0100000;

  blink u_blink_0 (
      .in       (currentSeconds1sPlaceSegments),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_seconds),
      .out      (currentSeconds1sPlaceSegmentsBlinked)
  );

  blink u_blink_1 (
      .in       (currentSeconds10sPlaceSegments),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_seconds),
      .out      (currentSeconds10sPlaceSegmentsBlinked)
  );

  blink u_blink_2 (
      .in       (currentMinutes1sPlaceSegments),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_minutes),
      .out      (currentMinutes1sPlaceSegmentsBlinked)
  );

  blink u_blink_3 (
      .in       (currentMinutes10sPlaceSegments),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_minutes),
      .out      (currentMinutes10sPlaceSegmentsBlinked)
  );


  tff u_tff (
      .clk(0),
      .rst(0),
      .t  (pb_pause_filtered),
      .q  (pause)
  );

  // takes in the select mode, whther or not we are paused, and the adjust mode, and outputs whether or not the seconds should blink 
  assign blink_sel_seconds = ~pause & ~sw_select & sw_mode;
  assign blink_sel_minutes = ~pause & sw_select & sw_mode;



  calculation u_calculation (
      .outputSeconds(currentSeconds),
      .outputMinutes(currentMinutes),
      .rst          (rst),
      .pause        (pause),
      .sel_switch   (sw_select),
      .adj_switch   (sw_mode),
      .clk1         (clk1Hz),
      .clk2         (clk2Hz)
  );


endmodule
