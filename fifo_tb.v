module tb();
  reg clk=0, rst,wr_en,rd_en;
  reg [7:0]wr_data;
  wire [7:0]rd_data;
  wire full,empty;
  fifo f0 (clk, rst,wr_en,rd_en,wr_data,rd_data,full,empty);
  
  task reset();
    @(negedge clk) rst=1;
    @(negedge clk) rst=0;
  endtask
  
  task write ();
    @(negedge clk) wr_en=1; wr_data=$random;
    @(negedge clk) wr_en=0;
  endtask
  
  task read();
    @(negedge clk) rd_en=1;
    @(negedge clk) rd_en=0;
  endtask 
  
  initial
    begin
      reset();
      repeat(10)write();
      repeat(10) read();
    end
  
   always
     begin
       #5 clk=~clk;
     end
  initial #500 $finish;
  
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #10000 
  $finish;
end
endmodule
