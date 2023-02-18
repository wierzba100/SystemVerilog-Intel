/**
 * Module name:    domains_intersection
 * Creation date:  2022.12.02
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

module domains_intersection #(
    RECEIVER_IDLE_CYCLES = 1
) (
    input logic        clk,
    input logic        rst_n,

    output logic [7:0] receiver_rdata,
    input logic        sender_trigger
);


/**
 * Local variables and signals
 */

logic       clk_99MHz, clk_2MHz;

logic [7:0] fifo_q, fifo_data;
logic       fifo_rdreq, fifo_wrreq, fifo_rdempty, fifo_wrfull;


/**
 * Submodules placement
 */

pll u_pll (
    .refclk(clk),
    .rst(~rst_n),
    .outclk_0(clk_2MHz),
    .locked()
);

pll99 u_pll99 (
    .refclk(clk),
    .rst(~rst_n),
    .outclk_0(clk_99MHz),
    .locked()
);

sender u_sender (
    .clk(clk_99MHz),
    .rst_n,

    .trigger(sender_trigger),

    .fifo_req(),
    .fifo_data(),
    .fifo_full(),
    .fifo_empty()
);

fifo u_fifo (
    .data(),
    .rdclk(clk_2MHz),
    .rdreq(),
    .wrclk(clk_99MHz),
    .wrreq(),
    .q(),
    .rdempty(),
    .wrfull()
);

receiver #(
    .IDLE_CYCLES(RECEIVER_IDLE_CYCLES)
) u_receiver (
    .clk(clk_2MHz),
    .rst_n,

    .fifo_req(),
    .fifo_empty(),
    .fifo_q(),

    .rdata(receiver_rdata)
);

endmodule
