
module power_ctrl(

    input   ref_clk
    ,input  [1:0]ref_rst

    ,output rom_clk
    ,output mem_a_clk
    ,output mem_b_clk
    ,output mem_c_clk
    ,output ctrl_clk
    ,output rst
);

wire pll_rst;
wire pll_clk;
wire pll_lock;

assign pll_rst	= ref_rst[0];
assign rst		= ref_rst[1] | ~pll_lock;

assign rom_clk    = pll_clk;
assign mem_a_clk  = pll_clk;
assign mem_b_clk  = pll_clk;
assign mem_c_clk  = pll_clk;
assign ctrl_clk   = pll_clk;


gen_pll ints_pll(
		 .refclk	(ref_clk)
		,.rst		(pll_rst)
		,.outclk_0	(pll_clk)
		,.locked	(pll_lock)
	);



endmodule
