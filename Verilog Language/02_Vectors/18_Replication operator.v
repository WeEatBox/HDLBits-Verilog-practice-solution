module top_module (
    input [7:0] in,
    output [31:0] out );//

    // assign out = { replicate-sign-bit , the-input };
    assign out = {  { 24{ in[7:7] } },    in[7:0]    }; // 24 duplicate in[7] then in[7:0]

endmodule