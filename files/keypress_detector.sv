/**
 * Module name:    keypress_detector
 * Creation date:  2022.12.02
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

module keypress_detector #(
    DEBOUNCE_TIME = 10_000_000
) (
    input logic  clk,
    input logic  rst_n,

    output logic keypress_detected,
    input logic  din
);


/**
 * User defined types and constants
 */

typedef enum logic [1:0] {
    WAITING_FOR_PRESS,
    PRESS_DEBOUNCING,
    WAITING_FOR_RELEASE,
    RELEASE_DEBOUNCING
} state_t;


/**
 * Local variables and signals
 */

state_t      state, state_nxt;

logic [31:0] counter, counter_nxt;
logic        keypress_detected_nxt;


/**
 * Module internal logic
 */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= WAITING_FOR_PRESS;
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
    WAITING_FOR_PRESS: begin
        if (~din)
            state_nxt = PRESS_DEBOUNCING;
    end
    PRESS_DEBOUNCING: begin
        if (counter == DEBOUNCE_TIME - 1) begin
            counter_nxt = 8'b0;
            state_nxt = WAITING_FOR_RELEASE;
        end else begin
            counter_nxt = counter + 1;
        end
    end
    WAITING_FOR_PRESS: begin
        if (din)
            state_nxt = WAITING_FOR_RELEASE;
    end
    WAITING_FOR_RELEASE: begin
        if (counter == DEBOUNCE_TIME - 1) begin
            counter_nxt = 8'b0;
            state_nxt = WAITING_FOR_PRESS;
        end else begin
            counter_nxt = counter + 1;
        end
    end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        keypress_detected <= 1'b0;
    else
        keypress_detected <= keypress_detected_nxt;
end

always_comb begin
    keypress_detected_nxt = 1'b0;

    case (state)
    WAITING_FOR_PRESS: begin
        if (~din)
            keypress_detected_nxt = 1'b1;
    end
    PRESS_DEBOUNCING: ;
    WAITING_FOR_PRESS: ;
    WAITING_FOR_RELEASE: ;
    endcase
end

endmodule
