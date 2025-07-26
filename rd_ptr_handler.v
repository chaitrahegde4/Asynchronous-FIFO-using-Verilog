module rd_ptr_handler #(parameter W=3)(
  input rd_clk, rd_en, rd_rst,
  input [W:0] g_wr_ptr_sync,
  output reg [W:0] b_rd_ptr, g_rd_ptr,
  output reg empty
);

  wire [W:0] b_rd_ptr_next, g_rd_ptr_next;
  wire rd_empty;

  // Next Pointer Logic
  assign b_rd_ptr_next = b_rd_ptr + (rd_en && !empty);

  // Sequential Logic
  always @(posedge rd_clk) begin
    if (rd_rst) begin
      b_rd_ptr = 0;
      g_rd_ptr = 0;
    end else begin
      b_rd_ptr = b_rd_ptr_next;
      g_rd_ptr = g_rd_ptr_next;
    end
  end

  // Binary to Gray Conversion
  assign g_rd_ptr_next = (b_rd_ptr_next >> 1) ^ b_rd_ptr_next;

  // Empty Detection
  assign rd_empty = (g_wr_ptr_sync == g_rd_ptr);

  // Empty Flag
  always @(posedge rd_clk) begin
    if (rd_rst)
      empty <= 0;
    else
      empty <= rd_empty;
  end

endmodule
