import uvm_pkg::*;

`include "uvm_macros.svh"
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "environment.sv"
`include "rand_test.sv"


module top ();

    logic clk;
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    wb_if intf (.clk(clk));

    mem_wb dut (
        .clk(intf.clk),
        .we(intf.we),
        .strb(intf.strb),
        .rst(intf.rst),
        .addr(intf.addr),
        .wdata(intf.wdata),
        .rdata(intf.rdata),
        .ack(intf.ack)
    );

    initial begin
        uvm_config_db#(virtual wb_if)::set(null, "*", "vif", intf);
        run_test("random_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end

endmodule
