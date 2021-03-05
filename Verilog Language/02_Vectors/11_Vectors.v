module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration
    
    assign o2=vec[2]; // same as outv[2]
    assign o1=vec[1]; // same as outv[1]
    assign o0=vec[0]; // same as outv[0]
    assign outv=vec;

endmodule