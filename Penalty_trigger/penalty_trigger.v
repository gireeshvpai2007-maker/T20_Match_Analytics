
`timescale 1ns/1ps

module penalty_trigger (
    input wire over_rate_violation,
    input wire target_reached,
    input wire [3:0] wickets,
    output reg penalty,
    output reg [1:0] penalty_code
);

    always @(*) begin
        penalty = 1'b0;
        penalty_code = 2'b00;

        if (over_rate_violation &&
            target_reached &&
            wickets < 4'd4) begin

            penalty = 1'b1;
            penalty_code = 2'b01;
        end
    end

endmodule
