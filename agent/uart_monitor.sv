class uart_monitor extends uvm_monitor;
	`uvm_component_utils(uart_monitor)

	virtual uart_if.MON_MP vif;
	uart_agent_config agt_cfg;
	uvm_analysis_port #(uart_xtn) mon_port;

	uart_xtn xtnh;


	function new(string name = "uart_monitor", uvm_component parent);
		super.new(name, parent);
		mon_port = new("mon_port",this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(uart_agent_config)::get(this,"","agt_cfg",agt_cfg))
			`uvm_fatal("MON","Config failed")

			xtnh = uart_xtn::type_id::create("xtnh");
		
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = agt_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		repeat(3)
		@(vif.mon_cb);
		forever
			begin
				collect_data;
				mon_port.write(xtnh);

			end
	endtask 


	task collect_data;
	while(vif.mon_cb.Psel !==1)
		@(vif.mon_cb);
	begin
	while(vif.mon_cb.Pready !== 1)
	@(vif.mon_cb);
	xtnh.Presetn = vif.mon_cb.Presetn;
	xtnh.Paddr = vif.mon_cb.Paddr;
	xtnh.Pwrite = vif.mon_cb.Pwrite;
	xtnh.Pwdata = vif.mon_cb.Pwdata;
	xtnh.Prdata = vif.mon_cb.Prdata;
	xtnh.Pslverr = vif.mon_cb.Pslverr;
	xtnh.Psel = vif.mon_cb.Psel;
	xtnh.Penable = vif.mon_cb.Penable;
	xtnh.IRQ = vif.mon_cb.IRQ;
	xtnh.baud_o = vif.mon_cb.baud_o;
	xtnh.Pready = vif.mon_cb.Pready;


	@(vif.mon_cb);
	
	//updating LCR
	if(xtnh.Paddr==32'hc && xtnh.Pwrite==1'b1)
		xtnh.LCR = xtnh.Pwdata;

	//updating IER
	if(xtnh.Paddr==32'h4 && xtnh.Pwrite==1'b1)
		xtnh.IER = xtnh.Pwdata;

	//updating FCR
	if(xtnh.Paddr==32'h8 && xtnh.Pwrite==1'b1)
		xtnh.FCR = xtnh.Pwdata;

	//updating IIR
	if(xtnh.Paddr==32'h8 && xtnh.Pwrite==1'b0)
		begin
			while(vif.mon_cb.IRQ !== 1)
			@(vif.mon_cb);
			xtnh.Prdata = vif.mon_cb.Prdata;
			xtnh.IIR = vif.mon_cb.Prdata;
			@(vif.mon_cb);
			
		end

	//updating MCR
	if(xtnh.Paddr==32'h10 && xtnh.Pwrite==1'b1)
		xtnh.MCR = xtnh.Pwdata;
	
	//updating LSR
	if(xtnh.Paddr==32'h14 && xtnh.Pwrite==1'b0)
		xtnh.LSR = xtnh.Prdata;

	//updating DIV1 MSB
	if(xtnh.Paddr==32'h1c && xtnh.Pwrite==1'b1)
		xtnh.DIV2 = xtnh.Pwdata;
	
	//updating DIV2 LSB
	if(xtnh.Paddr==32'h20 && xtnh.Pwrite ==1'b1)
		xtnh.DIV1 = xtnh.Pwdata;

	//updating THR
	if(xtnh.Paddr==32'h0 && xtnh.Pwrite==1'b1)
		begin
			xtnh.data_in_thr = 1'b1;
			xtnh.THR.push_back(xtnh.Pwdata);
		end

	//updating RBR
	if(xtnh.Paddr==32'h0 && xtnh.Pwrite==1'b0)
		begin
			xtnh.data_in_rbr = 1'b1;
			xtnh.RBR.push_back(xtnh.Prdata);
		end

	`uvm_info("UART_MON",$sformatf("Data from MON %s",xtnh.sprint),UVM_MEDIUM);
	end
//	repeat(2)
//	@(vif.mon_cb);
	endtask

endclass

