`ifndef SIMPLEBUS_MASTER_AGENT__SV
`define SIMPLEBUS_MASTER_AGENT__SV

`include "simplebus/master_agent/simplebus_master_driver.sv"
`include "simplebus/master_agent/simplebus_master_sequencer.sv"

class simplebus_master_agent extends uvm_agent;
    simplebus_master_sequencer sqr;
    simplebus_master_driver drv;
    // bus_monitor mon;

    // uvm_analysis_port #(bus_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (is_active == UVM_ACTIVE) begin
            `uvm_info(get_type_name(), "ACTIVE", UVM_MEDIUM)
            sqr = simplebus_master_sequencer::type_id::create("sqr", this);
            drv = simplebus_master_driver::type_id::create("drv", this);
        end
        // mon = bus_monitor::type_id::create("mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(sqr.seq_item_export);
        end
        // ap = mon.ap;
    endfunction

    `uvm_component_utils(simplebus_master_agent)
endclass;

`endif
