module ssd_display_mux (
    // 4 7 segment displays 6:0
    input [6:0] segments1,
    input [6:0] segments2,
    input [6:0] segments3,
    input [6:0] segments4,
    input clk,
    output reg [3:0] Anode_Activate,  // anode signals of the 7-segment LED display
    output reg [6:0] output_segments
);

  reg [1:0] LED_activating_counter;

  always @(posedge clk) begin
    LED_activating_counter <= LED_activating_counter + 1;
  end
  // anode activating signals for 4 LEDs
  // decoder to generate anode signals 
  always @(*) begin
    case (LED_activating_counter)
      2'b00: begin
        Anode_Activate  = 4'b0111;
        // activate LED1 and Deactivate LED2, LED3, LED4
        output_segments = segments1;
        // the first hex-digit of the 16-bit number
      end
      2'b01: begin
        Anode_Activate  = 4'b1011;
        // activate LED2 and Deactivate LED1, LED3, LED4
        output_segments = segments2;
        // the second hex-digit of the 16-bit number
      end
      2'b10: begin
        Anode_Activate  = 4'b1101;
        // activate LED3 and Deactivate LED2, LED1, LED4
        output_segments = segments3;
        // the third hex-digit of the 16-bit number
      end
      2'b11: begin
        Anode_Activate  = 4'b1110;
        // activate LED4 and Deactivate LED2, LED3, LED1
        output_segments = segments4;
        // the fourth hex-digit of the 16-bit number 
      end
      default: begin
        Anode_Activate  = 4'b0111;
        // activate LED1 and Deactivate LED2, LED3, LED4
        output_segments = segments1;
        // the first hex-digit of the 16-bit number
      end
    endcase
  end


endmodule  //ssd_display_mux
