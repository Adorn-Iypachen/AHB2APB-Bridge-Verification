class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(virtual_sequence)

	ahb_sequencer ahb_seqrh[];
	apb_sequencer apb_seqrh[];
	
	virtual_sequencer vseqrh;


	// env configuration handle
	env_config m_cfg;

//methods
	extern function new(string name="virtual_sequence");
	extern task body();
endclass


//constructor
function virtual_sequence::new(string name="virtual_sequence");
	super.new(name);
endfunction

//task body
task virtual_sequence::body();
	if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get m_cfg from uvm_config_db.have you set it?")

	ahb_seqrh =new[m_cfg.no_of_ahb_agent];
	apb_seqrh = new[m_cfg.no_of_apb_agent];

	assert($cast(vseqrh,m_sequencer))
	else
		begin
			`uvm_error("BODY", "ERROR in $cast of virtual sequencer")
		end
	foreach(ahb_seqrh[i])
		ahb_seqrh[i] = vseqrh.ahb_seqrh[i];
	foreach(apb_seqrh[i])
		apb_seqrh[i]= vseqrh.apb_seqrh[i];
endtask

//------------------------------single sequence --------------------------------

class virtual_single_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_single_sequence)

        single_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_single_sequence");
        extern task body();
endclass


//constructor
function virtual_single_sequence::new(string name="virtual_single_sequence");
        super.new(name);
endfunction

        //task body
task virtual_single_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = single_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------unspecified sequence --------------------------------

class virtual_unspecified_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_unspecified_sequence)

        unspecified_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_unspecified_sequence");
        extern task body();
endclass


//constructor
function virtual_unspecified_sequence::new(string name="virtual_unspecified_sequence");
        super.new(name);
endfunction

        //task body
task virtual_unspecified_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = unspecified_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------WRAP4 sequence --------------------------------

class virtual_wrap4_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_wrap4_sequence)

        wrap4_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_wrap4_sequence");
        extern task body();
endclass


//constructor
function virtual_wrap4_sequence::new(string name="virtual_wrap4_sequence");
        super.new(name);
endfunction

        //task body
task virtual_wrap4_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = wrap4_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------INCR4 sequence --------------------------------

class virtual_incr4_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_incr4_sequence)

        incr4_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_incr4_sequence");
        extern task body();
endclass


//constructor
function virtual_incr4_sequence::new(string name="virtual_incr4_sequence");
        super.new(name);
endfunction

        //task body
task virtual_incr4_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = incr4_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------WRAP8 sequence --------------------------------

class virtual_wrap8_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_wrap8_sequence)

        wrap8_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_wrap8_sequence");
        extern task body();
endclass


//constructor
function virtual_wrap8_sequence::new(string name="virtual_wrap8_sequence");
        super.new(name);
endfunction

        //task body
task virtual_wrap8_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = wrap8_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------INCR8 sequence --------------------------------

class virtual_incr8_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_incr8_sequence)

        incr8_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_incr8_sequence");
        extern task body();
endclass


//constructor
function virtual_incr8_sequence::new(string name="virtual_incr8_sequence");
        super.new(name);
endfunction

        //task body
task virtual_incr8_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = incr8_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------WRAP16 sequence --------------------------------

class virtual_wrap16_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_wrap16_sequence)

        wrap16_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_wrap16_sequence");
        extern task body();
endclass


//constructor
function virtual_wrap16_sequence::new(string name="virtual_wrap16_sequence");
        super.new(name);
endfunction

        //task body
task virtual_wrap16_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = wrap16_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end


endtask

//------------------------------INCR16 sequence --------------------------------

class virtual_incr16_sequence extends virtual_sequence;

        `uvm_object_utils(virtual_incr16_sequence)

        incr16_seq ahb_xtns;


        //methods
        extern function new(string name="virtual_incr16_sequence");
        extern task body();
endclass


//constructor
function virtual_incr16_sequence::new(string name="virtual_incr16_sequence");
        super.new(name);
endfunction

        //task body
task virtual_incr16_sequence::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = incr16_seq::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end
endtask

////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
//------------------------------single sequence --------------------------------

class virtual_single_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_single_sequence1)

        single_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_single_sequence1");
        extern task body();
endclass


//constructor
function virtual_single_sequence1::new(string name="virtual_single_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_single_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = single_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------unspecified sequence --------------------------------

class virtual_unspecified_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_unspecified_sequence1)

        unspecified_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_unspecified_sequence1");
        extern task body();
endclass


//constructor
function virtual_unspecified_sequence1::new(string name="virtual_unspecified_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_unspecified_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = unspecified_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------WRAP4 sequence --------------------------------

class virtual_wrap4_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_wrap4_sequence1)

        wrap4_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_wrap4_sequence1");
        extern task body();
endclass


//constructor
function virtual_wrap4_sequence1::new(string name="virtual_wrap4_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_wrap4_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = wrap4_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------INCR4 sequence --------------------------------

class virtual_incr4_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_incr4_sequence1)

        incr4_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_incr4_sequence1");
        extern task body();
endclass


//constructor
function virtual_incr4_sequence1::new(string name="virtual_incr4_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_incr4_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = incr4_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------WRAP8 sequence --------------------------------

class virtual_wrap8_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_wrap8_sequence1)

        wrap8_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_wrap8_sequence1");
        extern task body();
endclass


//constructor
function virtual_wrap8_sequence1::new(string name="virtual_wrap8_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_wrap8_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = wrap8_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------INCR8 sequence --------------------------------

class virtual_incr8_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_incr8_sequence1)

        incr8_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_incr8_sequence1");
        extern task body();
endclass


//constructor
function virtual_incr8_sequence1::new(string name="virtual_incr8_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_incr8_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = incr8_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end

endtask

//------------------------------WRAP16 sequence --------------------------------

class virtual_wrap16_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_wrap16_sequence1)

        wrap16_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_wrap16_sequence1");
        extern task body();
endclass


//constructor
function virtual_wrap16_sequence1::new(string name="virtual_wrap16_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_wrap16_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = wrap16_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end


endtask

//------------------------------INCR16 sequence --------------------------------

class virtual_incr16_sequence1 extends virtual_sequence;

        `uvm_object_utils(virtual_incr16_sequence1)

        incr16_seq1 ahb_xtns;


        //methods
        extern function new(string name="virtual_incr16_sequence1");
        extern task body();
endclass


//constructor
function virtual_incr16_sequence1::new(string name="virtual_incr16_sequence1");
        super.new(name);
endfunction

        //task body
task virtual_incr16_sequence1::body();
        super.body();

        if(m_cfg.has_ahb_agent)
                begin
                        ahb_xtns = incr16_seq1::type_id::create("ahb_xtns");
                        ahb_xtns.start(ahb_seqrh[0]);
                end
endtask

