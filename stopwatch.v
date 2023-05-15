// github copilot, please create my module tyvm

module stopwatch ();

  wire clk;
  wire clk1Hz;
  wire clk2Hz;
  wire clk10Hz;
  wire clk100Hz;
  wire slow_clk_en;


  wire rst;


  wire [5:0] currentSeconds;
  wire [5:0] currentMinutes;

  wire [3:0] currentSeconds1sPlace;
  wire [3:0] currentSeconds10sPlace;
  wire [3:0] currentMinutes1sPlace;
  wire [3:0] currentMinutes10sPlace;

  wire [3:0] currentSeconds1sPlaceSegments;
  wire [3:0] currentSeconds10sPlaceSegments;
  wire [3:0] currentMinutes1sPlaceSegments;
  wire [3:0] currentMinutes10sPlaceSegments;


  wire [3:0] currentSeconds1sPlaceSegmentsBlinked;
  wire [3:0] currentSeconds10sPlaceSegmentsBlinked;
  wire [3:0] currentMinutes1sPlaceSegmentsBlinked;
  wire [3:0] currentMinutes10sPlaceSegmentsBlinked;

  wire pb_rst;
  wire pb_pause;
  wire sw_select;
  wire sw_mode;

  wire pb_pause_filtered;
  wire sw_select_filtered;
  wire sw_mode_filtered;

  wire blink_sel_seconds;
  wire blink_sel_minutes;
  wire pause;



  //create the four clocks

  // 1 Hz
  clk_div #(
      .DIVISOR(100000000)
  ) u_clk_div_0 (
      .clk(clk),
      .rst(rst),
      .clk_out(clk1Hz)
  );

  // 2 Hz
  clk_div #(
      .DIVISOR(50000000)
  ) u_clk_div_1 (
      .clk(clk),
      .rst(rst),
      .clk_out(clk2Hz)
  );

  // 10 Hz
  clk_div #(
      .DIVISOR(10000000)
  ) u_clk_div_2 (
      .clk(clk),
      .rst(rst),
      .clk_out(clk10Hz)
  );

  // 100 Hz
  clk_div #(
      .DIVISOR(1000000)
  ) u_clk_div_3 (
      .clk(clk),
      .rst(rst),
      .clk_out(clk100Hz)
  );

  // input filtering
  clk_div #(
      .DIVISOR(249999)
  ) u_clk_div_4 (
      .clk(clk),
      .rst(rst),
      .clk_out(slow_clk_en)
  );





  next_number u_next_number (
      .currentSeconds(currentSeconds),
      .currentMinutes(currentMinutes),
      .switches      (switches),
      .nextSeconds   (nextSeconds),
      .nextMinutes   (nextMinutes)
  );


  // filter buttons and switches
  // first create the 4 wires for 2 buttons, 2 switches



  input_filtering u_input_filtering_button_1 (
      .pb_1       (pb_rst),
      .clk        (clk),
      .slow_clk_en(slow_clk_en),
      .pb_out     (rst)
  );


  input_filtering u_input_filtering_button_2 (
      .pb_1       (pb_pause),
      .clk        (clk),
      .slow_clk_en(slow_clk_en),
      .pb_out     (pb_pause_filtered)
  );


  input_filtering u_input_filtering_switch_1 (
      .pb_1       (sw_select),
      .clk        (clk),
      .slow_clk_en(slow_clk_en),
      .pb_out     (sw_select_filtered)
  );


  input_filtering u_input_filtering_switch_2 (
      .pb_1       (sw_mode),
      .clk        (clk),
      .slow_clk_en(slow_clk_en),
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


  blink u_blink_0 (
      .in       (currentSeconds1sPlace),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_seconds),
      .out      (currentSeconds1sPlaceSegmentsBlinked)
  );

  blink u_blink_1 (
      .in       (currentSeconds10sPlace),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_seconds),
      .out      (currentSeconds10sPlaceSegmentsBlinked)
  );

  blink u_blink_2 (
      .in       (currentMinutes1sPlace),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_minutes),
      .out      (currentMinutes1sPlaceSegmentsBlinked)
  );

  blink u_blink_3 (
      .in       (currentMinutes10sPlace),
      .blink_clk(clk10Hz),
      .blink_sel(blink_sel_minutes),
      .out      (currentMinutes10sPlaceSegmentsBlinked)
  );


  tff u_tff (
      .clk(clk),
      .rst(rst),
      .t  (pb_pause_filtered),
      .q  (pause)
  );


  mux_2_1 u_mux_2_1 (
      .in0(sw_select_filtered),
      .in1(pause),
      .sel(sw_mode_filtered),
      .out(blink_sel_seconds)
  );

  calculation u_calculation (
      .outputSeconds(currentSeconds),
      .outputMinutes(currentMinutes),
      .rst          (rst),
      .pause        (pause),
      .sel_switch   (sel_switch),
      .adj_switch   (adj_switch),
      .clk1         (clk1Hz),
      .clk2         (clk2Hz)
  );









endmodule
