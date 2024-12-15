class driver extends uvm_driver #(transaction);
    `uvm_component_utils(driver)

    transaction   tr;
    virtual wb_if vif;

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual wb_if)::get(this, "*", "vif", vif)) begin
            `uvm_fatal("Driver", "Couldn't access interface")
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        tr = transaction::type_id::create("tr");

        forever begin
            seq_item_port.get_next_item(tr);
            drive(tr);
            /* `uvm_info("Driver", "----------------------------\n\n", UVM_NONE) */
            `uvm_info("Driver", "Drove a transaction", UVM_NONE)
            tr.print();
            seq_item_port.item_done();
        end
    endtask

    task drive(transaction tr);
        if (tr.rst) begin
            @(posedge vif.clk);
            vif.rst <= tr.rst;
        end else begin
            if (tr.we) begin
                @(posedge vif.clk);
                vif.rst <= 1'b0;
                vif.we <= tr.we;
                vif.strb <= 1'b1;
                vif.addr <= tr.addr;
                vif.wdata <= tr.wdata;
                @(posedge vif.ack);
                @(posedge vif.clk);
                vif.strb <= 1'b0;
            end else begin
                @(posedge vif.clk);
                vif.rst <= 1'b0;
                vif.we  <= tr.we;
                @(posedge vif.clk);
                vif.strb <= 1'b1;
                vif.addr <= tr.addr;
                @(posedge vif.ack);
                @(posedge vif.clk);
                vif.strb <= 1'b0;
            end
        end
    endtask

endclass
