class ahb_seq extends uvm_sequence #(ahb_xtn);

	`uvm_object_utils(ahb_seq)

        bit [31:0]haddr;
        bit hwrite;
        bit [2:0]hsize;
        bit [2:0] hburst;

	extern function new(string name="ahb_seq");

endclass

function ahb_seq::new(string name="ahb_seq");
	super.new(name);
endfunction

//---------------------------------single transfer--------------------------------//
class single_seq extends ahb_seq;

        `uvm_object_utils(single_seq)


        extern function new(string name="single_seq");
        extern task body();

endclass

function single_seq::new(string name="single_seq");
        super.new(name);
endfunction

task single_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b000;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

endtask

//---------------------------------INCR unspecified length----------------------------//
class unspecified_seq extends ahb_seq;

        `uvm_object_utils(unspecified_seq)

        extern function new(string name="unspecified_seq");
        extern task body();

endclass

function unspecified_seq::new(string name="unspecified_seq");
        super.new(name);
endfunction

task unspecified_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b001;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<req.length-1;i++)
        begin
                start_item(req);

/*                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 1'b1;});


                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});


                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});
        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------INCR4 transfer------------------------------//
class incr4_seq extends ahb_seq;

	`uvm_object_utils(incr4_seq)

	extern function new(string name="incr4_seq");
	extern task body();

endclass

function incr4_seq::new(string name="incr4_seq");
	super.new(name);
endfunction

task incr4_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b011;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

	for(int i=0;i<3;i++)
	begin
		start_item(req);
		
/*		if(hsize == 0)
			assert(req.randomize() with {Hsize == hsize;
						     Htrans == 2'b11;
						     Haddr == haddr + 1'b1;});
		
		if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});

		if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});
		haddr = req.Haddr;
		finish_item(req);
	end

endtask

//---------------------------------INCR8 transfer-------------------------------//
class incr8_seq extends ahb_seq;

        `uvm_object_utils(incr8_seq)

        extern function new(string name="incr8_seq");
        extern task body();

endclass

function incr8_seq::new(string name="incr8_seq");
        super.new(name);
endfunction

task incr8_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b101;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<7;i++)
        begin
                start_item(req);

/*                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 1'b1;});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
						     Hburst == hburst;
						     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});

        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------INCR16 transfer---------------------------------//
class incr16_seq extends ahb_seq;

        `uvm_object_utils(incr16_seq)

        extern function new(string name="incr16_seq");
        extern task body();

endclass

function incr16_seq::new(string name="incr16_seq");
        super.new(name);
endfunction

task incr16_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b111;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<15;i++)
        begin
                start_item(req);

/*                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 1'b1;});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});

	        haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------WRAP4 transfer----------------------------------//
class wrap4_seq extends ahb_seq;

        `uvm_object_utils(wrap4_seq)

        extern function new(string name="wrap4_seq");
        extern task body();

endclass

function wrap4_seq::new(string name="wrap4_seq");
        super.new(name);
endfunction

task wrap4_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b010;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<3;i++)
        begin
                start_item(req);

                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:2],haddr[1:0] + 1'b1};});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:3],haddr[2:0] + 2'b10};});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == {haddr[31:4],haddr[3:0] + 3'b100};});


        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------WRAP8 transfer---------------------------------//
class wrap8_seq extends ahb_seq;

        `uvm_object_utils(wrap8_seq)

        extern function new(string name="wrap8_seq");
        extern task body();

endclass

function wrap8_seq::new(string name="wrap8_seq");
        super.new(name);
endfunction

task wrap8_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b100;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<7;i++)
        begin
                start_item(req);

                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:3],haddr[2:0] + 1'b1};});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:4],haddr[3:0] + 2'b10};});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:5],haddr[4:0] + 3'b100};});


        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------WRAP16 transfer---------------------------------//
class wrap16_seq extends ahb_seq;

        `uvm_object_utils(wrap16_seq)

        extern function new(string name="wrap16_seq");
        extern task body();

endclass

function wrap16_seq::new(string name="wrap16_seq");
        super.new(name);
endfunction

task wrap16_seq::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b110;
                                     Htrans == 2'b10;
                                     Hwrite == 1;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<15;i++)
        begin
                start_item(req);

                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:4],haddr[3:0] + 1'b1};});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:5],haddr[4:0] + 2'b10};});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:6],haddr[5:0] + 3'b100};});

	        haddr = req.Haddr;
        	finish_item(req);
        end

endtask

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------single transfer--------------------------------//
class single_seq1 extends ahb_seq;

        `uvm_object_utils(single_seq1)


        extern function new(string name="single_seq1");
        extern task body();

endclass

function single_seq1::new(string name="single_seq1");
        super.new(name);
endfunction

task single_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b000;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

endtask

//---------------------------------INCR unspecified length----------------------------//
class unspecified_seq1 extends ahb_seq;

        `uvm_object_utils(unspecified_seq1)

        extern function new(string name="unspecified_seq1");
        extern task body();

endclass

function unspecified_seq1::new(string name="unspecified_seq1");
        super.new(name);
endfunction

task unspecified_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b001;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<req.length-1;i++)
        begin
                start_item(req);

/*                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 1'b1;});


                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});


                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});
        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------INCR4 transfer------------------------------//
class incr4_seq1 extends ahb_seq;

	`uvm_object_utils(incr4_seq1)

	extern function new(string name="incr4_seq1");
	extern task body();

endclass

function incr4_seq1::new(string name="incr4_seq1");
	super.new(name);
endfunction

task incr4_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b011;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

	for(int i=0;i<3;i++)
	begin
		start_item(req);
		
/*		if(hsize == 0)
			assert(req.randomize() with {Hsize == hsize;
						     Htrans == 2'b11;
						     Haddr == haddr + 1'b1;});
		
		if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});

		if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});
		haddr = req.Haddr;
		finish_item(req);
	end

endtask

//---------------------------------INCR8 transfer-------------------------------//
class incr8_seq1 extends ahb_seq;

        `uvm_object_utils(incr8_seq1)

        extern function new(string name="incr8_seq1");
        extern task body();

endclass

function incr8_seq1::new(string name="incr8_seq1");
        super.new(name);
endfunction

task incr8_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b101;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<7;i++)
        begin
                start_item(req);

/*                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 1'b1;});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
						     Hburst == hburst;
						     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});

        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------INCR16 transfer---------------------------------//
class incr16_seq1 extends ahb_seq;

        `uvm_object_utils(incr16_seq1)

        extern function new(string name="incr16_seq1");
        extern task body();

endclass

function incr16_seq1::new(string name="incr16_seq1");
        super.new(name);
endfunction

task incr16_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b111;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<15;i++)
        begin
                start_item(req);

/*                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 1'b1;});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 2'b10;});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Haddr == haddr + 3'b100;});
*/
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == haddr +(3'b001<<Hsize);});

	        haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------WRAP4 transfer----------------------------------//
class wrap4_seq1 extends ahb_seq;

        `uvm_object_utils(wrap4_seq1)

        extern function new(string name="wrap4_seq1");
        extern task body();

endclass

function wrap4_seq1::new(string name="wrap4_seq1");
        super.new(name);
endfunction

task wrap4_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b010;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<3;i++)
        begin
                start_item(req);

                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:2],haddr[1:0] + 1'b1};});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:3],haddr[2:0] + 2'b10};});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Htrans == 2'b11;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Haddr == {haddr[31:4],haddr[3:0] + 3'b100};});


        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------WRAP8 transfer---------------------------------//
class wrap8_seq1 extends ahb_seq;

        `uvm_object_utils(wrap8_seq1)

        extern function new(string name="wrap8_seq1");
        extern task body();

endclass

function wrap8_seq1::new(string name="wrap8_seq1");
        super.new(name);
endfunction

task wrap8_seq1::body();

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b100;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<7;i++)
        begin
                start_item(req);

                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:3],haddr[2:0] + 1'b1};});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:4],haddr[3:0] + 2'b10};});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:5],haddr[4:0] + 3'b100};});


        	haddr = req.Haddr;
        	finish_item(req);
        end

endtask

//---------------------------------WRAP16 transfer---------------------------------//
class wrap16_seq1 extends ahb_seq;

        `uvm_object_utils(wrap16_seq1)

        extern function new(string name="wrap16_seq1");
        extern task body();

endclass

function wrap16_seq1::new(string name="wrap16_seq1");
        super.new(name);
endfunction

task wrap16_seq1::body();	

        req =ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {Hburst == 3'b110;
                                     Htrans == 2'b10;
                                     Hwrite == 0;});
        finish_item(req);

	//local variables
	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

        for(int i=0;i<15;i++)
        begin
                start_item(req);

                if(hsize == 0)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:4],haddr[3:0] + 1'b1};});

                if(hsize == 1)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:5],haddr[4:0] + 2'b10};});

                if(hsize == 2)
                        assert(req.randomize() with {Hsize == hsize;
                                                     Hburst == hburst;
                                                     Hwrite == hwrite;
                                                     Htrans == 2'b11;
                                                     Haddr == {haddr[31:6],haddr[5:0] + 3'b100};});

	        haddr = req.Haddr;
        	finish_item(req);
        end

endtask

