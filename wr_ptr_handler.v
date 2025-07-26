module wr_ptr_handler #(parameter W=3)(
  input wr_clk, wr_en, wr_rst,
  input [W:0] g_rd_ptr_sync,
  output reg [W:0] b_wr_ptr, g_wr_ptr,
  output reg full
);

  wire wr_full;
  wire [W:0] b_wr_ptr_next, g_wr_ptr_next;

  // Next Pointer Logic
  assign b_wr_ptr_next = b_wr_ptr + (wr_en && !full);

  // Sequential Logic
  always @(posedge wr_clk) begin
    if (wr_rst) begin
      b_wr_ptr = 0;
      g_wr_ptr = 0;
    end else begin
      b_wr_ptr = b_wr_ptr_next;
      g_wr_ptr = g_wr_ptr_next;
    end
  end

  // Binary to Gray Conversion
  assign g_wr_ptr_next = (b_wr_ptr_next >> 1) ^ b_wr_ptr_next;

  // Full Detection
  assign wr_full = (g_wr_ptr == {~g_rd_ptr_sync[W:W-1], g_rd_ptr_sync[W-2:0]});

  // Full Flag
  always @(posedge wr_clk)
    begin
      if (wr_rst)
        full <= 0;
      else
        full <= wr_full;
    end

endmodule
