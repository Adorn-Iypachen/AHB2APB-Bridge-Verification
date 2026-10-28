module top;

	import ahb_apb_pkg::*;
	import uvm_pkg::*;


bit clock;

initial
	begin
		forever
			#10 clock =~clock;
	end

	ahb_apb_if in0(clock);

	rtl_top DUT(
		.Hclk(clock),
		.Hresetn(in0.Hresetn),
		.Htrans(in0.Htrans),
		.Hsize(in0.Hsize),
		.Hreadyin(in0.Hreadyin),
		.Hwdata(in0.Hwdata),
		.Haddr(in0.Haddr),
		.Hwrite(in0.Hwrite),
		.Hrdata(in0.Hrdata),
		.Hresp(in0.Hresp),
		.Hreadyout(in0.Hreadyout),
		.Pselx(in0.Pselx),
		.Pwrite(in0.Pwrite),
		.Penable(in0.Penable),
		.Prdata(in0.Prdata),
		.Paddr(in0.Paddr),
		.Pwdata(in0.Pwdata));
initial
	begin
			`ifdef VCS
                        $fsdbDumpvars(0, top);
                        `endif

		uvm_config_db #(virtual ahb_apb_if)::set(null,"*","vif",in0);				

	run_test();
	end

endmodule

