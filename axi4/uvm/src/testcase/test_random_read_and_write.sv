`ifndef TEST_RANDOM_READ_AND_WRITE__SV
`define TEST_RANDOM_READ_AND_WRITE__SV

class test_random_read_and_write_sequence extends uvm_sequence #(axi_transaction);
    `uvm_object_utils(test_random_read_and_write_sequence)

    axi_transaction tr;

    function new(string name = "test_random_read_and_write");
        super.new(name);
    endfunction

    virtual task body();
        if (starting_phase != null)
            starting_phase.raise_objection(this);

        for (int i = 0; i < 10000; i++) begin
            `uvm_do_with(tr, {
                tr.tr_type == axi_transaction::READ || tr.tr_type == axi_transaction::WRITE;
                tr.addr[2:0] == 0;
                tr.addr < (32'd1 << 10);
                tr.addr > 0;
                tr.len > 0;
                tr.len < 8'd16;
            })

            `uvm_send(tr)
        end

        #100
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass


class test_random_read_and_write extends base_test;
    `uvm_component_utils(test_random_read_and_write)

    function new(string name = "test_random_read_and_write", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(uvm_object_wrapper)::set(this,
                                                "env.axi_agent.sqr.main_phase",
                                                "default_sequence",
                                                test_random_read_and_write_sequence::type_id::get());
    endfunction
endclass

`endif