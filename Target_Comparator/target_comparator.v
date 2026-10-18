`timescale 1ns/1ps

module target_comparator(
    input wire [15:0] current_score,
    input wire [15:0] target_score,
    output wire target_reached,
    output wire [15:0] runs_required,
    output wire V,
    output wire N,
    output wire Z
);
    wire [15:0] A, B, S;
    wire [16:0] C;

    assign A = target_score;
    assign B = ~current_score;
    assign C[0] = 1'b1;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : ripple_subtractor
            full_adder fa(A[i], B[i], C[i], S[i], C[i+1]);
        end
    endgenerate

    assign V = C[15] ^ C[16];
    assign N = S[15];
    assign Z = ~(|S);

    assign target_reached = (current_score >= target_score);
    assign runs_required = target_reached ? 16'd0 : S;

endmodule

module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule
