class rand_read_seq extends uvm_sequence;
    `uvm_object_utils(rand_read_seq)

    int no_of_tr;
    transaction tr;

    function new(string name = "rand_read_seq");
        super.new(name);
    endfunction


    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            `uvm_do_with(tr, {we == 0; rst == 0;});
        end
    endtask

endclass

class rand_write_seq extends uvm_sequence;
    `uvm_object_utils(rand_write_seq)

    int no_of_tr;
    transaction tr;

    function new(string name = "rand_write_seq");
        super.new(name);
    endfunction


    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            `uvm_do_with(tr, {we == 1; rst == 0;});
        end
    endtask

endclass

class reset_seq extends uvm_sequence;
    `uvm_object_utils(reset_seq)

    transaction tr;

    function new(string name = "reset_seq");
        super.new(name);
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        `uvm_do_with(tr, {rst == 1;});
    endtask

endclass

class directed_write_seq extends uvm_sequence;
    `uvm_object_utils(directed_write_seq)

    int no_of_tr, i;
    transaction tr;

    function new(string name = "directed_write_seq");
        super.new(name);
    endfunction


    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        i  = 0;
        for (; i < no_of_tr; i++) begin
            `uvm_do_with(tr, {we == 1; rst == 0; addr==i;});
        end
    endtask

endclass
