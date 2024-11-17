class environment extends uvm_env;
    `uvm_component_utils(environment)

    agent agnt;

    function new(string name="environment", uvm_component parent);
        super.new(name,parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agnt = agent::type_id::create("agnt",this);
    endfunction

endclass
