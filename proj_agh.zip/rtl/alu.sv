module alu
#(
	parameter WIDTH = 8
)
(
    input logic [WIDTH-1:0] inputA
   ,input logic [WIDTH-1:0] inputB
   ,input logic [7:0]       operation	//0=add, 1=mul
   ,output logic [(WIDTH*2)-1:0] outputC

);

wire [WIDTH-1:0]     addC;
wire [(WIDTH*2)-1:0] mulC;
wire cout;
wire cin;



assign outputC = (operation == 7'd0) ? {32'b0,addC} : mulC;



adder_gen 
	#(
		.WIDTH	(WIDTH)
	)
inst_adder(
	 .inputA    (inputA)
	,.inputB    (inputB)
	,.cin		(1'b0)
	,.addC		(addC)
	,.cout		(cout)
);



/*
gen_mul	gen_mul_inst (
	 .dataa		( inputA )
	,.datab		( inputB )
	,.result	( mulC )
	);
*/

mul	#(
		.WIDTH	(WIDTH)
	)
mul_inst
 	(
	 .dataa	( inputA )
	,.datab	( inputB )
	,.result	( mulC )
);


/*
adder_gen 
	#(
		.WIDTH	(WIDTH)
	)
inst_adder(
	 .a		(inputA)
	,.b		(inputB)
	,.cin		(1'b0)
	,.c		(addC)
	,.cout	(cout)
);

adder inst_adder(
	 .a		(inputA)
	,.b		(inputB)
	,.cin	(cin)
	,.c		(addC)
	,.cout	(cout)
);


*/

	
endmodule
