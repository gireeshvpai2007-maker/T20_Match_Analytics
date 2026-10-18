
`timescale 1ns/1ns
`include "person3_target_comparator.v"
module person3_target_comparator_tb();

reg [7:0] current_score;
reg [7:0] target_score;

wire target_reached;
wire [7:0] runs_required;
wire V, N, Z;

person3_target_comparator uut(
    .current_score(current_score),
    .target_score(target_score),
    .target_reached(target_reached),
    .runs_required(runs_required),
    .V(V),
    .N(N),
    .Z(Z)
);

initial begin
    $dumpfile("person3_target_comparator_tb.vcd");
    $dumpvars(0, person3_target_comparator_tb);

    $monitor("Time=%0t Current=%0d Target=%0d Runs=%0d Reached=%b V=%b N=%b Z=%b",
        $time, current_score, target_score,
        runs_required, target_reached, V, N, Z);

    target_score = 180;
    current_score = 150;
    #10;

    current_score = 179;
    #10;

    current_score = 180;
    #10;

    current_score = 181;
    #10;

    target_score = 100;
    current_score = 150;
    #10;

    target_score = 255;
    current_score = 0;
    #10;

    $finish;
end

endmodule
