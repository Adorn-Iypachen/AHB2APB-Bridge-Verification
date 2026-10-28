class ahb_apb_env extends uvm_env;

	`uvm_component_utils(ahb_apb_env)

	ahb_agt_top ahb_top;
	apb_agt_top apb_top;

	virtual_sequencer v_sequencer;

	scoreboard sb;

	env_config m_cfg;

	extern function new(string name="ahb_apb_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function ahb_apb_env::new(string name="ahb_apb_env",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_apb_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db.have you set it?")

	if(m_cfg.has_ahb_agent)
		begin
			ahb_top = ahb_agt_top::type_id::create("ahb_top",this);
		end

	if(m_cfg.has_apb_agent)
		begin
			apb_top = apb_agt_top::type_id::create("apb_top",this);
		end

	if(m_cfg.has_virtual_sequencer)
		begin
			v_sequencer= virtual_sequencer::type_id::create("v_sequencer",this);
		end

	if(m_cfg.has_scoreboard)
		begin
			sb=scoreboard::type_id::create("sb",this);
		end
endfunction

function void ahb_apb_env::connect_phase(uvm_phase phase);
	if(m_cfg.has_virtual_sequencer)
		begin
			if(m_cfg.has_ahb_agent)
				begin
					for(int i=0;i<m_cfg.no_of_ahb_agent;i++)
					begin
						v_sequencer.ahb_seqrh[i]= ahb_top.agnth[i].ahb_seqrh;
					end
				end
			if(m_cfg.has_apb_agent)
                                begin
                                        for(int i=0;i<m_cfg.no_of_apb_agent;i++)
                                        begin
                                                v_sequencer.apb_seqrh[i]= apb_top.agnth[i].apb_seqrh;
                                        end
                                end
		end
	if(m_cfg.has_scoreboard)
		begin
			if(m_cfg.has_ahb_agent)
				begin
					foreach(m_cfg.ahb_cfg[i])
						begin
							ahb_top.agnth[i].ahb_monh.monitor_port.connect(sb.fifo_ahb[i].analysis_export);
						end
				end
			if(m_cfg.has_apb_agent)
                                begin
                                        foreach(m_cfg.apb_cfg[i])
                                                begin
                                                        apb_top.agnth[i].apb_monh.monitor_port.connect(sb.fifo_apb[i].analysis_export);
                                                end
                                end
		end
endfunction

