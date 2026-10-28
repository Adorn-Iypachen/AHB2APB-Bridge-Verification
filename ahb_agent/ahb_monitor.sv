class ahb_monitor extends uvm_monitor;

	`uvm_component_utils(ahb_monitor)

	virtual ahb_apb_if.AHB_MON_MP vif;

	ahb_agt_config m_cfg;

	uvm_analysis_port #(ahb_xtn) monitor_port;

	extern function new(string name="ahb_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase (uvm_phase phase);
	extern task collect_data();
endclass

function ahb_monitor::new(string name="ahb_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port = new("monitor_port",this);
endfunction

function void ahb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(ahb_agt_config)::get(this,"","ahb_agt_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction

function void ahb_monitor::connect_phase(uvm_phase phase);
	vif = m_cfg.vif;
endfunction

task ahb_monitor::run_phase(uvm_phase phase);
        while(!vif.ahb_mon_cb.Hreadyout)
        @(vif.ahb_mon_cb);

	forever
		collect_data();
endtask

task ahb_monitor::collect_data();
	ahb_xtn xtn;
	xtn=ahb_xtn::type_id::create("xtn");
//        @(vif.ahb_mon_cb);
//       wait(vif.ahb_mon_cb.Hreadyout)

	while(vif.ahb_mon_cb.Htrans !== 2'b10 && vif.ahb_mon_cb.Htrans !== 2'b11)
        @(vif.ahb_mon_cb);
	xtn.Haddr = vif.ahb_mon_cb.Haddr;
	xtn.Htrans = vif.ahb_mon_cb.Htrans;
	xtn.Hsize = vif.ahb_mon_cb.Hsize;
	xtn.Hwrite = vif.ahb_mon_cb.Hwrite;
//	xtn.Hburst = vif.ahb_mon_cb.Hburst;

	@(vif.ahb_mon_cb);
//	wait(vif.ahb_mon_cb.Hreadyout)
        while(!vif.ahb_mon_cb.Hreadyout)
        @(vif.ahb_mon_cb);
	if (vif.ahb_mon_cb.Hwrite==1'b1)
		xtn.Hwdata = vif.ahb_mon_cb.Hwdata;
	else
		xtn.Hrdata = vif.ahb_mon_cb.Hrdata;

`uvm_info("AHB_MONITOR",$sformatf("printing from monitor \n %s",xtn.sprint()),UVM_LOW)

monitor_port.write(xtn);

endtask

