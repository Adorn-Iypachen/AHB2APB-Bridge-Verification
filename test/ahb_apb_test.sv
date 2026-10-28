class ahb_apb_test extends uvm_test;

	`uvm_component_utils(ahb_apb_test)


	ahb_apb_env env;
	env_config e_cfg;
	ahb_agt_config ahb_cfg[];
	apb_agt_config apb_cfg[];


	bit has_ahb_agent = 1;
	bit has_apb_agent =1;
	int no_of_ahb_agent = 1;
	int no_of_apb_agent = 1;
	bit has_scoreboard=1;
	bit has_virtual_sequencer=1;

	extern function new(string name="ahb_apb_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
        extern function void end_of_elaboration_phase(uvm_phase phase);
	extern function void config_();
endclass


function ahb_apb_test::new(string name= "ahb_apb_test",uvm_component parent);
	super.new(name,parent);
endfunction


function void ahb_apb_test::config_();
	if(has_ahb_agent)
		begin
			ahb_cfg = new[no_of_ahb_agent];
			foreach(ahb_cfg[i])
				begin
					ahb_cfg[i]= ahb_agt_config::type_id::create($sformatf("ahb_cfg[%0d]",i));

					if(!uvm_config_db#(virtual ahb_apb_if)::get(this,"","vif",ahb_cfg[i].vif))
						`uvm_fatal("VIF CONFIG","cannot get() vif from uvm_config_db.have you set() it?")
					ahb_cfg[i].is_active=UVM_ACTIVE;
					e_cfg.ahb_cfg[i] = ahb_cfg[i];
				end
		end

        if(has_apb_agent)
                begin
                        apb_cfg = new[no_of_apb_agent];
                        foreach(apb_cfg[i])
                                begin
                                        apb_cfg[i]= apb_agt_config::type_id::create($sformatf("apb_cfg[%0d]",i));

                                        if(!uvm_config_db#(virtual ahb_apb_if)::get(this,"","vif",apb_cfg[i].vif))
                                                `uvm_fatal("VIF CONFIG","cannot get() vif from uvm_config_db.have you set() it?")
                                        apb_cfg[i].is_active=UVM_ACTIVE;
                                        e_cfg.apb_cfg[i] = apb_cfg[i];
                                end
                end

	e_cfg.has_apb_agent = has_apb_agent;
	e_cfg.has_ahb_agent = has_ahb_agent;
	e_cfg.no_of_apb_agent = no_of_apb_agent;
	e_cfg.no_of_ahb_agent = no_of_ahb_agent;
	e_cfg.has_scoreboard = has_scoreboard;
	e_cfg.has_virtual_sequencer = has_virtual_sequencer;
endfunction


function void ahb_apb_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	e_cfg = env_config::type_id::create("e_cfg");

	if(has_ahb_agent)
		begin
			e_cfg.ahb_cfg = new[no_of_ahb_agent];
		end

        if(has_apb_agent)
                begin
                        e_cfg.apb_cfg = new[no_of_apb_agent];
                end

	config_();
	uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
	env =ahb_apb_env::type_id::create("env",this);
endfunction

function void ahb_apb_test::end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology;
endfunction


//------------------------------------single test1-----------------------------------------

class ahb_apb_test0 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test0)

        virtual_single_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test0",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test0::new(string name="ahb_apb_test0",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test0::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test0::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_single_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#65;
                        phase.drop_objection(this);

endtask

//------------------------------------unspecified test1-----------------------------------------

class ahb_apb_test1 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test1)

        virtual_unspecified_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test1",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test1::new(string name="ahb_apb_test1",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test1::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test1::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_unspecified_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#65
                        phase.drop_objection(this);

endtask

//------------------------------------WRAP4 test-----------------------------------------

class ahb_apb_test2 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test2)

        virtual_wrap4_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test2",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test2::new(string name="ahb_apb_test2",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test2::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test2::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_wrap4_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#65
                        phase.drop_objection(this);

endtask

//------------------------------------INCR4 test-----------------------------------------

class ahb_apb_test3 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test3)

        virtual_incr4_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test3",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test3::new(string name="ahb_apb_test3",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test3::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test3::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_incr4_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#65
                        phase.drop_objection(this);

endtask

//------------------------------------WRAP8 test-----------------------------------------

class ahb_apb_test4 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test4)

        virtual_wrap8_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test4",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test4::new(string name="ahb_apb_test4",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test4::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test4::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_wrap8_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#65
                        phase.drop_objection(this);

endtask

//------------------------------------INCR8 test-----------------------------------------

class ahb_apb_test5 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test5)

        virtual_incr8_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test5",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test5::new(string name="ahb_apb_test5",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test5::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test5::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_incr8_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------WRAP16 test-----------------------------------------

class ahb_apb_test6 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test6)

        virtual_wrap16_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test6",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test6::new(string name="ahb_apb_test6",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test6::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test6::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_wrap16_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------INCR16 test-----------------------------------------

class ahb_apb_test7 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test7)

        virtual_incr16_sequence v_seqh;

        //methods
        extern function new(string name="ahb_apb_test7",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test7::new(string name="ahb_apb_test7",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test7::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test7::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_incr16_sequence::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------single test1-----------------------------------------

class ahb_apb_test8 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test8)

        virtual_single_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test8",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test8::new(string name="ahb_apb_test8",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test8::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test8::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_single_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85;
                        phase.drop_objection(this);

endtask

//------------------------------------unspecified test1-----------------------------------------

class ahb_apb_test9 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test9)

        virtual_unspecified_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test9",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test9::new(string name="ahb_apb_test9",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test9::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test9::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_unspecified_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------WRAP4 test-----------------------------------------

class ahb_apb_test10 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test10)

        virtual_wrap4_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test10",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test10::new(string name="ahb_apb_test10",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test10::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test10::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_wrap4_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------INCR4 test-----------------------------------------

class ahb_apb_test11 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test11)

        virtual_incr4_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test11",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test11::new(string name="ahb_apb_test11",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test11::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test11::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_incr4_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------WRAP8 test-----------------------------------------

class ahb_apb_test12 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test12)

        virtual_wrap8_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test12",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test12::new(string name="ahb_apb_test12",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test12::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test12::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_wrap8_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------INCR8 test-----------------------------------------

class ahb_apb_test13 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test13)

        virtual_incr8_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test13",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test13::new(string name="ahb_apb_test13",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test13::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test13::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_incr8_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------WRAP16 test-----------------------------------------

class ahb_apb_test14 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test14)

        virtual_wrap16_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test14",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test14::new(string name="ahb_apb_test14",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test14::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test14::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_wrap16_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

//------------------------------------INCR16 test-----------------------------------------

class ahb_apb_test15 extends ahb_apb_test;

        `uvm_component_utils(ahb_apb_test15)

        virtual_incr16_sequence1 v_seqh;

        //methods
        extern function new(string name="ahb_apb_test15",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

        //constructor
function ahb_apb_test15::new(string name="ahb_apb_test15",uvm_component parent);
        super.new(name,parent);
endfunction

        //build_phase
function void ahb_apb_test15::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

        //run phase
task ahb_apb_test15::run_phase(uvm_phase phase);
//      repeat(5)
                        phase.raise_objection(this);
                        v_seqh=virtual_incr16_sequence1::type_id::create("v_seqh");
                        v_seqh.start(env.v_sequencer);
			#85
                        phase.drop_objection(this);

endtask

