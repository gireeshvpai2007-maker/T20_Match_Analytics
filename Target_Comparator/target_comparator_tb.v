`timescale 1ns/1ps
module target_comparator_tb;
    reg [15:0] current_score;
    reg [15:0] target_score;
    wire target_reached;
    wire [15:0] runs_required;
    wire V, N, Z;

    target_comparator dut (
        .current_score(current_score),
        .target_score(target_score),
        .target_reached(target_reached),
        .runs_required(runs_required),
        .V(V), .N(N), .Z(Z)
    );

    initial begin
        $dumpfile("target_comparator_tb.vcd");
        $dumpvars(0, target_comparator_tb);

        target_score = 180; current_score = 150; #10;
        if (target_reached !== 1'b0 || runs_required !== 16'd30)
            $fatal(1, "Failed: current=150 target=180");

        current_score = 179; #10;
        if (target_reached !== 1'b0 || runs_required !== 16'd1)
            $fatal(1, "Failed: current=179 target=180");

        current_score = 180; #10;
        if (target_reached !== 1'b1 || runs_required !== 16'd0)
            $fatal(1, "Failed: current=180 target=180");

        current_score = 181; #10;
        if (target_reached !== 1'b1 || runs_required !== 16'd0)
            $fatal(1, "Failed: current=181 target=180");

        target_score = 500; current_score = 300; #10;
        if (target_reached !== 1'b0 || runs_required !== 16'd200)
            $fatal(1, "Failed: 16-bit score comparison");

        $display("PASS: target comparator tests completed.");
        $finish;
    end
endmodule
