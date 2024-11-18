class rand_test extends uvm_test;
    `uvm_component_utils(rand_test)

    environment env;
    rand_write_seq rw;
    rand_read_seq rr;
    reset_seq rs;

    function new(string name = "rand_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env = environment::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        rs = reset_seq::type_id::create("rs");
        rw = rand_write_seq::type_id::create("rw");
        rw.set_no_of_tr(10);
        rr = rand_read_seq::type_id::create("rr");
        rr.set_no_of_tr(10);

        rs.start(env.agnt.seqr);
        rw.start(env.agnt.seqr);
        rr.start(env.agnt.seqr);
        #100;
        phase.drop_objection(this);
    endtask

endclass
