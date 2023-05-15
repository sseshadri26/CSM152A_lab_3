// Counter Module
// input
//      the current time - minutes, and seconds
// output
//      the next time, ticking up normally
//      the next minute, for when select is on minute


module next_number (
    input  [5:0] currentSeconds,
    input  [5:0] currentMinutes,
    input  [1:0] switches,
    output [5:0] nextSeconds,
    output [5:0] nextMinutes
);


  wire select;
  // 00 - Normal
  // 01 - Normal
  // 10 - Minutes tick
  // 01 - Normal

  assign select = switches[1] & ~switches[0];

  // if select == 0, then we are on seconds
  // if select == 1, then we are on minutes

  wire secondsMax;
  wire minutesMax;
  assign secondsMax = (currentSeconds == 59);
  assign minutesMax = (currentMinutes == 59);

  wire nextSecondsNormal;
  wire nextMinutesNormal;

  wire nextSecondsAlt;
  wire nextMinutesAlt;

  assign nextSecondsNormal = secondsMax ? 0 : currentSeconds + 1;
  assign nextMinutesNormal = minutesMax ? 0 : secondsMax ? currentMinutes + 1 : currentMinutes;
  assign nextSecondsAlt    = currentSeconds;
  assign nextMinutesAlt    = minutesMax ? 0 : currentMinutes + 1;

  assign nextSeconds = select ? nextSecondsAlt : nextSecondsNormal;
  assign nextMinutes = select ? nextMinutesAlt : nextMinutesNormal;
  // assign nextSeconds = 5;
  // assign nextMinutes = 5;

endmodule  //next_number
