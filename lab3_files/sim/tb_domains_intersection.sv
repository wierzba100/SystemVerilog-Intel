/**
 * Module name:    tb_domains_intersection
 * Creation date:  2022.12.14
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

`timescale 1ns/1ps

module tb_domains_intersection ();


/**
 * Local variables and signals
 */

logic       clk, rst_n;

logic [7:0] receiver_rdata;
logic       sender_trigger;


/**
 * Submodules placement
 */

domains_intersection #(
    .RECEIVER_IDLE_CYCLES(1)
) u_domains_intersection (
    .clk,
    .rst_n,

    .receiver_rdata,
    .sender_trigger
);


/**
 * Tasks and functions definitions
 */

task trig_sender();
    @(negedge clk);
    sender_trigger = 1'b1;

    @(negedge clk);
    sender_trigger = 1'b0;
endtask


/**
 * Test
 */

initial begin
    rst_n = 1'b0;
    sender_trigger = 1'b0;

    for (int i = 0; i < 2; ++i)
        @(negedge clk) ;

    rst_n = 1'b1;

    trig_sender();

    for (int i = 0; i < 1000; ++i)
        @(posedge clk) ;

    $finish();
end


/**
 * Clock generation
 */

/* 50 MHz */

initial begin
    clk = 1'b0;

    forever
        clk = #10 ~clk;
end

endmodule
