// Design: Synchronizer
module synchronizer #(parameter WIDTH=3)(
    input clk,
    input rst,
    input [WIDTH:0] d_in,
    output reg [WIDTH:0] d_out
);
  reg [WIDTH:0] q1;

  always @(posedge clk) begin
    if (!rst) begin
      q1 <= 0;
      d_out <= 0;
    end else begin
      q1 <= d_in;
      d_out <= q1;  // 1-clock cycle delayed output
    end
  end
endmodule

