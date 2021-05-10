module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    
    always@(*) begin
        out = 0;
        
        for(int i=0;i<$bits(in);i=i+1) begin //$bits(name) reports number of bits
            if(in[i]) out = out + 1'b1;
            else out = out + 1'b0;
        end
       
    end

endmodule