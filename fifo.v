module fifo(input clk, rst,wr_en,rd_en,input [7:0]wr_data,output reg [7:0]rd_data,output reg full,empty);
  int i=0;
  reg [3:0]wr_ptr=0,rd_ptr;
  reg [7:0]mem[7:0];
  
  //1. RST
  always @(posedge clk)
    begin
      if(rst==1)
        begin
      	for(i=0;i<=7;i=i+1)mem[i]=0;
      		wr_ptr=0;
      		rd_ptr=0;
        end
    end
  //2. WRITE (Sent=>put=>PUSH)
  always @(posedge clk)
    begin
      if(wr_en==1 && full!=1)
        begin
        mem[wr_ptr[2:0]]=wr_data;
         wr_ptr=wr_ptr+1;
        end
    end
  //3. READ (rcv=>get=>POP)
  always@(posedge clk)
    begin
      if(rd_en==1 && empty!=1)
        begin
        rd_data=mem[rd_ptr[2:0]];
        rd_ptr=rd_ptr+1;
        end
    end
  //4. FULL
  assign full=((wr_ptr-rd_ptr )==8)?1:0;
  //5. EMPTY
  assign empty=(wr_ptr==rd_ptr)?1:0;
endmodule
