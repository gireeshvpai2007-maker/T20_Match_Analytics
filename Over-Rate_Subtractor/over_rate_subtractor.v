
`timescale 1ns/1ps

module over_rate_subtractor (
    input wire [5:0] total_overs,
    input wire [5:0] completed_overs,
    input wire [5:0] allowed_overs,
    output reg [5:0] overs_remaining,
    output reg over_rate_violation
);

    always @(*) begin
        if (completed_overs >= total_overs)
            overs_remaining = 6'd0;
        else
            overs_remaining = total_overs - completed_overs;

        if (completed_overs > allowed_overs)
            over_rate_violation = 1'b1;
        else
            over_rate_violation = 1'b0;
    end

endmodule
