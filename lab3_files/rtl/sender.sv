/**
 * Module name:    sender
 * Creation date:  2022.12.14
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

module sender (
    input logic        clk,
    input logic        rst_n,

    input logic        trigger,

    output logic       fifo_req,
    output logic [7:0] fifo_data,
    input logic        fifo_full,
    input logic        fifo_empty
);


/**
 * User defined types and constants
 */

typedef enum logic {
    IDLE,
    ACTIVE
} state_t;


/**
 * Local variables and signals
 */

state_t     state, state_nxt;

logic [3:0] counter, counter_nxt;


/**
 * Module internal logic
 */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        counter <= 8'b0;
    end else begin
        state <= state_nxt;
        counter <= counter_nxt;
    end
end

always_comb begin
    state_nxt = state;
    counter_nxt = counter;

    case (state)
    IDLE: begin
        if (trigger)
            state_nxt = ACTIVE;
    end
    ACTIVE: begin
        if (counter == 15) begin
            counter_nxt = 8'b0;
            state_nxt = IDLE;
        end else begin
            if (!fifo_full)
                counter_nxt = counter + 1;
        end
    end
    endcase
end

always_comb begin
    fifo_req = state == ACTIVE;
    fifo_data = counter;
end

endmodule
