sequence strb_asserted;
    $rose(intf.strb);
endsequence

property signal_is_valid(signal);
    @(posedge intf.clk) disable iff(intf.rst) 
        intf.strb |-> !$isunknown(signal);
endproperty


we_is_valid_when_strb_is_asserted: assert property (signal_is_valid(intf.we))
	 `uvm_info("Assertions", "Passed: we is valid when strb is asserted", UVM_HIGH) 
	else `uvm_error("Assertions", "Failed: we is valid when strb is asserted")


addr_is_valid_when_strb_is_asserted: assert property (signal_is_valid(intf.addr))
	`uvm_info("Assertions", "Passed: addr is valid when strb is asserted", UVM_HIGH)
	else `uvm_error("Assertions", "Failed: addr is valid when strb is asserted")

property wdata_is_valid;
	@(posedge intf.clk) disable iff(intf.rst)
		intf.we |-> !$isunknown(intf.wdata);
endproperty

wdata_is_valid_when_we_is_asserted: assert property (wdata_is_valid)
	`uvm_info("Assertions", "Passed: wdata is valid", UVM_HIGH) 
	else `uvm_error("Assertions", "Failed: wdata is not valid when we is asserted")


// TODO:
// Read check rdata is valid after ack is asserted

property rdata_is_valid;
	$rose(intf.ack) |=> !$isunknown(intf.rdata);
endproperty

rdata_is_valid_after_ack_rises: assert property (rdata_is_valid)
	`uvm_info("Assertions", "Passed: rdata is valid", UVM_HIGH)
	else `uvm_error("Assertions", "Failed: rdata is not valid after ack rises")