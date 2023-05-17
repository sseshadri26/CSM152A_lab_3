//~ `New testbench
`timescale  1ns / 1ps

module tb_stopwatch;

// stopwatch Parameters
parameter PERIOD  = 10;


// stopwatch Inputs
reg    u_input_filtering_button_1 = 0 ;
reg   u_input_filtering_button_2 = 0 ;
reg    u_input_filtering_switch_1 = 0 ;
reg    u_input_filtering_switch_2 = 0 ;
reg            currentSeconds          = 0 ;
reg            currentMinutes          = 0 ;
reg currentSeconds1sPlace            = 0 ;
reg currentSeconds10sPlace           = 0 ;
reg currentMinutes1sPlace            = 0 ;
reg currentMinutes10sPlace           = 0 ;

// stopwatch Outputs
wire currentSeconds1sPlace    ;
wire currentSeconds10sPlace   ;
wire currentMinutes1sPlace    ;
wire currentMinutes10sPlace   ;
wire  currentSeconds1sPlaceSegments ;
wire  currentSeconds10sPlaceSegments ;
wire  currentMinutes1sPlaceSegments ;
wire  currentMinutes10sPlaceSegments ;
wire currentSeconds               ;
wire currentMinutes               ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

stopwatch  u_stopwatch (
    ._filtering u_input_filtering_button_1 (
      .pb_1       (pb_rst     ( _filtering u_input_filtering_button_1 (
      .pb_1       (pb_rst      ),
    ._filtering u_input_filtering_button_2 (
      .pb_1       (pb_pause   ( _filtering u_input_filtering_button_2 (
      .pb_1       (pb_pause    ),
    ._filtering u_input_filtering_switch_1 (
      .pb_1       (sw_select  ( _filtering u_input_filtering_switch_1 (
      .pb_1       (sw_select   ),
    ._filtering u_input_filtering_switch_2 (
      .pb_1       (sw_mode    ( _filtering u_input_filtering_switch_2 (
      .pb_1       (sw_mode     ),
    .Num         (currentSeconds                                           ( Num         (currentSeconds                                         
   ),
    .Num         (currentMinutes                                           ( Num         (currentMinutes                                         
   ),
    .Num(currentSeconds1sPlace                                             ( Num(currentSeconds1sPlace                                           
   ),
    .Num(currentSeconds10sPlace                                            ( Num(currentSeconds10sPlace                                          
   ),
    .Num(currentMinutes1sPlace                                             ( Num(currentMinutes1sPlace                                           
   ),
    .Num(currentMinutes10sPlace                                            ( Num(currentMinutes10sPlace                                          
   ),

    .Num1sPlace (currentSeconds1sPlace                                     ( Num1sPlace (currentSeconds1sPlace                                   
   ),
    .Num10sPlace(currentSeconds10sPlace                                    ( Num10sPlace(currentSeconds10sPlace                                  
   ),
    .Num1sPlace (currentMinutes1sPlace                                     ( Num1sPlace (currentMinutes1sPlace                                   
   ),
    .Num10sPlace(currentMinutes10sPlace                                    ( Num10sPlace(currentMinutes10sPlace                                  
   ),
    .Segments(currentSeconds1sPlaceSegments                                ( Segments(currentSeconds1sPlaceSegments                              
   ),
    .Segments(currentSeconds10sPlaceSegments                               ( Segments(currentSeconds10sPlaceSegments                             
   ),
    .Segments(currentMinutes1sPlaceSegments                                ( Segments(currentMinutes1sPlaceSegments                              
   ),
    .Segments(currentMinutes10sPlaceSegments                               ( Segments(currentMinutes10sPlaceSegments                             
   ),
    .Seconds(currentSeconds                                                ( Seconds(currentSeconds                                              
   ),
    .Minutes(currentMinutes                                                ( Minutes(currentMinutes                                              
   )
);

initial
begin

    $finish;
end

endmodule