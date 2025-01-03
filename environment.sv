class environment extends uvm_env;
    `uvm_component_utils(environment)

    agent agnt;
    scoreboard scb;
    coverage cvg;

    function new(string name = "environment", uvm_component parent);
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb  = scoreboard::type_id::create("scb", this);
        agnt = agent::type_id::create("agnt", this);
        cvg  = coverage::type_id::create("cvg", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agnt.mon.monitor_port.connect(scb.scoreboard_port);
        agnt.mon.monitor_port.connect(cvg.coverage_port);
    endfunction

endclass
