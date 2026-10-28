class apb_agent extends uvm_agent;

        `uvm_component_utils(apb_agent)
       
        apb_agt_config m_cfg;

        apb_monitor apb_monh;
        apb_sequencer apb_seqrh;
        apb_driver apb_drvh;

        extern function new(string name="apb_agent",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass

function apb_agent::new(string name="apb_agent",uvm_component parent);
        super.new(name,parent);
endfunction

function void apb_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(apb_agt_config)::get(this,"","apb_agt_config",m_cfg))
                `uvm_fatal("CONFIG","cannot get m_cfg from uvm_config_db.")
        apb_monh=apb_monitor::type_id::create("apb_monh",this);
        if(m_cfg.is_active==UVM_ACTIVE)
        begin
                apb_drvh=apb_driver::type_id::create("apb_drvh",this);
                apb_seqrh=apb_sequencer::type_id::create("apb_seqrh",this);
        end

endfunction

function void apb_agent::connect_phase(uvm_phase phase);
        if(m_cfg.is_active==UVM_ACTIVE)
        begin
                apb_drvh.seq_item_port.connect(apb_seqrh.seq_item_export);
        end
endfunction

