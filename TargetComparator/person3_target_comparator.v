

module person3_target_comparator(
    input [7:0] current_score,
    input [7:0] target_score,
    output target_reached,
    output [7:0] runs_required,
    output V,
    output N,
    output Z
);

wire [7:0] A, B;
wire [7:0] S;
wire [8:0] C;

assign A = target_score;
assign B = ~current_score;
assign C[0] = 1'b1;

full_adder fa0(A[0], B[0], C[0], S[0], C[1]);
full_adder fa1(A[1], B[1], C[1], S[1], C[2]);
full_adder fa2(A[2], B[2], C[2], S[2], C[3]);
full_adder fa3(A[3], B[3], C[3], S[3], C[4]);
full_adder fa4(A[4], B[4], C[4], S[4], C[5]);
full_adder fa5(A[5], B[5], C[5], S[5], C[6]);
full_adder fa6(A[6], B[6], C[6], S[6], C[7]);
full_adder fa7(A[7], B[7], C[7], S[7], C[8]);

assign V = C[7] ^ C[8];
assign N = S[7];
assign Z = ~(|S);

assign target_reached = ~C[8] | Z;
assign runs_required = target_reached ? 8'd0 : S;

endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
