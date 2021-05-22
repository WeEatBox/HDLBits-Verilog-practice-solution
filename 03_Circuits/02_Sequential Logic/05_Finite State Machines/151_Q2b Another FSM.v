module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    parameter A=0,B1=1,B2=2,B3=3,C1=4,C2=5,D=6,E=7,F=8;
    // A = initial state
    // F = output f=1 for 1 clock
    // B1= '1'01 check
    // B2= 1'0'1 check
    // B3= 10'1' check
    // C1= first clock check y
    // C2= second clock check y
    // D = output g=0 permanently
    // E = output g=1 permanently
    reg [3:0] state, next;
    
    always@(*) begin
        case(state)
            A : next = F;            //wait until reset==1
            F : next = B1;           //just for output f=1 for 1 clock
            B1: next = x?      B2:B1;//1, if '0'   go back to B1
            B2: next = x?      B2:B3;//0, if 1'1'  go back to B2
            B3: next = x?      C1:B1;//1, if 10'0' go back to B1
            C1: next = y?      E :C2;//if y==1 go to E, if y==0, second chance
            C2: next = y?      E : D;//if y==1 go to E, if y==0, go to D
            D : next = D;            //g output 0
            E : next = E;            //g output 1
            default: next = next;
        endcase
    end
    
    always@(posedge clk) begin
        if(~resetn) state <= A;
        else state <= next;
    end
    
    assign f = state==F;
    assign g = state==C1 | state==C2 | state==E;

endmodule