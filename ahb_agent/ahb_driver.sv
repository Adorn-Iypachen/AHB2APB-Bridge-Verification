class ahb_driver extends uvm_driver#(ahb_xtn);

	`uvm_component_utils(ahb_driver)

	virtual ahb_apb_if.AHB_DR_MP vif;

	ahb_agt_config m_cfg;

	extern function new(string name="ahb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(ahb_xtn xtn);	
endclass

function ahb_driver::new(string name="ahb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(ahb_agt_config)::get(this,"","ahb_agt_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get m_cfg from uvm_config_db.Have you set() it?")
endfunction

function void ahb_driver::connect_phase(uvm_phase phase);
	vif =m_cfg.vif;
endfunction

task ahb_driver::run_phase(uvm_phase phase);

	@(vif.ahb_drv_cb);
	vif.ahb_drv_cb.Hresetn <= 1'b0;
//	repeat(3)
	@(vif.ahb_drv_cb);
        vif.ahb_drv_cb.Hresetn <= 1'b1;

	forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
endtask

task ahb_driver::send_to_dut(ahb_xtn xtn);
//	wait(vif.ahb_drv_cb.Hreadyout ==1'b1)
        while(vif.ahb_drv_cb.Hreadyout !==1'b1)
        @(vif.ahb_drv_cb);
	vif.ahb_drv_cb.Htrans <= xtn.Htrans;
	vif.ahb_drv_cb.Haddr <= xtn.Haddr;
	vif.ahb_drv_cb.Hsize <= xtn.Hsize;
	vif.ahb_drv_cb.Hwrite <= xtn.Hwrite;
	vif.ahb_drv_cb.Hreadyin <= 1'b1;

        @(vif.ahb_drv_cb);
//	wait(vif.ahb_drv_cb.Hreadyout)
	while(vif.ahb_drv_cb.Hreadyout !==1'b1)
        @(vif.ahb_drv_cb);
         if (xtn.Hwrite==1'b1)
		vif.ahb_drv_cb.Hwdata <= xtn.Hwdata;
	else
		vif.ahb_drv_cb.Hwdata <= 32'b0;

	`uvm_info("AHB_DRIVER",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
endtask

