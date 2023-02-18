

module adder(
 	 input logic [3:0] a
	,input logic [3:0] b
	,input logic 	   cin
	
	,output logic [3:0] c
	,output logic 		cout
);


fadd ADD00(
	.a		(a[0])
	,.b	(b[0])
	,.cin	(cin)
	,.c	(c[0])
	,.cout	(carry[0])
);

fadd ADD01(
	.a		(a[1])
	,.b	(b[1])
	,.cin	(carry[0])
	,.c	(c[1])
	,.cout	(carry[1])
);

fadd ADD02(
	.a		(a[2])
	,.b	(b[2])
	,.cin	(carry[1])
	,.c	(c[2])
	,.cout	(carry[2])
);

fadd ADD03(
	.a		(a[3])
	,.b	(b[3])
	,.cin	(carry[2])
	,.c	(c[3])
	,.cout	(carry[3])
);

assign cout = carry[3];



endmodule



