

module adder_gen
#(
    parameter WIDTH = 32
)(
	 input logic [WIDTH-1:0] inputA
	,input logic [WIDTH-1:0] inputB
	,input logic cin

	,output logic [WIDTH-1:0] addC
	,output logic cout
);

wire [WIDTH:0] carry;

assign carry[0] = cin;

genvar i;
generate for(i=0; i<WIDTH;i=i+1) begin: fadd_generate

    fadd inst_GEN(
	     .a	    (inputA[i])
    	,.b     (inputB[i])
    	,.cin   (carry[i])
    	,.c     (addC[i])
    	,.cout	(carry[i+1])
    );


	 end
endgenerate

assign cout = carry[4];



endmodule
