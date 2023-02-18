/**
 * Module name:    receiver
 * Creation date:  2022.12.14
 * Author:         Pawel Skrzypiec <pawel.skrzypiec@intel.com>
 * Co-authored by:
 */

 module receiver #(
    IDLE_CYCLES = 1
 ) (
    input logic        clk,
    input logic        rst_n,

    output logic       fifo_req,
    input logic        fifo_empty,
    input logic [7:0]  fifo_q,

    output logic [7:0] rdata
);


/**
 * User defined types and constants
 */

typedef enum logic {
    ACTIVE,
    IDLE
} state_t;


/**
 * Local variables and signals
 */

state_t      state, state_nxt;

logic [31:0] counter, counter_nxt;
logic [7:0]  rdata_nxt;
logic        fifo_req_nxt;


/**
 * Module internal logic
 */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= ACTIVE;
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
    ACTIVE: begin
        if (!fifo_empty)
            state_nxt = IDLE;
    end
    IDLE: begin
        if (counter == IDLE_CYCLES - 1) begin
            counter_nxt = 8'b0;
            state_nxt = ACTIVE;
        end else begin
            counter_nxt = counter + 1;
        end
    end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        fifo_req <= 1'b0;
        rdata <= 8'b0;
    end else begin
        fifo_req <= fifo_req_nxt;
        rdata <= rdata_nxt;
    end
end

always_comb begin
    fifo_req_nxt = 1'b0;
    rdata_nxt = fifo_q;

    case (state)
    ACTIVE: begin
        if (!fifo_empty)
            fifo_req_nxt = 1'b1;
    end
    IDLE: ;
    endcase
end

endmodule
