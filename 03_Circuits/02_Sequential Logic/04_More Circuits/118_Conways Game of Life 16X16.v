module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [323:0]tmp;
    reg [255:0] data_tmp;
    
    assign q = data_tmp;
    always@(*) begin
        tmp[1+:16] = data_tmp[15*16+:16];         // add line 15 to above of line 0
        tmp[307+:16] = data_tmp[0+:16];           // add line 0 to below of line 15, 18*17+1 to 18*17+16
        for(int i=0; i<16; i++) begin
            tmp[18*(i+1)] = data_tmp[16*(i+1)-1]; // copy column 15 to left of column 0
            tmp[18*(i+1)+17] = data_tmp[16*(i)];  // copy column 0 to  right of column 15
            for(int j=0;j<16;j++) tmp[18*(i+1)+1+j] = data_tmp[16*i+j];
        end
        tmp[0] = data_tmp [255];    // copy bottom right to top left cornor
        tmp[17] = data_tmp [16*15]; // copy bottom left to top right cornor
        tmp[18*17] = data_tmp [15]; // copy top right to bottom left cornor
        tmp[323] = data_tmp [0];    // copy top left to bottom right cornor
    end
    
    always@(posedge clk) begin
        if(load) data_tmp <= data;
        else begin
            for(int i=0; i<16;i++) begin
                for(int j=0; j<16;j++) begin
                    case(tmp[18*i+j]+tmp[18*i+j+1]+tmp[18*i+j+2]+     // sum of surrounding 8 spots
                         tmp[18*(i+1)+j]+tmp[18*(i+1)+j+2]+tmp[18*(i+2)+j]+
                         tmp[18*(i+2)+j+1]+tmp[18*(i+2)+j+2]) 

                        5'd2: data_tmp[i*16+j] <= data_tmp[i*16+j];  // sum==2
                        5'd3: data_tmp[i*16+j] <= 1'b1;              // sum==3
                        default: data_tmp[i*16+j] <= 1'b0;           // otherwise
                    endcase
                end
                
            end
        end
    end

endmodule