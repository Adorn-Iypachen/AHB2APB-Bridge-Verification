interface ahb_apb_if(input bit clock);

logic Hresetn,Hwrite;
logic [2:0] Hsize;
logic[1:0]Htrans;
logic Hreadyin;
logic Hreadyout;
logic [31:0]Haddr;
logic [2:0] Hburst;
logic[1:0]Hresp;
logic[31:0] Hwdata;
logic[31:0]Hrdata;

logic Penable,Pwrite;
logic[31:0] Prdata;
logic [31:0] Pwdata;
logic [31:0] Paddr;
logic[3:0] Pselx;

//AHB driver clocking blk
clocking ahb_drv_cb @(posedge clock);
	default input #1 output #1;
	output Hwrite;
	output Hreadyin;
	output Hwdata;
	output Haddr;
	output Htrans;
	output Hburst;
	output Hresetn;
	output Hsize;
	input Hrdata;
	input Hreadyout;
endclocking

// apb clocking blk
clocking apb_drv_cb @(posedge clock);
	default input #1 output #1;
	output Prdata;
	input Penable;
	input Pwrite;
	input Pselx;
endclocking

//ahb driver MP
modport AHB_DR_MP (clocking ahb_drv_cb);
//apb driver MP
modport APB_DR_MP (clocking apb_drv_cb);

//Ahb monitor clocking blk
clocking ahb_mon_cb @(posedge clock);
	default input #1 output #1;
	input Hwrite;
	input Hreadyin;
	input Hwdata;
	input Haddr;
	input Htrans;
	input Hburst;
	input Hresetn;
	input Hsize;
	input Hrdata;
	input Hreadyout;
endclocking

//apb monitor clocking blk
clocking apb_mon_cb @(posedge clock);
	default input #1 output #1;
	input Prdata;
	input Penable;
	input Pwrite;
	input Pselx;
	input Paddr;
	input Pwdata;
endclocking

//ahb monitor MP
modport AHB_MON_MP(clocking ahb_mon_cb);

//apb monitor MP
modport APB_MON_MP (clocking apb_mon_cb);

endinterface 

