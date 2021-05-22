module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    wire d0,d1,d2;
    
    assign d0 = (KEY[1])? SW[0]:LEDR[2];
    assign d1 = (KEY[1])? SW[1]:LEDR[0];
    assign d2 = (KEY[1])? SW[2]:LEDR[2]^LEDR[1];
    
    always@(posedge KEY[0]) begin
        LEDR <= {d2,d1,d0};
        
    end


endmodule