class uart_env_config extends uvm_object;
	`uvm_object_utils(uart_env_config)

	bit has_scoreboard;
	bit has_uart_agent;
	int no_of_agent;
	
	uart_agent_config agt_cfg[];

	function new(string name = "uart_env_config");
		super.new(name);
	endfunction
endclass

