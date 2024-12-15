class coverage extends uvm_subscriber #(transaction);
    `uvm_component_utils(coverage)

    uvm_analysis_imp #(transaction, coverage) coverage_port;

    transaction item;
    covergroup func;
        option.per_instance = 1;
        option.auto_bin_max = 8;

        addr: coverpoint item.addr;
        din: coverpoint item.wdata;
        dout: coverpoint item.rdata;
        r_w: coverpoint item.we {bins read = {0}; bins write = {1};}
        read_all: cross r_w, addr{ignore_bins write = binsof (r_w.write);}
        write_all: cross r_w, addr{ignore_bins read = binsof (r_w.read);}
    endgroup

    function new(string name = "coverage", uvm_component parent);
        super.new(name, parent);
        func = new();
        `uvm_info("Coverage", "Constructor Coverage", UVM_MEDIUM)
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = transaction::type_id::create("tr");
        coverage_port = new("coverage_port", this);
    endfunction

    function void write(transaction t);
        item = t;
        func.sample();
    endfunction

endclass
