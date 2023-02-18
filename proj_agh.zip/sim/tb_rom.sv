/**
 * Module name:    tb_rom
 * Creation date:  2023.01.04
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

`timescale 1ns/1ps

module tb_rom ();


/**
 * Local variables and signals
 */

logic        clk, rden;
logic [31:0] q;
logic [4:0]  address;


/**
 * Submodules placement
 */

gen_rom	u_gen_rom (
    .address,
    .clock(clk),
    .rden,
    .q
);


/**
 * Test
 */

initial begin
    address = 5'b0;

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
