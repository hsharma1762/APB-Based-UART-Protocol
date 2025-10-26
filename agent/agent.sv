class uart_agent extends uvm_agent;
	`uvm_component_utils(uart_agent)

	uart_driver drvh;
	uart_monitor monh;
	uart_sequencer seqrh;

	uart_agent_config agt_cfg;

	function new(string name = "uart_agent",uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
	if(!uvm_config_db#(uart_agent_config)::get(this,"","agt_cfg",agt_cfg))
		`uvm_fatal("Agent","Config failed")

	monh = uart_monitor::type_id::create("monh",this);

	if(agt_cfg.is_active)
		begin
			drvh = uart_driver::type_id::create("drvh",this);
			seqrh = uart_sequencer::type_id::create("seqrh",this);
		end

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(agt_cfg.is_active)
			drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction

endclass


