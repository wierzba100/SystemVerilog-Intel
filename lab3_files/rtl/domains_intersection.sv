/**
 * Module name:    domains_intersection
 * Creation date:  2022.12.14
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

logic       clk_199_MHz, clk_49_MHz;

logic [7:0] fifo_q, fifo_data;
logic       fifo_rdreq, fifo_wrreq, fifo_rdempty, fifo_wrfull;


/**
 * Submodules placement
 */

pll u_pll (
    .refclk(clk),
    .rst(~rst_n),
    .outclk_0(clk_199_MHz),
    .outclk_1(clk_49_MHz),
    .locked()
);

sender u_sender (
    .clk(clk_199_MHz),
    .rst_n,

    .trigger(sender_trigger),

    .fifo_req(fifo_wrreq),
    .fifo_data(fifo_data),
    .fifo_full(fifo_wrfull),
    .fifo_empty(fifo_rdempty)
);

fifo u_fifo (
    .data(fifo_data),
    .rdclk(clk_49_MHz),
    .rdreq(fifo_rdreq),
    .wrclk(clk_199_MHz),
    .wrreq(fifo_wrreq),
    .q(fifo_q),
    .rdempty(fifo_rdempty),
    .wrfull(fifo_wrfull)
);

receiver #(
    .IDLE_CYCLES(RECEIVER_IDLE_CYCLES)
) u_receiver (
    .clk(clk_49_MHz),
    .rst_n,

    .fifo_req(fifo_rdreq),
    .fifo_empty(fifo_rdempty),
    .fifo_q(fifo_q),

    .rdata(receiver_rdata)
);

endmodule
