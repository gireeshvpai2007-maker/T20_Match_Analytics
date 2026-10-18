`timescale 1ns/1ps
`include "display_mux.v"
module display_mux_tb();
reg [15:0] score, runs_required;
reg [3:0] wickets;
reg [5:0] overs, overs_remaining;
reg [1:0] penalty;
reg [2:0] select;
wire [15:0] display_data;
display_mux dut (
.score(score),
.wickets(wickets),
.overs(overs),
.overs_remaining(overs_remaining),
.runs_required(runs_required),
.penalty(penalty),
.select(select),
.display_data(display_data)
);
initial begin
$dumpfile("display_mux.vcd");
$dumpvars(0, display_mux_tb);
score = 16'd156;
wickets = 4'd4;
overs = 6'd17;
overs_remaining = 6'd3;
runs_required = 16'd24;
penalty = 2'd1;
select = 3'b000; #10;
$display("Score: %0d", display_data);
select = 3'b001; #10;
$display("Wickets: %0d", display_data);
select = 3'b010; #10;
$display("Overs: %0d", display_data);
select = 3'b011; #10;
$display("Overs remaining: %0d", display_data);
select = 3'b100; #10;
$display("Runs required: %0d", display_data);
select = 3'b101; #10;
$display("Penalty: %0d", display_data);
select = 3'b110; #10;
$display("Invalid selection: %0d", display_data);
$finish;
end
endmodule