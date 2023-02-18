
module ctrl(

    input   clk
    ,input  rst

    ,output [4:0]   rom_addr
    ,output         rom_rd
    ,input  [31:0]  rom_data

    ,output         mem_a_rd
    ,output [4:0]   mem_a_addr
    ,output         mem_b_rd
    ,output [4:0]   mem_b_addr
    ,output         mem_c_wr
    ,output [4:0]   mem_c_addr

    ,output [7:0]   ops

);



typedef enum{IDLE,IP,DECODE,DECODE_WAIT,MEMRD,MEMRD_WAIT,EXEC,STORE} _F_CTRL;
_F_CTRL f_ctrl;


reg [4:0] ip;


always @(posedge clk) begin
	if(rst)begin
      f_ctrl <= IDLE;
      ip <= 'h0;
	end
	else begin
      case (f_ctrl)
         IDLE:begin
			if(ip < 5'b00010)begin
				f_ctrl <= IP;
				ip <= ip + 1;
			end
         end
         IP:begin
            f_ctrl <= DECODE_WAIT;
         end
         DECODE_WAIT:begin
            f_ctrl <= DECODE;
         end
         DECODE:begin
            f_ctrl <= MEMRD_WAIT;
         end
         MEMRD_WAIT:begin
            f_ctrl <= MEMRD;
         end
         MEMRD:begin
            f_ctrl <= EXEC;
         end
         EXEC:begin
            f_ctrl <= STORE;
         end
         STORE:begin
            f_ctrl <= IDLE;
         end
         default:begin
            f_ctrl <= IDLE;
         end
      endcase
   end
end


assign rom_rd 	= (IP == f_ctrl);
assign rom_addr	= ip;

assign mem_c_addr   = rom_data[20:16];
assign mem_c_wr     = (STORE == f_ctrl);

assign mem_a_addr   = rom_data[12:8];
assign mem_b_addr   = rom_data[4:0];

assign mem_a_rd     = (MEMRD_WAIT == f_ctrl);
assign mem_b_rd     = (MEMRD_WAIT == f_ctrl);

assign ops          = rom_data[31:24];



endmodule
