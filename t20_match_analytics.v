`timescale 1ns/1ps

module t20_match_analytics (
    input wire clk,
    input wire reset,
    input wire [3:0] runs_scored,
    input wire wicket,
    input wire [5:0] total_overs,
    input wire [5:0] completed_overs,
    input wire [5:0] allowed_overs,
    input wire [15:0] target_score,
    input wire [2:0] select,
    output wire [15:0] total_score,
    output wire [3:0] wickets,
    output wire [5:0] overs_remaining,
    output wire over_rate_violation,
    output wire target_reached,
    output wire [15:0] runs_required,
    output wire penalty,
    output wire [1:0] penalty_code,
    output wire [15:0] display_data
);
    wire [1:0] display_penalty;

    score_aggregator score_unit (
        .clk(clk),
        .reset(reset),
        .runs_scored(runs_scored),
        .wicket(wicket),
        .total_score(total_score),
        .wickets(wickets)
    );

    over_rate_subtractor over_rate_unit (
        .total_overs(total_overs),
        .completed_overs(completed_overs),
        .allowed_overs(allowed_overs),
        .overs_remaining(overs_remaining),
        .over_rate_violation(over_rate_violation)
    );

    target_comparator target_unit (
        .current_score(total_score),
        .target_score(target_score),
        .target_reached(target_reached),
        .runs_required(runs_required),
        .V(),
        .N(),
        .Z()
    );

    penalty_trigger penalty_unit (
        .over_rate_violation(over_rate_violation),
        .target_reached(target_reached),
        .wickets(wickets),
        .penalty(penalty),
        .penalty_code(penalty_code)
    );

    assign display_penalty = penalty_code;

    display_mux display_unit (
        .score(total_score),
        .wickets(wickets),
        .overs(completed_overs),
        .overs_remaining(overs_remaining),
        .runs_required(runs_required),
        .penalty(display_penalty),
        .select(select),
        .display_data(display_data)
    );
endmodule
