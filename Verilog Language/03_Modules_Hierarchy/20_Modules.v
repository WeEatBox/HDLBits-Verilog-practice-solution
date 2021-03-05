module top_module ( input a, input b, output out );

    mod_a a1(.out(out),.in1(a),.in2(b));//.name(parameter) can instantiate a module without parameter order
endmodule