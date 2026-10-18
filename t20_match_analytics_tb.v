`timescale 1ns/1ps

module t20_match_analytics_tb();
    reg clk, reset, wicket;
    reg [3:0] runs_scored;
    reg [5:0] total_overs, completed_overs, allowed_overs;
    reg [15:0] target_score;
    reg [2:0] select;

    wire [15:0] total_score, runs_required, display_data;
    wire [3:0] wickets;
    wire [5:0] overs_remaining;
    wire over_rate_violation, target_reached, penalty;
    wire [1:0] penalty_code;

    t20_match_analytics dut (
        .clk(clk), .reset(reset),
        .runs_scored(runs_scored), .wicket(wicket),
        .total_overs(total_overs), .completed_overs(completed_overs),
        .allowed_overs(allowed_overs), .target_score(target_score),
        .select(select), .total_score(total_score), .wickets(wickets),
        .overs_remaining(overs_remaining),
        .over_rate_violation(over_rate_violation),
        .target_reached(target_reached), .runs_required(runs_required),
        .penalty(penalty), .penalty_code(penalty_code),
        .display_data(display_data)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("t20_match_analytics_tb.vcd");
        $dumpvars(0, t20_match_analytics_tb);

        clk = 0; reset = 1; wicket = 0; runs_scored = 0;
        total_overs = 20; completed_overs = 0; allowed_overs = 18;
        target_score = 16'd180; select = 3'b000;
        #12 reset = 0;

        @(negedge clk) runs_scored = 4;
        @(negedge clk) runs_scored = 6;
        @(negedge clk) begin runs_scored = 1; wicket = 1; end
        @(negedge clk) begin runs_scored = 0; wicket = 0; end
        @(negedge clk) runs_scored = 6;
        @(negedge clk) begin runs_scored = 0; completed_overs = 19; end
        #2;

        if (total_score !== 16'd17)
            $fatal(1, "Score aggregation failed: got %0d", total_score);
        if (wickets !== 4'd1)
            $fatal(1, "Wicket aggregation failed: got %0d", wickets);
        if (runs_required !== 16'd163 || target_reached !== 1'b0)
            $fatal(1, "Target comparator failed: runs_required=%0d reached=%b", runs_required, target_reached);
        if (overs_remaining !== 6'd1 || over_rate_violation !== 1'b1)
            $fatal(1, "Over-rate logic failed: remaining=%0d violation=%b", overs_remaining, over_rate_violation);

        select = 3'b000; #1;
        if (display_data !== total_score)
            $fatal(1, "Display mux score selection failed");

        $display("PASS: integrated T20 Match Analytics tests completed.");
        $display("Score=%0d Wickets=%0d RunsRequired=%0d OversRemaining=%0d Violation=%b Penalty=%b Code=%b",
            total_score, wickets, runs_required, overs_remaining,
            over_rate_violation, penalty, penalty_code);
        $finish;
    end
endmodule
