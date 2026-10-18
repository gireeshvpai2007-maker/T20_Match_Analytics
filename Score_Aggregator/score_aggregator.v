
`timescale 1ns/1ps

module score_aggregator (
    input wire clk,
    input wire reset,
    input wire [3:0] runs_scored,
    input wire wicket,
    output reg [15:0] total_score,
    output reg [3:0] wickets
);

    reg wicket_d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            total_score <= 16'd0;
            wickets <= 4'd0;
            wicket_d <= 1'b0;
        end
        else begin
            total_score <= total_score + runs_scored;

            if (wicket && !wicket_d && wickets < 4'd10)
                wickets <= wickets + 1'b1;

            wicket_d <= wicket;
        end
    end

endmodule
