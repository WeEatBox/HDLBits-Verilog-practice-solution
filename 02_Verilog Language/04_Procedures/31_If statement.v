module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    
    assign out_assign = ( {sel_b1,sel_b2}==2'b11 ) ? b : a; // if sel == 2'b11, output = b
    always@(*) begin
        if ({sel_b1,sel_b2}==2'b11) out_always = b; // if sel == 2'b11, output = b
        else out_always = a;
    end

endmodule