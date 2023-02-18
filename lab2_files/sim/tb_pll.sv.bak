/**
 * Module name:    tb_pll
 * Creation date:  2022.12.07
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

`timescale 1ns/1ps

module tb_pll ();


/**
 * Local variables and signals
 */

logic refclk, rst, outclk_0, locked;


/**
 * Submodules placement
 */

// pll u_pll (

// );


/**
 * Tasks and functions definitions
 */

task reset();
    @(negedge refclk) ;
    @(negedge refclk) ;
    rst = 1'b1;

    @(negedge refclk) ;
    rst = 1'b0;
endtask


/**
 * Test
 */

initial begin
    rst = 1'b0;

    reset();

    for (int i = 0; i < 100; ++i)
        @(posedge refclk) ;

    $finish();
end


/**
 * Clock generation
 */

/* 50 MHz */

// initial begin

// end

endmodule
