class uart_agent_top extends uvm_env;
	`uvm_component_utils(uart_agent_top)
	
	uart_agent agth[];
	uart_agent_config agt_cfg[];
	uart_env_config m_cfg;
	
	function new(string name = "uart_agent_top", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(uart_env_config)::get(this,"","m_cfg",m_cfg))
		`uvm_fatal("Env","config failed")
		
		agth = new[m_cfg.no_of_agent];
		foreach(agth[i])
			begin
			agth[i] = uart_agent::type_id::create($sformatf("agth[%0d]",i),this);
	
			uvm_config_db#(uart_agent_config)::set(this,$sformatf("agth[%0d]*",i),"agt_cfg",m_cfg.agt_cfg[i]);
			end
	endfunction
	
endclass
