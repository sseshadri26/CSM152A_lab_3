// module to take a number 0-60 and split it into 2 digits

module get_digits (
    input  [5:0] inputNum,
    output [3:0] outputNum1sPlace,
    output [3:0] outputNum10sPlace
);

  assign outputNum1sPlace  = inputNum % 10;
  assign outputNum10sPlace = inputNum / 10;

endmodule
