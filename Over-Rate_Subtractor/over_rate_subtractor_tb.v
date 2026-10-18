`timescale 1ns/1ps

module over_rate_subtractor_tb;
reg [5:0] total_overs;
reg [5:0] completed_overs;
reg [5:0] allowed_overs;
wire [5:0] overs_remaining;
wire over_rate_violation;
over_rate_subtractor dut (
.total_overs(total_overs),
.completed_overs(completed_overs),
.allowed_overs(allowed_overs),
.overs_remaining(overs_remaining),
.over_rate_violation(over_rate_violation)
);
initial begin
$dumpfile("over_rate_subtractor.vcd");
$dumpvars(0, over_rate_subtractor_tb);
total_overs = 20;
allowed_overs = 18;
completed_overs = 10;
#10;
$display("Completed=10 Remaining=%0d Violation=%b",
overs_remaining, over_rate_violation);
completed_overs = 18;
#10;
$display("Completed=18 Remaining=%0d Violation=%b",
overs_remaining, over_rate_violation);
completed_overs = 19;
#10;
$display("Completed=19 Remaining=%0d Violation=%b",
overs_remaining, over_rate_violation);
completed_overs = 20;
#10;
$display("Completed=20 Remaining=%0d Violation=%b",
overs_remaining, over_rate_violation);
$finish;
end
endmodule