module top_module();

    wire out;
    reg [1:0] in;
    
    andgate agate(.in(in),.out(out));
    
    initial begin
        in = 2'b00; // time = 0
        #10;
        in = 2'b01; // time = 10
        #10;
        in = 2'b10; // time = 20
        #10;
        in = 2'b11; // time = 30
    end
endmodule