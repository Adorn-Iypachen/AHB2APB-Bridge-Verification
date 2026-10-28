class ahb_agt_top extends uvm_env;

	`uvm_component_utils(ahb_agt_top)

	ahb_agent agnth[];
	
	env_config m_cfg;

	extern function new(string name ="ahb_agt_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass

function ahb_agt_top::new(string name="ahb_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_agt_top::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","not able to get configuration")
	
	agnth = new[m_cfg.no_of_ahb_agent];
	foreach(agnth[i])
		begin
			agnth[i]=ahb_agent::type_id::create($sformatf("agnth[%0d]",i),this);
			uvm_config_db#(ahb_agt_config)::set(this,$sformatf("agnth[%0d]*",i),"ahb_agt_config",m_cfg.ahb_cfg[i]);
		end
endfunction

