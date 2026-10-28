class apb_driver extends uvm_driver#(apb_xtn);

        `uvm_component_utils(apb_driver)

        virtual ahb_apb_if.APB_DR_MP vif;

        apb_agt_config m_cfg;

        extern function new(string name="apb_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(apb_xtn xtn);

endclass

function apb_driver::new(string name="apb_driver",uvm_component parent);
        super.new(name,parent);
endfunction

function void apb_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(apb_agt_config)::get(this,"","apb_agt_config",m_cfg))
                `uvm_fatal("DRIVER","cannot get m_cfg from uvm_config_db.Have you set() it?")
endfunction

function void apb_driver::connect_phase(uvm_phase phase);
	vif =m_cfg.vif;
endfunction

task apb_driver::run_phase(uvm_phase phase);
	req=apb_xtn::type_id::create("req",this);

	forever
		begin
			send_to_dut(req);
		end
endtask

task apb_driver::send_to_dut(apb_xtn xtn);

	wait(!vif.apb_drv_cb.Pselx==0);
	if(vif.apb_drv_cb.Pwrite==0)
	begin
		wait(vif.apb_drv_cb.Penable==1'b1);
		vif.apb_drv_cb.Prdata <= {$random};
	end
	
	repeat(2)
	@(vif.apb_drv_cb);

	`uvm_info("APB_DRIVER",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
endtask

