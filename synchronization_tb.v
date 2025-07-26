// Testbench
module tb;
  parameter WIDTH = 3;
  reg clk = 0, rst;
  reg [WIDTH:0] d_in;
  wire [WIDTH:0] d_out;

  // Instantiate DUT
  synchronizer #(WIDTH) sync (
    .clk(clk),
    .rst(rst),
    .d_in(d_in),
    .d_out(d_out)
  );

  // Clock generation
  always #5 clk = ~clk;  // 10 ns period

  // Stimulus
  initial begin
    rst = 0; d_in = 0;
    #12 rst = 1;         // Assert reset at 12 ns
    #10 d_in = 5;
    #10 d_in = 6;
    #10 d_in = 7;
    #10 d_in = 8;
    #10 d_in = 9;
    #100 $finish;
  end

  // Waveform generation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end
endmodule
