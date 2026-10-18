`timescale 1ns/1ps

module score_aggregator_tb;
reg clk, reset, wicket;
reg [3:0] runs_scored;
wire [15:0] total_score;
wire [3:0] wickets;
score_aggregator dut (
.clk(clk),
.reset(reset),
.runs_scored(runs_scored),
.wicket(wicket),
.total_score(total_score),
.wickets(wickets)
);
always #5 clk = ~clk;
initial begin
$dumpfile("score_aggregator.vcd");
$dumpvars(0, score_aggregator_tb);
clk = 0;
reset = 1;
runs_scored = 0;
wicket = 0;
#12 reset = 0;
@(negedge clk) runs_scored = 4;
@(negedge clk) runs_scored = 2;
@(negedge clk) begin
runs_scored = 1;
wicket = 1;
end
@(negedge clk) begin
runs_scored = 0;
wicket = 0;
end
@(negedge clk) runs_scored = 6;
@(negedge clk) runs_scored = 0;
#10;
$display("Total score = %0d", total_score);
$display("Wickets = %0d", wickets);
$finish;
end
endmodule