class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    // inputs
    rand logic we;
    logic strb;
    rand logic rst;
    randc logic [7:0] addr;
    rand logic [7:0] wdata;

    // output
    logic ack;
    logic [7:0] rdata;

    function new(string name = "transaction");
        super.new(name);
    endfunction

    // constraint write_tr {we == 1;}
    // constraint read_tr {we == 0;}

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("Reset", rst, 1, UVM_HEX);
        printer.print_field_int("Write/Read", we, 1, UVM_HEX);
        printer.print_field_int("Address", addr, 8, UVM_HEX);
        printer.print_field_int("Write Data", wdata, 8, UVM_HEX);
        printer.print_field_int("Read Data", rdata, 8, UVM_HEX);
    endfunction

endclass
