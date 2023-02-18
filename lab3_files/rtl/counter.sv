/**
 * Module name:    counter
 * Creation date:  2022.12.02
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

module counter #(
    COMPARE_VALUE = 2_000_000
) (
    input logic  clk,
    input logic  rst_n,

    output logic matched
);


/**
 * Local variables and signals
 */

logic [31:0] counter, counter_nxt;
logic        matched_nxt;


/**
 * Module internal logic
 */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 32'b0;
        matched <= 1'b0;
    end else begin
        counter <= counter_nxt;
        matched <= matched_nxt;
    end
end

always_comb begin
    counter_nxt = counter;
    matched_nxt = 1'b0;

    if (counter == COMPARE_VALUE - 1) begin
        counter_nxt = 32'b0;
        matched_nxt = 1'b1;
    end else begin
        counter_nxt = counter + 1;
    end
end

endmodule
