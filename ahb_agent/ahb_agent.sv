class ahb_agent extends uvm_agent;

	`uvm_component_utils(ahb_agent)
	
	ahb_agt_config m_cfg;

	ahb_monitor ahb_monh;
	ahb_sequencer ahb_seqrh;
	ahb_driver ahb_drvh;

	extern function new(string name="ahb_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function ahb_agent::new(string name="ahb_agent",uvm_component parent);
	super.new(name,parent);
endfunction


function void ahb_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(ahb_agt_config)::get(this,"","ahb_agt_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get m_cfg from uvm_config_db.have you set() it?")
	ahb_monh=ahb_monitor::type_id::create("ahb_monh",this);
	if(m_cfg.is_active==UVM_ACTIVE)
	begin
		ahb_drvh=ahb_driver::type_id::create("ahb_drvh",this);
		ahb_seqrh=ahb_sequencer::type_id::create("ahb_seqrh",this);
	end
endfunction


function void ahb_agent::connect_phase(uvm_phase phase);
	if(m_cfg.is_active==UVM_ACTIVE)
	begin
		ahb_drvh.seq_item_port.connect(ahb_seqrh.seq_item_export);
	end
endfunction

