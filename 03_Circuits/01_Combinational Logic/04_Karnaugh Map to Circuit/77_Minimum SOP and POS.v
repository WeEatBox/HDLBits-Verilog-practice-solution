module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
    
); 
    assign out_sop = c*d | ~a*~b*c ;      // sum of product : output==1
    assign out_pos = c & (~a|d) & (~b|d); // product of sum : output==0
                   

endmodule