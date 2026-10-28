class scoreboard extends uvm_scoreboard;

        `uvm_component_utils(scoreboard)

        uvm_tlm_analysis_fifo #(apb_xtn) fifo_apb[];
        uvm_tlm_analysis_fifo #(ahb_xtn) fifo_ahb[];

        //ahb_xtn & apb_xtn handles
        ahb_xtn ahb_cov_data;
        apb_xtn apb_cov_data;

        env_config e_cfg;

        //methods
        extern function new(string name,uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task check_data();
        extern task compare(input int HDATA,PDATA,HADDR,PADDR);

covergroup master;
        option.per_instance=1;

WRITE_ADDRESS: coverpoint ahb_cov_data.Haddr
        {
                bins mslave1 = {[32'h8000_0000:32'h8000_03ff]};
                bins mslave2 = {[32'h8400_0000:32'h8400_03ff]};
                bins mslave3 = {[32'h8800_0000:32'h8800_03ff]};
                bins mslave4 = {[32'h8c00_0000:32'h8c00_03ff]};
        }

HTRANS: coverpoint ahb_cov_data.Htrans
        {
                bins NON_SEQ ={2};
                bins SEQ     ={3};
        }

HSIZE: coverpoint ahb_cov_data.Hsize
        {
                bins size_0 ={0};
                bins size_1 ={1};
                bins size_2 ={2};
        }
HWRITE: coverpoint ahb_cov_data.Hwrite
        {
                bins WRITE ={1};
                bins READ ={0};
        }
HBURST: coverpoint ahb_cov_data.Hburst
        {
                bins burst ={[0:7]};
        }
HSIZEXHTRANSXHWRITEXWRITE_ADDRESS: cross HSIZE,HTRANS,HWRITE,WRITE_ADDRESS;
endgroup

covergroup slave;
        option.per_instance=1;

ADDRESS: coverpoint apb_cov_data.Paddr
        {
                bins slave1 = {[32'h8000_0000:32'h8000_03ff]};
                bins slave2 = {[32'h8400_0000:32'h8400_03ff]};
                bins slave3 = {[32'h8800_0000:32'h8800_03ff]};
                bins slave4 = {[32'h8c00_0000:32'h8c00_03ff]};
        }

PWRITE: coverpoint apb_cov_data.Pwrite
        {
                ignore_bins WRITE={1};
                bins READ ={0};
        }

SELECT: coverpoint apb_cov_data.Pselx
        {
                bins sel1 ={4'b0001};
                bins sel2 ={4'b0010};
                bins sel3 ={4'b0100};
                bins sel4 ={4'b1000};
        }

ADDRESS_X_PWRITE: cross ADDRESS,PWRITE;
endgroup

endclass

//build_phase
function void scoreboard::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                `uvm_fatal("EN_cfg","no update")

        ahb_cov_data = ahb_xtn::type_id::create("ahb_cov_data",this);
        apb_cov_data = apb_xtn::type_id::create("apb_cov_data",this);


        fifo_apb = new[e_cfg.no_of_apb_agent];
        fifo_ahb = new[e_cfg.no_of_ahb_agent];
        foreach(fifo_ahb[i])
                begin
                        fifo_ahb[i] = new($sformatf("fifo_ahb[%0d]",i),this);
                end

        foreach(fifo_apb[i])
                begin
                        fifo_apb[i] = new($sformatf("fifo_apb[%0d]",i),this);
                end

endfunction

//constructor
function scoreboard::new(string name,uvm_component parent);
        super.new(name,parent);

        master=new;
        slave=new;
endfunction

task scoreboard::run_phase(uvm_phase phase);
fork
        forever
                begin
                        fifo_ahb[0].get(ahb_cov_data);
                        `uvm_info(get_type_name(),"data received from ahb_monitor",UVM_LOW);
                        ahb_cov_data.print();

                        fifo_apb[0].get(apb_cov_data);
                        `uvm_info(get_type_name(),"data received from apb_monitor",UVM_LOW);
                        apb_cov_data.print();
                        check_data();
                end
join
endtask


task scoreboard::check_data();

        if(ahb_cov_data.Hwrite==1'b1)
        begin

        $display("after if HWRITE=%d",ahb_cov_data.Hwrite);
        case(ahb_cov_data.Hsize)

        2'b00:begin
        if(ahb_cov_data.Haddr[1:0] == 2'b00)
        compare(ahb_cov_data.Hwdata[7:0],apb_cov_data.Pwdata[7:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b01)
        compare(ahb_cov_data.Hwdata[15:8],apb_cov_data.Pwdata[7:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b10)
        compare(ahb_cov_data.Hwdata[23:16],apb_cov_data.Pwdata[7:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b11)
        compare(ahb_cov_data.Hwdata[31:24],apb_cov_data.Pwdata[7:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        end

        2'b01:begin
        if(ahb_cov_data.Haddr[1:0] == 2'b00)
        compare(ahb_cov_data.Hwdata[15:0],apb_cov_data.Pwdata[15:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b10)
        compare(ahb_cov_data.Hwdata[31:16],apb_cov_data.Pwdata[15:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        end

        2'b10:begin
        compare(ahb_cov_data.Hwdata,apb_cov_data.Pwdata,ahb_cov_data.Haddr,apb_cov_data.Paddr);
        end
        endcase
        end

        else
        begin

        case(ahb_cov_data.Hsize)

        2'b00:begin
        if(ahb_cov_data.Haddr[1:0] == 2'b00)
        compare(ahb_cov_data.Hrdata[7:0],apb_cov_data.Prdata[7:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b01)
        compare(ahb_cov_data.Hrdata[7:0],apb_cov_data.Prdata[15:8],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b10)
        compare(ahb_cov_data.Hrdata[7:0],apb_cov_data.Prdata[23:16],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b11)
        compare(ahb_cov_data.Hrdata[7:0],apb_cov_data.Prdata[31:24],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        end

        2'b01:begin
        if(ahb_cov_data.Haddr[1:0] == 2'b00)
        compare(ahb_cov_data.Hrdata[15:0],apb_cov_data.Prdata[15:0],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        else if(ahb_cov_data.Haddr[1:0] == 2'b10)
        compare(ahb_cov_data.Hrdata[15:0],apb_cov_data.Prdata[31:16],ahb_cov_data.Haddr,apb_cov_data.Paddr);
        end

        2'b10:begin
        compare(ahb_cov_data.Hrdata,apb_cov_data.Prdata,ahb_cov_data.Haddr,apb_cov_data.Paddr);
        end
        endcase
        end
endtask

task scoreboard::compare(input int HDATA,PDATA,HADDR,PADDR);

        if(HADDR==PADDR)
        $display("ADDRESS COMPARED SUCCESSFULLY");

        else
        `uvm_error("SCOREBOARD","ADDRESS COMPARED UNSUCCESSFULL");

        if(HDATA==PDATA)
        $display("DATA COMPARED SUCCESSFULLY");
        else
        begin
        $display("Hwdata = %h, Pwdata = %h", HDATA,PDATA);
        `uvm_error("SCOREBOARD","DATA COMPARISON UNSUCCESSFULL");

        end

        master.sample;
        slave.sample;
endtask
