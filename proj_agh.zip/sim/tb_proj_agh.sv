/**
 * Module name:    tb_proj_agh
 * Creation date:  2023.01.04
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

`timescale 1ns/1ps

module tb_proj_agh ();


/**
 * Local variables and signals
 */

logic        clk, rst, pll_rst;


/**
 * Submodules placement
 */

proj_agh u_proj_agh (
    .FPGA_CLK_50(clk),
    .FPGA_CLK2_50(1'b0),
    .FPGA_CLK3_50(1'b0),

    .KEY({rst, pll_rst}),
    .SW(4'b0)
);


/**
 * Test
 */

initial begin
    rst = 1'b0;
    pll_rst = 1'b1;

    for (int i = 0; i < 2; ++i)
        @(negedge clk) ;
    pll_rst = 1'b0;

    @(negedge clk) ;
    rst = 1'b1;

    @(negedge clk) ;
    rst = 1'b0;

    for (int i = 0; i < 10; ++i)
        @(negedge clk) ;

    $finish();
end


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever
        clk = #10 ~clk;
end

endmodule
