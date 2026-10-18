
`timescale 1ns/1ps

module display_mux (
    input wire [15:0] score,
    input wire [3:0] wickets,
    input wire [5:0] overs,
    input wire [5:0] overs_remaining,
    input wire [15:0] runs_required,
    input wire [1:0] penalty,
    input wire [2:0] select,
    output reg [15:0] display_data
);

    always @(*) begin
        case (select)
            3'b000: display_data = score;
            3'b001: display_data = {12'd0, wickets};
            3'b010: display_data = {10'd0, overs};
            3'b011: display_data = {10'd0, overs_remaining};
            3'b100: display_data = runs_required;
            3'b101: display_data = {14'd0, penalty};
            default: display_data = 16'd0;
        endcase
    end

endmodule
