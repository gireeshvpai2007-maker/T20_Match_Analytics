`timescale 1ns/1ps

module penalty_trigger_tb;
reg over_rate_violation;
reg target_reached;
reg [3:0] wickets;
wire penalty;
wire [1:0] penalty_code;
penalty_trigger dut (
.over_rate_violation(over_rate_violation),
.target_reached(target_reached),
.wickets(wickets),
.penalty(penalty),
.penalty_code(penalty_code)
);
initial begin
$dumpfile("penalty_trigger.vcd");
$dumpvars(0, penalty_trigger_tb);
over_rate_violation = 0;
target_reached = 0;
wickets = 2;
#10;
$display("Penalty=%b Code=%b", penalty, penalty_code);
over_rate_violation = 1;
target_reached = 0;
#10;
$display("Penalty=%b Code=%b", penalty, penalty_code);
target_reached = 1;
#10;
$display("Penalty=%b Code=%b", penalty, penalty_code);
wickets = 4;
#10;
$display("Penalty=%b Code=%b", penalty, penalty_code);
$finish;
end
endmodule