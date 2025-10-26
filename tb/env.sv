class uart_env extends uvm_env;
	`uvm_component_utils(uart_env)

	uart_agent_top agt_toph;
	uart_scoreboard sb_h;
	uart_env_config m_cfg;

	function new(string name = "uart_env", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	if(!uvm_config_db #(uart_env_config)::get(this,"","m_cfg",m_cfg))
		`uvm_fatal("Env","config failed")

	if(m_cfg.has_uart_agent)
		agt_toph = uart_agent_top::type_id::create("agt_toph",this);

	if(m_cfg.has_scoreboard)
		sb_h = uart_scoreboard::type_id::create("sb_h",this);


	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		foreach(agt_toph.agth[i])
		agt_toph.agth[i].monh.mon_port.connect(sb_h.tlm_fifo[i].analysis_export);
	endfunction
endclass
