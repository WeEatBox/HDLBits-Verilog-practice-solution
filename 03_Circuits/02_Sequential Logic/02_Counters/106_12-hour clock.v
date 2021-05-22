module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire ena_10s,ena_1m,ena_10m,ena_1h;
    
    initial begin         // initial time
        hh = 8'b0001_0010;
    end
    
    
    bcdcount counter_s0    (clk, reset,    ena, ss[7:0]);
    bcdcount counter_m0    (clk, reset, ena_1m, mm[7:0]);
    bcdcount_1h counter_h0 (clk, reset, ena_1h, hh[7:0]);

    assign ena_1m = (ss[7:0]==8'h59) ? 1 : 0;
    assign ena_1h = (ss[7:0]==8'h59 & mm[7:0]==8'h59) ? 1 : 0;   // 59:59 -> 1hr
    

    always@(posedge clk) begin
        if(reset) pm <= 0;
        else if(ss[7:0]==8'h59 & mm[7:0]==8'h59 & hh[7:0] == 8'h11) pm <= ~pm;
        else pm <= pm;
    end
    
endmodule


module bcdcount(
    input clk,
    input reset,
    input enable,
    
    output [7:0]Q);
    
    always@(posedge clk) begin
        if(reset) Q <= 8'b0; // default ss=00
        else begin
            if(enable) begin
                if(Q==8'b0101_1001) Q <= 8'b0000_0000;            // if ss=59 -> 00
                else if(Q[3:0]==4'b1001) Q <= {Q[7:4]+1,4'b0000}; // if ss ?9 -> ?0
                else Q <= Q + 1;
            end
            else Q <= Q;
        end
    end
endmodule

module bcdcount_1h(
    input clk,
    input reset,
    input enable,
    
    output [7:0]Q);
    
    always@(posedge clk) begin
        if(reset) Q <= 8'b0001_0010; // default hh=12
        else begin
            if(enable) begin
                if(Q==8'b0001_0010) Q <= 8'b0000_0001;       // if hh=12 -> 01
                else if(Q==8'b0000_1001) Q <= 8'b0001_0000;  // if hh=09 -> 10
                else Q <= Q + 1;
            end
            else Q <= Q;
        end
    end
endmodule