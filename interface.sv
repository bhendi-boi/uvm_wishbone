interface wb_if(
    input logic clk
);
    // logic clk;
    logic we;
    logic strb;
    logic rst;
    logic [7:0] addr;
    logic [7:0] wdata;
    logic [7:0] rdata;
    logic ack;
endinterface
