/**
 * Module name:    tb_sender
 * Creation date:  2022.12.07
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

`timescale 1ns/1ps

module tb_sender ();


/**
 * Local variables and signals
 */

logic       refclk, rst_n, pll_outclk_0, pll_locked, pll99_outclk_0, pll99_locked;

logic [7:0] fifo_data, rdata;
logic       fifo_req, trigger;


/**
 * Submodules placement
 */

pll u_pll (
    .refclk,
    .rst(~rst_n),
    .outclk_0(pll_outclk_0),
    .locked(pll_locked)
);

pll99 u_pll99 (
    .refclk,
    .rst(~rst_n),
    .outclk_0(pll99_outclk_0),
    .locked(pll99_locked)
);

sender u_sender (
    .clk(pll99_outclk_0),
    .rst_n,

    .trigger,

    .fifo_req,
    .fifo_data,
    .fifo_full(1'b0),
    .fifo_empty()
);


/**
 * Tasks and functions definitions
 */

task trig_sender();
    @(negedge pll99_outclk_0) ;
    trigger = 1'b1;

    @(negedge pll99_outclk_0) ;
    trigger = 1'b0;
endtask


/**
 * Module internal logic
 */

always_ff @(posedge pll99_outclk_0 or negedge rst_n) begin
    if (!rst_n)
        rdata <= 8'b0;
    else
        rdata <= fifo_data;
end


/**
 * Test
 */

initial begin
    rst_n = 1'b0;
    trigger = 1'b0;

    @(negedge refclk) ;
    rst_n = 1'b1;

    trig_sender();

    for (int i = 0; i < 100; ++i)
        @(posedge refclk) ;

    $finish();
end


/**
 * Clock generation
 */

/* 50 MHz */

initial begin
    refclk = 1'b0;

    forever
        refclk = #10 ~refclk;
end

endmodule
